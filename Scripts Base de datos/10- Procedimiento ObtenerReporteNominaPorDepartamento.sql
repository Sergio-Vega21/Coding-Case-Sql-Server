CREATE PROCEDURE ObtenerReporteNominaPorDepartamento
AS
BEGIN
    SELECT 
        d.nombreDept, 
        SUM(p.montoPago) AS totalPagos,
        COUNT(p.idPago) AS cantidadPagos
    FROM Pagos p
    INNER JOIN Usuarios u ON p.idUsuario = u.idUsuario
    INNER JOIN Departamentos d ON u.idDept = d.idDept
    GROUP BY d.nombreDept
    ORDER BY totalPagos DESC;
END;

/*EXEC ObtenerReporteNominaPorDepartamento;*/
