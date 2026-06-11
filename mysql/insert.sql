USE biblioteca_campus;

-- libros
INSERT INTO libro (titulo, genero, isbn, disponibilidad) VALUES
('El Hobbit', 'Fantasia', '978000000001', TRUE),
('Cien Anos de Soledad', 'Novela', '978000000002', FALSE),
('Fundacion', 'Ciencia Ficcion', '978000000003', TRUE);

-- autores
INSERT INTO autor (nombre) VALUES
('J.R.R. Tolkien'),
('Gabriel Garcia Marquez'),
('Isaac Asimov');

-- RELACION LIBRO-AUTOR
INSERT INTO LibroAutor (id_libro, id_autor) VALUES
(1,1),
(2,2),
(3,3);

-- PUBLICACIONES
INSERT INTO Publicacion
(id_libro, edicion, fecha_publicacion, editor)
VALUES
(1,1,'1937-09-21','Allen & Unwin'),
(1,2,'1951-01-01','Allen & Unwin'),
(2,1,'1967-05-30','Sudamericana'),
(3,1,'1951-06-01','Gnome Press'),
(3,2,'1988-01-01','Spectra');

-- MIEMBROS
INSERT INTO Miembro (nombre) VALUES
('Juan Perez'),
('Maria Lopez'),
('Carlos Gomez');

-- TRANSACCIONES
INSERT INTO Transaccion
(id_libro, id_miembro, fecha_prestamo, fecha_devolucion)
VALUES
(1,1,'2026-01-10','2026-01-20'),
(2,2,'2026-02-01',NULL),
(3,3,'2026-03-05','2026-03-15');