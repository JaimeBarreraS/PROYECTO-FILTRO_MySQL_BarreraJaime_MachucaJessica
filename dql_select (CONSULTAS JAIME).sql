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

-- 6. Ventas por cada proveedor de productos

SELECT P.nombre AS proveedor, SUM(D.cantidad_vendida * D.precio_unitario) AS total_ventas
FROM Proveedor P
JOIN Inventario I ON P.id_proveedor = I.id_proveedor
JOIN Detalle_Venta D ON I.id_producto = D.id_producto
GROUP BY P.nombre;

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

-- 14.Productos más vendidos

SELECT I.nombre, SUM(D.cantidad_vendida) AS total_vendido
FROM Inventario I, Detalle_Venta D
WHERE I.id_producto = D.id_producto
GROUP BY I.nombre;

-- 15. Clientes con ventas recurrentes y su total

SELECT C.nombre, C.apellidos, SUM(V.total) AS total_recurrente
FROM Cliente C, Venta V
WHERE C.id_cliente = V.id_cliente
GROUP BY C.id_cliente
HAVING COUNT(V.id_venta) > 1;

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

-- 19. Cultivos con rendimiento inferior a 50 toneladas

SELECT C.variedad, SUM(P.toneladas_RFF) AS total_produccion
FROM Cultivo C, Produccion P
WHERE C.id_cultivo = P.id_cultivo
GROUP BY C.variedad
HAVING total_produccion < 50;

-- 20. Empleados con más de 10 asignaciones completadas

SELECT E.nombre, E.apellidos, COUNT(A.id_asignacion) AS total_asignaciones
FROM Empleado E, Asignacion_Empleado A
WHERE E.id_empleado = A.id_empleado
GROUP BY E.id_empleado
HAVING total_asignaciones > 10;

-- 21. Proveedores con productos con cantidad menor a 10

SELECT P.nombre AS proveedor, I.nombre AS producto
FROM Proveedor P, Inventario I
WHERE P.id_proveedor = I.id_proveedor AND I.cantidad_disponible < 10;

-- 22. Ventas de productos con descuento superior al 20%

SELECT V.id_venta, V.total, D.descuento
FROM Venta V, Detalle_Venta D
WHERE V.id_venta = D.id_venta AND D.descuento > 20;

-- 23. Perdidas relacionadas con productos específicos

SELECT P.monto_perdida, I.nombre AS producto
FROM Perdidas P, Inventario I
WHERE P.id_producto = I.id_producto;

-- 24. Cultivos con menor rendimiento por mes

SELECT C.variedad, MONTH(P.fecha_cosecha) AS mes, MIN(P.toneladas_RFF) AS minimo_rendimiento
FROM Cultivo C, Produccion P
WHERE C.id_cultivo = P.id_cultivo
GROUP BY C.variedad, MONTH(P.fecha_cosecha);

-- 25. Empleados con salarios superiores a 3000

SELECT E.nombre, E.apellidos, S.salario_base
FROM Empleado E, Salario S
WHERE E.id_empleado = S.id_empleado
AND S.salario_base > 3000;

-- 26. Ventas por cada proveedor de productos

SELECT P.nombre AS proveedor, SUM(D.cantidad_vendida * D.precio_unitario) AS total_ventas
FROM Proveedor P, Inventario I, Detalle_Venta D
WHERE I.id_proveedor = P.id_proveedor AND I.id_producto = D.id_producto
GROUP BY P.nombre;

-- 27. Proveedores con productos con cantidades por debajo de 20 unidades

SELECT P.nombre AS proveedor, I.nombre AS producto
FROM Proveedor P, Inventario I
WHERE I.id_proveedor = P.id_proveedor AND I.cantidad_disponible < 20;

-- 28. Ventas realizadas por clientes con frecuencia mensual

SELECT V.id_venta, V.total
FROM Venta V, Cliente C
WHERE V.id_cliente = C.id_cliente
AND C.frecuencia_compra = 'Mensual';

-- 29. Perdidas por maquinaria de tipo 'Tractor'

SELECT P.monto_perdida, M.nombre AS maquinaria
FROM Perdidas P, Maquinaria M
WHERE P.id_maquinaria = M.id_maquinaria
AND M.nombre = 'Tractor';

-- 30. Total de ventas realizadas por cada cliente

SELECT C.nombre, C.apellidos, SUM(V.total) AS total_ventas
FROM Cliente C, Venta V
WHERE C.id_cliente = V.id_cliente
GROUP BY C.id_cliente;

-- 31. Ventas por cada cliente y producto

SELECT C.nombre, I.nombre AS producto, SUM(D.cantidad_vendida * D.precio_unitario) AS total_producto
FROM Cliente C, Inventario I, Detalle_Venta D
WHERE C.id_cliente = D.id_cliente AND D.id_producto = I.id_producto
GROUP BY C.id_cliente, I.id_producto;

-- 32.Cultivos de mayor rentabilidad

SELECT C.variedad, SUM(P.toneladas_RFF * P.precio_unitario) AS rentabilidad
FROM Cultivo C, Produccion P
WHERE C.id_cultivo = P.id_cultivo
GROUP BY C.variedad
ORDER BY rentabilidad DESC;

-- 33. Clientes con ventas recurrentes

SELECT C.nombre, C.apellidos
FROM Cliente C, Venta V
WHERE C.id_cliente = V.id_cliente
GROUP BY C.id_cliente
HAVING COUNT(V.id_venta) > 1;

-- 34. Productos por proveedor

SELECT P.nombre AS proveedor, I.nombre AS producto
FROM Proveedor P, Inventario I
WHERE I.id_proveedor = P.id_proveedor;

-- 35.Empleados con asignaciones mayores de 6 horas

SELECT E.nombre, E.apellidos, COUNT(A.id_asignacion) AS total_asignaciones
FROM Empleado E, Asignacion_Empleado A
WHERE E.id_empleado = A.id_empleado
GROUP BY E.id_empleado
HAVING total_asignaciones > 6;

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

-- 43. Proveedores con productos en promoción

SELECT P.nombre AS proveedor, I.nombre AS producto
FROM Proveedor P, Inventario I
WHERE I.id_proveedor = P.id_proveedor AND I.unidad_medida = 1;

-- 44. Empleados con horas extras superiores a 10 horas

SELECT E.nombre, E.apellidos, SUM(A.horas_extras) AS total_horas_extras
FROM Empleado E, Asignacion_Empleado A
WHERE E.id_empleado = A.id_empleado
GROUP BY E.id_empleado
HAVING total_horas_extras > 10;

-- 45. Ventas realizadas con descuento superior al 20%

SELECT V.id_venta, V.total, D.descuento
FROM Venta V, Detalle_Venta D
WHERE V.id_venta = D.id_venta AND D.descuento > 20;

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

-- 48. Cultivos con producción inferior a 100 toneladas

SELECT C.variedad, SUM(P.toneladas_RFF) AS total_produccion
FROM Cultivo C, Produccion P
WHERE C.id_cultivo = P.id_cultivo
GROUP BY C.variedad
HAVING total_produccion < 100;

-- 49. Clientes con mayor frecuencia de compra

SELECT C.nombre, C.apellidos, COUNT(V.id_venta) AS total_compras
FROM Cliente C, Venta V
WHERE C.id_cliente = V.id_cliente
GROUP BY C.id_cliente
ORDER BY total_compras DESC;

-- 50. Clientes que nunca realizaron compras

SELECT C.nombre, C.apellidos
FROM Cliente C
WHERE C.id_cliente NOT IN (SELECT V.id_cliente FROM Venta V);

