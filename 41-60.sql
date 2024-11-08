/*1. Calcula el precio de venta del producto más caro y más barato en una misma consulta.*/

SELECT MAX(p.precio_venta) AS precio_mayor, MIN(p.precio_venta) AS precio_menor FROM producto p;

/*2. Calcula el número de clientes que tiene la empresa.*/

SELECT COUNT(c.nombre_cliente) AS clientes_en_empresa FROM cliente c;

/*3. ¿Cuántos clientes tiene la ciudad de Madrid?*/

SELECT COUNT(c.nombre_cliente) AS clientes_madrilenios FROM cliente c WHERE c.ciudad LIKE 'Madrid';

/*4. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?*/

SELECT COUNT(c.codigo_cliente), c.ciudad AS clientes_madrilenios  FROM cliente c WHERE c.ciudad LIKE 'M%'  GROUP BY c.ciudad ORDER BY c.ciudad;

/*5. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende
cada uno.*/

SELECT e.nombre, COUNT(c.nombre_cliente) FROM empleado e JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas WHERE puesto LIKE 'Rep%' GROUP BY e.nombre ASC; -- con where no esta

SELECT e.nombre, COUNT(c.nombre_cliente) FROM empleado e JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas GROUP BY e.nombre ASC; -- sin where

SELECT e.nombre, count(c.codigo_cliente) as 'Cantidad clientes' FROM empleado e INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas GROUP BY e.nombre;



/*6. Calcula el número de clientes que no tiene asignado representante de ventas.*/

SELECT COUNT(c.codigo_cliente) AS clientes_sin_rep FROM cliente c WHERE c.codigo_empleado_rep_ventas NOT IN (SELECT codigo_empleado FROM empleado WHERE puesto LIKE 'Rep%'); --con puesto

SELECT count(codigo_cliente) as 'Cantidad Clientes' FROM cliente WHERE codigo_empleado_rep_ventas NOT IN (SELECT codigo_empleado FROM empleado); --sin puesto 

SELECT COUNT(c.nombre_cliente) FROM cliente c WHERE c.codigo_empleado_rep_ventas IS NULL; -- Raro

/*7. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado
deberá mostrar el nombre y los apellidos de cada cliente.*/

SELECT c.nombre_cliente, c.apellido_contacto, MAX(p.fecha_pago) AS ultimo, MIN(p.fecha_pago) AS primero FROM cliente c JOIN pago p ON c.codigo_cliente = p.codigo_cliente GROUP BY c.nombre_cliente;

/*8. Calcula el número de productos diferentes que hay en cada uno de los pedidos.*/
SELECT COUNT(pr.nombre), pe.codigo_pedido FROM producto pr JOIN detalle_pedido dp ON pr.codigo_producto = dp.codigo_producto JOIN pedido pe ON pe.codigo_pedido = dp.codigo_pedido GROUP BY pe.codigo_pedido;

/*9 Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los
pedidos.*/
SELECT SUM(dp.cantidad), pe.codigo_pedido FROM producto pr JOIN detalle_pedido dp ON pr.codigo_producto = dp.codigo_producto JOIN pedido pe ON pe.codigo_pedido = dp.codigo_pedido GROUP BY pe.codigo_pedido ORDER BY pe.codigo_pedido;

/*10. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se
han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades
vendidas.*/

SELECT pr.nombre, COUNT(dt.cantidad) AS unidades_vendidas, pr.cantidad_en_stock FROM producto pr JOIN detalle_pedido dt ON pr.codigo_producto = dt.codigo_producto GROUP BY pr.nombre ORDER BY pr.cantidad_en_stock ASC LIMIT 20; --Para mi es con count, aunque estaba con sum

/*11. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA
y el total facturado. La base imponible se calcula sumando el coste del producto por el número
de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el
total la suma de los dos campos anteriores.*/

SELECT SUM(cantidad * precio_unidad) AS base_imponible, SUM(cantidad * precio_unidad) * 0.21 AS IVA, SUM((cantidad * precio_unidad) - (cantidad * precio_unidad) * 0.21) AS total_facturado FROM detalle_pedido;

/*12. La misma información que en la pregunta anterior, pero agrupada por código de producto.*/
SELECT SUM(cantidad * precio_unidad) AS base_imponible, SUM(cantidad * precio_unidad) * 0.21 AS IVA, SUM((cantidad * precio_unidad) - (cantidad * precio_unidad) * 0.21) AS total_facturado FROM detalle_pedido GROUP BY codigo_producto;

/*13. La misma información que en la pregunta anterior, pero agrupada por código de producto
filtrada por los códigos que empiecen por OR.*/

SELECT 
    pr.codigo_producto,
    SUM(dp.cantidad * dp.precio_unidad) AS base_imponible,
    SUM(dp.cantidad * dp.precio_unidad) * 0.21 AS iva 
    FROM detalle_pedido dp 
    JOIN producto pr ON pr.codigo_producto = dp.codigo_producto
    AND pr.codigo_producto LIKE 'OR%'
    GROUP BY pr.codigo_producto ; -- mio

SELECT SUM(cantidad * precio_unidad) AS base_imponible, SUM(cantidad * precio_unidad) * 0.21 AS IVA, SUM((cantidad * precio_unidad) - (cantidad * precio_unidad) * 0.21) AS total_facturado FROM detalle_pedido WHERE codigo_producto LIKE "OR%" GROUP BY codigo_producto; -- porta

/*14. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará
el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).*/

SELECT pr.nombre, dp.cantidad AS unidaddes_vendidas, SUM(dp.precio_unidad * dp.cantidad) AS total_facturado, SUM(dp.cantidad * dp.precio_unidad) - SUM(dp.precio_unidad * dp.cantidad * 0.21) AS total_facturado_iva FROM detalle_pedido dp JOIN producto pr ON pr.codigo_producto = dp.codigo_producto GROUP BY pr.nombre HAVING SUM(dp.precio_unidad * dp.cantidad) > 3000;


/*15. Devuelve el nombre del cliente con mayor límite de crédito.*/

SELECT nombre_cliente, limite_credito FROM cliente WHERE limite_credito = (SELECT max(limite_credito) FROM cliente);

/*16. Devuelve el nombre del producto que tenga el precio de venta más caro.*/

SELECT nombre, precio_venta FROM producto WHERE precio_venta = (SELECT max(precio_venta) FROM producto);

/*17. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que
tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a
partir de los datos de la tabla detalle_pedido. Una vez que sepa cuál es el código del producto,
puede obtener su nombre fácilmente.)*/

--SELECT pr.nombre, MAX(dp.cantidad) AS total_unidades_vendidas FROM producto pr JOIN detalle_pedido dp --ON pr.codigo_producto = dp.codigo_producto;

SELECT pr.nombre, dp.cantidad FROM producto pr JOIN detalle_pedido dp WHERE dp.cantidad >= ALL (SELECT cantidad FROM detalle_pedido) ORDER BY pr.nombre DESC LIMIT 1; -- esta bien

/*18. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin
utilizar INNER JOIN).*/

SELECT c.limite_credito, p.total FROM cliente c, pago p WHERE c.codigo_cliente = p.codigo_cliente AND c.limite_credito > p.total;

/*19. Devuelve el producto que más unidades tiene en stock.*/
SELECT pr.nombre, pr.cantidad_en_stock AS menos_unidades FROM producto pr WHERE cantidad_en_stock = (SELECT max(cantidad_en_stock) FROM producto);

/*20. Devuelve el producto que menos unidades tiene en stock.*/

SELECT pr.nombre, pr.cantidad_en_stock AS menos_unidades FROM producto pr WHERE cantidad_en_stock = (SELECT min(cantidad_en_stock) FROM producto);
