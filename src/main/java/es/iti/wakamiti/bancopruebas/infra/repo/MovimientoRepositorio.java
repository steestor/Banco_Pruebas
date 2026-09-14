package es.iti.wakamiti.bancopruebas.infra.repo;

import es.iti.wakamiti.bancopruebas.dominio.Movimiento;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MovimientoRepositorio extends JpaRepository<Movimiento, Long> {
    List<Movimiento> findByArticuloId(Long articuloId);
}
