
/*Creacion Consulta supervisor mediante procedimiento */

CREATE PROCEDURE VistaSupervisor 
	@idSupervisor INT
as	
begin
	select u.idUsuario, u.nombreUsuario, u.emailUsuario, r.nombreRol
	from Usuarios u 
	inner join Roles r on u.idRol = r.idRol
	where u.idDept =  (select idDept from Usuarios where idUsuario=@idSupervisor)
end;


/*Ejemplo supervisor 12 */
EXEC VistaSupervisor @idSupervisor = 12;

