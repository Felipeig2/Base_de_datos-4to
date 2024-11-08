/*1. Listar los nombres de los clientes que tienen asignado el representante Lorena Pauxton
(suponiendo que no puede haber representantes con el mismo nombre).*/
SELECT c.nombre_cliente, e.nombre, e.apellido1 FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = codigo_empleado AND e.nombre LIKE 'Lorena' AND e.apellido1 LIKE 'Paxton';

/*2. Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados
que tiene.*/

SELECT o.ciudad, COUNT(e.nombre) AS numero_empleados FROM oficina o JOIN empleado e ON e.codigo_oficina = o.codigo_oficina GROUP BY o.ciudad ORDER BY o.ciudad;

/*3. Listar a los vendedores que no trabajan en oficinas dirigidas por el empleado 108.*/

SELECT pr.proveedor, e.codigo_empleado FROM producto pr JOIN detalle_pedido dp ON pr.codigo_producto = dp.codigo_producto JOIN pedido pe ON pe.codigo_pedido = dp.codigo_pedido JOIN cliente c ON c.codigo_cliente = pe.codigo_cliente JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado WHERE e.codigo_empleado != 108 AND e.puesto LIKE 'Rep%';

/*la 4 y la 5*/

/*6. Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el
número de teléfono de la oficina del representante de ventas, de aquellos clientes que no
hayan realizado ningún pago.*/

SELECT c.nombre_cliente, 
e.nombre AS nombre_rep, 
e.apellido1 AS apellido_rep, 
o.telefono 
FROM oficina o 
JOIN empleado e ON o.codigo_oficina = e.codigo_oficina 
JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado 
WHERE c.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago) AND e.puesto LIKE 'Rep%';

/*7. Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer
apellido de su representante de ventas y la ciudad donde está su oficina.*/

SELECT c.nombre_cliente, e.apellido1, o.ciudad FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE e.puesto LIKE 'Rep%';

/*8. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no
sean representante de ventas de ningún cliente.*/

SELECT e.nombre, e.apellido1, e.puesto, o.telefono FROM oficina o JOIN empleado e ON o.codigo_oficina = e.codigo_oficina WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente) AND e.puesto LIKE 'Rep%';

/*9. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto
Soria.*/

SELECT nombre, Apellido1, apellido2, email FROM empleado  WHERE codigo_jefe = (SELECT codigo_empleado FROM empleado WHERE nombre = 'Alberto' AND apellido1 = 'Soria');

/*10. Devuelve el nombre del cliente con mayor límite de crédito. (utilizar ALL, ANY)*/
SELECT nombre_cliente FROM cliente WHERE limite_credito >= ALL (SELECT limite_credito FROM cliente);
-- SELECT nombre_cliente FROM cliente WHERE limite_credito >= ANY (SELECT max(limite_credito) FROM cliente);

/*11. Devuelve el nombre del producto que tenga el precio de venta más caro. (utilizar ALL, ANY)*/
SELECT nombre, precio_venta FROM producto WHERE precio_venta >= ALL (SELECT precio_venta FROM producto);
-- SELECT nombre, precio_venta FROM producto WHERE precio_venta >= ANY (SELECT precio_venta FROM producto);

/*12. Devuelve el producto que menos unidades tiene en stock. (utilizar ALL, ANY)*/

-- SELECT nombre, cantidad_en_stock FROM producto WHERE cantidad_en_stock < ALL (SELECT cantidad_en_stock FROM producto);
-- SELECT nombre, cantidad_en_stock FROM producto WHERE cantidad_en_stock = ANY (SELECT cantidad_en_stock FROM producto WHERE cantidad_en_stock < (SELECT MIN(cantidad_en_stock) FROM producto));

/*13. Devuelve el nombre, apellido1 y cargo de los empleados que no representan a ningún cliente.
(Utilizar IN, NOT IN)*/

SELECT e.nombre, e.apellido1 FROM empleado e WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);
--Con in?

/*14. Devuelve un listado que muestre solamente a los clientes que no han realizado ningún pago.*/
SELECT nombre_cliente FROM cliente WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

/*15 Devuelve un listado que muestre solamente a los clientes que sí han realizado algún pago.*/
SELECT nombre_cliente FROM cliente WHERE codigo_cliente IN (SELECT codigo_cliente FROM pago);

/*16. Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
SELECT nombre FROM producto WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);

/*17. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no
sean representante de ventas de ningún cliente.(Utilizar IN, NOT IN)*/
SELECT e.nombre, e.apellido1, e.puesto, o.telefono FROM oficina o JOIN empleado e ON o.codigo_oficina = e.codigo_oficina WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

/*18. Devuelve un listado que muestre solamente a los clientes que no han realizado ningún pago.
(Utilizar EXISTS y NOT EXISTS)*/

SELECT c.nombre_cliente FROM cliente c WHERE NOT EXISTS (SELECT codigo_cliente FROM pago p WHERE p.codigo_cliente = c.codigo_cliente);

-- SELECT c.nombre_cliente FROM cliente c WHERE NOT EXISTS (SELECT 1 FROM pago p WHERE p.codigo_cliente = c.codigo_cliente);

/*19. Devuelve un listado que muestre solamente a los clientes que sí han realizado algún pago.
(Utilizar EXISTS y NOT EXISTS)*/
SELECT c.nombre_cliente FROM cliente c WHERE EXISTS (SELECT codigo_cliente FROM pago p WHERE p.codigo_cliente = c.codigo_cliente);  
-- SELECT c.nombre_cliente FROM cliente c WHERE EXISTS (SELECT 1 FROM pago p WHERE p.codigo_cliente = c.codigo_cliente);



/*20. Devuelve un listado de los productos que nunca han aparecido en un pedido. (Utilizar EXISTS y
NOT EXISTS)*/

SELECT pr.nombre FROM producto pr WHERE EXISTS (SELECT 1 FROM detalle_pedido dp WHERE dp.codigo_producto = pr.codigo_producto);

/*21. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados
alfabéticamente de menor a mayor.*/

SELECT c.nombre_cliente, p.fecha_pedido FROM cliente c JOIN pedido p ON p.codigo_cliente = c.codigo_cliente WHERE YEAR(fecha_pedido) = 2008 AND EXISTS (SELECT 1 FROM pedido p WHERE c.codigo_cliente = p.codigo_cliente) ORDER BY c.nombre_cliente ASC;