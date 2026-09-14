package es.iti.wakamiti.bancopruebas.infra.repo;

import es.iti.wakamiti.bancopruebas.dominio.Articulo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ArticuloRepositorio extends JpaRepository<Articulo, Long> {
    Page<Articulo> findByProveedorId(Long proveedorId, Pageable pageable);
}
