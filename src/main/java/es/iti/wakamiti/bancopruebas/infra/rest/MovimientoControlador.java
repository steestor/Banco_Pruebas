package es.iti.wakamiti.bancopruebas.infra.rest;

import es.iti.wakamiti.bancopruebas.dominio.EstadoMovimiento;
import es.iti.wakamiti.bancopruebas.dominio.Movimiento;
import es.iti.wakamiti.bancopruebas.servicio.MovimientoServicio;
import es.iti.wakamiti.bancopruebas.servicio.TransicionInvalida;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/movimientos")
public class MovimientoControlador {

    private final MovimientoServicio servicio;

    public MovimientoControlador(MovimientoServicio servicio) {
        this.servicio = servicio;
    }

    @GetMapping("/{id}")
    public MovimientoDto porId(@PathVariable Long id) {
        return aDto(servicio.porId(id));
    }

    @PostMapping
    public ResponseEntity<MovimientoDto> crear(@Valid @RequestBody MovimientoDto cuerpo) {
        Movimiento creado = servicio.crear(cuerpo.getArticuloId(), cuerpo.getUnidades());
        return ResponseEntity.status(HttpStatus.CREATED).body(aDto(creado));
    }

    @PostMapping("/{id}/estado/{destino}")
    public MovimientoDto transitar(@PathVariable Long id, @PathVariable String destino) {
        EstadoMovimiento estado = parsearEstado(destino);
        return aDto(servicio.transitar(id, estado));
    }

    private EstadoMovimiento parsearEstado(String destino) {
        try {
            return EstadoMovimiento.valueOf(destino.toUpperCase());
        } catch (IllegalArgumentException e) {
            throw new TransicionInvalida("Estado desconocido: " + destino);
        }
    }

    private MovimientoDto aDto(Movimiento movimiento) {
        MovimientoDto dto = new MovimientoDto();
        dto.setId(movimiento.getId());
        dto.setArticuloId(movimiento.getArticulo().getId());
        dto.setUnidades(movimiento.getUnidades());
        dto.setEstado(movimiento.getEstado().name());
        return dto;
    }
}
