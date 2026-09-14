#language: es
@ArticuloApiV1 @FID-put_articulo
Característica: 4º Modificar un artículo - PUT /api/v1/articulos/{id}
  Como: responsable del almacén
  Quiero: modificar la descripción y las existencias de un artículo
  Para: mantener el inventario al día

  Antecedentes:
    * Al finalizar, se ejecuta el script SQL del fichero 'data/articulos/limpiar_altas.sql'
    Dado que se ejecuta el script SQL del fichero 'data/articulos/crear_borrable.sql'
    Y el servicio REST '/api/v1/articulos/{id}'

  @ID-PutArticulo-1
  Escenario: Modificación correcta
    Dado los siguientes parámetros de ruta:
    | nombre | valor |
    | id     | 900   |
    Cuando se reemplaza el articulo con los siguientes datos:
      """
      {
        "descripcion": "Alta Wakamiti articulo modificado",
        "existencias": 99,
        "proveedorId": 2
      }
      """
    Entonces el código de respuesta HTTP es 200
    Y el siguiente registro existe en la tabla de BBDD articulo:
    | id  | existencias |
    | 900 | 99          |

  @ID-PutArticulo-2
  Escenario: Modificación de un artículo inexistente
    Dado los siguientes parámetros de ruta:
    | nombre | valor |
    | id     | 9999  |
    Cuando se reemplaza el articulo con los siguientes datos:
      """
      {
        "descripcion": "Alta Wakamiti inexistente",
        "existencias": 1,
        "proveedorId": 1
      }
      """
    Entonces el código de respuesta HTTP es 404
