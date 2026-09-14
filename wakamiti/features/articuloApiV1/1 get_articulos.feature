#language: es
@ArticuloApiV1 @ArticuloControlador @FID-get_articulos
Característica: 1º Consultar el listado de artículos - GET /api/v1/articulos
  Como: consumidor del almacén
  Quiero: consultar los artículos dados de alta
  Para: conocer las existencias disponibles

  Antecedentes:
    Dado el servicio REST '/api/v1/articulos'

  @ID-GetArticulos-1
  Escenario: Listado completo paginado
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200
    Y el entero del fragmento de la respuesta 'totalElements' es igual a 5

  @ID-GetArticulos-2
  Escenario: Listado filtrado por proveedor
    Dado los siguientes parámetros de búsqueda:
    | nombre      | valor |
    | proveedorId | 1     |
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200
    Y el entero del fragmento de la respuesta 'totalElements' es igual a 2

  @ID-GetArticulos-3
  Esquema del escenario: Tamaño de página respetado
    Dado los siguientes parámetros de búsqueda:
    | nombre | valor    |
    | size   | <tamano> |
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200
    Y el entero del fragmento de la respuesta 'totalPages' es igual a <paginas>

    Ejemplos:
    | tamano | paginas |
    | 2      | 3       |
    | 5      | 1       |
