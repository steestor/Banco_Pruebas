#language: es
@ArticuloApiV1 @FID-get_articulo_por_id
Característica: 2º Consultar un artículo - GET /api/v1/articulos/{id}
  Como: consumidor del almacén
  Quiero: consultar un artículo concreto
  Para: ver su descripción y existencias

  Antecedentes:
    Dado el servicio REST '/api/v1/articulos/{id}'

  @ID-GetArticuloPorId-1
  Escenario: Artículo existente
    Dado los siguientes parámetros de ruta:
    | nombre | valor |
    | id     | 1     |
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200
    Y el entero del fragmento de la respuesta 'existencias' es igual a 120

  @ID-GetArticuloPorId-2
  Escenario: Artículo inexistente
    Dado los siguientes parámetros de ruta:
    | nombre | valor |
    | id     | 9999  |
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 404
