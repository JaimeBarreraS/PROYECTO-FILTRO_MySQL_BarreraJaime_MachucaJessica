USE Palmaris_Tech_pe;
-- inner join.
-- 1.
select cliente.id_cliente, cliente.nombre, venta.id_venta, venta.fecha_venta from cliente 
inner join venta on cliente.id_cliente = venta.id_cliente;

-- 2. 
select distinct mantenimiento.id_mantenimiento, empleado.id_empleado, empleado.nombre, empleado.apellidos from mantenimiento 
inner join empleado on mantenimiento.id_empleado = empleado.id_empleado
order by empleado.id_empleado asc, empleado.nombre asc, empleado.apellidos asc, mantenimiento.id_mantenimiento asc;

-- 3. 
select venta.id_venta, venta.fecha_venta, venta.total, venta.metodo_pago, Inventario.nombre, Inventario.descripcion 
as descripcion, Inventario.cantidad_disponible from venta inner join Inventario 
on venta.id_producto = Inventario.id_producto order by venta.id_venta asc;

-- 4. 
select * from proveedor; 
select Inventario.nombre, Inventario.descripcion as descripcion, Inventario.cantidad_disponible, proveedor.id_proveedor,
proveedor.nombre, proveedor.telefono, proveedor.correo_electronico from inventario inner join proveedor
on inventario.id_proveedor = proveedor.id_proveedor;

-- 5. 
select cultivo.id_cultivo, cultivo.variedad, cultivo.fecha_siembra, estado.descripcion_estado from cultivo inner join estado
on cultivo.id_estado = estado.id_estado order by cultivo.id_cultivo desc;

-- 6. 
select * from produccion;
select produccion.id_produccion, produccion.fecha_cosecha, produccion.destino, cultivo.id_cultivo, cultivo.hectareas, cultivo.rendimiento_estimado
from produccion inner join cultivo on produccion.id_cultivo = cultivo.id_cultivo where produccion.destino = 'Mercado Local';

-- 7. 
select * from inventario;
select * from estado;
select venta.id_venta, venta.fecha_venta, cliente.nombre, cliente.apellidos, inventario.id_producto, inventario.cantidad_disponible, 
estado.descripcion_estado from venta inner join cliente on venta.id_cliente = cliente.id_cliente inner join inventario
on venta.id_producto = inventario.id_producto inner join estado on venta.id_estado = estado.id_estado order by venta.fecha_venta desc;

-- 8. 
select * from fertilizacion;
select fertilizacion.id_fertilizacion, fertilizacion.fecha_aplicacion, fertilizacion.insumo_utilizado, cultivo.id_cultivo, cultivo.variedad, cultivo.fecha_siembra
from fertilizacion inner join cultivo on fertilizacion.id_cultivo = cultivo.id_cultivo where fertilizacion.insumo_utilizado = 'Urea';

-- 9. 
select * from maquinaria;
select * from mantenimiento;
select mantenimiento.id_mantenimiento, mantenimiento.fecha_mantenimiento, mantenimiento.costo, maquinaria.id_maquinaria, 
maquinaria.estado, maquinaria.fecha_compra, maquinaria.horas_operativas from mantenimiento inner join maquinaria
on mantenimiento.id_maquinaria = maquinaria.id_maquinaria where mantenimiento.costo = '200';

-- 10. 
select * from salario;
select salario.id_salario, salario.salario_base, salario.fecha_inicio, salario.fecha_fin, empleado.nombre, empleado.apellidos,
cultivo.variedad, maquinaria.nombre from salario inner join empleado on salario.id_empleado = empleado.id_empleado inner join cultivo
on salario.id_cultivo = cultivo.id_cultivo inner join maquinaria on salario.id_maquinaria = maquinaria.id_maquinaria 
where salario.fecha_inicio >= '2024-01-01' and salario.fecha_fin <= '2024-12-31';

-- Consultas
-- 11. 
select lower(concat(nombre, ' ', apellidos, '   ', coalesce(`direccion`, ' '))) as nombre_direccion from empleado;

-- 12. 
select fecha_inicio, fecha_fin from Salario where fecha_fin > fecha_inicio;

-- 13. 
select count(*) as total_empleados from empleado where nombre = 'José';

-- 14. 
select * from cliente limit 5 offset 2;

-- 15. 
select count(*) as monto_perdida from perdidas where monto_perdida = '1200';

-- 16. 
select cultivo.id_cultivo, cultivo.fecha_siembra, estado.id_estado, estado.descripcion_estado from cultivo right join estado
on cultivo.id_estado = estado.id_estado order by cultivo.id_cultivo desc, cultivo.fecha_siembra desc, 
estado.id_estado desc, estado.descripcion_estado desc;

-- 17. 
select * from Inventario;
select * from venta left join inventario on venta.id_venta = inventario.id_producto; 

-- 18. 
select * from salario;
select salario_base, fecha_inicio, costo_dia_falta, dias_faltas from salario where dias_faltas >= 3;

-- 19.
select fecha_inicio, fecha_fin from salario order by fecha_fin desc;

-- 20. 
select distinct nombre from cliente order by 1 asc; 

-- 21. 
select * from gastos left join empleado on gastos.id_gastos = empleado.id_empleado;

-- 22. 
select * from empleado;
select salario, ciudad, nombre, estado from empleado where salario is null;

-- 23. 
select * from produccion;
select id_produccion, fecha_cosecha, destino from produccion right join cultivo on produccion.id_produccion = cultivo.id_cultivo;

-- 24. 
select * from cliente where apellidos = 'Pérez';

-- 25. 
select sum(costo) as costo from mantenimiento;

-- 26. 
select avg(cantidad_aplicada) as cantidad_aplicada from fertilizacion;

-- 27.
select categoria, monto_perdida from perdidas where monto_perdida = (select min(monto_perdida) from perdidas);

-- 28. 
select count(*) as total_empleados from empleado where nombre = 'José';

-- 29. 
select upper(concat(nombre,' ', apellidos, ' ', coalesce(`apellidos`, ''))) as Nombre_apellidos from cliente;

-- 30. 
select * from salario;
select fecha_inicio, salario_base from salario where salario_base >= 2100 and salario_base <= 2500;

-- 31. 
select * from empleado;
select distinct ciudad, nombre, apellidos from empleado where ciudad = 'Ciudad A';

-- 32. 
select * from cultivo;
select variedad, hectareas, id_lote, rendimiento_estimado from cultivo where rendimiento_estimado = '2000.00';

-- 33. 
select * from venta;
select fecha_venta, metodo_pago, total from venta where total = (select max(total) from venta);

-- 34. 
select * from mantenimiento;
select  id_mantenimiento, fecha_mantenimiento, costo from mantenimiento left join empleado on mantenimiento.id_mantenimiento = empleado.id_empleado;

-- 35. 
select * from inventario;
select nombre, cantidad_disponible from inventario where cantidad_disponible not between 200.00 and 800.00;

-- 36. 
select * from proveedor;
select nombre, direccion, telefono from proveedor where nombre = 'ProAgro S.A.';

-- 37. 
select empleado.id_empleado, count(estado.id_estado) as estado from empleado left join estado
on empleado.id_empleado = estado.id_estado group by empleado.id_empleado;

-- 38. 
select upper(concat(nombre, ' ', apellidos, ' ', coalesce(`apellidos`, ' '))) as nombre_apellido from cliente;

-- 39. 
select * from detalle_venta;
select avg(subtotal) as subtotal from detalle_venta;

-- 40.
select * from asignacion_empleado;
select actividad, duracion from asignacion_empleado where duracion >= '6.50';

-- 41. 
select * from fertilizacion;
select  fecha_aplicacion, efectividad_estimada, cantidad_aplicada from fertilizacion order by efectividad_estimada desc limit 2;

-- 42. 
select * from gastos;
select fecha_pago, pago, tipo_gasto from gastos where fecha_pago <= '2024-01-01';

-- 43. 
select * from perdidas;
select monto_perdida, categoria, fecha_recuperacion from perdidas where categoria = 'Robo';

-- 44. 
select * from salario;
select dias_faltas, costo_dia_falta from salario where costo_dia_falta = 50;

-- 45. 
select * from inventario;
select id_producto, inventario.nombre, inventario.cantidad_disponible from inventario right join proveedor on inventario.id_producto = proveedor.id_proveedor;

-- 46. 
select * from cultivo;
select hectareas, variedad, id_lote from cultivo where id_lote between 3 and 8;

-- 47. 
select * from cliente;
select * from cliente where nombre = 'Carlos' and apellidos = 'Gomez';

-- 48. 
select * from venta;
select id_venta, venta.fecha_venta, venta.total from venta left join estado on venta.id_venta = estado.id_estado;

-- 49. 
select * from detalle_venta;
select  cantidad_vendida precio_unitario from detalle_venta where precio_unitario not between 60.00 and 89.00;

-- 50. 
select * from asignacion_empleado;
select actividad, duracion from asignacion_empleado where actividad = 'Cosecha de palma';
