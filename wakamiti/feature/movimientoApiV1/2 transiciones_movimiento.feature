#language: es
@MovimientoApiV1 @MovimientoControlador @FID-transiciones_movimiento
Característica: 2º Transiciones de estado de un movimiento - POST /api/v1/movimientos/{id}/estado/{destino}
  Como: responsable del almacén
  Quiero: confirmar o anular un movimiento
  Para: que las existencias reflejen lo que ha pasado de verdad

  Antecedentes:
    Dado el servicio REST '/api/v1/movimientos/{id}/estado/{destino}'

  @ID-TransicionMovimiento-1
  Esquema del escenario: Transiciones no admitidas desde un estado terminal
    Dado los siguientes parámetros de ruta:
    | nombre  | valor      |
    | id      | 3          |
    | destino | <destino>  |
    Cuando se crea la petición de cambio de estado con los siguientes datos:
      """
      {}
      """
    Entonces el código de respuesta HTTP es 409

    Ejemplos:
    | destino    |
    | CONFIRMADO |
    | ANULADO    |

  @ID-TransicionMovimiento-2
  Escenario: Estado destino desconocido
    Dado los siguientes parámetros de ruta:
    | nombre  | valor      |
    | id      | 1          |
    | destino | INVENTADO  |
    Cuando se crea la petición de cambio de estado con los siguientes datos:
      """
      {}
      """
    Entonces el código de respuesta HTTP es 409

  @ID-TransicionMovimiento-3
  Escenario: Movimiento inexistente
    Dado los siguientes parámetros de ruta:
    | nombre  | valor      |
    | id      | 9999       |
    | destino | CONFIRMADO |
    Cuando se crea la petición de cambio de estado con los siguientes datos:
      """
      {}
      """
    Entonces el código de respuesta HTTP es 404
