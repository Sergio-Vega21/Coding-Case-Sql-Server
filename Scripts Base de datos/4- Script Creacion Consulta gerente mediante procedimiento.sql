/*Creacion Consulta gerente mediante procedimiento */
CREATE PROCEDURE VistaGerente 
    @idGerente INT
AS	
BEGIN
    SELECT 
        u.idUsuario, 
        u.nombreUsuario, 
        u.emailUsuario, 
        r.nombreRol, 
        p.montoPago, 
        p.fechaPago
    FROM Usuarios u 
    INNER JOIN Roles r ON u.idRol = r.idRol
    full OUTER JOIN Pagos p ON u.idUsuario = p.idUsuario
    WHERE u.idDept = (select idDept from Usuarios where idUsuario=@idGerente)
    ORDER BY p.fechaPago DESC;
END;

/*Ejémplo gerente 5 */ 
/*EXEC VistaGerente @idGerente = 5;*/
