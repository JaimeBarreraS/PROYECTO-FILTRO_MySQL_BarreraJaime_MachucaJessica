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



