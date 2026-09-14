#language: es
@ArticuloApiV1 @FID-post_articulo
Característica: 3º Dar de alta un artículo - POST /api/v1/articulos
  Como: responsable del almacén
  Quiero: dar de alta un artículo
  Para: poder registrar movimientos sobre él

  Antecedentes:
    * Al finalizar, se ejecuta el script SQL del fichero 'data/articulos/limpiar_altas.sql'
    Dado el servicio REST '/api/v1/articulos'

  @ID-PostArticulo-1
  Escenario: Alta correcta
    Cuando se crea el articulo con los siguientes datos:
      """
      {
        "descripcion": "Alta Wakamiti caja de bridas",
        "existencias": 30,
        "proveedorId": 1
      }
      """
    Entonces el código de respuesta HTTP es 201
    Y el siguiente registro existe en la tabla de BBDD articulo:
    | descripcion                  | existencias |
    | Alta Wakamiti caja de bridas | 30          |

  @ID-PostArticulo-2
  Escenario: Alta con proveedor inexistente
    Cuando se crea el articulo con los siguientes datos:
      """
      {
        "descripcion": "Alta Wakamiti sin proveedor",
        "existencias": 5,
        "proveedorId": 9999
      }
      """
    Entonces el código de respuesta HTTP es 404

  @ID-PostArticulo-3
  Escenario: Alta sin descripción
    Cuando se crea el articulo con los siguientes datos:
      """
      {
        "descripcion": "",
        "existencias": 5,
        "proveedorId": 1
      }
      """
    Entonces el código de respuesta HTTP es 400
