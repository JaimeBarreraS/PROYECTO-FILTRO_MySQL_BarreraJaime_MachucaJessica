CREATE DATABASE Palmaris_Tech;
USE Palmaris_Tech;

CREATE TABLE Cultivo (
    id_cultivo INT PRIMARY KEY AUTO_INCREMENT,
    variedad VARCHAR(50),
    fecha_siembra DATE,
    hectareas DECIMAL(10, 2),
    estado VARCHAR(20),
    rendimiento_estimado DECIMAL(10, 2),
    id_lote INT
);

CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    direccion VARCHAR(100),
    ciudad VARCHAR(50),
    rol VARCHAR(50),
    salario DECIMAL(10, 2),
    fecha_contratacion DATE
);

CREATE TABLE Maquinaria (
    id_maquinaria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    estado VARCHAR(50),
    fecha_compra DATE,
    costo_adquisicion VARCHAR(20),
    ultimo_mantenimiento DATE,
    horas_operativas DECIMAL(10, 2)
);

CREATE TABLE Proveedor (
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(50),
    producto_sumistrado VARCHAR(100)
);

CREATE TABLE Produccion (
    id_produccion INT PRIMARY KEY AUTO_INCREMENT,
    id_cultivo INT,
    fecha_cosecha DATE,
    toneladas_RFF DECIMAL(10, 2),
    destino VARCHAR(20),
    estado_destino VARCHAR(20),
    FOREIGN KEY (id_cultivo) REFERENCES Cultivo(id_cultivo)
);

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(50),
    frecuencia_compra VARCHAR(20)
);

CREATE TABLE Venta (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    fecha_venta DATE,
    id_cliente INT,
    total DECIMAL(10, 2),
    producto_vendido VARCHAR(50),
    metodo_pago VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Detalle_Venta (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_produccion INT,
    id_venta INT,
    cantidad_vendida DECIMAL(10, 2),
    precio_unitario DECIMAL(10, 2),
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (id_produccion) REFERENCES Produccion(id_produccion),
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta)
);

CREATE TABLE Asignacion_Empleado (
    id_asignacion INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado INT,
    id_cultivo INT,
    actividad VARCHAR(100),
    fecha_asignacion DATE,
    duracion DECIMAL(10, 2),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_cultivo) REFERENCES Cultivo(id_cultivo)
);

CREATE TABLE Inventario (
    id_inventario INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT,
    descripcion VARCHAR(100),
    cantidad_disponible DECIMAL(10, 2),
    unidad VARCHAR(20),
    fecha_actualizacion DATE,
    tipo VARCHAR(20)
);

CREATE TABLE Mantenimiento (
    id_mantenimiento INT PRIMARY KEY AUTO_INCREMENT,
    id_maquinaria INT,
    id_empleado INT,
    fecha_mantenimiento DATE,
    tipo_mantenimiento VARCHAR(50),
    costo DECIMAL(10, 2),
    descripcion TEXT,
    FOREIGN KEY (id_maquinaria) REFERENCES Maquinaria(id_maquinaria),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

CREATE TABLE Fertilizacion (
    id_fertilizacion INT PRIMARY KEY AUTO_INCREMENT,
    id_cultivo INT,
    fecha_aplicacion DATE,
    insumo_utilizado VARCHAR(50),
    cantidad_aplicada DECIMAL(10, 2),
    efectividad_estimada INT,
    FOREIGN KEY (id_cultivo) REFERENCES Cultivo(id_cultivo)
);

SHOW TABLES;

