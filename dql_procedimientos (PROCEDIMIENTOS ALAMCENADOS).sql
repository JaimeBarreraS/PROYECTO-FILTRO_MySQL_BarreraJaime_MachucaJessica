USE Palmaris_Tech;

-- 1 Registrar un nuevo proveedor
DELIMITER //
CREATE PROCEDURE registrar_proveedor(
    IN p_nombre VARCHAR(100),
    IN p_direccion VARCHAR(100),
    IN p_telefono VARCHAR(20),
    IN p_correo VARCHAR(50),
    IN p_producto VARCHAR(100)
)
BEGIN
    INSERT INTO Proveedor (nombre, direccion, telefono, correo_electronico, producto_sumistrado)
    VALUES (p_nombre, p_direccion, p_telefono, p_correo, p_producto);
END;
//
DELIMITER ;
CALL registrar_proveedor(
    'Proveedor Ejemplo', 
    'Dirección 123', 
    '123456789', 
    'ejemplo@correo.com', 
    'Fertilizantes'
);

-- 2 Registrar un nuevo empleado
DELIMITER //
CREATE PROCEDURE registrar_empleado(
    IN p_nombre VARCHAR(50),
    IN p_apellidos VARCHAR(50),
    IN p_direccion VARCHAR(100),
    IN p_ciudad VARCHAR(50),
    IN p_rol VARCHAR(50),
    IN p_fecha_contratacion DATE,
    IN p_id_estado INT
)
BEGIN
    INSERT INTO Empleado (nombre, apellidos, direccion, ciudad, rol, fecha_contratacion, id_estado)
    VALUES (p_nombre, p_apellidos, p_direccion, p_ciudad, p_rol, p_fecha_contratacion, p_id_estado);
END;
//
DELIMITER ;
CALL registrar_empleado(
    'Juan', 
    'Pérez', 
    'Calle Principal 45', 
    'Ciudad ABC', 
    'Agrónomo', 
    '2024-11-01', 
    1
);

-- 3 Actualizar el estado de una maquinaria
DELIMITER //
CREATE PROCEDURE actualizar_estado_maquinaria(
    IN p_id_maquinaria INT,
    IN p_estado VARCHAR(50)
)
BEGIN
    UPDATE Maquinaria
    SET estado_maquinaria = p_estado
    WHERE id_maquinaria = p_id_maquinaria;
END;
//
DELIMITER ;
CALL actualizar_estado_maquinaria(3, 'En reparación');

-- 4 Registrar un nuevo lote de producción
DELIMITER //
CREATE PROCEDURE registrar_produccion(
    IN p_id_cultivo INT,
    IN p_fecha_cosecha DATE,
    IN p_toneladas DECIMAL(10, 2),
    IN p_destino VARCHAR(100),
    IN p_estado_destino VARCHAR(20)
)
BEGIN
    INSERT INTO Produccion (id_cultivo, fecha_cosecha, toneladas_RFF, destino, estado_destino)
    VALUES (p_id_cultivo, p_fecha_cosecha, p_toneladas, p_destino, p_estado_destino);
END;
//
DELIMITER ;
CALL registrar_produccion(
    2, 
    '2024-11-15', 
    15.5, 
    'Almacén Central', 
    'En tránsito'
);

-- 5 Registrar un gasto
DELIMITER //
CREATE PROCEDURE registrar_gasto(
    IN p_id_empleado INT,
    IN p_id_cultivo INT,
    IN p_id_proveedor INT,
    IN p_id_maquinaria INT,
    IN p_fecha_pago DATE,
    IN p_pago VARCHAR(100),
    IN p_tipo_gasto VARCHAR(80)
)
BEGIN
    INSERT INTO Gastos (id_empleado, id_cultivo, id_proveedor, id_maquinaria, fecha_pago, pago, tipo_gasto)
    VALUES (p_id_empleado, p_id_cultivo, p_id_proveedor, p_id_maquinaria, p_fecha_pago, p_pago, p_tipo_gasto);
END;
//
DELIMITER ;
CALL registrar_gasto(
    1, 
    2, 
    3, 
    4, 
    '2024-11-20', 
    '500.00', 
    'Compra de insumos'
);

-- 6 Registrar una asignación de empleado
DELIMITER //
CREATE PROCEDURE registrar_asignacion(
    IN p_id_empleado INT,
    IN p_id_cultivo INT,
    IN p_actividad VARCHAR(100),
    IN p_fecha DATE,
    IN p_duracion DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Asignacion_Empleado (id_empleado, id_cultivo, actividad, fecha_asignacion, duracion)
    VALUES (p_id_empleado, p_id_cultivo, p_actividad, p_fecha, p_duracion);
END;
//
DELIMITER ;
CALL registrar_asignacion(
    1, 
    2, 
    'Cosecha', 
    '2024-11-21', 
    8.5
);

-- 7 Registrar fertilización
DELIMITER //
CREATE PROCEDURE registrar_fertilizacion(
    IN p_id_cultivo INT,
    IN p_fecha_aplicacion DATE,
    IN p_insumo VARCHAR(50),
    IN p_cantidad DECIMAL(10, 2),
    IN p_efectividad INT
)
BEGIN
    INSERT INTO Fertilizacion (id_cultivo, fecha_aplicacion, insumo_utilizado, cantidad_aplicada, efectividad_estimada)
    VALUES (p_id_cultivo, p_fecha_aplicacion, p_insumo, p_cantidad, p_efectividad);
END;
//
DELIMITER ;
CALL registrar_fertilizacion(
    2, 
    '2024-11-22', 
    'Nitrógeno', 
    200.5, 
    85
);

-- 8 Actualizar inventarios al recibir productos de un proveedor
DELIMITER //
CREATE PROCEDURE actualizar_inventario_proveedor(
    IN p_id_producto INT,
    IN p_cantidad DECIMAL(10, 2),
    IN p_fecha_actualizacion DATE
)
BEGIN
    UPDATE Inventario
    SET cantidad_disponible = cantidad_disponible + p_cantidad, 
        fecha_actualizacion = p_fecha_actualizacion
    WHERE id_producto = p_id_producto;
END;
//
DELIMITER ;
CALL actualizar_inventario_proveedor(
    5, 
    50.0, 
    '2024-11-23'
);

-- 9 Actualizar estado de un cultivo
DELIMITER //
CREATE PROCEDURE actualizar_estado_cultivo(
    IN p_id_cultivo INT,
    IN p_estado INT
)
BEGIN
    UPDATE Cultivo
    SET id_estado = p_estado
    WHERE id_cultivo = p_id_cultivo;
END;
//
DELIMITER ;
CALL actualizar_estado_cultivo(2, 1);

-- 10 Registrar un mantenimiento
DELIMITER //
CREATE PROCEDURE registrar_mantenimiento(
    IN p_id_maquinaria INT,
    IN p_id_empleado INT,
    IN p_fecha DATE,
    IN p_tipo VARCHAR(50),
    IN p_costo DECIMAL(10, 2),
    IN p_descripcion TEXT
)
BEGIN
    INSERT INTO Mantenimiento (id_maquinaria, id_empleado, fecha_mantenimiento, tipo_mantenimiento, costo, descripcion)
    VALUES (p_id_maquinaria, p_id_empleado, p_fecha, p_tipo, p_costo, p_descripcion);
    UPDATE Maquinaria
    SET estado_maquinaria = 'Mantenimiento'
    WHERE id_maquinaria = p_id_maquinaria;
END;
//
DELIMITER ;
CALL registrar_mantenimiento(
    3, 
    1, 
    '2024-11-15', 
    'Reparación mayor', 
    1200.00, 
    'Cambio de motor'
);

-- 11 Cambiar el estado de un empleado
DELIMITER //
CREATE PROCEDURE cambiar_estado_empleado(
    IN p_id_empleado INT,
    IN p_id_estado INT
)
BEGIN
    UPDATE Empleado
    SET id_estado = p_id_estado
    WHERE id_empleado = p_id_empleado;
END;
//
DELIMITER ;
CALL cambiar_estado_empleado(1, 2);

-- 12 Registrar una pérdida
DELIMITER //
CREATE PROCEDURE registrar_perdida(
    IN p_id_empleado INT,
    IN p_id_cultivo INT,
    IN p_id_proveedor INT,
    IN p_id_maquinaria INT,
    IN p_fecha_perdida DATE,
    IN p_monto INT,
    IN p_categoria VARCHAR(80),
    IN p_fecha_recuperacion DATE
)
BEGIN
    INSERT INTO Perdidas (id_empleado, id_cultivo, id_proveedor, id_maquinaria, fecha_perdida, monto_perdida, categoria, fecha_recuperacion)
    VALUES (p_id_empleado, p_id_cultivo, p_id_proveedor, p_id_maquinaria, p_fecha_perdida, p_monto, p_categoria, p_fecha_recuperacion);
END;
//
DELIMITER ;
CALL registrar_perdida(
    1, 
    2, 
    3, 
    4, 
    '2024-11-10', 
    3000, 
    'Daño de maquinaria', 
    '2024-12-01'
);

-- 13 Obtener un resumen financiero por mes
DELIMITER //
CREATE PROCEDURE resumen_financiero_mes(
    IN p_mes INT,
    IN p_anio INT
)
BEGIN
    SELECT 
        SUM(total) AS total_ventas,
        SUM(costo) AS total_mantenimiento,
        (SUM(total) - SUM(costo)) AS ganancia_neta
    FROM Venta
    LEFT JOIN Mantenimiento ON MONTH(fecha_mantenimiento) = p_mes AND YEAR(fecha_mantenimiento) = p_anio
    WHERE MONTH(fecha_venta) = p_mes AND YEAR(fecha_venta) = p_anio;
END;
//
DELIMITER ;
CALL resumen_financiero_mes(11, 2024);

-- 14 Reasignar un empleado a un cultivo
DELIMITER //
CREATE PROCEDURE reasignar_empleado(
    IN p_id_empleado INT,
    IN p_id_cultivo INT,
    IN p_actividad VARCHAR(100),
    IN p_fecha DATE
)
BEGIN
    DELETE FROM Asignacion_Empleado WHERE id_empleado = p_id_empleado;
    INSERT INTO Asignacion_Empleado (id_empleado, id_cultivo, actividad, fecha_asignacion, duracion)
    VALUES (p_id_empleado, p_id_cultivo, p_actividad, p_fecha, 0);
END;
//
DELIMITER ;
CALL reasignar_empleado(1, 3, 'Limpieza de terreno', '2024-11-25');

-- 15 Registrar un nuevo cliente
DELIMITER //
CREATE PROCEDURE registrar_cliente(
    IN p_nombre VARCHAR(50),
    IN p_apellidos VARCHAR(50),
    IN p_direccion VARCHAR(100),
    IN p_telefono VARCHAR(20),
    IN p_correo VARCHAR(50),
    IN p_frecuencia_compra VARCHAR(20)
)
BEGIN
    INSERT INTO Cliente (nombre, apellidos, direccion, telefono, correo_electronico, frecuencia_compra)
    VALUES (p_nombre, p_apellidos, p_direccion, p_telefono, p_correo, p_frecuencia_compra);
END;
//
DELIMITER ;
CALL registrar_cliente(
    'Carlos', 
    'Gómez', 
    'Av. Central 456', 
    '987654321', 
    'carlos@correo.com', 
    'Mensual'
);

-- 16 Actualizar los datos de un proveedor
DELIMITER //
CREATE PROCEDURE actualizar_proveedor(
    IN p_id_proveedor INT,
    IN p_nombre VARCHAR(100),
    IN p_direccion VARCHAR(100),
    IN p_telefono VARCHAR(20),
    IN p_correo VARCHAR(50),
    IN p_producto VARCHAR(100)
)
BEGIN
    UPDATE Proveedor
    SET nombre = p_nombre,
        direccion = p_direccion,
        telefono = p_telefono,
        correo_electronico = p_correo,
        producto_sumistrado = p_producto
    WHERE id_proveedor = p_id_proveedor;
END;
//
DELIMITER ;
CALL actualizar_proveedor(
    3, 
    'Proveedor Actualizado', 
    'Dirección Nueva 789', 
    '456789123', 
    'nuevo@correo.com', 
    'Pesticidas'
);

-- 17 Generar un informe de rendimiento por cultivo
DELIMITER //
CREATE PROCEDURE informe_rendimiento(
    IN p_id_cultivo INT
)
BEGIN
    SELECT 
        c.variedad,
        SUM(p.toneladas_RFF) AS total_produccion,
        c.hectareas AS hectareas_totales,
        (SUM(p.toneladas_RFF) / c.hectareas) AS rendimiento_promedio
    FROM Cultivo c
    INNER JOIN Produccion p ON c.id_cultivo = p.id_cultivo
    WHERE c.id_cultivo = p_id_cultivo
    GROUP BY c.id_cultivo;
END;
//
DELIMITER ;
CALL informe_rendimiento(2);

-- 18 Calcular salario neto de un empleado
DELIMITER //
CREATE PROCEDURE calcular_salario_neto(
    IN p_id_empleado INT,
    IN p_mes INT,
    IN p_anio INT
)
BEGIN
    SELECT 
        e.nombre,
        e.apellidos,
        s.salario_base - (s.dias_faltas * s.costo_dia_falta) AS salario_neto
    FROM Salario s
    INNER JOIN Empleado e ON s.id_empleado = e.id_empleado
    WHERE s.id_empleado = p_id_empleado
      AND MONTH(s.fecha_inicio) = p_mes
      AND YEAR(s.fecha_inicio) = p_anio;
END;
//
DELIMITER ;
CALL calcular_salario_neto(1, 11, 2024);

-- 19 Registrar fertilización de un cultivo
DELIMITER //
CREATE PROCEDURE registrar_fertilizacion(
    IN p_id_cultivo INT,
    IN p_fecha_aplicacion DATE,
    IN p_insumo_utilizado VARCHAR(50),
    IN p_cantidad_aplicada DECIMAL(10, 2),
    IN p_efectividad_estimada INT
)
BEGIN
    INSERT INTO Fertilizacion (id_cultivo, fecha_aplicacion, insumo_utilizado, cantidad_aplicada, efectividad_estimada)
    VALUES (p_id_cultivo, p_fecha_aplicacion, p_insumo_utilizado, p_cantidad_aplicada, p_efectividad_estimada);
END;
//
DELIMITER ;
CALL registrar_fertilizacion(
    3, 
    '2024-11-24', 
    'Fósforo', 
    150.5, 
    90
);

-- 20 Eliminar un proveedor
DELIMITER //
CREATE PROCEDURE eliminar_proveedor(
    IN p_id_proveedor INT
)
BEGIN
    DELETE FROM Proveedor
    WHERE id_proveedor = p_id_proveedor;
END;
//
DELIMITER ;
CALL eliminar_proveedor(3);

