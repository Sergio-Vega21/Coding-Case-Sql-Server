
/*Creacion Registro roles*/

INSERT INTO Roles (nombreRol) VALUES 
('Administrador'),
('Gerente'),
('Supervisor'),
('Empleado');


/*Creacion Departamentos*/
INSERT INTO Departamentos (nombreDept)  
VALUES 
    ('Recursos Humanos'),
    ('Finanzas'),
    ('TI'),
    ('Ventas'),
    ('Marketing'),
    ('Operaciones'),
    ('Atención al Cliente');


/*Creacion Registro usuario -> administrador*/
INSERT INTO Usuarios (nombreUsuario, emailUsuario, idRol, idDept, idJefe)  
VALUES ('Luis Vanegas', 'LuisVanegas@gmail.com', 1, NULL, NULL);


/*Creacion Registro usuario -> Gerentes*/
INSERT INTO Usuarios (nombreUsuario, emailUsuario, idRol, idDept, idJefe)
VALUES 
    ('Carlos Gómez', 'CarlosGomez@gmail.com', 2, 1, 1), -- Gerente de Recursos Humanos
    ('Ana Martínez', 'AnaMartinez@gmail.com', 2, 2, 1), -- Gerente de Finanzas
    ('Luis Rodríguez', 'LuisRodriguez@gmail.com', 2, 3, 1), -- Gerente de TI
    ('Marta Sánchez', 'MartaSanchez@gmail.com', 2, 4, 1), -- Gerente de Ventas
    ('Pedro López', 'PedroLopez@gmail.com', 2, 5, 1), -- Gerente de Marketing
    ('Sofía Ramírez', 'SofiaRamirez@gmail.com', 2, 6, 1), -- Gerente de Operaciones
    ('Javier Torres', 'JavierTorres@gmail.com', 2, 7, 1); -- Gerente de Atención al Cliente

/*Creacion Registro usuario -> supervisores*/

INSERT INTO Usuarios (nombreUsuario, emailUsuario, idRol, idDept, idJefe)
VALUES 
    -- Recursos Humanos
    ('Andrea Ramírez', 'AndreaRamirez@gmail.com', 3, 1, (SELECT idUsuario FROM Usuarios WHERE idDept = 1 AND idRol = 2)),
    ('Diego Fernández', 'DiegoFernandez@gmail.com', 3, 1, (SELECT idUsuario FROM Usuarios WHERE idDept = 1 AND idRol = 2)),
    -- Finanzas
    ('Beatriz Gómez', 'BeatrizGomez@gmail.com', 3, 2, (SELECT idUsuario FROM Usuarios WHERE idDept = 2 AND idRol = 2)),
    ('Fernando Torres', 'FernandoTorres@gmail.com', 3, 2, (SELECT idUsuario FROM Usuarios WHERE idDept = 2 AND idRol = 2)),
    -- TI
    ('Gabriela Castro', 'GabrielaCastro@gmail.com', 3, 3, (SELECT idUsuario FROM Usuarios WHERE idDept = 3 AND idRol = 2)),
    ('Hugo Morales', 'HugoMorales@gmail.com', 3, 3, (SELECT idUsuario FROM Usuarios WHERE idDept = 3 AND idRol = 2)),
    -- Ventas
    ('Isabel Díaz', 'IsabelDiaz@gmail.com', 3, 4, (SELECT idUsuario FROM Usuarios WHERE idDept = 4 AND idRol = 2)),
    ('Juan Vega', 'JuanVega@gmail.com', 3, 4, (SELECT idUsuario FROM Usuarios WHERE idDept = 4 AND idRol = 2)),
    -- Marketing
    ('Karen Méndez', 'KarenMendez@gmail.comm', 3, 5, (SELECT idUsuario FROM Usuarios WHERE idDept = 5 AND idRol = 2)),
    ('Leonardo Herrera', 'LeonardoHerrera@gmail.com', 3, 5, (SELECT idUsuario FROM Usuarios WHERE idDept = 5 AND idRol = 2)),
    -- Operaciones
    ('Marina Suárez', 'MarinaSuarez@gmail.com', 3, 6, (SELECT idUsuario FROM Usuarios WHERE idDept = 6 AND idRol = 2)),
    ('Nicolás Pardo', 'NicolasPardo@gmail.com', 3, 6, (SELECT idUsuario FROM Usuarios WHERE idDept = 6 AND idRol = 2)),
    -- Atención al Cliente
    ('Olga Ríos', 'OlgaRios@gmail.com', 3, 7, (SELECT idUsuario FROM Usuarios WHERE idDept = 7 AND idRol = 2)),
    ('Pablo Salazar', 'PabloSalazar@gmail.com', 3, 7, (SELECT idUsuario FROM Usuarios WHERE idDept = 7 AND idRol = 2));

	/*Creacion Registro usuario -> empleados*/
	
INSERT INTO Usuarios (nombreUsuario, emailUsuario, idRol, idDept, idJefe)
VALUES 
    ('Santiago Rojas', 'SantiagoRojas@gmail.com', 4, 1, (SELECT TOP 1 idUsuario FROM Usuarios WHERE idDept = 1 AND idRol = 3 )),
    ('Camila Vargas', 'CamilaVargas@gmail.com', 4, 1, (SELECT TOP 1 idUsuario FROM Usuarios WHERE idDept = 1 AND idRol = 3)),
    ('Alejandro Nieto', 'AlejandroNieto@gmail.com', 4, 2, (SELECT TOP 1 idUsuario FROM Usuarios WHERE idDept = 2 AND idRol = 3)),
    ('Valentina Paredes', 'ValentinaParedes@gmail.com', 4, 3, (SELECT TOP 1 idUsuario FROM Usuarios WHERE idDept = 3 AND idRol = 3)),
    ('Ricardo Mejía', 'RicardoMejia@gmail.com', 4, 4, (SELECT TOP 1 idUsuario FROM Usuarios WHERE idDept = 4 AND idRol = 3)),
    ('Daniela Gutiérrez', 'DanielaGutierrez@gmail.com', 4, 5, (SELECT TOP 1 idUsuario FROM Usuarios WHERE idDept = 5 AND idRol = 3)),
    ('Julián Castillo', 'JulianCastillo@gmail.com', 4, 6, (SELECT TOP 1 idUsuario FROM Usuarios WHERE idDept = 6 AND idRol = 3)),
    ('Mariana Peña', 'MarianaPena@gmail.com', 4, 7, (SELECT TOP 1 idUsuario FROM Usuarios WHERE idDept = 7 AND idRol = 3)),
    ('Felipe Cárdenas', 'FelipeCardenas@gmail.com', 4, 2, (SELECT  TOP 1 idUsuario FROM Usuarios WHERE idDept = 2 AND idRol = 3)),
    ('Natalia León', 'NataliaLeon@gmail.com', 4, 3, (SELECT TOP 1 idUsuario FROM Usuarios WHERE idDept = 3 AND idRol = 3));


		/*Creacion Registro Pagos*/

INSERT INTO Pagos (idUsuario, montoPago, fechaPago)
VALUES 
    -- Jefes (idRol = 2) con mayor sueldo
    (2, 6000.00, '2025-01-15'),
    (3, 5900.50, '2025-01-18'),
    (4, 5800.75, '2025-01-20'),
    (5, 5700.25, '2025-01-25'),
    (6, 5600.00, '2025-01-28'),
    (7, 5500.60, '2025-02-01'),
    (8, 5400.30, '2025-02-05'),

    -- Empleados (idRol = 3) con pago medio
    (11, 4500.00, '2025-02-12'),
    (12, 4400.90, '2025-02-15'),
    (13, 4300.50, '2025-02-18'),
    (14, 4200.75, '2025-02-20'),
    (15, 4100.25, '2025-02-22'),
    (16, 4000.00, '2025-02-25'),
    (17, 3900.60, '2025-02-27'),
    (18, 3800.30, '2025-02-28'),
    (19, 3700.40, '2025-03-01'),
	(20, 2800.80, '2025-03-02'),
    (21, 2700.00, '2025-03-05'),
  -- Empleados comunes (idRol = 4) con menor sueldo
	(23, 3000.40, '2025-02-08'),
    (24, 2900.80, '2025-02-10');
	INSERT INTO Pagos (idUsuario, montoPago, fechaPago)
VALUES 
    -- Empleados comunes (idRol = 4) con menor sueldo
    (23, 6000.00, '2025-02-15'),
    (24, 5900.50, '2025-02-18'),
    (25, 5800.75, '2025-01-20'),
    (26, 5700.25, '2025-01-25'),
    (27, 5600.00, '2025-01-28'),
    (30, 5500.60, '2025-02-01'),
    (32, 5400.30, '2025-02-05');
	
INSERT INTO Roles (nombreRol) VALUES 
('Contador');


INSERT INTO Usuarios (nombreUsuario, emailUsuario, idRol, idDept, idJefe)
VALUES 
    ('Bruno Diaz', 'BrunoDiaz@gmail.com', 5, 2, (SELECT TOP 1 idUsuario FROM Usuarios WHERE idDept = 1 AND idRol = 3 )),
    ('Camila Diaz', 'CamilaDiaz@gmail.com', 5, 2, (SELECT TOP 1 idUsuario FROM Usuarios WHERE idDept = 1 AND idRol = 3));

	INSERT INTO Pagos (idUsuario, montoPago, fechaPago)
VALUES 
    -- Empleados Contadores (idRol = 5)
    (35, 6500.00, '2025-02-15'),
    (36, 6900.50, '2025-02-18'),
	(35, 6500.00, '2024-02-15'),
    (36, 6900.50, '2024-02-18');
