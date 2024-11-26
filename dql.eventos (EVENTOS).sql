USE Palmaris_Tech_t1;

-- 1.
SELECT * FROM SALARIO;
CREATE EVENT limpiar_logs ON SCHEDULE EVERY 1 WEEK DO DELETE FROM Palmaris_Tech_pe.salario 
WHERE fecha_inicio < month(2) - INTERVAL 1 MONTH;

-- 2. 
select * from empleado;
create event limpiar_log on schedule at current_timestamp + interval 1 minute do 
insert into empleado values ('Evento 1', now(2023));

-- 3. 
select * from inventario;
show events;