#language: es
@RotasApiV1 @FID-gherkin_invalido
Característica: Feature con sintaxis rota
  Como: banco de pruebas

  @ID-GherkinInvalido-1
  Escenario: Tabla sin cabecera y bloque sin cerrar
    Dado el servicio REST '/api/v1/articulos'
    Y los siguientes parámetros de búsqueda:
    | 1 | 2 | 3
    Cuando se realiza la búsqueda
      """
      falta el cierre del bloque
