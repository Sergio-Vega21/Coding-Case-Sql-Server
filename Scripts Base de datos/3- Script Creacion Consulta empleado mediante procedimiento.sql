/*Creacion Consulta Usuario normal / empleado */

CREATE PROCEDURE VistaEmpleado 
	@idEmpleado INT
as	
begin
	select P.idPago, P.idUsuario, P.montoPago, P.fechaPago
	from pagos P
	where P.idUsuario = @idEmpleado
end;


/*Ejemplo Empleado 23*/
/*EXEC VistaEmpleado @idEmpleado=23;*/