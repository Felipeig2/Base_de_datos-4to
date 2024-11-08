1)
SELECT e.codigo_empleado, e.nombre, CONCAT(apellido1, ' ', apellido2) AS apellido
FROM empleado e WHERE e.puesto NOT LIKE 'representante ventas';

+-----------------+----------+----------------+
| codigo_empleado | nombre   | apellido       |
+-----------------+----------+----------------+
|               1 | Marcos   | Maga?a Perez   |
|               2 | Ruben    | L?pez Martinez |
|               3 | Alberto  | Soria Carrasco |
|               4 | Maria    | Sol?s Jerez    |
|               7 | Carlos   | Soria Jimenez  |
|              11 | Emmanuel | Maga?a Perez   |
|              15 | Francois | Fignon         |
|              18 | Michael  | Bolton         |
|              20 | Hilary   | Washington     |
|              23 | Nei      | Nishikori      |
|              26 | Amy      | Johnson        |
|              29 | Kevin    | Fallmer        |
+-----------------+----------+----------------+

2)
SELECT c.codigo_cliente, c.nombre_cliente, p.fecha_pago
FROM cliente c JOIN pago p ON c.codigo_cliente = p.codigo_cliente 
WHERE YEAR(p.fecha_pago) = 2008;

+----------------+--------------------------------+------------+
| codigo_cliente | nombre_cliente                 | fecha_pago |
+----------------+--------------------------------+------------+
|              1 | GoldFish Garden                | 2008-11-10 |
|              1 | GoldFish Garden                | 2008-12-10 |
|             13 | Camunas Jardines S.L.          | 2008-08-04 |
|             14 | Dardena S.A.                   | 2008-07-15 |
|             26 | Jardines y Mansiones Cactus SL | 2008-03-18 |
+----------------+--------------------------------+------------+

3)
SELECT p.codigo_pedido, p.fecha_pedido, p.fecha_entrega 
FROM pedido p 
WHERE MONTH(p.fecha_entrega) = 1;

+---------------+--------------+---------------+
| codigo_pedido | fecha_pedido | fecha_entrega |
+---------------+--------------+---------------+
|             1 | 2006-01-17   | 2006-01-19    |
|            13 | 2009-01-12   | 2009-01-15    |
|            15 | 2009-01-09   | 2009-01-11    |
|            16 | 2009-01-06   | 2009-01-15    |
|            17 | 2009-01-08   | 2009-01-11    |
|            18 | 2009-01-05   | 2009-01-07    |
|            21 | 2009-01-09   | 2009-01-09    |
|            22 | 2009-01-11   | 2009-01-13    |
|            32 | 2007-01-07   | 2007-01-27    |
|            55 | 2008-12-10   | 2009-01-11    |
|            58 | 2009-01-24   | 2009-01-30    |
|            64 | 2009-01-24   | 2009-01-30    |
|            75 | 2009-01-11   | 2009-01-13    |
|            79 | 2009-01-12   | 2009-01-13    |
|            82 | 2009-01-20   | 2009-01-29    |
|            95 | 2008-01-04   | 2008-01-19    |
|           100 | 2009-01-10   | 2009-01-15    |
|           102 | 2008-12-28   | 2009-01-08    |
|           103 | 2009-01-15   | 2009-01-24    |
|           113 | 2008-10-28   | 2009-01-09    |
|           114 | 2009-01-15   | 2009-01-31    |
|           119 | 2009-01-10   | 2009-01-15    |
|           121 | 2008-12-28   | 2009-01-08    |
|           123 | 2009-01-15   | 2009-01-24    |
+---------------+--------------+---------------+

4)
SELECT c.codigo_cliente, c.nombre_cliente, c.codigo_empleado_rep_ventas, p.forma_pago 
FROM cliente c JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE EXISTS ( SELECT codigo_cliente FROM pago );

+----------------+--------------------------------+----------------------------+---------------+
| codigo_cliente | nombre_cliente                 | codigo_empleado_rep_ventas | forma_pago    |
+----------------+--------------------------------+----------------------------+---------------+
|              1 | GoldFish Garden                |                         19 | PayPal        |
|              1 | GoldFish Garden                |                         19 | PayPal        |
|              3 | Gardening Associates           |                         19 | PayPal        |
|              3 | Gardening Associates           |                         19 | PayPal        |
|              3 | Gardening Associates           |                         19 | PayPal        |
|              4 | Gerudo Valley                  |                         22 | PayPal        |
|              4 | Gerudo Valley                  |                         22 | PayPal        |
|              4 | Gerudo Valley                  |                         22 | PayPal        |
|              4 | Gerudo Valley                  |                         22 | PayPal        |
|              4 | Gerudo Valley                  |                         22 | PayPal        |
|              5 | Tendo Garden                   |                         22 | Transferencia |
|              7 | Beragua                        |                         11 | Cheque        |
|              9 | Naturagua                      |                         11 | PayPal        |
|             13 | Camunas Jardines S.L.          |                          8 | PayPal        |
|             14 | Dardena S.A.                   |                          8 | PayPal        |
|             15 | Jardin de Flores               |                         30 | PayPal        |
|             15 | Jardin de Flores               |                         30 | PayPal        |
|             16 | Flores Marivi                  |                          5 | PayPal        |
|             19 | Golf S.A.                      |                         12 | PayPal        |
|             23 | Sotogrande                     |                         12 | PayPal        |
|             26 | Jardines y Mansiones Cactus SL |                          9 | PayPal        |
|             27 | Jardiner?as Mat?as SL          |                          9 | PayPal        |
|             28 | Agrojardin                     |                         30 | PayPal        |
|             30 | Jardineria Sara                |                          5 | PayPal        |
|             35 | Tutifruti S.A                  |                         31 | PayPal        |
|             38 | El Jardin Viviente S.L         |                         31 | PayPal        |
+----------------+--------------------------------+----------------------------+---------------+

5)
SELECT o.codigo_oficina, prod.gama
FROM oficina o 
JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
JOIN producto prod ON dp.codigo_producto = prod.codigo_producto
WHERE prod.gama LIKE 'frutales' GROUP BY o.codigo_oficina;
+----------------+----------+
| codigo_oficina | gama     |
+----------------+----------+
| BCN-ES         | Frutales |
| BOS-USA        | Frutales |
| MAD-ES         | Frutales |
| SFC-USA        | Frutales |
| SYD-AU         | Frutales |
| TAL-ES         | Frutales |
+----------------+----------+

6)
SELECT COUNT(codigo_empleado) AS empleados FROM empleado;
+-----------+
| empleados |
+-----------+
|        31 |
+-----------+

7)
SELECT MAX(precio_venta) AS 'mas_caro', MIN(precio_venta) AS 'mas_barato' FROM producto;
+----------+------------+
| mas_caro | mas_barato |
+----------+------------+
|   462.00 |       1.00 |
+----------+------------+

8)
SELECT e.nombre AS nombre_empleado, COUNT(c.nombre_cliente) AS clientes
FROM empleado e JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
GROUP BY e.nombre;
+-----------------+----------+
| nombre_empleado | clientes |
+-----------------+----------+
| Emmanuel        |        5 |
| Felipe          |        5 |
| Jos? Manuel     |        5 |
| Julian          |        5 |
| Lionel          |        2 |
| Lorena          |        2 |
| Lucio           |        2 |
| Mariano         |        4 |
| Mariko          |        2 |
| Michael         |        2 |
| Walter Santiago |        2 |
+-----------------+----------+

9)
SELECT dp.codigo_pedido, p.nombre, SUM(dp.cantidad) AS vendidos 
FROM detalle_pedido dp JOIN producto p ON dp.codigo_producto = p.codigo_producto 
GROUP BY dp.codigo_pedido;
+---------------+--------------------------------------------+----------+
| codigo_pedido | nombre                                     | vendidos |
+---------------+--------------------------------------------+----------+
|             1 | Cerezo                                     |      113 |
|             2 | Manzano Starking Delicious                 |      161 |
|             3 | Nogal Com?n                                |      232 |
|             4 | Ciruelo Santa Rosa                         |      179 |
|             8 | Peral                                      |       14 |
|             9 | Ajedrea                                    |      625 |
|            10 | Higuera                                    |       40 |
|            11 | Petrosilium Hortense (Peregil)             |      260 |
|            12 | Thymus Vulgaris                            |      290 |
|            13 | Sierra de Poda 400MM                       |       22 |
|            14 | Nectarina                                  |       21 |
|            15 | Kaki                                       |       21 |
|            16 | Azad?n                                     |       22 |
|            17 | Sierra de Poda 400MM                       |       25 |
|            18 | Rastrillo de Jard?n                        |       16 |
|            19 | Azad?n                                     |       41 |
|            20 | Sierra de Poda 400MM                       |       22 |
|            21 | Pala                                       |       30 |
|            22 | Phoenix Canariensis                        |        1 |
|            23 | Lav?ndula Dentata                          |      194 |
|            24 | Rastrillo de Jard?n                        |       19 |
|            25 | Granado                                    |       29 |
|            26 | Calamondin Copa                            |       27 |
|            27 | Expositor Mimosa Semilla Mix               |       84 |
|            28 | Limonero 30/40                             |       12 |
|            29 | Higuera                                    |       40 |
|            30 | Melissa                                    |       33 |
|            31 | Thymus Vulgaris                            |       26 |
|            32 | Sierra de Poda 400MM                       |       40 |
|            33 | Rosal bajo 1?? -En maceta-inicio brotaci?n |      905 |
|            34 | Mandarino calibre 8/10                     |       56 |
|            35 | Pala                                       |      178 |
|            36 | Azad?n                                     |       28 |
|            37 | Olea-Olivos                                |      245 |
|            38 | Sierra de Poda 400MM                       |        7 |
|            39 | Rastrillo de Jard?n                        |        9 |
|            40 | Ajedrea                                    |       12 |
|            41 | Mejorana                                   |       10 |
|            42 | Mentha Sativa                              |        4 |
|            43 | Salvia Mix                                 |        9 |
|            44 | Thymus Citriodra (Tomillo lim?n)           |        5 |
|            45 | Thymus Vulgaris                            |       10 |
|            46 | Expositor C?tricos Mix                     |       12 |
|            47 | Nectarina                                  |       14 |
|            48 | Olea-Olivos                                |      147 |
|            49 | Pinus Halepensis                           |       65 |
|            50 | Chamaerops Humilis                         |       71 |
|            51 | Archontophoenix Cunninghamiana             |      200 |
|            52 | Cerezo                                     |       10 |
|            53 | Kaki                                       |        9 |
|            54 | Sierra de Poda 400MM                       |       69 |
|            55 | Forsytia Intermedia "Lynwood"              |       20 |
|            56 | Camelia japonica ejemplar                  |       22 |
|            57 | Cerezo                                     |       17 |
|            58 | Mimosa Semilla Bayleyana                   |      364 |
|            59 | Cerezo                                     |       10 |
|            60 | Cerezo                                     |       10 |
|            61 | Cerezo                                     |       10 |
|            62 | Cerezo                                     |       10 |
|            63 | Cerezo                                     |       10 |
|            64 | Cerezo                                     |       10 |
|            65 | Cerezo                                     |       10 |
|            66 | Cerezo                                     |       10 |
|            67 | Cerezo                                     |       10 |
|            68 | Cerezo                                     |       10 |
|            74 | Cerezo                                     |       91 |
|            75 | Petrosilium Hortense (Peregil)             |      130 |
|            76 | Thymus Vulgaris                            |      374 |
|            77 | Rastrillo de Jard?n                        |       49 |
|            78 | Peral Blanq. de Aranjuez                   |      153 |
|            79 | Phoenix Canariensis                        |       50 |
|            80 | Limonero 30/40                             |      162 |
|            81 | Tuja orientalis "Aurea nana"               |       30 |
|            82 | Chamaerops Humilis                         |       34 |
|            83 | Tuja orientalis "Aurea nana"               |       30 |
|            89 | Peral                                      |       32 |
|            90 | Ajedrea                                    |       41 |
|            91 | Nectarina                                  |      101 |
|            92 | Peral                                      |       62 |
|            93 | N?spero Tanaca                             |       79 |
|            94 | Sierra de Poda 400MM                       |       45 |
|            95 | Limonero 2 a?os injerto                    |       20 |
|            96 | Membrillero Gigante de Wranja              |       36 |
|            97 | Manzano Reineta                            |       36 |
|            98 | Ciruelo Friar                              |       62 |
|            99 | Acer Pseudoplatanus                        |       45 |
|           100 | Manzano                                    |       60 |
|           101 | Petrosilium Hortense (Peregil)             |      209 |
|           102 | Rastrillo de Jard?n                        |       55 |
|           103 | Peral Blanq. de Aranjuez                   |       64 |
|           104 | Kaki                                       |      122 |
|           105 | Chamaerops Humilis                         |       48 |
|           106 | Thymus Vulgaris                            |      278 |
|           107 | Azad?n                                     |      158 |
|           108 | Peral Blanq. de Aranjuez                   |      112 |
|           109 | Pitimini rojo                              |       69 |
|           110 | Santolina Chamaecyparys                    |       21 |
|           111 | Cerezo                                     |       10 |
|           112 | Cerezo                                     |       10 |
|           113 | Cerezo                                     |       10 |
|           114 | Cerezo                                     |       10 |
|           115 | Cerezo                                     |       10 |
|           116 | Pala                                       |       78 |
|           117 | Higuera                                    |       24 |
|           118 | Cerezo                                     |       10 |
|           119 | Cerezo                                     |       10 |
|           120 | Cerezo                                     |       10 |
|           121 | Cerezo                                     |       10 |
|           122 | Cerezo                                     |       10 |
|           123 | Cerezo                                     |       10 |
|           124 | Cerezo                                     |       10 |
|           125 | Cerezo                                     |       10 |
|           126 | Cerezo                                     |       10 |
|           127 | Cerezo                                     |       10 |
|           128 | Melissa                                    |       33 |
+---------------+--------------------------------------------+----------+

10)
SELECT nombre_cliente, limite_credito FROM cliente GROUP BY limite_credito DESC LIMIT 1;
+----------------+----------------+
| nombre_cliente | limite_credito |
+----------------+----------------+
| Tendo Garden   |      600000.00 |
+----------------+----------------+

