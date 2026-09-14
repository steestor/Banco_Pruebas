INSERT INTO proveedor (id, nombre, activo) VALUES
    (1, 'Suministros del Norte', true),
    (2, 'Distribuciones Aurora', true),
    (3, 'Almacenes Retirados', false);

INSERT INTO articulo (id, descripcion, existencias, proveedor_id) VALUES
    (1, 'Caja de tornillos M6', 120, 1),
    (2, 'Rollo de cable 50m', 8, 1),
    (3, 'Juego de brocas', 45, 2),
    (4, 'Cinta aislante', 0, 2),
    (5, 'Estanteria modular', 12, 3);
SELECT setval('articulo_id_seq', 5);

INSERT INTO movimiento (id, articulo_id, unidades, estado) VALUES
    (1, 1, 10, 'BORRADOR'),
    (2, 1, 5,  'CONFIRMADO'),
    (3, 3, 2,  'ANULADO');
SELECT setval('movimiento_id_seq', 3);
