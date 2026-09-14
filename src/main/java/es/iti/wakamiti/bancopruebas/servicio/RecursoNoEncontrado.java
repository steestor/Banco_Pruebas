package es.iti.wakamiti.bancopruebas.servicio;

public class RecursoNoEncontrado extends RuntimeException {
    public RecursoNoEncontrado(String mensaje) {
        super(mensaje);
    }
}
