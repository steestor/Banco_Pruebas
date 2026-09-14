#language: es
@ProveedorApiV1 @FID-proveedores_sueltos
Característica: Consultar artículos por proveedor sin subdirectorio propio
  Como: consumidor del almacén
  Quiero: filtrar artículos por su proveedor
  Para: revisar el catálogo de cada suministrador

  # Esta feature cuelga DIRECTAMENTE del directorio de features, sin subdirectorio de API.
  # Es la forma mayoritaria en repositorios reales y la que el sincronizador descartaba.

  Antecedentes:
    Dado el servicio REST '/api/v1/articulos'

  @ID-ProveedoresSueltos-1
  Escenario: Proveedor con artículos
    Dado los siguientes parámetros de búsqueda:
    | nombre      | valor |
    | proveedorId | 2     |
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200
    Y el entero del fragmento de la respuesta 'totalElements' es igual a 2

  @ID-ProveedoresSueltos-2
  Escenario: Proveedor inactivo, que igualmente tiene artículos
    Dado los siguientes parámetros de búsqueda:
    | nombre      | valor |
    | proveedorId | 3     |
    Cuando se realiza la búsqueda
    Entonces el código de respuesta HTTP es 200
    Y el entero del fragmento de la respuesta 'totalElements' es igual a 1
