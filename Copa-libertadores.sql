CREATE DATABASE copa_libertadores;
USE copa_libertadores;

CREATE TABLE Estadio (
    ID_estadio INT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Pais VARCHAR(255) NOT NULL,
    Capacidad INT NOT NULL
);

CREATE TABLE Arbitro (
    ID_arbitro INT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Nacionalidad VARCHAR(255) NOT NULL
);

CREATE TABLE Equipo (
    ID_equipo INT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Pais VARCHAR(255) NOT NULL,
    Estadio_ID INT,
    FOREIGN KEY (Estadio_ID) REFERENCES Estadio(ID_estadio)
);

CREATE TABLE Jugador (
    ID_jugador INT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Fecha_nacimiento DATE NOT NULL,
    Posicion VARCHAR(255) NOT NULL,
    Nacionalidad VARCHAR(255) NOT NULL,
    Equipo_ID INT,
    FOREIGN KEY (Equipo_ID) REFERENCES Equipo(ID_equipo)
);

CREATE TABLE Grupo (
    ID_grupo INT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL
);

CREATE TABLE Partido (
    ID_partido INT PRIMARY KEY,
    Fecha DATE NOT NULL,
    Equipo_local_ID INT,
    Equipo_visitante_ID INT,
    Estadio_ID INT,
    Grupo_ID INT,
    Arbitro_ID INT,
    Fase VARCHAR(255) NOT NULL, -- Como 'Primera ronda', 'Cuartos de final', etc.
    FOREIGN KEY (Equipo_local_ID) REFERENCES Equipo(ID_equipo),
    FOREIGN KEY (Equipo_visitante_ID) REFERENCES Equipo(ID_equipo),
    FOREIGN KEY (Estadio_ID) REFERENCES Estadio(ID_estadio),
    FOREIGN KEY (Grupo_ID) REFERENCES Grupo(ID_grupo),
    FOREIGN KEY (Arbitro_ID) REFERENCES Arbitro(ID_arbitro)
);

CREATE TABLE Gol (
    ID_gol INT PRIMARY KEY,
    Minuto INT NOT NULL,
    Jugador_ID INT,
    Partido_ID INT,
    FOREIGN KEY (Jugador_ID) REFERENCES Jugador(ID_jugador),
    FOREIGN KEY (Partido_ID) REFERENCES Partido(ID_partido)
);

CREATE TABLE Tarjeta (
    ID_tarjeta INT PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL, -- Como 'Amarilla' o 'Roja'
    Minuto INT NOT NULL,
    Jugador_ID INT,
    Partido_ID INT,
    FOREIGN KEY (Jugador_ID) REFERENCES Jugador(ID_jugador),
    FOREIGN KEY (Partido_ID) REFERENCES Partido(ID_partido)
);

CREATE TABLE ClasificacionGrupo (
    ID_clasificacion INT PRIMARY KEY,
    Puntos INT NOT NULL,
    Partidos_jugados INT NOT NULL,
    Victorias INT NOT NULL,
    Empates INT NOT NULL,
    Derrotas INT NOT NULL,
    Goles_a_favor INT NOT NULL,
    Goles_en_contra INT NOT NULL,
    Diferencia_de_goles INT NOT NULL,
    Grupo_ID INT,
    Equipo_ID INT,
    FOREIGN KEY (Grupo_ID) REFERENCES Grupo(ID_grupo),
    FOREIGN KEY (Equipo_ID) REFERENCES Equipo(ID_equipo)
);
