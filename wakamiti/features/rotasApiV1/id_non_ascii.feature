#language: es
@RotasApiV1 @FID-id_non_ascii
Característica: Feature con tilde en el tag @ID
  Como: banco de pruebas
  Quiero: un @ID con caracteres no ASCII
  Para: que el preflight lo aparte antes de que rompa la escritura del JSON de resultado

  @ID-GetArtículoAcentuado-1
  Escenario: El identificador lleva tilde y no debe llegar al run
    Dado el servicio REST '/api/v1/articulos'
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200
