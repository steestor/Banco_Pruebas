# Features rotas a propósito

**No las arregles.** Cada fichero de este directorio reproduce un defecto concreto que el
pre-vuelo del pipeline debe detectar antes de que Maven arranque la batería.

| Fichero | Defecto | Resultado esperado |
|---|---|---|
| `id_non_ascii.feature` | Tilde en el tag `@ID` | Apartado a cuarentena |
| `con_bom.feature` | Marca de orden de bytes al inicio | Apartado a cuarentena |
| `gherkin_invalido.feature` | Tabla sin cabecera y bloque sin cerrar | Apartado a cuarentena |
| `sin_id.feature` | Escenario sin `@ID` con `strictTestCaseID` activo | Apartado a cuarentena |
| `id_duplicado.feature` | Mismo `@ID` en dos escenarios del mismo fichero | **Solo advertencia**, sigue en el run |

## Defecto abierto del pre-vuelo

`id_duplicado.feature` está clasificado como advertencia, pero Wakamiti **aborta el plan
entero** al encontrar un `@ID` repetido:

```
WakamitiException: The ID ID-IdDuplicado-1 is used in 2 test cases
```

Medido en este mismo proyecto: con ese fichero activo la batería produce **0 resultados**;
apartándolo, **25 de 25 pasan**. Y el build termina en `SUCCESS`, porque el pipeline lanza
Maven con `-Dmaven.test.failure.ignore=true`, así que el fallo no se ve por ningún lado.

Mientras el pre-vuelo no lo trate como motivo de cuarentena, este fichero deja la batería
del banco de pruebas en cero. Se conserva a propósito: es la evidencia del defecto.

Un pipeline sano aparta los cuatro primeros, avisa del quinto y ejecuta el resto de la
batería sin caerse. Si alguno de estos ficheros llega a Maven, hay una regresión en el
pre-vuelo.
