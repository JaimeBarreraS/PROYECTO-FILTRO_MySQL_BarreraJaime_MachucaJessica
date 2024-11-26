USE Palmaris_Tech;

-- ############## CONSULTAS CON JOIN ###################

-- 1. Ventas por cliente

SELECT C.nombre, C.apellidos, SUM(V.total) AS total_ventas
FROM Cliente C
JOIN Venta V ON C.id_cliente = V.id_cliente
GROUP BY C.id_cliente;

-- 2. Productos más vendidos

SELECT I.nombre, SUM(D.cantidad_vendida) AS total_vendido
FROM Inventario I
JOIN Detalle_Venta D ON I.id_producto = D.id_produccion
GROUP BY I.nombre;

-- 3. Productos por proveedor

SELECT P.nombre AS proveedor, I.nombre AS producto
FROM Proveedor P
JOIN Inventario I ON P.id_proveedor = I.id_proveedor;

-- 4. Cultivos por estado

SELECT C.variedad, E.descripcion_estado
FROM Cultivo C
JOIN Estado E ON C.id_estado = E.id_estado
WHERE E.descripcion_estado = 'Activo';

-- 5. Empleados por salario

SELECT E.nombre, E.apellidos, S.salario_base
FROM Empleado E
JOIN Salario S ON E.id_empleado = S.id_empleado
WHERE S.salario_base > 2000;

-- 6. detalles de la maquinaria asignada a esos cultivos

SELECT E.nombre AS empleado,C.variedad AS cultivo,
M.nombre AS maquinaria,A.actividad,A.fecha_asignacion
FROM Asignacion_Empleado A
JOIN Empleado E ON A.id_empleado = E.id_empleado
JOIN Cultivo C ON A.id_cultivo = C.id_cultivo
JOIN Maquinaria M ON C.id_lote = M.id_maquinaria
ORDER BY E.nombre, C.variedad;

-- 7. Gastos por fertilización y tipo de insumo utilizado

SELECT F.insumo_utilizado, SUM(G.pago) AS total_gastos
FROM Gastos G
JOIN Fertilizacion F ON G.id_cultivo = F.id_cultivo
GROUP BY F.insumo_utilizado;

-- 8. Empleados y su promedio de horas trabajadas por asignación

SELECT E.nombre, E.apellidos, AVG(A.duracion) AS promedio_horas
FROM Empleado E
JOIN Asignacion_Empleado A ON E.id_empleado = A.id_empleado
GROUP BY E.id_empleado;

-- 9. Cultivos con rendimiento superior a 100 toneladas

SELECT C.variedad, SUM(P.toneladas_RFF) AS total_produccion
FROM Cultivo C
JOIN Produccion P ON C.id_cultivo = P.id_cultivo
GROUP BY C.variedad
HAVING total_produccion > 100;

-- 10. Ventas realizadas por clientes con frecuencia mensual

SELECT V.id_venta, V.total
FROM Venta V
JOIN Cliente C ON V.id_cliente = C.id_cliente
WHERE C.frecuencia_compra = 'Mensual';

-- 11. Empleados con asignaciones superiores a 5 horas

SELECT E.nombre, E.apellidos, COUNT(A.id_asignacion) AS total_asignaciones
FROM Empleado E
JOIN Asignacion_Empleado A ON E.id_empleado = A.id_empleado
GROUP BY E.id_empleado
HAVING total_asignaciones;

-- 12. Cultivos de mayor rentabilidad

SELECT C.variedad, SUM(P.toneladas_RFF * P.id_cultivo) AS rentabilidad
FROM Cultivo C
JOIN Produccion P ON C.id_cultivo = P.id_cultivo
GROUP BY C.variedad
ORDER BY rentabilidad DESC;

-- ####### CONSULTAS ###########

-- 13. Ventas por cliente

SELECT C.nombre, C.apellidos, SUM(V.total) AS total_ventas
FROM Cliente C, Venta V
WHERE C.id_cliente = V.id_cliente
GROUP BY C.id_cliente;

-- 14.obtener los empleados y los cultivos asignados

SELECT E.nombre AS empleado, E.apellidos AS apellidos, C.variedad AS cultivo, 
A.fecha_asignacion AS fecha_asignacion
FROM Empleado E, Cultivo C, Asignacion_Empleado A
WHERE E.id_empleado = A.id_empleado
AND C.id_cultivo = A.id_cultivo
ORDER BY E.nombre, A.fecha_asignacion;

-- 15. Listado de empleados y su estado:
SELECT nombre, apellidos, ciudad
FROM Empleado
WHERE id_estado = 1;

-- 16. Productos por proveedor

SELECT P.nombre AS proveedor, I.nombre AS producto
FROM Proveedor P, Inventario I
WHERE I.id_proveedor = P.id_proveedor;

-- 17. Cultivos con fecha de siembra posterior a 2023

SELECT C.variedad, C.fecha_siembra
FROM Cultivo C
WHERE C.fecha_siembra > '2023-01-01';

-- 18. Ventas realizadas por clientes con frecuencia mensual

SELECT V.id_venta, V.total
FROM Venta V, Cliente C
WHERE V.id_cliente = C.id_cliente
AND C.frecuencia_compra = 'Mensual';

-- 19. Cultivos sembrados en un año específico:
SELECT variedad, fecha_siembra
FROM Cultivo
WHERE YEAR(fecha_siembra) = 2024;

-- 20. Total de ventas por cliente:
SELECT id_cliente, SUM(total) AS total_ventas
FROM Venta
GROUP BY id_cliente;

-- 21. Proveedores con productos con cantidad menor a 10

SELECT P.nombre AS proveedor, I.nombre AS producto
FROM Proveedor P, Inventario I
WHERE P.id_proveedor = I.id_proveedor AND I.cantidad_disponible < 10;

-- 22. Empleados con más de 2 faltas
SELECT id_empleado, dias_faltas
FROM Salario
WHERE dias_faltas > 2;

-- 23. Proveedor que suministra un tipo de producto específico
SELECT nombre, producto_sumistrado
FROM Proveedor
WHERE producto_sumistrado = 'Fertilizantes';

-- 24. Cultivos con menor rendimiento por mes

SELECT C.variedad, MONTH(P.fecha_cosecha) AS mes, MIN(P.toneladas_RFF) AS minimo_rendimiento
FROM Cultivo C, Produccion P
WHERE C.id_cultivo = P.id_cultivo
GROUP BY C.variedad, MONTH(P.fecha_cosecha);

-- 25. Empleados con salarios superiores a 1000

SELECT E.nombre, E.apellidos, S.salario_base
FROM Empleado E, Salario S
WHERE E.id_empleado = S.id_empleado
AND S.salario_base > 1000;

-- 26. Total de producción por cultivo
SELECT id_cultivo, SUM(toneladas_RFF) AS total_produccion
FROM Produccion
GROUP BY id_cultivo;

-- 27. Proveedores con productos con cantidades por debajo de 20 unidades

SELECT P.nombre AS proveedor, I.nombre AS producto
FROM Proveedor P, Inventario I
WHERE I.id_proveedor = P.id_proveedor AND I.cantidad_disponible < 20;

-- 28. Ventas realizadas por clientes con frecuencia mensual

SELECT V.id_venta, V.total
FROM Venta V, Cliente C
WHERE V.id_cliente = C.id_cliente
AND C.frecuencia_compra = 'Mensual';

-- 29. Cultivos que tienen un rendimiento estimado mayor a 50 toneladas
SELECT variedad, rendimiento_estimado
FROM Cultivo
WHERE rendimiento_estimado > 50;

-- 30. Total de ventas realizadas por cada cliente

SELECT C.nombre, C.apellidos, SUM(V.total) AS total_ventas
FROM Cliente C, Venta V
WHERE C.id_cliente = V.id_cliente
GROUP BY C.id_cliente;

-- 31. Maquinaria que necesita mantenimiento en un mes específico
SELECT nombre, fecha_compra
FROM Maquinaria
WHERE MONTH(ultimo_mantenimiento) = 6;

-- 32.Clientes con frecuencia de compra mensual
SELECT nombre, apellidos
FROM Cliente
WHERE frecuencia_compra = 'Mensual';

-- 33. Ventas realizadas en el mes de febrero de 2024
SELECT id_venta, fecha_venta
FROM Venta
WHERE MONTH(fecha_venta) = 2 AND YEAR(fecha_venta) = 2024;

-- 34. Productos por proveedor

SELECT P.nombre AS proveedor, I.nombre AS producto
FROM Proveedor P, Inventario I
WHERE I.id_proveedor = P.id_proveedor;

-- 35.Gastos realizados por un empleado específico
SELECT tipo_gasto, pago
FROM Gastos
WHERE id_empleado = 1;

-- 36. Cultivos con fecha de siembra anterior a 2023

SELECT C.variedad, C.fecha_siembra
FROM Cultivo C
WHERE C.fecha_siembra < '2024-01-01';

-- 37. Ventas realizadas por clientes con frecuencia Bimensual

SELECT V.id_venta, V.total
FROM Venta V, Cliente C
WHERE V.id_cliente = C.id_cliente
AND C.frecuencia_compra = 'Bimensual';

-- 38. Productos con menor cantidad en inventario

SELECT I.nombre, I.cantidad_disponible
FROM Inventario I
WHERE I.cantidad_disponible < 10;

-- 39. Clientes con ventas superiores a 500

SELECT C.nombre, C.apellidos, SUM(V.total) AS total_ventas
FROM Cliente C, Venta V
WHERE C.id_cliente = V.id_cliente
GROUP BY C.id_cliente
HAVING total_ventas > 500;

-- 40. Proveedores con productos que tengan alta demanda

SELECT P.nombre AS proveedor, I.nombre AS producto
FROM Proveedor P, Inventario I
WHERE P.id_proveedor = I.id_proveedor
AND I.cantidad_disponible > 1000;

-- 41. Cultivos con producción superior a 100 toneladas

SELECT C.variedad, SUM(P.toneladas_RFF) AS total_produccion
FROM Cultivo C, Produccion P
WHERE C.id_cultivo = P.id_cultivo
GROUP BY C.variedad
HAVING total_produccion > 100;

-- 42. Productos con mayor demanda y proveedores asociados

SELECT I.nombre AS producto, SUM(D.cantidad_vendida) AS total_vendido, P.nombre AS proveedor
FROM Inventario I, Detalle_Venta D, Proveedor P
WHERE I.id_producto = D.id_produccion AND I.id_proveedor = P.id_proveedor
GROUP BY I.nombre, P.nombre
ORDER BY total_vendido DESC;

-- 43. Productos con más de 100 unidades disponibles
SELECT nombre, cantidad_disponible
FROM Inventario
WHERE cantidad_disponible > 100;

-- 44. Empleados que fueron asignados a un cultivo específico
SELECT nombre, apellidos
FROM Empleado
WHERE id_empleado IN (SELECT id_empleado FROM Asignacion_Empleado WHERE id_cultivo = 1);

-- 45. Total de pérdidas por maquinaria
SELECT id_maquinaria, SUM(monto_perdida) AS total_perdidas
FROM Perdidas
GROUP BY id_maquinaria;

-- 46. Cultivos con ventas superiores a 500 unidades

SELECT C.variedad, SUM(P.toneladas_RFF) AS total_produccion
FROM Cultivo C, Produccion P
WHERE C.id_cultivo = P.id_cultivo
GROUP BY C.variedad
HAVING total_produccion > 500;

-- 47. Cultivos que han generado perdidas

SELECT C.variedad, SUM(P.monto_perdida) AS total_perdidas
FROM Cultivo C, Perdidas P
WHERE C.id_cultivo = P.id_cultivo
GROUP BY C.variedad;

-- 48. Detalle de mantenimiento de una maquinaria específica
SELECT fecha_mantenimiento, tipo_mantenimiento
FROM Mantenimiento
WHERE id_maquinaria = 1;

-- 49. Clientes con mayor frecuencia de compra

SELECT C.nombre, C.apellidos, COUNT(V.id_venta) AS total_compras
FROM Cliente C, Venta V
WHERE C.id_cliente = V.id_cliente
GROUP BY C.id_cliente
ORDER BY total_compras DESC;

-- 50. Productos vendidos en una venta específica
SELECT cantidad_vendida, precio_unitario
FROM Detalle_Venta
WHERE id_venta = 1;

-- inner join.
-- 1. Inner join entre la tabla cliente y venta.
select cliente.id_cliente, cliente.nombre, venta.id_venta, venta.fecha_venta from cliente 
inner join venta on cliente.id_cliente = venta.id_cliente;

-- 2. Inner join de las tablas mantenimiento y empleado con los atributos ascendentes.
select distinct mantenimiento.id_mantenimiento, empleado.id_empleado, empleado.nombre, empleado.apellidos from mantenimiento 
inner join empleado on mantenimiento.id_empleado = empleado.id_empleado
order by empleado.id_empleado asc, empleado.nombre asc, empleado.apellidos asc, mantenimiento.id_mantenimiento asc;

-- 3. Inner join de las tablas venta e inventario con el atributo id_venta ascendente.
select venta.id_venta, venta.fecha_venta, venta.total, venta.metodo_pago, Inventario.nombre, Inventario.descripcion 
as descripcion, Inventario.cantidad_disponible from venta inner join Inventario 
on venta.id_producto = Inventario.id_producto order by venta.id_venta asc;

-- 4. Inner join de las tablas inventario y proveedor donde el id_inventario debe ser igual al id_proveedor.
select * from proveedor; 
select Inventario.nombre, Inventario.descripcion as descripcion, Inventario.cantidad_disponible, proveedor.id_proveedor,
proveedor.nombre, proveedor.telefono, proveedor.correo_electronico from inventario inner join proveedor
on inventario.id_proveedor = proveedor.id_proveedor;

-- 5. Inner join de la tabla cultivo y estado donde ordena por el id_cultivo.
select cultivo.id_cultivo, cultivo.variedad, cultivo.fecha_siembra, estado.descripcion_estado from cultivo inner join estado
on cultivo.id_estado = estado.id_estado order by cultivo.id_cultivo desc;

-- 6. Inner join de la tabla produccion y cultivo donde produccion_destino debe ser igual Mercado Local.
select * from produccion;
select produccion.id_produccion, produccion.fecha_cosecha, produccion.destino, cultivo.id_cultivo, cultivo.hectareas, cultivo.rendimiento_estimado
from produccion inner join cultivo on produccion.id_cultivo = cultivo.id_cultivo where produccion.destino = 'Mercado Local';

-- 7. Inner join de las tablas inventario y cliente y ordena por fecha_venta.
select * from inventario;
select * from estado;
select venta.id_venta, venta.fecha_venta, cliente.nombre, cliente.apellidos, inventario.id_producto, inventario.cantidad_disponible, 
estado.descripcion_estado from venta inner join cliente on venta.id_cliente = cliente.id_cliente inner join inventario
on venta.id_producto = inventario.id_producto inner join estado on venta.id_estado = estado.id_estado order by venta.fecha_venta desc;

-- 8. Inner join fertilizacion y cultivo donde el insumo debe de ser Urea.
select * from fertilizacion;
select fertilizacion.id_fertilizacion, fertilizacion.fecha_aplicacion, fertilizacion.insumo_utilizado, cultivo.id_cultivo, cultivo.variedad, cultivo.fecha_siembra
from fertilizacion inner join cultivo on fertilizacion.id_cultivo = cultivo.id_cultivo where fertilizacion.insumo_utilizado = 'Urea';

-- 9.  Inner join de las tablas mantenimiento y maquinaria donde el costo debe ser 200.
select * from maquinaria;
select * from mantenimiento;
select mantenimiento.id_mantenimiento, mantenimiento.fecha_mantenimiento, mantenimiento.costo, maquinaria.id_maquinaria, 
maquinaria.estado, maquinaria.fecha_compra, maquinaria.horas_operativas from mantenimiento inner join maquinaria
on mantenimiento.id_maquinaria = maquinaria.id_maquinaria where mantenimiento.costo = '200';

-- 10. Inner join de las tablas salario, empleadoy maquinaria con fecha de inicio mayor a fecha_fin.
select * from salario;
select salario.id_salario, salario.salario_base, salario.fecha_inicio, salario.fecha_fin, empleado.nombre, empleado.apellidos,
cultivo.variedad, maquinaria.nombre from salario inner join empleado on salario.id_empleado = empleado.id_empleado inner join cultivo
on salario.id_cultivo = cultivo.id_cultivo inner join maquinaria on salario.id_maquinaria = maquinaria.id_maquinaria 
where salario.fecha_inicio >= '2024-01-01' and salario.fecha_fin <= '2024-12-31';

-- Consultas
-- 11. Los atributos deben aparecer en minusculas.
select lower(concat(nombre, ' ', apellidos, '   ', coalesce(`direccion`, ' '))) as nombre_direccion from empleado;

-- 12.  En la tabla empleado la fecha _fin debe ser mayor a fecha_inicio.
select fecha_inicio, fecha_fin from Salario where fecha_fin > fecha_inicio;

-- 13. Conteo de los empleados con nombre José.
select count(*) as total_empleados from empleado where nombre = 'José';

-- 14. Todos los atributos de la tabla cliente con limite 5. 
select * from cliente limit 5 offset 2;

-- 15. Conteo del monto_perdida debe de ser 1200.
select count(*) as monto_perdida from perdidas where monto_perdida = '1200';

-- 16. Ordenar descendentemente los atributos de las tablas cultivo y estado.
select cultivo.id_cultivo, cultivo.fecha_siembra, estado.id_estado, estado.descripcion_estado from cultivo right join estado
on cultivo.id_estado = estado.id_estado order by cultivo.id_cultivo desc, cultivo.fecha_siembra desc, 
estado.id_estado desc, estado.descripcion_estado desc;

-- 17. Muestra las columnas de la izquierda de la tabla inventario.
select * from Inventario;
select * from venta left join inventario on venta.id_venta = inventario.id_producto; 

-- 18. En la tabla salario los dias de faltas deben ser mayor o igual a 3.
select * from salario;
select salario_base, fecha_inicio, costo_dia_falta, dias_faltas from salario where dias_faltas >= 3;

-- 19. Ordena de forma descendente desde el atributo fecha_fin.
select fecha_inicio, fecha_fin from salario order by fecha_fin desc;

-- 20. Ordena de forma ascendentemente el nombre de los clientes.
select distinct nombre from cliente order by 1 asc; 

-- 21. Muestra los datos iguales en la tabla gastos y empleados.
select * from gastos left join empleado on gastos.id_gastos = empleado.id_empleado;

-- 22. Muestra en la tabla empleado los salarios que son nulos. 
select * from empleado;
select salario, ciudad, nombre, estado from empleado where salario is null;

-- 23. Lista las columnas de la derecha que estan en produccion y cultivo.
select * from produccion;
select id_produccion, fecha_cosecha, destino from produccion right join cultivo on produccion.id_produccion = cultivo.id_cultivo;

-- 24. Lista los clientes con apellido Pérez. 
select * from cliente where apellidos = 'Pérez';

-- 25. Suma el costo de la tabla mantenimiento. 
select sum(costo) as costo from mantenimiento;

-- 26.  Saca un promedio de la cantidad de aplicacion en el cultivo de los fertilizantes.
select avg(cantidad_aplicada) as cantidad_aplicada from fertilizacion;

-- 27. Hace un subconsulta donde nos arroja el minimo del monto de perdida de la tabla perdidas.
select categoria, monto_perdida from perdidas where monto_perdida = (select min(monto_perdida) from perdidas);

-- 28. Nos hace un conteo de los clientes con nombre de Andres.
select count(*) as total_cliente from cliente where nombre = 'Andres';

-- 29. Listar los atributos en mayusculas.
select upper(concat(nombre,' ', apellidos, ' ', coalesce(`apellidos`, ''))) as Nombre_apellidos from cliente;

-- 30. Lista los salarios mayor a 2100 y menor a 2500.
select * from salario;
select fecha_inicio, salario_base from salario where salario_base >= 2100 and salario_base <= 2500;

-- 31. Lista los empleados que vivan en la ciudad A.
select * from empleado;
select distinct ciudad, nombre, apellidos from empleado where ciudad = 'Ciudad A';

-- 32.Lista el rendimiento estimado del cultivo que sea igual a 2000.00. 
select * from cultivo;
select variedad, hectareas, id_lote, rendimiento_estimado from cultivo where rendimiento_estimado = '2000.00';

-- 33. Lista el total maximo de la tabla venta.
select * from venta;
select fecha_venta, metodo_pago, total from venta where total = (select max(total) from venta);

-- 34. Lista los atributos iguales en las entidades mantenimiento y empleado.
select * from mantenimiento;
select  id_mantenimiento, fecha_mantenimiento, costo from mantenimiento left join empleado on mantenimiento.id_mantenimiento = empleado.id_empleado;

-- 35. Lista la cantidad disponible del inventario 200.00 y 800.00.
select * from inventario;
select nombre, cantidad_disponible from inventario where cantidad_disponible not between 200.00 and 800.00;

-- 36. Lista los proveedores los cuales el nombre sea ProAgro S.A.
select * from proveedor;
select nombre, direccion, telefono from proveedor where nombre = 'ProAgro S.A.';

-- 37. Lista y hace un conteo del estado y el id del empeado y los agrupa.
select empleado.id_empleado, count(estado.id_estado) as estado from empleado left join estado
on empleado.id_empleado = estado.id_estado group by empleado.id_empleado;

-- 38. Lista los atributos en mayusculasa.
select upper(concat(nombre, ' ', apellidos, ' ', coalesce(`apellidos`, ' '))) as nombre_apellido from cliente;

-- 39. Lista el promedio del subtotal de detalles venta.
select * from detalle_venta;
select avg(subtotal) as subtotal from detalle_venta;

-- 40. Lista la duracion mayor o igual a 6.50.
select * from asignacion_empleado;
select actividad, duracion from asignacion_empleado where duracion >= '6.50';

-- 41. Lista la fecha, efectividad y cantidada de fertilizacion de forma descendente con limite 1.
select * from fertilizacion;
select  fecha_aplicacion, efectividad_estimada, cantidad_aplicada from fertilizacion order by efectividad_estimada desc limit 2;

-- 42. Lista la fecha de pago que sea menor a 2024-01-01.
select * from gastos;
select fecha_pago, pago, tipo_gasto from gastos where fecha_pago <= '2024-01-01';

-- 43. Lista la categoria que sea igual a Robo.
select * from perdidas;
select monto_perdida, categoria, fecha_recuperacion from perdidas where categoria = 'Robo';

-- 44. Lista los costos por dias que sean igual a 50.
select * from salario;
select dias_faltas, costo_dia_falta from salario where costo_dia_falta = 50;

-- 45. Lista las columnas de la derecha de las tablas inventario y proveedor.
select * from inventario;
select id_producto, inventario.nombre, inventario.cantidad_disponible from inventario right join proveedor on inventario.id_producto = proveedor.id_proveedor;

-- 46. Lista el lote que sea 3 y 8.
select * from cultivo;
select hectareas, variedad, id_lote from cultivo where id_lote between 3 and 8;

-- 47. Lista el nombre los cliented que sea igual a Carlos y el apellido igual a Gomez
select * from cliente;
select * from cliente where nombre = 'Carlos' and apellidos = 'Gomez';

-- 48. Lista las columnas de la izquierda de la tabla venta y estado.
select * from venta;
select id_venta, venta.fecha_venta, venta.total from venta left join estado on venta.id_venta = estado.id_estado;

-- 49. Lista el precio unitario 60.00 y 89.00.
select * from detalle_venta;
select  cantidad_vendida precio_unitario from detalle_venta where precio_unitario not between 60.00 and 89.00;

-- 50. Lista la actividada que sea igual a Cosecha de palma.
select * from asignacion_empleado;
select actividad, duracion from asignacion_empleado where actividad = 'Cosecha de palma';

