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
