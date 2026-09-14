package es.iti.wakamiti.bancopruebas.servicio;

import es.iti.wakamiti.bancopruebas.dominio.Articulo;
import es.iti.wakamiti.bancopruebas.dominio.Proveedor;
import es.iti.wakamiti.bancopruebas.infra.repo.ArticuloRepositorio;
import es.iti.wakamiti.bancopruebas.infra.repo.MovimientoRepositorio;
import es.iti.wakamiti.bancopruebas.infra.repo.ProveedorRepositorio;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ArticuloServicio {

    private final ArticuloRepositorio articulos;
    private final ProveedorRepositorio proveedores;
    private final MovimientoRepositorio movimientos;

    public ArticuloServicio(ArticuloRepositorio articulos, ProveedorRepositorio proveedores,
                            MovimientoRepositorio movimientos) {
        this.articulos = articulos;
        this.proveedores = proveedores;
        this.movimientos = movimientos;
    }

    public Page<Articulo> listar(Long proveedorId, Pageable pageable) {
        return proveedorId == null
            ? articulos.findAll(pageable)
            : articulos.findByProveedorId(proveedorId, pageable);
    }

    public Articulo porId(Long id) {
        return articulos.findById(id)
            .orElseThrow(() -> new RecursoNoEncontrado("No existe el articulo " + id));
    }

    @Transactional
    public Articulo crear(String descripcion, Integer existencias, Long proveedorId) {
        Proveedor proveedor = proveedores.findById(proveedorId)
            .orElseThrow(() -> new RecursoNoEncontrado("No existe el proveedor " + proveedorId));
        Articulo articulo = new Articulo();
        articulo.setDescripcion(descripcion);
        articulo.setExistencias(existencias);
        articulo.setProveedor(proveedor);
        return articulos.save(articulo);
    }

    @Transactional
    public Articulo actualizar(Long id, String descripcion, Integer existencias) {
        Articulo articulo = porId(id);
        articulo.setDescripcion(descripcion);
        articulo.setExistencias(existencias);
        return articulos.save(articulo);
    }

    /** Un articulo con movimientos no se borra: su historico dejaria de cuadrar. */
    @Transactional
    public void borrar(Long id) {
        Articulo articulo = porId(id);
        if (!movimientos.findByArticuloId(id).isEmpty()) {
            throw new TransicionInvalida("El articulo " + id + " tiene movimientos y no puede borrarse");
        }
        articulos.delete(articulo);
    }
}
