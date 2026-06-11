CREATE DATABASE biblioteca_campus;
USE biblioteca_campus;


-- tabla de libros

CREATE TABLE libro(
	id_libro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(40) NOT NULL,
    genero VARCHAR(40) NOT NULL,
    isbn VARCHAR(20),
    disponibilidad BOOLEAN NOT NULL
);


-- tabla de autores de libros
CREATE TABLE autor(
	id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(40) NOT NULL
);

-- aqui estoy creando una relacion entre libro y autor
CREATE TABLE LibroAutor(
	id_libro INT,
    id_autor INT,
    PRIMARY KEY (id_libro, id_autor),
    
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
	FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);
-- Aca se hacen las Publicaciones y ediciones
CREATE TABLE Publicacion (
    id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
    id_libro INT NOT NULL,
    edicion INT NOT NULL,
    fecha_publicacion DATE NOT NULL,
    editor VARCHAR(40) NOT NULL,

    FOREIGN KEY (id_libro)
        REFERENCES libro(id_libro)
);

-- Miembros de la biblioteca
CREATE TABLE Miembro (
    id_miembro INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);
-- Prestamos y devoluciones
CREATE TABLE Transaccion (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_libro INT NOT NULL,
    id_miembro INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE,

    FOREIGN KEY (id_libro)
        REFERENCES libro(id_libro),

    FOREIGN KEY (id_miembro)
        REFERENCES Miembro(id_miembro)
);



-- CONSULTA 1: Listar todos los libros disponibles
SELECT *
FROM libro
WHERE disponibilidad = TRUE;

-- CONSULTA 2: Buscar libros por género
SELECT *
FROM libro
WHERE genero = 'Fantasia';

-- CONSULTA 3: Obtener información de un libro por ISBN
SELECT *
FROM libro
WHERE isbn = '9781234567890';

-- CONSULTA 4: Contar el número de libros en la biblioteca
SELECT COUNT(*) AS total_libros
FROM libro;

-- CONSULTA 5: Listar todos los autores
SELECT *
FROM autor;

-- CONSULTA 6: Buscar autores por nombre
SELECT *
FROM autor
WHERE nombre LIKE '%Juan%';

-- CONSULTA 7: Obtener todos los libros de un autor específico
SELECT L.*
FROM libro L
INNER JOIN LibroAutor LA
    ON L.id_libro = LA.id_libro
INNER JOIN autor A
    ON A.id_autor = LA.id_autor
WHERE A.id_autor = 1;

-- CONSULTA 8: Listar todas las ediciones de un libro
SELECT *
FROM Publicacion
WHERE id_libro = 1;

-- CONSULTA 9: Obtener la última edición de un libro
SELECT *
FROM Publicacion
WHERE id_libro = 1
ORDER BY edicion DESC
LIMIT 1;

-- CONSULTA 10: Contar cuántas ediciones hay de un libro específico
SELECT COUNT(*) AS total_ediciones
FROM Publicacion
WHERE id_libro = 1;

-- CONSULTA 11: Listar todas las transacciones de préstamo
SELECT *
FROM Transaccion;

-- CONSULTA 12: Obtener los libros prestados actualmente
SELECT DISTINCT L.*
FROM libro L
INNER JOIN Transaccion T
    ON L.id_libro = T.id_libro
WHERE T.fecha_devolucion IS NULL;

-- CONSULTA 13: Contar el número de transacciones de un miembro específico
SELECT COUNT(*) AS total_transacciones
FROM Transaccion
WHERE id_miembro = 1;

-- CONSULTA 14: Listar todos los miembros de la biblioteca
SELECT *
FROM Miembro;

-- CONSULTA 15: Buscar un miembro por nombre
SELECT *
FROM Miembro
WHERE nombre LIKE '%Carlos%';

-- CONSULTA 16: Obtener las transacciones de un miembro específico
SELECT *
FROM Transaccion
WHERE id_miembro = 1;

-- CONSULTA 17: Listar todos los libros y sus autores
SELECT
    L.titulo,
    A.nombre
FROM libro L
INNER JOIN LibroAutor LA
    ON L.id_libro = LA.id_libro
INNER JOIN autor A
    ON A.id_autor = LA.id_autor;

-- CONSULTA 18: Obtener el historial de préstamos de un libro específico
SELECT *
FROM Transaccion
WHERE id_libro = 1;

-- CONSULTA 19: Contar cuántos libros han sido prestados en total
SELECT COUNT(*) AS total_prestamos
FROM Transaccion;

-- CONSULTA 20: Listar todos los libros junto con su última edición y estado de disponibilidad
SELECT
    L.titulo,
    P.edicion,
    L.disponibilidad
FROM libro L
INNER JOIN Publicacion P
    ON L.id_libro = P.id_libro
WHERE P.edicion = (
    SELECT MAX(P2.edicion)
    FROM Publicacion P2
    WHERE P2.id_libro = L.id_libro
);

