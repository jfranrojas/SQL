DROP SCHEMA IF EXISTS copa_libertadores;
CREATE SCHEMA copa_libertadores;
-- Base de datos para la COPA LIBERTADORES
USE copa_libertadores;
CREATE TABLE IF NOT EXISTS Entrenador (
    ID_entrenador INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador del Entrenador',
    Apellido VARCHAR(255) COMMENT 'Apellido ',
    Nombre VARCHAR(255) COMMENT 'Nombre',
    Fecha_nacimiento DATE COMMENT 'Fecha de nacimiento',
    Nacionalidad VARCHAR(255) COMMENT 'Pais de origen'
);
CREATE TABLE IF NOT EXISTS Estadio (
    ID_estadio INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador del Estadio',
    Nombre VARCHAR(255) COMMENT 'Nombre del Estadio',
    Ciudad VARCHAR(255) COMMENT 'Ciudad donde se ubica',
    Pais VARCHAR(255) COMMENT 'Pais donde se ubica',
    Capacidad INT COMMENT 'Capacidad total'
);
CREATE TABLE IF NOT EXISTS Equipo (
    ID_equipo INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador del Equipo',
    Nombre VARCHAR(255) COMMENT 'Nombre ',
    Ciudad VARCHAR(255) COMMENT 'Ciudad de origen',
    Pais VARCHAR(255) COMMENT 'Pais de origen',
    ID_estadio INT,
    ID_entrenador INT,
    FOREIGN KEY (ID_estadio) REFERENCES Estadio(ID_estadio),
    FOREIGN KEY (ID_entrenador) REFERENCES Entrenador(ID_entrenador)
);
CREATE TABLE IF NOT EXISTS Jugador (
    ID_jugador INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador del Jugador',
    Apellido VARCHAR(255) COMMENT 'Apellido',
    Nombre VARCHAR(255) COMMENT 'Nombre',
    Fecha_nacimiento DATE COMMENT 'Fecha de nacimiento',
    Nacionalidad VARCHAR(255) COMMENT 'Pais de origen',
    Posicion VARCHAR(255) COMMENT 'Posición que ocupa en el campo de juego',
    ID_equipo INT,
    FOREIGN KEY (ID_equipo) REFERENCES Equipo(ID_equipo)
);
CREATE TABLE IF NOT EXISTS Arbitro (
    ID_arbitro INT AUTO_INCREMENT PRIMARY KEY,
    Apellido VARCHAR(255) COMMENT 'Apellido',
    Nombre VARCHAR(255) COMMENT 'Nombre',
    Nacionalidad VARCHAR(255) COMMENT 'País de origen'
);
CREATE TABLE IF NOT EXISTS FaseEliminatoria (
    ID_fase INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) COMMENT 'Nombre de la fase eliminatoria (e.g. cuartos)'
);
CREATE TABLE IF NOT EXISTS Grupo (
    ID_grupo CHAR(1) PRIMARY KEY COMMENT 'Nombre de grupo (e.g H)'
);

CREATE TABLE IF NOT EXISTS Torneo (
    ID_torneo INT AUTO_INCREMENT PRIMARY KEY,
    Temporada VARCHAR(10) COMMENT 'Temporada del campeonato (e.g. 2022/2023)'
);
CREATE TABLE IF NOT EXISTS HistoricoCampeones (
    ID_campeon_historico INT AUTO_INCREMENT PRIMARY KEY,
    ID_torneo INT COMMENT 'Identificador del torneo',
    ID_equipo INT COMMENT 'Identificador del Equipo campeón',
    FOREIGN KEY (ID_torneo) REFERENCES Torneo(ID_torneo),
    FOREIGN KEY (ID_equipo) REFERENCES Equipo(ID_equipo)
);
CREATE TABLE IF NOT EXISTS Partido (
    ID_partido INT AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE COMMENT 'Fecha del partido',
    ID_local INT COMMENT 'Identificador equipo local',
    ID_visitante INT COMMENT 'Identificador equipo visitante',
    ID_arbitro INT COMMENT 'Identificador arbitro responsable',
    ID_estadio INT COMMENT 'Identificador estadio',
    ID_faseEliminatoria INT COMMENT 'Identificador de fase eliminatoria',
    ID_grupo CHAR(1) COMMENT 'Identificador de fase grupo',
    ID_torneo INT COMMENT 'Identificador del Equipo',
    FOREIGN KEY (ID_local) REFERENCES Equipo(ID_equipo),
    FOREIGN KEY (ID_visitante) REFERENCES Equipo(ID_equipo),
    FOREIGN KEY (ID_arbitro) REFERENCES Arbitro(ID_arbitro),
    FOREIGN KEY (ID_estadio) REFERENCES Estadio(ID_estadio),
    FOREIGN KEY (ID_faseEliminatoria) REFERENCES FaseEliminatoria(ID_fase),
    FOREIGN KEY (ID_grupo) REFERENCES Grupo(ID_grupo),
    FOREIGN KEY (ID_torneo) REFERENCES Torneo(ID_torneo)
);
CREATE TABLE IF NOT EXISTS Gol (
    ID_gol INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador del Gol',
    Minuto INT COMMENT 'Minuto en el que se anotó',
    ID_jugador INT COMMENT 'Identificador del jugador que anotó',
    ID_partido INT COMMENT 'Identificador del partido',
    FOREIGN KEY (ID_jugador) REFERENCES Jugador(ID_jugador),
    FOREIGN KEY (ID_partido) REFERENCES Partido(ID_partido)
);
CREATE TABLE IF NOT EXISTS Asistencia (
    ID_asistencia INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador de la Asistencia',
    ID_jugador INT COMMENT 'Identificador del jugador que anotó',
    ID_gol INT COMMENT 'Identificador del Gol',
    FOREIGN KEY (ID_jugador) REFERENCES Jugador(ID_jugador),
    FOREIGN KEY (ID_gol) REFERENCES Gol(ID_gol)
);
CREATE TABLE IF NOT EXISTS TipoTarjeta (
    ID_tipo_tarjeta INT AUTO_INCREMENT PRIMARY KEY,
    Tipo VARCHAR(255) COMMENT 'Tipo de tarjeta(amarilla/roja)'
);
CREATE TABLE IF NOT EXISTS Tarjeta (
    ID_tarjeta INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador de la Tarjeta',
    ID_tipo_tarjeta INT COMMENT 'Identificador de tarjeta',
    ID_partido INT COMMENT 'Identificador del partido',
    ID_jugador INT COMMENT 'Identificador que recibió la tarjeta',
    FOREIGN KEY (ID_tipo_tarjeta) REFERENCES TipoTarjeta(ID_tipo_tarjeta),
    FOREIGN KEY (ID_partido) REFERENCES Partido(ID_partido),
    FOREIGN KEY (ID_jugador) REFERENCES Jugador(ID_jugador)
);
CREATE TABLE IF NOT EXISTS Goleador (
    ID_goleador INT AUTO_INCREMENT PRIMARY KEY,
    ID_jugador INT COMMENT 'Identificador del jugador',
    ID_torneo INT COMMENT 'Identificador del torneo',
    Goles_marcados INT COMMENT 'Acumulador de goles del jugador',
    FOREIGN KEY (ID_jugador) REFERENCES Jugador(ID_jugador),
    FOREIGN KEY (ID_torneo) REFERENCES Torneo(ID_torneo)
);
CREATE TABLE IF NOT EXISTS ClasificacionGrupo (
    ID_Clasificacion INT AUTO_INCREMENT PRIMARY KEY,
    Puntos INT COMMENT 'Puntos totales en el Partido',
    Partidos_jugados INT COMMENT 'Cantidad de partidos jugados',
    Ganados INT COMMENT 'Cantidad de partidos ganados',
    Empatados INT COMMENT 'Cantidad de partidos empatados',
    Perdidos INT COMMENT 'Cantidad de partidos perdidos',
    Goles_favor INT COMMENT 'Cantidad de goles anotados',
    Goles_contra INT COMMENT 'Cantidad de goles recibidos',
    Diferencia_gol INT COMMENT 'Diferencia entre goles anotados y recibidos',
    ID_grupo CHAR(1) COMMENT 'Identificador del grupo',
    ID_equipo INT COMMENT 'Identificador del Equipo',
	ID_torneo INT COMMENT 'Identificador del torneo',
    FOREIGN KEY (ID_grupo) REFERENCES Grupo(ID_grupo),
    FOREIGN KEY (ID_equipo) REFERENCES Equipo(ID_equipo),
	FOREIGN KEY (ID_torneo) REFERENCES Torneo(ID_torneo)
);