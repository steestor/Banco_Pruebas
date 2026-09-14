DELETE FROM movimiento WHERE articulo_id IN (SELECT id FROM articulo WHERE descripcion LIKE 'Alta Wakamiti%');
DELETE FROM articulo WHERE descripcion LIKE 'Alta Wakamiti%';
