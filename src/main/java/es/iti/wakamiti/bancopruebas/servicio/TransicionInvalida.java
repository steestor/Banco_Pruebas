package es.iti.wakamiti.bancopruebas.servicio;

public class TransicionInvalida extends RuntimeException {
    public TransicionInvalida(String mensaje) {
        super(mensaje);
    }
}
