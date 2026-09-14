package es.iti.wakamiti.bancopruebas.dominio;

/** Estados de un movimiento. Las transiciones válidas las decide MovimientoServicio. */
public enum EstadoMovimiento {
    BORRADOR,
    CONFIRMADO,
    ANULADO
}
