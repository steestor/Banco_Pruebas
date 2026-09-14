#language: es
@ArticuloApiV1 @FID-ia_articulo_selector
Característica: Selector de artículos generado por IA - GET /api/v1/articulos
  Como: consumidor del almacén
  Quiero: recuperar el selector de artículos
  Para: alimentar un desplegable

  Antecedentes:
    Dado el servicio REST '/api/v1/articulos'

  @ID-IaArticuloSelector-1
  Escenario: El selector responde correctamente
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200
