                                                                            --Resolucion de Ejercicios--

-- 1) SELECT a.nombre AS Nombre_Producto FROM articulos a;
+-----------------+
| Nombre_Producto |
+-----------------+
| Computadora     |
| Celular         |
| Tablet          |
| Auriculares     |
| Laptop          |
| Gabinete        |
| Monitor         |
| Teclado         |
| Mouse           |
| Disco Duro      |
+-----------------+
10 rows in set (0.000 sec)

--2) SELECT a.nombre AS Nombre_Producto, a.precio AS Precio_Producto FROM articulos a
+-----------------+-----------------+
| Nombre_Producto | Precio_Producto |
+-----------------+-----------------+
| Computadora     |      1500000.00 |
| Celular         |       800000.00 |
| Tablet          |       700000.00 |
| Auriculares     |        10000.00 |
| Laptop          |       690000.00 |
| Gabinete        |       450000.00 |
| Monitor         |       400000.00 |
| Teclado         |        80000.00 |
| Mouse           |        35000.00 |
| Disco Duro      |       100000.00 |
+-----------------+-----------------+
10 rows in set (0.000 sec)

-- 3) SELECT a.precio, a.nombre from articulos a WHERE a.precio < 200000;
+-----------+-------------+
| precio    | nombre      |
+-----------+-------------+
|  10000.00 | Auriculares |
|  80000.00 | Teclado     |
|  35000.00 | Mouse       |
| 100000.00 | Disco Duro  |
+-----------+-------------+
4 rows in set (0.000 sec)

--4)  SELECT a.precio, a.nombre from articulos a WHERE a.precio BETWEEN 60000 AND 1200000;
+-----------+------------+
| precio    | nombre     |
+-----------+------------+
| 800000.00 | Celular    |
| 700000.00 | Tablet     |
| 690000.00 | Laptop     |
| 450000.00 | Gabinete   |
| 400000.00 | Monitor    |
|  80000.00 | Teclado    |
| 100000.00 | Disco Duro |
+-----------+------------+
7 rows in set (0.000 sec)

--5) SELECT (a.precio / 1400) AS Precio_Dolares, a.precio AS Precio_normal, a.nombre AS Nombre_Producto from articulos a ;
+----------------+---------------+-----------------+
| Precio_Dolares | Precio_normal | Nombre_Producto |
+----------------+---------------+-----------------+
|    1071.428571 |    1500000.00 | Computadora     |
|     571.428571 |     800000.00 | Celular         |
|     500.000000 |     700000.00 | Tablet          |
|       7.142857 |      10000.00 | Auriculares     |
|     492.857143 |     690000.00 | Laptop          |
|     321.428571 |     450000.00 | Gabinete        |
|     285.714286 |     400000.00 | Monitor         |
|      57.142857 |      80000.00 | Teclado         |
|      25.000000 |      35000.00 | Mouse           |
|      71.428571 |     100000.00 | Disco Duro      |
+----------------+---------------+-----------------+
10 rows in set (0.000 sec)

--6) SELECT AVG(a.precio) AS Promedio_Productos from articulos a;

+--------------------+
| Promedio_Productos |
+--------------------+
|    476500.00       |
+--------------------+
1 row in set (0.000 sec)

--7) SELECT AVG(a.precio) AS Promedio_Codigo2 from articulos a WHERE a.Codigo_fabricantes = 2;
+------------------+
| Promedio_Codigo2 |
+------------------+
|    442500.000000 |
+------------------+
1 row in set (0.000 sec)

--8) SELECT a.codigo AS Numero_articulo, a.precio AS Precio_Menor_a_180000 FROM articulos a WHERE a.precio >= 180000;
+-----------------+-----------------------+
| Numero_articulo | Precio_Menor_a_180000 |
+-----------------+-----------------------+
|               1 |            1500000.00 |
|               2 |             800000.00 |
|               3 |             700000.00 |
|              90 |             700000.00 |
|               5 |             690000.00 |
|               6 |             450000.00 |
|               7 |             400000.00 |
+-----------------+-----------------------+
7 rows in set (0.001 sec)

--9) SELECT a.nombre AS Nombre_Articulos, a.precio AS Precio_Articulos FROM articulos a WHERE a.precio >= 180000 ORDER BY Precio DESC, Nombre ASC;

+------------------+------------------+
| Nombre_Articulos | Precio_Articulos |
+------------------+------------------+
| Computadora      |       1500000.00 |
| Celular          |        800000.00 |
| Cuca             |        700000.00 |
| Tablet           |        700000.00 |
| Laptop           |        690000.00 |
| Gabinete         |        450000.00 |
| Monitor          |        400000.00 |
+------------------+------------------+

--10) SELECT a.nombre, a.Codigo_fabricantes, a.Codigo, a.precio, f.codigo, f.nombre FROM articulos a, fabricantes f;

--Con innerJoin: SELECT a.nombre, a.fabricante, a.Codigo, a.precio, f.codigo, f.nombre FROM articulos a INNER JOIN fabricantes f ON a.fabricante = f.Codigo;
+-------------+------------+--------+------------+--------+---------+
| nombre      | fabricante | Codigo | precio     | codigo | nombre  |
+-------------+------------+--------+------------+--------+---------+
| Computadora |          1 |      1 | 1500000.00 |      1 | Asus    |
| Celular     |          2 |      2 |  800000.00 |      2 | Lenovo  |
| Calculadora |          2 |     10 |   85000.00 |      2 | Lenovo  |
| Tablet      |          3 |      3 |  700000.00 |      3 | HP      |
| Cuca        |          3 |     90 |  700000.00 |      3 | HP      |
| Auriculares |          4 |      4 |   10000.00 |      4 | Apple   |
| Laptop      |          5 |      5 |  690000.00 |      5 | Acer    |
| Gabinete    |          6 |      6 |  450000.00 |      6 | Toshiba |
| Monitor     |          7 |      7 |  400000.00 |      7 | Samsung |
| Teclado     |          8 |      8 |   80000.00 |      8 | DELL    |
| Mouse       |          9 |      9 |   35000.00 |      9 | EXO     |
| Disco Duro  |         10 |     10 |  100000.00 |     10 | MSI     |
+-------------+------------+--------+------------+--------+---------+
12 rows in set (0.001 sec)

--11) SELECT a.nombre, a.precio, f.nombre FROM articulos a, fabricantes f WHERE a.fabricante = f.codigo;

+-------------+------------+---------+
| nombre      | precio     | nombre  |
+-------------+------------+---------+
| Computadora | 1500000.00 | Asus    |
| Celular     |  800000.00 | Lenovo  |
| Calculadora |   85000.00 | Lenovo  |
| Tablet      |  700000.00 | HP      |
| Cuca        |  700000.00 | HP      |
| Auriculares |   10000.00 | Apple   |
| Laptop      |  690000.00 | Acer    |
| Gabinete    |  450000.00 | Toshiba |
| Monitor     |  400000.00 | Samsung |
| Teclado     |   80000.00 | DELL    |
| Mouse       |   35000.00 | EXO     |
| Disco Duro  |  100000.00 | MSI     |
+-------------+------------+---------+
12 rows in set (0.001 sec)

--12) SELECT f.Nombre AS FabricanteNombre, AVG(a.Precio) AS PrecioMedio FROM articulos a INNER JOIN fabricantes f ON a.fabricante = f.Codigo GROUP BY f.Nombre;


+------------------+----------------+
| FabricanteNombre | PrecioMedio    |
+------------------+----------------+
| Acer             |  690000.000000 |
| Apple            |   10000.000000 |
| Asus             | 1500000.000000 |
| DELL             |   80000.000000 |
| EXO              |   35000.000000 |
| HP               |  700000.000000 |
| Lenovo           |  442500.000000 |
| MSI              |  100000.000000 |
| Samsung          |  400000.000000 |
| Toshiba          |  450000.000000 |
+------------------+----------------+
10 rows in set (0.001 sec)


--13) SELECT f.Nombre AS FabricanteNombre, AVG(a.Precio) AS PrecioMedio FROM articulos a INNER JOIN fabricantes f ON a.fabricante = f.Codigo GROUP BY f.Nombre HAVING AVG(a.precio) >= 150000;

+------------------+----------------+
| FabricanteNombre | PrecioMedio    |
+------------------+----------------+
| Acer             |  690000.000000 |
| Asus             | 1500000.000000 |
| HP               |  700000.000000 |
| Lenovo           |  318333.333333 |
| Samsung          |  400000.000000 |
| Toshiba          |  450000.000000 |
+------------------+----------------+
6 rows in set (0.001 sec)

--14) SELECT a.nombre, MIN(a.precio) AS Mas_Barato FROM articulos a;

+-------------+------------+
| nombre      | Mas_Barato |
+-------------+------------+
| Computadora |   10000.00 |
+-------------+------------+
1 row in set (0.001 sec)

--15)
insert into articulos VALUES('045', '2', 'Parlantes', '70000.00');
+--------+------------+-------------+------------+
| Codigo | Fabricante | Nombre      | Precio     |
+--------+------------+-------------+------------+
|     45 |          2 | Parlantes   |   70000.00 |
+--------+------------+-------------+------------+

--16) UPDATE articulos SET Nombre = 'Impresora Laser' WHERE Codigo = 8;
+--------+------------+-----------------+------------+
| Codigo | Fabricante | Nombre          | Precio     |
+--------+------------+-----------------+------------+
|      8 |          8 | Impresora Laser |   80000.00 |
+--------+------------+-----------------+------------+

--17) SELECT (a.precio *0.9), a.nombre FROM articulos a WHERE a.precio >= 200000;
+-----------------+-------------+
| (a.precio *0.9) | nombre      |
+-----------------+-------------+
|      1350000.00 | Computadora |
|       720000.00 | Celular     |
|       630000.00 | Tablet      |
|       630000.00 | Cuca        |
|       621000.00 | Laptop      |
|       405000.00 | Gabinete    |
|       360000.00 | Monitor     |
+-----------------+-------------+
7 rows in set (0.001 sec)


--)extras

SELECT f.Nombre AS FabricanteNombre, AVG(a.Precio) AS PrecioMedio FROM articulos a INNER JOIN fabricante f ON a.fabricante = f.codigo GROUP BY f.Nombre HAVING AVG(a.Precio) < 60000;

SELECT AVG(a.precio), a.nombre FROM articulos a, fabricantes f WHERE a.fabricante = f.codigo  GROUP BY f.Nombre HAVING AVG(a.precio) < 60000;
+---------------+-------------+
| AVG(a.precio) | nombre      |
+---------------+-------------+
|  10000.000000 | Auriculares |
|  35000.000000 | Mouse       |
+---------------+-------------+
2 rows in set (0.001 sec)

SELECT SUM(precio) FROM articulos; 
+-------------+
| SUM(precio) |
+-------------+
|  5620000.00 |
+-------------+
1 row in set (0.000 sec)

SELECT MIN(precio) FROM articulos;
+-------------+
| MIN(precio) |
+-------------+
|    10000.00 |
+-------------+
1 row in set (0.000 sec)

SELECT MAX(precio) FROM articulos;
+-------------+
| MAX(precio) |
+-------------+
|  1500000.00 |
+-------------+
1 row in set (0.000 sec)

SELECT COUNT(*) FROM articulos;
+----------+
| COUNT(*) |
+----------+
|       13 |
+----------+
1 row in set (0.000 sec)

SELECT AVG(precio) FROM articulos WHERE codigo >= 3;
+---------------+
| AVG(precio)   |
+---------------+
| 301818.181818 |
+---------------+
1 row in set (0.001 sec)

SELECT nombre FROM articulos where nombre LIKE 'C%';
+-------------+
| nombre      |
+-------------+
| Computadora |
| Celular     |
| Calculadora |
| Cuca        |
+-------------+
4 rows in set (0.000 sec)

SELECT nombre from articulos ORDER BY nombre DESC;
+-----------------+
| nombre          |
+-----------------+
| Tablet          |
| Parlantes       |
| Mouse           |
| Monitor         |
| Laptop          |
| Impresora Laser |
| Gabinete        |
| Disco Duro      |
| Cuca            |
| Computadora     |
| Celular         |
| Calculadora     |
| Auriculares     |
+-----------------+
13 rows in set (0.000 sec)

SELECT a.codigo, a.nombre FROM articulos a WHERE a.codigo BETWEEN 5 AND 10;

+--------+-----------------+
| codigo | nombre          |
+--------+-----------------+
|     10 | Calculadora     |
|      5 | Laptop          |
|      6 | Gabinete        |
|      7 | Monitor         |
|      8 | Impresora Laser |
|      9 | Mouse           |
|     10 | Disco Duro      |
+--------+-----------------+
7 rows in set (0.001 sec)