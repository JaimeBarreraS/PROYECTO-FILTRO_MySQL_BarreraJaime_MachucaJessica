USE Palmaris_Tech;

-- 1. Crea un nuevo mes en fecha_inicio.
SELECT * FROM SALARIO;
CREATE EVENT limpiar_logs ON SCHEDULE EVERY 1 WEEK DO DELETE FROM Palmaris_Tech_pe.salario 
WHERE fecha_inicio < month(2) - INTERVAL 1 MONTH;

-- 2. Crea un nuevo año en empleado.
select * from empleado;
create event limpiar_log on schedule at current_timestamp + interval 1 minute do 
insert into empleado values ('Evento 1', now(2023));

-- 3. Este evento ejecuta una consulta todos losd dias a las 10.
select * from inventario;
create event inventario on schedule every 1 day starts '2024-11-28 10:00' do delete from inventario 
where nueva_fecha < now() - interval 30 day;

-- 4. Este evento inserta un dato a la tabla empleado. 
create event empleado on schedule at '2024-11-28  10:00' do 
insert into nuevo_evento(nombre, apelldios) values ('Pedro', 'Gonzales');

-- 5. Este evento ajusta los precios de una tabla. 
create event ajustar_precio on schedule every 1 week starts '2024-12-05  10:00' 
do update precio set precio_unitario = precio_unitario * 1.05;

-- 6. Este evento especifica la hora y fecha en que dejara de ejecutarse.
select * from empleado;
create event empleados on schedule every 1 week starts '2024-11-28  10:00' ends '2024-11-30  10:00'
do delete from empleado where dato < now() -  interval 20 day;

-- 7. Este evento se ejecutara cada hora. 
select * from cultivo;
create event cultivo on schedule every 1 hour starts '2024-12-01 10:00'
ends '2024-12-02  10:00' do update cultivo set value = value + 1 where id_cultivo = 1;

-- 8. crea una nueva direccion cada mes.
select * from cliente;
CREATE EVENT clientes ON SCHEDULE EVERY 1 month DO DELETE FROM clientes
WHERE direccion < month(2) - INTERVAL 1 MONTH;

-- 9. Este evento ajustara el precio de adquision.
select * from maquinaria;
create event costo_adqusicion on schedule every 1 week starts '2024-12-05  10:00' 
do update costo set costo_adquisicion = costo_adquisicion * 2;

-- 10. Hora y fecha en que se va a ejecutar.
select * from mantenimiento;
create event mantenimiento on schedule every 3 week starts '2024-12-28  10:00' ends '2024-12-30  10:00'
do delete from mantenimiento where datos_mantenimiento < now() -  interval 25 day; 

-- 11. Crea un dia.
select * from salario;
create event dias_falta on schedule at current_timestamp + interval 5 minute do 
insert into dias_falta values ('Evento 2', now());

-- 12. Crea un nuevo telefono.
select * from proveedor;
create event proveedor on schedule at '2024-11-30  10:00' do 
insert into nuevo_proveedor(telefono) values ('555-5348');

-- 13. Crea un pago cada semana.
select * from gastos;
CREATE EVENT gastos ON SCHEDULE EVERY 1 week DO DELETE FROM gastos
WHERE pago < week(3) - INTERVAL 2 week;

-- 14. Se ejecutara cada semana. 
select * from perdidas;
create event perdidas on schedule every 2 week starts '2024-12-01 10:00'
ends '2024-12-02  10:00' do update perdidas set value = value + 1 where id_perdida = 1;

-- 15. Elimina los eventos que tengan mas de 12 dias.
select * from maquinaria;
create event maquinaria on schedule every 1 month do delete from maquinaria where fecha_compra < curdate() - interval 12 day;

-- 16. Actualiza el campo destino cada 5 horas.
select * from produccion;
create event produccion on schedule every 5 hour do update produccion
set destino = 'Exportación' where fecha_cosecha < curdate() - interval 15 day 
and destino != 'Exportación';

-- 17. Crea un registro automatico.
select * from venta;
create event venta on schedule every 7 day starts '2024-12-02 12:00' do
insert into ventas (fecha_venta, total) values (curdate(), 200.00);

-- 18. Crea un precio unitario cada 3 semanas.
select * from detalle_venta;
CREATE EVENT detalle_venta ON SCHEDULE EVERY 3 week DO DELETE FROM detalle_venta
WHERE precio_unitario < week(4) - INTERVAL 3 week;

-- 19. Ajusta la duracion.
select * from asignacion_empleado;
create event asignacion_empleado on schedule every 2 hour starts '2024-12-05  10:00' 
do update duracion set duracion = duracion * 5.00;

-- 20.
select * from fertilizacion;
create event fertilizacion on schedule at current_timestamp + interval 40 minute do 
insert into efectividad_estimada values ('Evento 4', now());

-- Sirve para ver todos los eventos creados.
show events;