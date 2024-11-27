USE Palmaris_Tech;
-- 1.
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

delimiter //
create trigger tabla_cultivo 
after insert on Cultivo  
for each row
begin 
insert into Cultivo (id_cultivo, variedad, fecha_siembra)
values (NEW.id_cultivo, 'Dura', '2021-10-12');
end
//
delimiter ;
select *from Cultivo;

-- 2. 
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

delimiter //
create trigger tabla_empleado 
before update on Empleado
for each row
begin
insert into Empleado (id_empleado, nombre, ciudad)
values (new.id_empleado, 'Dario', 'Cúcuta');
end
//
delimiter ;
select * from Empleado;

-- 3. 
CREATE TABLE Maquinaria (
    id_maquinaria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    estado_maquinaria VARCHAR(50),
    fecha_compra DATE,
    costo_adquisicion VARCHAR(20),
    ultimo_mantenimiento DATE,
    horas_operativas DECIMAL(10, 2)
);

delimiter //
create trigger tabla_maquinaria 
after insert on Maquinaria 
for each row
begin
insert into Maquinaria (id_maquinaria, costo_adquisicion, horas_operativas)
values (new.id_maquinaria, '50000', '250.00');
end
//
delimiter ;
select * from Maquinaria;

-- 4. 
CREATE TABLE Proveedor (
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(50),
    producto_sumistrado VARCHAR(100)
);

delimiter //
create trigger tabla_proveedor
before update on Proveedor
for each row
begin
insert into Proveedor(id_proveedor, telefono)
values (new.id_proveedor, '666.2134');
end
//
delimiter ;
select * from Proveedor;

-- 5. 
CREATE TABLE Produccion (
    id_produccion INT PRIMARY KEY AUTO_INCREMENT,
    id_cultivo INT,
    fecha_cosecha DATE,
    toneladas_RFF DECIMAL(10, 2),
    destino VARCHAR(100),
    estado_destino VARCHAR(20),
    FOREIGN KEY (id_cultivo) REFERENCES Cultivo(id_cultivo)
);

delimiter //
create trigger tabla_produccion
after insert on Produccion
for each row
begin
insert into Produccion(id_produccion, destino)
values (new.id_produccion, 'Mercado Interno');
end 
//
delimiter ;
select * from produccion;

-- 6. 
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(50),
    frecuencia_compra VARCHAR(20)
);

delimiter //
create trigger tabla_cliente
before update on Cliente
for each row
begin
insert into Cliente (id_cliente, apellidos)
values (new.id_cliente, 'Machuca');
end
//
delimiter ;
select * from cliente;

-- 7. 
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

delimiter //
create trigger tabla_venta
after delete on venta
for each row
begin 
delete from Venta where id_venta = old.id_venta;
end 
//
delimiter ;
select * from Venta;

-- 8. 
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

delimiter //
create trigger tabla_detalle_venta
before delete on detalle_Venta
for each row
begin 
delete from Detalle_Venta where id_detalle = old.id_detalle;
end 
//
delimiter ;
select * from Detalle_Venta;

-- 9. 
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

delimiter //
create trigger tabla_asignacion_empleado
before insert on Asignacion_Empleado
for each row
begin 
insert into tabla_asignacion_empleado (id_asignacion, actividad)
values (new.id_asignacion, 'Fertilizacion de palma');
end 
//
delimiter ;
select * from asignacion_empleado;

-- 10. 
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

delimiter //
create trigger tabla_inventario
after update on Inventario 
for each row
begin
insert into tabla_inventario (id_producto, cantidad_disponible)
values (new.id_producto, '300.00');
end 
//
delimiter ;
select * from inventario;

-- 11. 
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

delimiter //
create trigger tabla_mantenimiento
before update on mantenimiento
for each row
begin 
insert into tabla_mantenimiento (id_mantenimiento, costo, fecha_mantenimiento)
values (new.id_mantenimiento, '500', 2022-10-01);
end 
//
delimiter ;
select * from mantenimiento;

-- 12. 
CREATE TABLE Fertilizacion (
    id_fertilizacion INT PRIMARY KEY AUTO_INCREMENT,
    id_cultivo INT,
    fecha_aplicacion DATE,
    insumo_utilizado VARCHAR(50),
    cantidad_aplicada DECIMAL(10, 2),
    efectividad_estimada INT,
    FOREIGN KEY (id_cultivo) REFERENCES Cultivo(id_cultivo)
);

delimiter //
create trigger tabla_fertilizacion 
after insert on Fertilizacion
for each row 
begin
insert into tabla_fertilizacion (id_fertilizacion, insumo_utilizado)
values (new.id_fertilizacion,'Fertilizante orgánico');
end 
//
delimiter ;
select * from fertilizacion;

-- 13. 
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

delimiter //
create trigger tabla_gastos
before update on Gastos 
for each row
begin 
insert into tabla_gastos (id_gastos, pago, tipo_pago)
values (new.id_gastos, 'Pago compra semillas', 'Compra');
end 
//
delimiter ;
select * from gastos;

-- 14. 
CREATE TABLE Estado (
	id_estado INT PRIMARY KEY AUTO_INCREMENT,
	descripcion_estado VARCHAR(100)
);

delimiter //
create trigger tabla_estado
after delete on estado
for each row
begin
delete from Estado where id_estado = old.id_estado;
end 
//
delimiter ;
select * from estado;

-- 15. 
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

delimiter //
create trigger tabla_perdidas
after delete on Perdidas
for each row
begin
delete from Perdidas where id_perdida = old.id_perdida;
end 
//
delimiter ;
select * from perdidas;

-- 16. 
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

delimiter //
create trigger tabla_salario 
before insert on Salario 
for each row 
begin 
insert into tabla_salario (id_salario, fecha_fin)
values (new.id_salario, '2023-10-10');
end
//
delimiter ;
select * from salario;

-- 17. 
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

delimiter //
create trigger tabla_cultivos
after update on Cultivo
for each row 
begin 
insert into tabla_cultivos (id_cultivo, rendimiento_estimado)
values (new.id_cultivo, '150.00');
end
//
delimiter ;
select * from cultivo;

-- 18. 
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

delimiter //
create trigger tabla_empleados
before delete on Empleado
for each row
begin
delete from Empleado where id_empleado = old.id_empleado;
end
//
delimiter ;
select * from empleado;

-- 19. 
CREATE TABLE Maquinaria (
    id_maquinaria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    estado_maquinaria VARCHAR(50),
    fecha_compra DATE,
    costo_adquisicion VARCHAR(20),
    ultimo_mantenimiento DATE,
    horas_operativas DECIMAL(10, 2)
);

delimiter //
create trigger tabla_maquinarias
after update on Maquinaria 
for each row
begin
insert into tabla_maquinarias(id_maquinaria, estado_maquinaria)
values (new.id_maquinaria,'En operacion');
end
//
delimiter ;
select * from maquinaria; 

-- 20. 
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(50),
    frecuencia_compra VARCHAR(20)
);

delimiter //
create trigger tabla_clientes
before delete on Cliente
for each row
begin 
delete from Cliente where id_cliente = old.id_cliente;
end 
//
delimiter ;
select * from cliente;
