CREATE DATABASE torneo_eliminatorio;
USE torneo_eliminatorio;

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    rol VARCHAR(20) NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE
);
SHOW TABLES;
DESCRIBE usuarios;

CREATE TABLE equipos (
    id_equipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_equipo VARCHAR(100) NOT NULL,
    escudo VARCHAR(255),
    telefono VARCHAR(20),
    estado VARCHAR(20) NOT NULL,
    id_usuario INT NOT NULL,
    id_admin_aprobador INT,
    fecha_aprobacion DATE,

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),

    FOREIGN KEY (id_admin_aprobador)
        REFERENCES usuarios(id_usuario)
);

SHOW TABLES;
DESCRIBE equipos;

CREATE TABLE torneos (
    id_torneo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    imagen VARCHAR(255),
    fecha_inicio DATE,
    fecha_fin DATE,
    premio DECIMAL(10,2),
    estado VARCHAR(20) NOT NULL,
    id_campeon INT,

    FOREIGN KEY (id_campeon)
        REFERENCES equipos(id_equipo)
);

DESCRIBE torneos;

CREATE TABLE rondas (
    id_ronda INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

INSERT INTO rondas (nombre) VALUES
('Octavos'),
('Cuartos'),
('Semifinal'),
('Final');

SELECT * FROM rondas;

CREATE TABLE torneo_equipos (
    id_torneo INT,
    id_equipo INT,

    PRIMARY KEY (id_torneo, id_equipo),

    FOREIGN KEY (id_torneo)
        REFERENCES torneos(id_torneo),

    FOREIGN KEY (id_equipo)
        REFERENCES equipos(id_equipo)
);

CREATE TABLE partidos (
    id_partido INT AUTO_INCREMENT PRIMARY KEY,

    id_torneo INT NOT NULL,
    id_ronda INT NOT NULL,

    id_equipo_local INT NOT NULL,
    id_equipo_visitante INT NOT NULL,

    goles_local INT,
    goles_visitante INT,

    id_ganador INT,

    fecha_partido DATE,
    hora_partido TIME,

    estado VARCHAR(20) NOT NULL,

    FOREIGN KEY (id_torneo)
        REFERENCES torneos(id_torneo),

    FOREIGN KEY (id_ronda)
        REFERENCES rondas(id_ronda),

    FOREIGN KEY (id_equipo_local)
        REFERENCES equipos(id_equipo),

    FOREIGN KEY (id_equipo_visitante)
        REFERENCES equipos(id_equipo),

    FOREIGN KEY (id_ganador)
        REFERENCES equipos(id_equipo)
);

SHOW TABLES;

SELECT * FROM rondas;

INSERT INTO usuarios
(nombre_completo, correo, contrasena, rol, activo, fecha_registro)
VALUES
(
'Administrador',
'admin@torneo.com',
'1234',
'ADMIN',
TRUE,
CURDATE()
);
SELECT * FROM usuarios;

INSERT INTO usuarios
(nombre_completo, correo, contrasena, rol, activo, fecha_registro)
VALUES
(
'Juan Perez',
'juan@gmail.com',
'1234',
'USUARIO',
TRUE,
CURDATE()
);