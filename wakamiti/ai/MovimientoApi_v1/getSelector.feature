#language: es
@MovimientoApiV1 @FID-ia_movimiento_selector
Característica: Selector de movimientos generado por IA - GET /api/v1/movimientos/{id}
  Como: consumidor del almacén
  Quiero: recuperar un movimiento concreto
  Para: mostrar su estado

  Antecedentes:
    Dado el servicio REST '/api/v1/movimientos/{id}'

  @ID-IaMovimientoSelector-1
  Escenario: El movimiento existe
    Dado los siguientes parámetros de ruta:
    | nombre | valor |
    | id     | 1     |
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200
