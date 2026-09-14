# Banco_Pruebas

Proyecto Java de referencia para validar el pipeline de cobertura y regresión selectiva
(`wakamiti_jacoco_ast_apm`, Vertiente 1 — local) sin depender de infraestructura corporativa.

No es una demo ni un ejemplo didáctico: existe para **ejercitar las costuras** donde el
pipeline ha fallado históricamente. Que aquí todo pase en verde es la señal de que la
vertiente local funciona; que falle señala una regresión real.

## Por qué no hereda del parent corporativo

Los proyectos reales bajo prueba heredan de un parent que vive en un Nexus privado. Este
usa `spring-boot-starter-parent` público para poder construirse sin credenciales. Lo que sí
se replica fielmente son las versiones de los plugins Wakamiti y las rutas de salida
(`target/wakamiti/multipleJsons/`), que es lo que el pipeline lee.

## Dominio

Almacén con tres entidades y tres capas reales (`Controlador → Servicio → Repositorio`),
para que el grafo AST tenga profundidad medible y los árboles de llamadas APM registren
transacciones de verdad.

| Entidad | Qué aporta |
|---|---|
| `proveedor` | Clave ajena contra artículo → conflictos de integridad |
| `articulo` | CRUD completo: listado paginado, por id, alta, modificación, baja |
| `movimiento` | Transiciones `BORRADOR → CONFIRMADO → ANULADO` con efecto sobre existencias |

Estados HTTP que produce: 200, 201, 204, 400 (cuerpo inválido), 404 (no existe),
409 (transición no admitida, existencias insuficientes, borrado con movimientos).

## Requisitos

- JDK 17
- PostgreSQL con base `banco_pruebas` (usuario y contraseña `banco`)

El esquema y los datos se cargan en cada arranque desde `schema.sql` y `data.sql`: el banco
de pruebas debe partir siempre del mismo estado conocido o las aserciones no son estables.

## Ejecución

```bash
mvn spring-boot:run              # solo la aplicación
mvn -Pwakamiti verify            # batería Wakamiti + cobertura JaCoCo
```
