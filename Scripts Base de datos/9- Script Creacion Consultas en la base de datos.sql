/*Consultas segun rol*/

CREATE PROCEDURE EjecutarConsultaSegunRol
    @idUsuario INT
AS
BEGIN
    DECLARE @Rol NVARCHAR(50);
    DECLARE @idDept INT;
    DECLARE @sql NVARCHAR(MAX) = '';

    -- Obtener el rol del usuario
    SELECT 
        @Rol = r.nombreRol, 
        @idDept = u.idDept
    FROM Usuarios u
    INNER JOIN Roles r ON u.idRol = r.idRol
    WHERE u.idUsuario = @idUsuario;

    -- Crear una tabla temporal global con todas las posibles columnas
    IF OBJECT_ID('tempdb..##TempTable') IS NOT NULL
        DROP TABLE ##TempTable;

    CREATE TABLE ##TempTable (
        idUsuario INT NULL,
        nombreUsuario NVARCHAR(255) NULL,
        emailUsuario NVARCHAR(255) NULL,
        nombreRol NVARCHAR(50) NULL,
        nombreDept NVARCHAR(255) NULL,
        idPago INT NULL,
        montoPago DECIMAL(10,2) NULL,
        fechaPago DATE NULL
    );

    -- Ejecutar según el rol y registrar la tabla correspondiente
    IF @Rol = 'Gerente'
    BEGIN
        SET @sql = 'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Pagos''; ' +
                   'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Usuarios''; ' +
			      'INSERT INTO ##TempTable (idUsuario, nombreUsuario, emailUsuario, nombreRol, montoPago, fechaPago) EXEC VistaGerente ' + CAST(@idUsuario AS NVARCHAR);    
				  END
    ELSE IF @Rol = 'Supervisor'
    BEGIN
        SET @sql = 'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Usuarios''; ' +
                   'INSERT INTO ##TempTable (idUsuario, nombreUsuario, emailUsuario, nombreRol) EXEC VistaSupervisor ' + CAST(@idUsuario AS NVARCHAR);
    END
    ELSE IF @Rol = 'Administrador'
    BEGIN
        SET @sql = 'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Pagos''; ' +
                   'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Usuarios''; ' +
                   'INSERT INTO ##TempTable SELECT * FROM VistaAdministrador;';
    END
    ELSE IF @Rol = 'Contador'
    BEGIN
        SET @sql = 'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Pagos''; ' +
                   'INSERT INTO ##TempTable (idPago, montoPago, fechaPago) SELECT * FROM VistaContador';
    END
    ELSE IF @Rol = 'Empleado'
    BEGIN
        SET @sql = 'EXEC RegistrarAcceso ' + CAST(@idUsuario AS NVARCHAR) + ', ''Pagos''; ' +
                 'INSERT INTO ##TempTable (idPago, idUsuario, montoPago, fechaPago) EXEC VistaEmpleado ' + CAST(@idUsuario AS NVARCHAR);
    END
    ELSE
    BEGIN
        SET @sql = 'INSERT INTO ##TempTable (nombreUsuario) VALUES (''El usuario no tiene permisos para acceder a esta información.'')';
    END

    -- Ejecutar la consulta generada dinámicamente
    EXEC sp_executesql @sql;

    -- Retornar los datos almacenados en la tabla temporal
    SELECT * FROM ##TempTable;
END;



/*Ejemplo adminstrador*/
EXEC EjecutarConsultaSegunRol @idUsuario = 35;

select * from AuditoriaAccesos;
