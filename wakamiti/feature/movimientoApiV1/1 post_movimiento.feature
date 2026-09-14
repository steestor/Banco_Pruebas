#language: es
@MovimientoApiV1 @MovimientoControlador @FID-post_movimiento
Característica: 1º Registrar un movimiento - POST /api/v1/movimientos
  Como: operario del almacén
  Quiero: registrar un movimiento sobre un artículo
  Para: dejar constancia de la entrada o salida

  # Vive bajo 'feature/' en SINGULAR, conviviendo con 'features/' en plural. Ningún
  # proyecto real tiene los dos a la vez: está así para cubrir esa bifurcación.

  Antecedentes:
    Dado el servicio REST '/api/v1/movimientos'

  @ID-PostMovimiento-1
  Escenario: Alta de movimiento sobre artículo existente
    Cuando se crea el movimiento con los siguientes datos:
      """
      {
        "articuloId": 3,
        "unidades": 4
      }
      """
    Entonces el código de respuesta HTTP es 201

  @ID-PostMovimiento-2
  Escenario: Alta sobre artículo inexistente
    Cuando se crea el movimiento con los siguientes datos:
      """
      {
        "articuloId": 9999,
        "unidades": 4
      }
      """
    Entonces el código de respuesta HTTP es 404

  @ID-PostMovimiento-3
  Escenario: Alta con unidades no positivas
    Cuando se crea el movimiento con los siguientes datos:
      """
      {
        "articuloId": 3,
        "unidades": 0
      }
      """
    Entonces el código de respuesta HTTP es 409
