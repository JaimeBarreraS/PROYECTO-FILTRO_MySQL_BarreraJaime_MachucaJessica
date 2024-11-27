USE Palmaris_Tech;

-- 1. Calcular el rendimiento promedio por hectárea de un cultivo
DELIMITER //
CREATE FUNCTION eficiencia_maquinaria(id_maquinaria INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE eficiencia DECIMAL(10,2);
    SELECT (SUM(horas_operativas) / COUNT(id_mantenimiento)) 
    INTO eficiencia
    FROM Maquinaria
    LEFT JOIN Mantenimiento ON Maquinaria.id_maquinaria = Mantenimiento.id_maquinaria
    WHERE Maquinaria.id_maquinaria = id_maquinaria;
	RETURN IFNULL(eficiencia, 0);
END;
//
DELIMITER ;
SELECT eficiencia_maquinaria(1) AS eficiencia_promedio;

-- 2. Estimar el costo operativo total de la finca en un período
DELIMITER //
CREATE FUNCTION costo_operativo_total(fecha_inicio DATE, fecha_fin DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(costo)
    INTO total
    FROM Mantenimiento
    WHERE fecha_mantenimiento BETWEEN fecha_inicio AND fecha_fin;
    RETURN IFNULL(total, 0);
END;
//
DELIMITER ;
SELECT costo_operativo_total('2024-01-01', '2024-12-31') AS costo_operativo;


-- 3. Calcular el costo total de fertilizantes aplicados a un cultivo
DELIMITER //
CREATE FUNCTION costo_total_fertilizacion(id_cultivo INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE costo_total DECIMAL(10,2);
    SELECT SUM(cantidad_aplicada * efectividad_estimada)
    INTO costo_total
    FROM Fertilizacion
    WHERE id_cultivo = id_cultivo;
    RETURN IFNULL(costo_total, 0);
END;
//
DELIMITER ;
SELECT costo_total_fertilizacion(1) AS costo_fertilizacion;

-- 4. Determinar el costo promedio de mantenimiento de maquinaria
DELIMITER //
CREATE FUNCTION costo_promedio_mantenimiento(id_maquinaria INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(costo)
    INTO promedio
    FROM Mantenimiento
    WHERE id_maquinaria = id_maquinaria;
    RETURN IFNULL(promedio, 0);
END;
//
DELIMITER ;
SELECT costo_promedio_mantenimiento(1) AS costo_promedio;

-- 5. Calcular el costo total por empleado en mantenimiento
DELIMITER //
CREATE FUNCTION costo_total_empleado(id_empleado INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(costo)
    INTO total
    FROM Mantenimiento
    WHERE id_empleado = id_empleado;
    RETURN IFNULL(total, 0);
END;
//
DELIMITER ;
SELECT costo_total_empleado(3) AS costo_total;

-- 6. Calcular el ingreso promedio por cliente
DELIMITER //
CREATE FUNCTION ingreso_promedio_cliente(id_cliente INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(total)
    INTO promedio
    FROM Venta
    WHERE id_cliente = id_cliente;
    RETURN IFNULL(promedio, 0);
END;
//
DELIMITER ;
SELECT ingreso_promedio_cliente(2) AS ingreso_promedio;

-- 7. Calcular el tiempo promedio de asignación por cultivo
DELIMITER //
CREATE FUNCTION tiempo_promedio_asignacion(id_cultivo INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(duracion)
    INTO promedio
    FROM Asignacion_Empleado
    WHERE id_cultivo = id_cultivo;
    RETURN IFNULL(promedio, 0);
END;
//
DELIMITER ;
SELECT tiempo_promedio_asignacion(1) AS tiempo_promedio;

-- 8. Determinar la cantidad de fertilizante utilizada por cultivo
DELIMITER //
CREATE FUNCTION fertilizante_total_cultivo(id_cultivo INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(cantidad_aplicada)
    INTO total
    FROM Fertilizacion
    WHERE id_cultivo = id_cultivo;
    RETURN IFNULL(total, 0);
END;
//
DELIMITER ;
SELECT fertilizante_total_cultivo(1) AS fertilizante_total;

-- 9. Determinar el porcentaje de ventas realizadas por un cliente específico
DELIMITER //
CREATE FUNCTION porcentaje_ventas_cliente(id_cliente INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE porcentaje DECIMAL(10,2);
    SELECT (COUNT(id_venta) * 100.0 / (SELECT COUNT(*) FROM Venta)) 
    INTO porcentaje
    FROM Venta
    WHERE Venta.id_cliente = id_cliente;
    RETURN IFNULL(porcentaje, 0);
END;
//
DELIMITER ;
SELECT porcentaje_ventas_cliente(2) AS porcentaje_ventas;

-- 10. Calcular el tiempo promedio para completar asignaciones por empleado
DELIMITER //
CREATE FUNCTION tiempo_promedio_asignaciones(id_empleado INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio_tiempo DECIMAL(10,2);
    SELECT AVG(duracion)
    INTO promedio_tiempo
    FROM Asignacion_Empleado
    WHERE id_empleado = id_empleado;
    RETURN IFNULL(promedio_tiempo, 0);
END;
//
DELIMITER ;
SELECT tiempo_promedio_asignaciones(1) AS tiempo_promedio;

-- 11. Calcular el porcentaje de efectividad promedio de fertilización por cultivo
DELIMITER //
CREATE FUNCTION efectividad_promedio_fertilizacion(id_cultivo INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(efectividad_estimada)
    INTO promedio
    FROM Fertilizacion
    WHERE id_cultivo = id_cultivo;
    RETURN IFNULL(promedio, 0);
END;
//
DELIMITER ;
SELECT efectividad_promedio_fertilizacion(1) AS efectividad_promedio;

-- 12. Determinar la cantidad total de insumos utilizados en fertilización por tipo
DELIMITER //
CREATE FUNCTION total_insumo_utilizado(tipo_insumo VARCHAR(50))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(cantidad_aplicada)
    INTO total
    FROM Fertilizacion
    WHERE insumo_utilizado = tipo_insumo;
    RETURN IFNULL(total, 0);
END;
//
DELIMITER ;
SELECT total_insumo_utilizado('Fosfato diamónico') AS total_insumo;

-- 13. Calcular el total de horas operativas de una maquinaria en un rango de tiempo
DELIMITER //
CREATE FUNCTION horas_operativas_totales(id_maquinaria INT, fecha_inicio DATE, fecha_fin DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(horas_operativas)
    INTO total
    FROM Maquinaria
    WHERE id_maquinaria = id_maquinaria 
      AND fecha_compra <= fecha_fin
      AND (ultimo_mantenimiento IS NULL OR ultimo_mantenimiento >= fecha_inicio);
    RETURN IFNULL(total, 0);
END;
//
DELIMITER ;
SELECT horas_operativas_totales(1, '2024-01-01', '2024-12-31') AS horas_totales;

-- 14. Calcular el porcentaje de ventas por método de pago
DELIMITER //
CREATE FUNCTION porcentaje_ventas_metodo(metodo_pago VARCHAR(50))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE porcentaje DECIMAL(10,2);
    DECLARE total_ventas DECIMAL(10,2);
    DECLARE ventas_metodo DECIMAL(10,2);
    
    SELECT SUM(total) INTO total_ventas FROM Venta;
    SELECT SUM(total) INTO ventas_metodo FROM Venta WHERE metodo_pago = metodo_pago;
    
    SET porcentaje = IFNULL((ventas_metodo / total_ventas) * 100, 0);
    RETURN porcentaje;
END;
//
DELIMITER ;
SELECT porcentaje_ventas_metodo('Tarjeta de crédito') AS porcentaje;

-- 15. Calcular la cantidad promedio de productos vendidos en cada venta
DELIMITER //
CREATE FUNCTION promedio_productos_vendidos()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(cantidad_vendida)
    INTO promedio
    FROM Detalle_Venta;
    RETURN IFNULL(promedio, 0);
END;
//
DELIMITER ;
SELECT promedio_productos_vendidos() AS promedio_productos;

-- 16. Calcular las pérdidas totales por categoría
DELIMITER //
CREATE FUNCTION perdidas_totales_categoria(categoria VARCHAR(80))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(monto_perdida)
    INTO total
    FROM Perdidas
    WHERE categoria = categoria;
    RETURN IFNULL(total, 0);
END;
//
DELIMITER ;
SELECT perdidas_totales_categoria('Clima') AS perdidas_totales;

-- 17. Calcular el salario promedio de los empleados en un rango de tiempo
DELIMITER //
CREATE FUNCTION salario_promedio(fecha_inicio DATE, fecha_fin DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(salario_base)
    INTO promedio
    FROM Salario
    WHERE fecha_inicio BETWEEN fecha_inicio AND fecha_fin;
    RETURN IFNULL(promedio, 0);
END;
//
DELIMITER ;
SELECT salario_promedio('2024-01-01', '2024-12-31') AS salario_promedio;

-- 18. Estimar los ingresos totales por ventas en un período determinado
DELIMITER //
CREATE FUNCTION ingresos_totales_periodo(fecha_inicio DATE, fecha_fin DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE ingresos DECIMAL(10,2);
    SELECT SUM(total)
    INTO ingresos
    FROM Venta
    WHERE fecha_venta BETWEEN fecha_inicio AND fecha_fin;
    RETURN IFNULL(ingresos, 0);
END;
//
DELIMITER ;
SELECT ingresos_totales_periodo('2024-01-01', '2024-12-31') AS ingresos_totales;

-- 19. Calcular el total de ganancias por cultivo considerando las ventas relacionadas
DELIMITER //
CREATE FUNCTION ganancias_totales_cultivo(id_cultivo INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE ganancias DECIMAL(10,2);
    SELECT SUM(Detalle_Venta.subtotal)
    INTO ganancias
    FROM Detalle_Venta
    INNER JOIN Produccion ON Detalle_Venta.id_produccion = Produccion.id_produccion
    WHERE Produccion.id_cultivo = id_cultivo;
    RETURN IFNULL(ganancias, 0);
END;
//
DELIMITER ;
SELECT ganancias_totales_cultivo(1) AS ganancias_totales;

-- 20. Calcular el promedio de días faltados por los empleados
DELIMITER //
CREATE FUNCTION promedio_dias_faltas()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(dias_faltas)
    INTO promedio
    FROM Salario;
    RETURN IFNULL(promedio, 0);
END;
//
DELIMITER ;
SELECT promedio_dias_faltas() AS promedio_faltas;
