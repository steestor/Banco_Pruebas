package es.iti.wakamiti.bancopruebas.infra.rest;

import es.iti.wakamiti.bancopruebas.dominio.Articulo;
import es.iti.wakamiti.bancopruebas.servicio.ArticuloServicio;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/articulos")
public class ArticuloControlador {

    private final ArticuloServicio servicio;

    public ArticuloControlador(ArticuloServicio servicio) {
        this.servicio = servicio;
    }

    @GetMapping
    public Map<String, Object> listar(@RequestParam(required = false) Long proveedorId,
                                      @RequestParam(defaultValue = "0") int page,
                                      @RequestParam(defaultValue = "20") int size) {
        Page<Articulo> pagina = servicio.listar(proveedorId, PageRequest.of(page, size));
        List<ArticuloDto> contenido = pagina.getContent().stream().map(this::aDto).collect(Collectors.toList());
        return Map.of(
            "content", contenido,
            "totalElements", pagina.getTotalElements(),
            "totalPages", pagina.getTotalPages(),
            "number", pagina.getNumber()
        );
    }

    @GetMapping("/{id}")
    public ArticuloDto porId(@PathVariable Long id) {
        return aDto(servicio.porId(id));
    }

    @PostMapping
    public ResponseEntity<ArticuloDto> crear(@Valid @RequestBody ArticuloDto cuerpo) {
        Articulo creado = servicio.crear(cuerpo.getDescripcion(), cuerpo.getExistencias(), cuerpo.getProveedorId());
        return ResponseEntity.status(HttpStatus.CREATED).body(aDto(creado));
    }

    @PutMapping("/{id}")
    public ArticuloDto actualizar(@PathVariable Long id, @Valid @RequestBody ArticuloDto cuerpo) {
        return aDto(servicio.actualizar(id, cuerpo.getDescripcion(), cuerpo.getExistencias()));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> borrar(@PathVariable Long id) {
        servicio.borrar(id);
        return ResponseEntity.noContent().build();
    }

    private ArticuloDto aDto(Articulo articulo) {
        ArticuloDto dto = new ArticuloDto();
        dto.setId(articulo.getId());
        dto.setDescripcion(articulo.getDescripcion());
        dto.setExistencias(articulo.getExistencias());
        dto.setProveedorId(articulo.getProveedor().getId());
        return dto;
    }
}
