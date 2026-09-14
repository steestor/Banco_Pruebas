#language: es
@RotasApiV1 @FID-sin_id
Característica: Feature con un escenario sin identificador
  Como: banco de pruebas
  Quiero: dejar un escenario sin su tag @ID
  Para: que la validación de strictTestCaseID lo aparte

  @ID-SinId-1
  Escenario: Este sí lleva identificador
    Dado el servicio REST '/api/v1/articulos'
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200

  Escenario: Este no lleva identificador y no debería pasar la validación
    Dado el servicio REST '/api/v1/articulos'
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200
