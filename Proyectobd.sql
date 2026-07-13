
-- FASE 1: estructura de la bases de datos e índices
CREATE DATABASE IF NOT EXISTS tienda_electronica;
USE tienda_electronica;

CREATE TABLE Categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    direccion TEXT
);

CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
    stock INT NOT NULL CHECK (stock >= 0),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria) ON DELETE SET NULL
);

CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('pendiente', 'enviado', 'entregado') DEFAULT 'pendiente',
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE
);

CREATE TABLE Detalles_Pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

CREATE TABLE Resenas (
    id_reseña INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    id_cliente INT,
    calificacion INT NOT NULL CHECK (calificacion BETWEEN 1 AND 5),
    comentario TEXT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto) ON DELETE CASCADE,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE
);

-- Optimización de rendimiento mediante índices
CREATE INDEX idx_productos_nombre ON Productos(nombre);
CREATE INDEX idx_productos_categoria_precio ON Productos(id_categoria, precio);
CREATE INDEX idx_pedidos_cliente_estado ON Pedidos(id_cliente, estado);

-- FASE 2: POBLADO DE DATOS DE PRUEBA (DML)
-- Categorías
INSERT INTO Categorias (nombre, descripcion) VALUES
('Teléfonos', 'Smartphones y dispositivos móviles'),
('Laptops', 'Computadoras portátiles para oficina y gaming'),
('Accesorios', 'Audífonos, teclados, mouse y cables'),
('Monitores', 'Pantallas de alta definición'),
('Audio', 'Bocinas y sistemas de sonido');

-- Clientes
INSERT INTO Clientes (nombre, correo, telefono, direccion) VALUES
('Carlos Mendoza', 'carlos@mail.com', '555-0101', 'Av. Reforma 123'),
('Ana Gómez', 'ana@mail.com', '555-0102', 'Calle Juárez 456'),
('Luis Pardo', 'luis@mail.com', '555-0103', 'Blvd. Avila Camacho 789'),
('Sofia Castro', 'sofia@mail.com', '555-0104', 'Av. Insurgentes 101'),
('Diego Torres', 'diego@mail.com', '555-0105', 'Colonia Centro Ext 4'),
('Maria Lopez', 'maria@mail.com', '555-0106', 'Paseo de la Republica 12'),
('Pedro Picapica', 'pedro@mail.com', '555-0107', 'Mármol 444'),
('Laura Benitez', 'laura@mail.com', '555-0108', 'Av. Universidad 99'),
('Jorge Ramirez', 'jorge@mail.com', '555-0109', 'Pino Suarez 231'),
('Elena Rostova', 'elena@mail.com', '555-0110', 'Red Square 10'),
('Miguel Hidalgo', 'miguel@mail.com', '555-0111', 'Dolores Hidalgo 1810'),
('Clara Zavala', 'clara@mail.com', '555-0112', 'Constituyentes 88'),
('Roberto Gomez', 'roberto@mail.com', '555-0113', 'Vecindad 72'),
('Patricia Sosa', 'patricia@mail.com', '555-0114', 'Av. Corrientes 990'),
('Fernando Alonso', 'alonso@mail.com', '555-0115', 'Circuito Spa 33');

-- Productos
INSERT INTO Productos (nombre, descripcion, precio, stock, id_categoria) VALUES
('iPhone 15', 'Apple iPhone 15 128GB', 999.99, 15, 1),
('Galaxy S24', 'Samsung Galaxy S24 Ultra', 1199.99, 12, 1),
('Xiaomi 14', 'Xiaomi 14 Pro Global', 799.99, 20, 1),
('Pixel 8', 'Google Pixel 8 Pro', 899.99, 8, 1),
('Moto Edge 50', 'Motorola Edge Premium', 599.99, 4, 1),
('MacBook Air M3', 'Apple MacBook Air 13p M3', 1099.99, 10, 2),
('Dell XPS 13', 'Dell XPS Intel Core i7', 1299.99, 7, 2),
('Lenovo ThinkPad', 'Lenovo ThinkPad X1 Carbon', 1499.99, 5, 2),
('Asus ROG Strix', 'Laptop Gaming Asus RTX 4070', 1799.99, 3, 2),
('HP Pavilion', 'HP Pavilion 15 Acer', 649.99, 14, 2),
('Teclado Logitech G213', 'Teclado RGB Gamer', 49.99, 50, 3),
('Mouse Razer Deathadder', 'Mouse óptico ergonómico', 69.99, 40, 3),
('Hub USB-C Anker', 'Adaptador 7 en 1', 39.99, 2, 3),
('Cable HDMI 2.1', 'Cable de alta velocidad 2 metros', 14.99, 100, 3),
('Cargador Baseus 65W', 'Cargador GaN tres puertos', 34.99, 25, 3),
('Monitor LG 27p', 'Monitor LG 4K IPS', 349.99, 11, 4),
('Monitor Asus Tuf 24p', 'Monitor 165Hz Gaming', 199.99, 15, 4),
('Monitor Samsung Odyssey G9', 'Monitor Curvo 49p', 1299.99, 3, 4),
('Monitor BenQ Ben', 'Monitor para edición fotográfica', 449.99, 6, 4),
('Monitor Dell 22p', 'Monitor básico de oficina', 99.99, 30, 4),
('Audífonos Sony WH-1000XM5', 'Audífonos Noise Cancelling', 349.99, 18, 5),
('AirPods Pro 2', 'Audífonos Apple Wireless', 249.99, 22, 5),
('Bose QuietComfort', 'Audífonos Diadema premium', 299.99, 10, 5),
('JBL Flip 6', 'Bocina portátil Bluetooth IP67', 119.99, 35, 5),
('Barra de Sonido Samsung', 'Sistema de sonido de casa 5.1', 279.99, 8, 5),
('Galaxy Buds 3', 'Audífonos inalámbricos Samsung', 149.99, 12, 5),
('HyperX QuadCast', 'Micrófono condensador USB', 139.99, 14, 5),
('Sennheiser HD 600', 'Audífonos abiertos de estudio', 399.99, 4, 5),
('Sony SRS-XB100', 'Mini bocina portátil', 49.99, 40, 5),
('Logitech Pebble', 'Mouse inalámbrico silencioso', 24.99, 60, 3);

-- Pedidos
INSERT INTO Pedidos (id_cliente, fecha_pedido, estado) VALUES
(1, '2026-01-01', 'entregado'), (2, '2026-01-02', 'entregado'),
(3, '2026-01-03', 'enviado'), (4, '2026-01-04', 'pendiente'),
(5, '2026-01-05', 'pendiente'), (6, '2026-01-06', 'entregado'),
(7, '2026-01-07', 'pendiente'), (8, '2026-01-08', 'enviado'),
(1, '2026-01-09', 'pendiente'), (2, '2026-01-10', 'pendiente'),
(11, '2026-01-11', 'entregado'), (12, '2026-01-12', 'enviado'),
(13, '2026-01-13', 'pendiente'), (14, '2026-01-14', 'entregado'),
(15, '2026-01-15', 'enviado'), (1, '2026-01-16', 'pendiente'),
(2, '2026-01-17', 'entregado'), (3, '2026-01-18', 'pendiente'),
(4, '2026-01-19', 'enviado'), (5, '2026-01-20', 'pendiente');

-- Detalles de Pedidos
INSERT INTO Detalles_Pedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 999.99), (1, 11, 1, 49.99), (2, 2, 1, 1199.99), 
(3, 6, 1, 1099.99), (4, 12, 2, 69.99), (5, 21, 1, 349.99),
(6, 3, 1, 799.99), (6, 14, 2, 14.99), (7, 7, 1, 1299.99), 
(8, 22, 1, 249.99), (9, 16, 1, 349.99), (10, 13, 1, 39.99),
(11, 4, 1, 899.99), (12, 8, 1, 1499.99), (13, 24, 2, 119.99), 
(14, 5, 1, 599.99), (15, 17, 1, 199.99), (16, 23, 1, 299.99),
(17, 2, 1, 1199.99), (17, 12, 1, 69.99), (18, 9, 1, 1799.99), 
(19, 25, 1, 279.99), (20, 1, 1, 999.99), (20, 30, 2, 24.99),
(2, 15, 1, 34.99);

-- Reseñas
INSERT INTO Resenas (id_producto, id_cliente, calificacion, comentario) VALUES
(1, 1, 5, 'Excelente teléfono, la batería dura muchísimo.'),
(11, 1, 4, 'Buen teclado por su precio, aunque es de membrana.'),
(2, 2, 5, 'La pantalla del S24 Ultra es impresionante.'),
(6, 3, 5, 'La laptop más ligera y veloz que he tenido.'),
(3, 6, 4, 'Gran rendimiento de cámara, el software es mejorable.'),
(14, 6, 5, 'Cable robusto y cumple con los 120Hz sin fallas.'),
(22, 8, 3, 'Buen sonido, pero se desconectan a veces.'),
(5, 14, 4, 'Buen diseño de gama media.'),
(2, 2, 4, 'Me gusta pero es muy grande para mi mano.'),
(15, 2, 5, 'Carga mi laptop y mi celular rapidísimo.');

-- FASE 3: REPORTES DE CONSULTA
-- Reporte 1: Productos disponibles por categoría ordenador por precio
SELECT c.nombre AS Categoria, p.nombre AS Producto, p.precio AS Precio, p.stock AS Stock 
FROM Productos p INNER JOIN Categorias c ON p.id_categoria = c.id_categoria
WHERE p.stock > 0 ORDER BY c.nombre ASC, p.precio DESC;

-- Reporte 2: Clientes con pedidos pendientes e histórico
SELECT cl.id_cliente, cl.nombre, 
       COUNT(DISTINCT CASE WHEN pe.estado = 'pendiente' THEN pe.id_pedido END) AS Pedidos_Pendientes,
       COALESCE(SUM(dp.cantidad * dp.precio_unitario), 0) AS Total_Compras_Historico
FROM Clientes cl LEFT JOIN Pedidos pe ON cl.id_cliente = pe.id_cliente LEFT JOIN Detalles_Pedido dp ON pe.id_pedido = dp.id_pedido
GROUP BY cl.id_cliente, cl.nombre HAVING Pedidos_Pendientes > 0;

-- Reporte 3: Top 5 mejores productos calificados
SELECT p.id_producto, p.nombre AS Producto, ROUND(AVG(r.calificacion), 2) AS Promedio_Estrellas, COUNT(r.id_reseña) AS Total_Resenas
FROM Productos p INNER JOIN Resenas r ON p.id_producto = r.id_producto
GROUP BY p.id_producto, p.nombre ORDER BY Promedio_Estrellas DESC, Total_Resenas DESC LIMIT 5;

-- FASE 4: PROCEDIMIENTOS ALMACENADOS (LÓGICA AUTOMATIZADA)
DELIMITER //

CREATE PROCEDURE sp_RegistrarPedido(IN p_id_cliente INT, IN p_id_producto INT, IN p_cantidad INT, OUT p_resultado VARCHAR(250))
BEGIN
    DECLARE v_pendientes INT; DECLARE v_stock INT; DECLARE v_precio DECIMAL(10,2); DECLARE v_id_pedido INT;
    SELECT COUNT(*) INTO v_pendientes FROM Pedidos WHERE id_cliente = p_id_cliente AND estado = 'pendiente';
    IF v_pendientes >= 5 THEN SET p_resultado = 'Error: El cliente ya alcanzó el límite de 5 pedidos pendientes.';
    ELSE
        SELECT stock, precio INTO v_stock, v_precio FROM Productos WHERE id_producto = p_id_producto;
        IF v_stock < p_cantidad THEN SET p_resultado = 'Error: Stock insuficiente para realizar el pedido.';
        ELSE
            START TRANSACTION;
                INSERT INTO Pedidos (id_cliente, fecha_pedido, estado) VALUES (p_id_cliente, NOW(), 'pendiente');
                SET v_id_pedido = LAST_INSERT_ID();
                INSERT INTO Detalles_Pedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES (v_id_pedido, p_id_producto, p_cantidad, v_precio);
                UPDATE Productos SET stock = stock - p_cantidad WHERE id_producto = p_id_producto;
            COMMIT;
            SET p_resultado = CONCAT('Pedido registrado exitosamente. ID: ', v_id_pedido);
        END IF;
    END IF;
END //

CREATE PROCEDURE sp_RegistrarResena(IN p_id_producto INT, IN p_id_cliente INT, IN p_calificacion INT, IN p_comentario TEXT, OUT p_resultado VARCHAR(250))
BEGIN
    DECLARE v_compro INT;
    SELECT COUNT(*) INTO v_compro FROM Pedidos pe INNER JOIN Detalles_Pedido dp ON pe.id_pedido = dp.id_pedido WHERE pe.id_cliente = p_id_cliente AND dp.id_producto = p_id_producto;
    IF v_compro = 0 THEN SET p_resultado = 'Error: Solo los clientes que han adquirido este producto pueden dejar una reseña.';
    ELSE
        INSERT INTO Resenas (id_producto, id_cliente, calificacion, comentario, fecha) VALUES (p_id_producto, p_id_cliente, p_calificacion, p_comentario, NOW());
        SET p_resultado = 'Reseña publicada con éxito.';
    END IF;
END //

CREATE PROCEDURE sp_ActualizarStock(IN p_id_producto INT, IN p_nuevo_stock INT)
BEGIN UPDATE Productos SET stock = p_nuevo_stock WHERE id_producto = p_id_producto; END //

CREATE PROCEDURE sp_CambiarEstadoPedido(IN p_id_pedido INT, IN p_nuevo_estado ENUM('pendiente', 'enviado', 'entregado'))
BEGIN UPDATE Pedidos SET estado = p_nuevo_estado WHERE id_pedido = p_id_pedido; END //

CREATE PROCEDURE sp_EliminarResenasProducto(IN p_id_producto INT)
BEGIN DELETE FROM Resenas WHERE id_producto = p_id_producto; END //

CREATE PROCEDURE sp_CrearProducto(IN p_nombre VARCHAR(150), IN p_descripcion TEXT, IN p_precio DECIMAL(10,2), IN p_stock INT, IN p_id_categoria INT, OUT p_resultado VARCHAR(100))
BEGIN
    DECLARE v_existe INT; SELECT COUNT(*) INTO v_existe FROM Productos WHERE nombre = p_nombre;
    IF v_existe > 0 THEN SET p_resultado = 'Error: Ya existe un producto con el mismo nombre.';
    ELSE
        INSERT INTO Productos(nombre, descripcion, precio, stock, id_categoria) VALUES (p_nombre, p_descripcion, p_precio, p_stock, p_id_categoria);
        SET p_resultado = 'Producto creado exitosamente.';
    END IF;
END //

CREATE PROCEDURE sp_ActualizarCliente(IN p_id_cliente INT, IN p_direccion TEXT, IN p_telefono VARCHAR(20))
BEGIN UPDATE Clientes SET direccion = p_direccion, telefono = p_telefono WHERE id_cliente = p_id_cliente; END //

CREATE PROCEDURE sp_ReporteStockBajo()
BEGIN SELECT id_producto, nombre, stock FROM Productos WHERE stock < 5; END //

DELIMITER ;

-- Pruebas de funcionamiento e integridad del sistema
CALL sp_RegistrarResena(1, 5, 5, 'Intento de reseña fraudulenta', @resultado1);
SELECT @resultado1 AS Verificacion_Regla_Resenas;
CALL sp_ReporteStockBajo();