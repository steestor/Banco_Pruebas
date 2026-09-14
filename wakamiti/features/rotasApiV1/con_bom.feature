#language: es
@RotasApiV1 @FID-con_bom
Característica: Feature que empieza con BOM
  Como: banco de pruebas
  Quiero: un fichero con marca de orden de bytes al inicio
  Para: que el preflight lo aparte

  @ID-ConBom-1
  Escenario: No debe llegar al run
    Dado el servicio REST '/api/v1/articulos'
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200
