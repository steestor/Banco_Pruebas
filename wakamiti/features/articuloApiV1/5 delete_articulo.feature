#language: es
@ArticuloApiV1 @ArticuloControlador @FID-delete_articulo
Característica: 5º Dar de baja un artículo - DELETE /api/v1/articulos/{id}
  Como: responsable del almacén
  Quiero: dar de baja un artículo
  Para: retirarlo del inventario

  Antecedentes:
    * Al finalizar, se ejecuta el script SQL del fichero 'data/articulos/limpiar_altas.sql'
    Dado que se ejecuta el script SQL del fichero 'data/articulos/crear_borrable.sql'
    Y el servicio REST '/api/v1/articulos/{id}'

  @ID-DeleteArticulo-1
  Escenario: Baja de un artículo sin movimientos
    Dado los siguientes parámetros de ruta:
    | nombre | valor |
    | id     | 900   |
    Cuando se elimina el articulo
    Entonces el código de respuesta HTTP es 204
    Y el siguiente registro no existe en la tabla de BBDD articulo:
    | id  |
    | 900 |

  @ID-DeleteArticulo-2
  Escenario: Baja de un artículo con movimientos
    Dado los siguientes parámetros de ruta:
    | nombre | valor |
    | id     | 1     |
    Cuando se elimina el articulo
    Entonces el código de respuesta HTTP es 409

  @ID-DeleteArticulo-3
  Escenario: Baja de un artículo inexistente
    Dado los siguientes parámetros de ruta:
    | nombre | valor |
    | id     | 9999  |
    Cuando se elimina el articulo
    Entonces el código de respuesta HTTP es 404
