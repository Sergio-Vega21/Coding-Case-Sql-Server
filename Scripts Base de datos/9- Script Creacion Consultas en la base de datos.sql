/*Consultas segun rol*/

CREATE PROCEDURE EjecutarConsultaSegunRol
    @idUsuario INT
AS
BEGIN
    DECLARE @Rol NVARCHAR(50);
    DECLARE @idDept INT;
    DECLARE @sql NVARCHAR(MAX) = '';

    -- Obtener el rol y departamento del usuario
    SELECT 
        @Rol = r.nombreRol, 
        @idDept = u.idDept
    FROM Usuarios u
    INNER JOIN Roles r ON u.idRol = r.idRol
    WHERE u.idUsuario = @idUsuario;

    -- Ejecutar según el rol y registrar la tabla correspondiente
    IF @Rol = 'Gerente'
    BEGIN
        SET @sql = @sql + 'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Pagos''; ';
		SET @sql = @sql + 'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Usuarios''; ';
        SET @sql = @sql + 'EXEC VistaGerente @idGerente = ' + CAST(@idUsuario AS NVARCHAR);
    END
    ELSE IF @Rol = 'Supervisor'
    BEGIN
	 SET @sql = @sql + 'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Usuarios''; ';
        SET @sql = @sql + 'EXEC VistaSupervisor @idSupervisor = ' + CAST(@idUsuario AS NVARCHAR);
    END
    ELSE IF @Rol = 'Administrador'
    BEGIN
        SET @sql = @sql + 'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Pagos''; ';
		SET @sql = @sql + 'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Usuarios''; ';
        SET @sql = @sql + 'SELECT * FROM VistaAdministrador';
    END
	ELSE IF @Rol = 'Contador'
    BEGIN
        SET @sql = @sql + 'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Pagos''; ';
         SET @sql = @sql + 'SELECT * FROM VistaContador';
    END
    ELSE IF @Rol = 'Empleado'
    BEGIN
	    SET @sql = @sql + 'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Pagos''; ';
        SET @sql = @sql + 'EXEC VistaEmpleado @idEmpleado = ' + CAST(@idUsuario AS NVARCHAR);
    END
    ELSE
    BEGIN
        SET @sql = @sql + 'PRINT ''El usuario no tiene permisos para acceder a esta información.''';
    END

    -- Ejecutar la consulta generada dinámicamente
    EXEC sp_executesql @sql;
END;


/*Ejemplo adminstrador*/
EXEC EjecutarConsultaSegunRol @idUsuario = 35;

select * from AuditoriaAccesos;
select * from Usuarios;