/*Creacion Vista Administrador */
CREATE VIEW VistaAdministrador AS
SELECT 
    u.idUsuario, 
    u.nombreUsuario, 
    u.emailUsuario, 
    r.nombreRol, 
    d.nombreDept, 
    p.idPago, 
    p.montoPago, 
    p.fechaPago
FROM Usuarios u
LEFT JOIN Roles r ON u.idRol = r.idRol
LEFT JOIN Departamentos d ON u.idDept = d.idDept
LEFT JOIN Pagos p ON u.idUsuario = p.idUsuario;

/*Prueba de la vista*/
/*SELECT * FROM VistaAdministrador;*/
