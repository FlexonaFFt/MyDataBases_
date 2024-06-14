--- Самый дорогой товар
SELECT name, price
FROM products
WHERE price = (SELECT MAX(price) FROM products);

--- Товары по которым не было продаж (3 разных способа)
SELECT p.name
FROM products p
LEFT JOIN sales s ON p.id = s.product_id
WHERE s.id IS NULL;

--- Товары той же категории что и «Рис» (2 разных способа)
SELECT p2.name
FROM products p1
JOIN products p2 ON p1.category_id = p2.category_id
WHERE p1.name = 'Рис' AND p2.name <> 'Рис';

--- День принесший самую большую выручку
SELECT sale_date, SUM(total_amount) AS total_revenue
FROM sales
GROUP BY sale_date
ORDER BY total_revenue DESC
LIMIT 1;
