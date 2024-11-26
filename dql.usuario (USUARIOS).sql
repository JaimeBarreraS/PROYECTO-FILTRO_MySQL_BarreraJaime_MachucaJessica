USE Palmaris_Tech;

-- Crear usuarios
CREATE USER 'administrador'@'localhost' IDENTIFIED BY 'admin_password';
CREATE USER 'vendedor'@'localhost' IDENTIFIED BY 'vendedor_password';
CREATE USER 'contador'@'localhost' IDENTIFIED BY 'contador_password';
CREATE USER 'proveedor'@'localhost' IDENTIFIED BY 'proveedor_password';
CREATE USER 'cliente'@'localhost' IDENTIFIED BY 'cliente_password';
CREATE USER 'empleado'@'localhost' IDENTIFIED BY 'empleado_password';

-- Asignar privilegios al administrador
GRANT ALL PRIVILEGES ON Palmaris_Tech.* TO 'administrador'@'localhost';

-- Asignar privilegios al vendedor
GRANT SELECT, INSERT, UPDATE ON Palmaris_Tech.Cliente TO 'vendedor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Palmaris_Tech.Venta TO 'vendedor'@'localhost';
GRANT SELECT, INSERT ON Palmaris_Tech.Inventario TO 'vendedor'@'localhost';

-- Asignar privilegios al contador
GRANT SELECT ON Palmaris_Tech.Venta TO 'contador'@'localhost';
GRANT SELECT ON Palmaris_Tech.Gastos TO 'contador'@'localhost';
GRANT SELECT ON Palmaris_Tech.Salario TO 'contador'@'localhost';

-- Asignar privilegios al proveedor
GRANT SELECT ON Palmaris_Tech.Proveedor TO 'proveedor'@'localhost';
GRANT SELECT ON Palmaris_Tech.Inventario TO 'proveedor'@'localhost';

-- Asignar privilegios al cliente
GRANT SELECT ON Palmaris_Tech.Cliente TO 'cliente'@'localhost';
GRANT SELECT ON Palmaris_Tech.Venta TO 'cliente'@'localhost';

-- Asignar privilegios al empleado
GRANT SELECT, UPDATE ON Palmaris_Tech.Empleado TO 'empleado'@'localhost';
GRANT SELECT, INSERT ON Palmaris_Tech.Asignacion_Empleado TO 'empleado'@'localhost';

-- Aplicar cambios
FLUSH PRIVILEGES;

-- Verificacion de privilegios
SHOW GRANTS FOR 'administrador'@'localhost';
SHOW GRANTS FOR 'vendedor'@'localhost';
SHOW GRANTS FOR 'contador'@'localhost';
SHOW GRANTS FOR 'proveedor'@'localhost';
SHOW GRANTS FOR 'cliente'@'localhost';
SHOW GRANTS FOR 'empleado'@'localhost';
