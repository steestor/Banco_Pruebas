package es.iti.wakamiti.bancopruebas.infra.repo;

import es.iti.wakamiti.bancopruebas.dominio.Proveedor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProveedorRepositorio extends JpaRepository<Proveedor, Long> {
}
