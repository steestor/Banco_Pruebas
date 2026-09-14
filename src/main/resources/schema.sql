DROP TABLE IF EXISTS movimiento;
DROP TABLE IF EXISTS articulo;
DROP TABLE IF EXISTS proveedor;

CREATE TABLE proveedor (
    id     BIGINT       PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    activo BOOLEAN      NOT NULL
);

CREATE TABLE articulo (
    id           BIGSERIAL    PRIMARY KEY,
    descripcion  VARCHAR(200) NOT NULL,
    existencias  INTEGER      NOT NULL,
    proveedor_id BIGINT       NOT NULL REFERENCES proveedor (id)
);

CREATE TABLE movimiento (
    id          BIGSERIAL   PRIMARY KEY,
    articulo_id BIGINT      NOT NULL REFERENCES articulo (id),
    unidades    INTEGER     NOT NULL,
    estado      VARCHAR(20) NOT NULL
);
