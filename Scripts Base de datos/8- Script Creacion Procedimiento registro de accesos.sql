

CREATE PROCEDURE RegistrarAcceso
    @idUsuario INT,
    @tablaAccedida VARCHAR(50)
AS
BEGIN
    INSERT INTO AuditoriaAccesos (idUsuario, tablaAccedida, fechaAcceso)
    VALUES (@idUsuario, @tablaAccedida, GETDATE());
END;