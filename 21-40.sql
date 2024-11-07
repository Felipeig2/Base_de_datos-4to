/*1. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus
representantes junto con la ciudad de la oficina a la que pertenece el representante.*/
SELECT c.nombre_cliente, e.nombre AS nombre_representante, o.ciudad FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN oficina o  ON e.codigo_oficina = o.codigo_oficina WHERE c.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

/*2. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.*/

SELECT c.region, o.linea_direccion2 FROM oficina o JOIN empleado e ON o.codigo_oficina = e.codigo_oficina JOIN cliente c ON codigo_empleado_rep_ventas = codigo_empleado AND c.region LIKE 'Fuenlabrada';

/*3. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la
oficina a la que pertenece el representante.*/

SELECT c.nombre_cliente, e.nombre, o.ciudad FROM empleado e JOIN oficina o ON e.codigo_oficina = o.codigo_oficina JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

/*4. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.*/

SELECT e.nombre AS empleado, j.nombre AS jefe FROM empleado e LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado;

/*5. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.*/
SELECT c.nombre_cliente, p.fecha_esperada, p.fecha_entrega, p.estado FROM cliente c JOIN pedido p ON c.codigo_cliente = p.codigo_cliente AND estado LIKE 'Entre%' AND fecha_esperada < fecha_entrega;

/*6. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.*/

SELECT DISTINCT c.nombre_cliente, g.gama FROM cliente c JOIN pedido p ON c.codigo_cliente = p.codigo_cliente JOIN detalle_pedido d ON p.codigo_pedido = d.codigo_pedido JOIN producto pr ON pr.codigo_producto = d.codigo_producto JOIN gama_producto g ON pr.gama = g.gama;

/*7. Devuelve un listado que muestre solamente a los clientes que no han realizado ningún pago.*/

SELECT c.nombre_cliente FROM cliente c WHERE c.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

/*8. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.*/
SELECT c.nombre_cliente FROM cliente c WHERE c.codigo_cliente NOT IN (SELECT codigo_cliente FROM pedido);

/*9. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no
han realizado ningún pedido.*/
SELECT c.nombre_cliente FROM cliente c WHERE c.codigo_cliente NOT IN (SELECT codigo_cliente FROM pedido) AND c.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

/*10. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.*/
SELECT e.nombre FROM empleado e LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE o.codigo_oficina IS NULL;

/*11. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.*/
SELECT e.nombre FROM empleado e LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas WHERE c.codigo_empleado_rep_ventas IS NULL;

/*12. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no
tienen un cliente asociado.*/

SELECT e.nombre FROM empleado e LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE c.codigo_empleado_rep_ventas IS NULL AND o.codigo_oficina IS NULL;

/*13 hasta 16*/


/*17. ¿Cuántos empleados hay en la compañía?*/
SELECT SUM(e.codigo_empleado) AS empleados FROM empleado e;
/*18. ¿Cuántos clientes tiene cada país?*/
SELECT c.pais, SUM(c.codigo_cliente) AS clientes_por_pais FROM cliente c GROUP BY c.pais DESC;

/*19. ¿Cuál fue el pago medio en 2009?*/

SELECT AVG(p.total) AS pago_medio_2009 FROM pago p WHERE YEAR(p.fecha_pago) = 2009;

/*20. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el
número de pedidos.*/

SELECT p.estado, COUNT(p.codigo_pedido) AS pedido_por_estado FROM pedido p JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido GROUP BY p.estado ORDER BY p.codigo_pedido DESC;


















/*11. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.*/
SELECT e.nombre FROM empleado e WHERE e.codigo_empleado NOT IN(SELECT codigo_empleado_rep_ventas FROM cliente);

MariaDB [jardineria]> SELECT e.nombre FROM empleado e WHERE e.codigo_empleado NOT IN(SELECT codigo_empleado_rep_ventas FROM cliente);

SELECT e.nombre, c.nombre_cliente FROM empleado e, cliente c WHERE c.codigo_empleado_rep_ventas IS NULL;
+-------------+
| nombre      |
+-------------+
| Marcos      |
| Ruben       |
| Alberto     |
| Maria       |
| Juan Carlos |
| Carlos      |
| Hilario     |
| David       |
| Oscar       |
| Francois    |
| Laurent     |
| Hilary      |
| Marcus      |
| Nei         |
| Narumi      |
| Takuma      |
| Amy         |
| Larry       |
| John        |
| Kevin       |
+-------------+
20 rows in set (0.005 sec)
SELECT e.codigo_empleado, e.nombre, c.codigo_empleado_rep_ventas FROM empleado e LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas WHERE c.codigo_empleado_rep_ventas IS NULL;



/*12. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no
tienen un cliente asociado.*/

SELECT e.nombre, o.codigo_oficina, c.codigo_cliente FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE e.codigo_oficina IS NULL OR e.codigo_empleado IS NULL;



/* 13. Devuelve un listado de los productos que nunca han aparecido en un pedido. */
SELECT 