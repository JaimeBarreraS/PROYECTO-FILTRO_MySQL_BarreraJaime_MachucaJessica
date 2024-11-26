CREATE DATABASE Palmaris_Tech_t1;
USE Palmaris_Tech_t1;

CREATE TABLE Cultivo (
    id_cultivo INT PRIMARY KEY AUTO_INCREMENT,
    variedad VARCHAR(50),
    fecha_siembra DATE,
    hectareas DECIMAL(10, 2),
	id_estado INT, 
    rendimiento_estimado DECIMAL(10, 2),
    id_lote INT,
    FOREIGN KEY (id_estado) REFERENCES Estado(id_estado)
);

CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT, 
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    direccion VARCHAR(100),
    ciudad VARCHAR(50),
    rol VARCHAR(50),
    fecha_contratacion DATE,
    FOREIGN KEY (id_estado) REFERENCES Estado(id_estado)
);

CREATE TABLE Maquinaria (
    id_maquinaria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    estado_maquinaria VARCHAR(50),
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
    destino VARCHAR(100),
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
    id_estado INT,
    fecha_venta DATE,
    id_cliente INT,
    total DECIMAL(10, 2),
    id_producto INT,
    metodo_pago VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES Inventario(id_producto),
    FOREIGN KEY (id_estado) REFERENCES Estado(id_estado)
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
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion VARCHAR(100),
    cantidad_disponible DECIMAL(10, 2),
    unidad_medida VARCHAR(20),
    fecha_actualizacion DATE,
    tipo VARCHAR(20),
    id_proveedor INT,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

CREATE TABLE Mantenimiento (
    id_mantenimiento INT PRIMARY KEY AUTO_INCREMENT,
    id_maquinaria INT,
    id_empleado INT,
    fecha_mantenimiento DATE,
    tipo_mantenimiento VARCHAR(50),
    costo INT,
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

CREATE TABLE Gastos (
	id_gastos INT PRIMARY KEY AUTO_INCREMENT,
	id_empleado INT,
	id_cultivo INT,
	id_proveedor INT,
	id_maquinaria INT,
	fecha_pago DATE,
	pago VARCHAR(100),
	tipo_gasto VARCHAR(80),
	FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
	FOREIGN KEY (id_cultivo) REFERENCES Cultivo(id_cultivo),
	FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor),
	FOREIGN KEY (id_maquinaria) REFERENCES Maquinaria(id_maquinaria)
);

CREATE TABLE Estado (
	id_estado INT PRIMARY KEY AUTO_INCREMENT,
	descripcion_estado VARCHAR(100)
);

CREATE TABLE Perdidas (
	id_perdida INT PRIMARY KEY AUTO_INCREMENT,
	id_empleado INT,
	id_cultivo INT,
	id_proveedor INT,
	id_maquinaria INT,
	fecha_perdida DATE,
	monto_perdida INT,
	categoria VARCHAR(80),
	fecha_recuperacion date,
	FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
	FOREIGN KEY (id_cultivo) REFERENCES Cultivo(id_cultivo),
	FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor),
	FOREIGN KEY (id_maquinaria) REFERENCES Maquinaria(id_maquinaria)
);

CREATE TABLE Salario (
	id_salario INT PRIMARY KEY AUTO_INCREMENT,
	id_empleado INT,
	id_cultivo INT,
	id_maquinaria INT,
	fecha_inicio DATE,
	fecha_fin DATE,
	salario_base INT,
	dias_faltas INT,
	costo_dia_falta INT,
	FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
	FOREIGN KEY (id_cultivo) REFERENCES Cultivo(id_cultivo),
	FOREIGN KEY (id_maquinaria) REFERENCES Maquinaria(id_maquinaria)
);
SHOW TABLES;


