--- Единым списком все названия категорий и названия товаров с ценой выше 400
SELECT c.name AS category_name, p.name AS product_name, p.price
FROM categories c
JOIN products p ON c.id = p.category_id
WHERE p.price > 400;

--- Товары по которым не было продаж
SELECT p.name
FROM products p
LEFT JOIN sales s ON p.id = s.product_id
WHERE s.id IS NULL;

--- Дни когда продавались товары категории «Прочее»
SELECT DISTINCT s.sale_date
FROM sales s
JOIN products p ON s.product_id = p.id
JOIN categories c ON p.category_id = c.id
WHERE c.name = 'Прочее';
