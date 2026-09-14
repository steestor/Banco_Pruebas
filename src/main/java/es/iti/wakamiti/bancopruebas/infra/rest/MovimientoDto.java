package es.iti.wakamiti.bancopruebas.infra.rest;

import javax.validation.constraints.NotNull;

public class MovimientoDto {

    private Long id;

    @NotNull
    private Long articuloId;

    @NotNull
    private Integer unidades;

    private String estado;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getArticuloId() { return articuloId; }
    public void setArticuloId(Long articuloId) { this.articuloId = articuloId; }
    public Integer getUnidades() { return unidades; }
    public void setUnidades(Integer unidades) { this.unidades = unidades; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}
