#language: es
@RotasApiV1 @FID-id_duplicado
Característica: Feature con el mismo @ID en dos escenarios
  Como: banco de pruebas
  Quiero: repetir un identificador dentro del mismo fichero
  Para: comprobar que el preflight avisa pero NO aparta el fichero

  @ID-IdDuplicado-1
  Escenario: Primero
    Dado el servicio REST '/api/v1/articulos'
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200

  @ID-IdDuplicado-1
  Escenario: Segundo, con el mismo identificador que el primero
    Dado el servicio REST '/api/v1/articulos'
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200
