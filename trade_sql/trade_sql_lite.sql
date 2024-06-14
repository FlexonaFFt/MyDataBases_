-- Table structure for table `categories`

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

-- Dumping data for table `categories`
INSERT INTO `categories` (id, name) VALUES 
(1, 'Табачные изделия'),
(2, 'Алкоголь'),
(3, 'Снэки'),
(4, 'Продукты'),
(5, 'Прочее'),
(6, 'Одежда');

-- Table structure for table `products`

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  category_id INTEGER,
  price REAL,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Dumping data for table `products`
INSERT INTO `products` (id, name, category_id, price) VALUES 
(1, 'Сигареты', 1, 100.0),
(2, 'Вино', 2, 500.0),
(3, 'Чипсы', 3, 50.0),
(4, 'Молоко', 4, 60.0),
(5, 'Тетрадь', 5, 20.0),
(6, 'Футболка', 6, 300.0),
(7, 'Сигары', 1, 120.0),
(8, 'Пиво', 2, 70.0),
(9, 'Орешки', 3, 30.0),
(10, 'Сыр', 4, 200.0);

-- Table structure for table `sales`

DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales` (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  product_id INTEGER,
  sale_date TEXT,
  quantity INTEGER,
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Dumping data for table `sales`
INSERT INTO `sales` (id, product_id, sale_date, quantity) VALUES 
(1, 1, '2020-01-01 00:00:00', 5),
(2, 2, '2020-01-01 00:00:00', 3),
(3, 3, '2020-01-02 00:00:00', 2),
(4, 4, '2020-01-02 00:00:00', 4),
(5, 5, '2020-01-03 00:00:00', 1),
(6, 6, '2020-01-03 00:00:00', 6),
(7, 7, '2020-01-04 00:00:00', 3),
(8, 8, '2020-01-04 00:00:00', 2),
(9, 9, '2020-01-05 00:00:00', 7),
(10, 10, '2020-01-05 00:00:00', 5),
(11, 1, '2020-02-01 00:00:00', 4),
(12, 2, '2020-02-02 00:00:00', 3),
(13, 3, '2020-02-03 00:00:00', 5),
(14, 4, '2020-02-04 00:00:00', 2),
(15, 5, '2020-02-05 00:00:00', 1),
(16, 6, '2020-02-06 00:00:00', 4),
(17, 7, '2020-02-07 00:00:00', 3),
(18, 8, '2020-02-08 00:00:00', 2),
(19, 9, '2020-02-09 00:00:00', 7),
(20, 10, '2020-02-10 00:00:00', 5),
(21, 1, '2020-03-01 00:00:00', 6),
(22, 2, '2020-03-02 00:00:00', 2),
(23, 3, '2020-03-03 00:00:00', 4),
(24, 4, '2020-03-04 00:00:00', 1),
(25, 5, '2020-03-05 00:00:00', 3),
(26, 6, '2020-03-06 00:00:00', 6),
(27, 7, '2020-03-07 00:00:00', 2),
(28, 8, '2020-03-08 00:00:00', 4),
(29, 9, '2020-03-09 00:00:00', 5),
(30, 10, '2020-03-10 00:00:00', 3),
(31, 1, '2020-04-01 00:00:00', 7),
(32, 2, '2020-04-02 00:00:00', 6),
(33, 3, '2020-04-03 00:00:00', 2),
(34, 4, '2020-04-04 00:00:00', 3),
(35, 5, '2020-04-05 00:00:00', 4),
(36, 6, '2020-04-06 00:00:00', 1),
(37, 7, '2020-04-07 00:00:00', 5),
(38, 8, '2020-04-08 00:00:00', 7),
(39, 9, '2020-04-09 00:00:00', 3),
(40, 10, '2020-04-10 00:00:00', 6);