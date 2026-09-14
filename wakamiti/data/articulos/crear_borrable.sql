INSERT INTO articulo (id, descripcion, existencias, proveedor_id)
VALUES (900, 'Alta Wakamiti articulo borrable', 7, 2)
ON CONFLICT (id) DO NOTHING;
