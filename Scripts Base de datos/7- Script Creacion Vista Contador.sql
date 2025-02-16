/*Creacion Vista Contador */
CREATE VIEW VistaContador AS
SELECT 
    p.idPago, 
    p.montoPago, 
    p.fechaPago
FROM Usuarios u
JOIN Pagos p ON u.idUsuario = p.idUsuario;

/*Prueba de la vista*/
/*SELECT * FROM VistaContador;*/

