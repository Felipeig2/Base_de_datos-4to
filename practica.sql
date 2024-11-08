
Aquí tienes 7 preguntas de la lista seleccionadas aleatoriamente:

--Devuelve un listado con los distintos estados por los que puede pasar un pedido.
  SELECT DISTINCT estado FROM pedido;
  
--Devuelve un listado con el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
SELECT e.nombre, COUNT(c.codigo_cliente) FROM empleado e JOIN cliente c GROUP BY e.nombre ORDER BY e.nombre;

-- Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
SELECT c.nombre_cliente, c.ciudad, e.codigo_empleado FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado WHERE c.ciudad LIKE 'Mad%' AND e.codigo_empleado = 11 OR e.codigo_empleado = 30;

-- Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.

SELECT pr.nombre, pr.gama, pr.cantidad_en_stock, pr.precio_venta FROM producto pr WHERE pr.cantidad_en_stock > 100 AND gama LIKE 'Ornam%' ORDER BY pr.precio_venta DESC;

--Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
SELECT p.codigo_pedido, c.codigo_cliente, p.fecha_esperada, p.fecha_entrega FROM cliente c JOIN pedido p ON c.codigo_cliente = p.codigo_cliente WHERE p.fecha_entrega > p.fecha_esperada;

-- Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.
SELECT c.nombre_cliente, MIN(p.fecha_pago), MAX(p.fecha_pago) FROM cliente c JOIN pago p ON c.codigo_cliente = p.codigo_cliente GROUP BY nombre_cliente ORDER BY nombre_cliente;

-- Devuelve un listado con los productos que nunca han aparecido en un pedido. (Utilizar IN, NOT IN).

SELECT pr.nombre FROM producto pr WHERE pr.codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);