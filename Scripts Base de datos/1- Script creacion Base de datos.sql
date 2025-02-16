
/*Creacion Base de datos*/
CREATE DATABASE ControlPermisos;
GO
USE ControlPermisos;
GO

/*Creacion tabla Roles*/
CREATE TABLE Roles (
    idRol INT PRIMARY KEY IDENTITY,
    nombreRol VARCHAR(50) NOT NULL UNIQUE
);

/*Creacion tabla Roles*/
CREATE TABLE Departamentos (
    idDept INT PRIMARY KEY IDENTITY,
    nombreDept VARCHAR(100) NOT NULL UNIQUE
);

/*Creacion tabla Usuarios*/
CREATE TABLE Usuarios (
    idUsuario INT PRIMARY KEY IDENTITY,
    nombreUsuario VARCHAR(100) NOT NULL,
    emailUsuario VARCHAR(100) UNIQUE NOT NULL,
    idRol INT,
    idDept INT,
	idJefe INT NULL
    FOREIGN KEY (idRol) REFERENCES Roles(idRol),
    FOREIGN KEY (idDept) REFERENCES Departamentos(idDept),
	FOREIGN KEY (idJefe) REFERENCES Usuarios(idUsuario)
);

/*Creacion tabla Pagos*/
CREATE TABLE Pagos (
    idPago INT PRIMARY KEY IDENTITY,
    idUsuario INT,
    montoPago DECIMAL(10,2) NOT NULL,
    fechaPago DATE NOT NULL,
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

/*Creacion tabla Auditoria Accesos*/
CREATE TABLE AuditoriaAccesos (
    idAcceso INT PRIMARY KEY IDENTITY,
    idUsuario INT,
    tablaAccedida VARCHAR(50),
    fechaAcceso DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

