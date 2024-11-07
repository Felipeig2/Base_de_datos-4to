/*1. Listar los nombres de los clientes que tienen asignado el representante Lorena Pauxton
(suponiendo que no puede haber representantes con el mismo nombre).*/
SELECT c.nombre_cliente, e.nombre, e.apellido1 FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = codigo_empleado AND e.nombre LIKE 'Lorena' AND e.apellido1 LIKE 'Paxton';

/*2. Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados
que tiene.*/

SELECT o.ciudad, COUNT(e.nombre) AS numero_empleados FROM oficina o JOIN empleado e ON e.codigo_oficina = o.codigo_oficina GROUP BY o.ciudad ORDER BY o.ciudad;

/*3. Listar a los vendedores que no trabajan en oficinas dirigidas por el empleado 108.*/

SELECT pr.proveedor, e.codigo_empleado FROM producto pr JOIN detalle_pedido dp ON pr.codigo_producto = dp.codigo_producto JOIN pedido pe ON pe.codigo_pedido = dp.codigo_pedido JOIN cliente c ON c.codigo_cliente = pe.codigo_cliente JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado WHERE e.codigo_empleado != 108;

/*4 a 17*/

/*18. Devuelve un listado que muestre solamente a los clientes que no han realizado ningún pago.
(Utilizar EXISTS y NOT EXISTS)*/

SELECT c.nombre_cliente FROM cliente c WHERE NOT EXISTS (SELECT 1 FROM pago p WHERE p.codigo_cliente = c.codigo_cliente);

/*19. Devuelve un listado que muestre solamente a los clientes que sí han realizado algún pago.
(Utilizar EXISTS y NOT EXISTS)*/
SELECT c.nombre_cliente FROM cliente c WHERE EXISTS (SELECT 1 FROM pago p WHERE p.codigo_cliente = c.codigo_cliente);

/*20. Devuelve un listado de los productos que nunca han aparecido en un pedido. (Utilizar EXISTS y
NOT EXISTS)*/

SELECT pr.nombre FROM producto pr WHERE EXISTS (SELECT 1 FROM detalle_pedido dp WHERE dp.codigo_producto = pr.codigo_producto);

/*21. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados
alfabéticamente de menor a mayor.*/

SELECT c.nombre_cliente FROM cliente c WHERE EXISTS (SELECT 1 FROM pedido p WHERE c.codigo_cliente = p.codigo_cliente) ORDER BY c.nombre_cliente DESC;