/* 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas. */

SELECT codigo_oficina, ciudad FROM oficina;

+----------------+----------------------+
| codigo_oficina | ciudad               |
+----------------+----------------------+
| BCN-ES         | Barcelona            |
| BOS-USA        | Boston               |
| LON-UK         | Londres              |
| MAD-ES         | Madrid               |
| PAR-FR         | Paris                |
| SFC-USA        | San Francisco        |
| SYD-AU         | Sydney               |
| TAL-ES         | Talavera de la Reina |
| TOK-JP         | Tokyo                |
+----------------+----------------------+

/* 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España. */

SELECT ciudad, telefono FROM oficina WHERE codigo_oficina LIKE '%-ES';

+----------------------+----------------+
| ciudad               | telefono       |
+----------------------+----------------+
| Barcelona            | +34 93 3561182 |
| Madrid               | +34 91 7514487 |
| Talavera de la Reina | +34 925 867231 |
+----------------------+----------------+

/* 3. Devuelve un listado con el email, nombre, apellidos completos (Por ej. Fernandez Alonso,
Mario Alfredo) de los empleados cuyo jefe tiene un código de jefe igual a 7. */

SELECT email, nombre, apellido1, apellido2 FROM empleado WHERE codigo_jefe = 7;

+--------------------------+---------+-----------+-----------+
| email                    | nombre  | apellido1 | apellido2 |
+--------------------------+---------+-----------+-----------+
| mlopez@jardineria.es     | Mariano | L?pez     | Murcia    |
| lcampoamor@jardineria.es | Lucio   | Campoamor | Mart?n    |
| hrodriguez@jardineria.es | Hilario | Rodriguez | Huertas   |
+--------------------------+---------+-----------+-----------+

/* 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa */

SELECT puesto, nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe IS NULL;

+------------------+--------+-----------+-----------+----------------------+
| puesto           | nombre | apellido1 | apellido2 | email                |
+------------------+--------+-----------+-----------+----------------------+
| Director General | Marcos | Maga?a    | Perez     | marcos@jardineria.es |
+------------------+--------+-----------+-----------+----------------------+

/* 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean
representantes de ventas */

SELECT nombre, apellido1, apellido2, puesto FROM empleado WHERE puesto != 'Representante Ventas';

+----------+------------+-----------+-----------------------+
| nombre   | apellido1  | apellido2 | puesto                |
+----------+------------+-----------+-----------------------+
| Marcos   | Maga?a     | Perez     | Director General      |
| Ruben    | L?pez      | Martinez  | Subdirector Marketing |
| Alberto  | Soria      | Carrasco  | Subdirector Ventas    |
| Maria    | Sol?s      | Jerez     | Secretaria            |
| Carlos   | Soria      | Jimenez   | Director Oficina      |
| Francois | Fignon     |           | Director Oficina      |
| Michael  | Bolton     |           | Director Oficina      |
| Hilary   | Washington |           | Director Oficina      |
| Nei      | Nishikori  |           | Director Oficina      |
| Amy      | Johnson    |           | Director Oficina      |
| Kevin    | Fallmer    |           | Director Oficina      |
+----------+------------+-----------+-----------------------+

/* 6. Devuelve un listado con el nombre de todos los clientes españoles. */

SELECT nombre_cliente FROM cliente WHERE pais LIKE 'Spain';

+--------------------------------+
| nombre_cliente                 |
+--------------------------------+
| Lasas S.A.                     |
| Lasas S.A.                     |
| Camunas Jardines S.L.          |
| Dardena S.A.                   |
| Jardin de Flores               |
| Flores Marivi                  |
| Flowers, S.A                   |
| Naturajardin                   |
| Vivero Humanes                 |
| Fuenla City                    |
| Jardines y Mansiones Cactus SL |
| Jardiner?as Mat?as SL          |
| Agrojardin                     |
| Top Campo                      |
| Jardineria Sara                |
| Campohermoso                   |
| Flores S.L.                    |
+--------------------------------+

/* 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido. */

SELECT DISTINCT estado FROM pedido;

+-----------+
| estado    |
+-----------+
| Entregado |
| Rechazado |
| Pendiente |
+-----------+

/* 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en
2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan
repetidos. Resuelva la consulta:
 Utilizando la función YEAR
 Utilizando DATE_FORMAT
 Sin utilizar ninguna de las funciones anteriores.*/

SELECT DISTINCT c.codigo_cliente, p.fecha_pago FROM cliente c, pago p WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';

SELECT DISTINCT c.codigo_cliente, p.fecha_pago FROM cliente c, pago p WHERE YEAR(fecha_pago) = 2008;

SELECT DISTINCT c.codigo_cliente, p.fecha_pago FROM cliente c, pago p WHERE fecha_pago >= '2008-01-01' AND fecha_pago < '2009-01-01';

/* 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos que no han sido entregados a tiempo.*/
SELECT c.codigo_cliente, p.fecha_esperada, p.fecha_entrega, p.estado FROM cliente c, pedido p WHERE p.fecha_esperada < p.fecha_entrega AND estado = 'Entregado';

/*10  Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha
esperada.
 Utilizando la función ADDDATE
 Utilizando la función DATEDIFF */

SELECT p.codigo_pedido, c.codigo_cliente, p.fecha_esperada, p.fecha_entrega FROM cliente c, pedido p WHERE fecha_entrega <= ADDDATE(fecha_esperada, -2);

SELECT p.codigo_pedido, p.codigo_cliente, p.fecha_esperada, p.fecha_entrega FROM pedido p WHERE DATEDIFF(p.fecha_esperada, p.fecha_entrega) >= 2;

 /*11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.*/

 SELECT codigo_pedido, fecha_entrega, estado FROM pedido WHERE estado LIKE 'Rechazado' AND YEAR(fecha_entrega) LIKE '2009';

/*12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de
cualquier año*/

SELECT p.codigo_pedido, p.fecha_entrega FROM pedido p WHERE MONTH(fecha_entrega) = 1;

/*13 Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal.
Ordene el resultado de mayor a menor*/

SELECT p.forma_pago, p.fecha_pago FROM pago p WHERE YEAR(p.fecha_pago) = 2008 AND p.forma_pago = 'PayPal';

/*14 Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en
cuenta que no deben aparecer formas de pago repetidas.*/

SELECT DISTINCT p.forma_pago from pago p;

/*15 Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que
tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta,
mostrando en primer lugar los de mayor precio*/

SELECT p.nombre, p.gama, p.cantidad_en_stock, p.precio_venta FROM producto p WHERE p.gama = 'Ornamentales' AND p.cantidad_en_stock >= 100 ORDER BY p.precio_venta DESC;

/*16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo
representante de ventas tenga el código de empleado 11 o 30.*/

SELECT c.nombre_cliente, c.ciudad, e.codigo_empleado FROM cliente c, empleado e WHERE c.ciudad = 'Madrid' AND (e.codigo_empleado = 11 OR e.codigo_empleado = 30);

/*17. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de
ventas.*/

SELECT c.nombre_cliente, e.nombre, e.apellido1 FROM cliente c JOIN empleado e ON codigo_empleado_rep_ventas = e.codigo_empleado;

/*18. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
representantes de ventas.*/

SELECT c.nombre_cliente, e.nombre AS nombre_representante FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN pago p ON c.codigo_cliente = p.codigo_cliente;

/*19. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus
representantes de ventas.*/
SELECT c.nombre_cliente, e.nombre FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente WHERE p.codigo_cliente IS NULL;

/*20. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
junto con la ciudad de la oficina a la que pertenece el representante.*/ 

SELECT c.nombre_cliente, c.codigo_cliente, e.nombre, o.ciudad FROM cliente c INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina HAVING c.codigo_cliente IN(SELECT codigo_cliente FROM pago) ORDER BY c.codigo_cliente;