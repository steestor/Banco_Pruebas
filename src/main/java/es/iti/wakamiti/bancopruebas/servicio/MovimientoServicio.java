package es.iti.wakamiti.bancopruebas.servicio;

import es.iti.wakamiti.bancopruebas.dominio.Articulo;
import es.iti.wakamiti.bancopruebas.dominio.EstadoMovimiento;
import es.iti.wakamiti.bancopruebas.dominio.Movimiento;
import es.iti.wakamiti.bancopruebas.infra.repo.MovimientoRepositorio;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class MovimientoServicio {

    /** Transiciones admitidas. Un estado ausente aqui es terminal. */
    private static final Map<EstadoMovimiento, List<EstadoMovimiento>> TRANSICIONES = Map.of(
        EstadoMovimiento.BORRADOR, List.of(EstadoMovimiento.CONFIRMADO, EstadoMovimiento.ANULADO),
        EstadoMovimiento.CONFIRMADO, List.of(EstadoMovimiento.ANULADO),
        EstadoMovimiento.ANULADO, List.of()
    );

    private final MovimientoRepositorio movimientos;
    private final ArticuloServicio articulos;

    public MovimientoServicio(MovimientoRepositorio movimientos, ArticuloServicio articulos) {
        this.movimientos = movimientos;
        this.articulos = articulos;
    }

    public Movimiento porId(Long id) {
        return movimientos.findById(id)
            .orElseThrow(() -> new RecursoNoEncontrado("No existe el movimiento " + id));
    }

    @Transactional
    public Movimiento crear(Long articuloId, Integer unidades) {
        if (unidades == null || unidades <= 0) {
            throw new TransicionInvalida("Las unidades deben ser mayores que cero");
        }
        Articulo articulo = articulos.porId(articuloId);
        Movimiento movimiento = new Movimiento();
        movimiento.setArticulo(articulo);
        movimiento.setUnidades(unidades);
        movimiento.setEstado(EstadoMovimiento.BORRADOR);
        return movimientos.save(movimiento);
    }

    /**
     * Cambia el estado si la transicion esta admitida. Confirmar descuenta existencias, y
     * anular un confirmado las devuelve: sin eso el stock se desincroniza del historico.
     */
    @Transactional
    public Movimiento transitar(Long id, EstadoMovimiento destino) {
        Movimiento movimiento = porId(id);
        EstadoMovimiento origen = movimiento.getEstado();
        if (!TRANSICIONES.getOrDefault(origen, List.of()).contains(destino)) {
            throw new TransicionInvalida("No se puede pasar de " + origen + " a " + destino);
        }
        aplicarEfectoSobreExistencias(movimiento, origen, destino);
        movimiento.setEstado(destino);
        return movimientos.save(movimiento);
    }

    private void aplicarEfectoSobreExistencias(Movimiento movimiento, EstadoMovimiento origen,
                                               EstadoMovimiento destino) {
        Articulo articulo = movimiento.getArticulo();
        if (destino == EstadoMovimiento.CONFIRMADO) {
            if (articulo.getExistencias() < movimiento.getUnidades()) {
                throw new TransicionInvalida("Existencias insuficientes en el articulo " + articulo.getId());
            }
            articulo.setExistencias(articulo.getExistencias() - movimiento.getUnidades());
        } else if (destino == EstadoMovimiento.ANULADO && origen == EstadoMovimiento.CONFIRMADO) {
            articulo.setExistencias(articulo.getExistencias() + movimiento.getUnidades());
        }
    }
}
