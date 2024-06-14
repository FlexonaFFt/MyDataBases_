--- Общая выручка за все время
SELECT SUM(total_amount) AS total_revenueSELECT SUM(total_amount) AS weekend_revenue
FROM sales
--- Суммарная выручка за все субботы и воскресенья
WHERE DAYOFWEEK(sale_date) IN (1, 7);  -- 1 для воскресенья и 7 для субботы в MySQLz
FROM sales;

--- Средняя дневная выручка
SELECT AVG(daily_revenue) AS average_daily_revenue
FROM (
    SELECT sale_date, SUM(total_amount) AS daily_revenue
    FROM sales
    GROUP BY sale_date
) AS daily_sales;

--- Выручка по категориям
SELECT c.name AS category_name, SUM(s.total_amount) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.id
JOIN categories c ON p.category_id = c.id
GROUP BY c.name;

--- Выручка по категориям и дням
SELECT c.name AS category_name, s.sale_date, SUM(s.total_amount) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.id
JOIN categories c ON p.category_id = c.id
GROUP BY c.name, s.sale_date;

--- Средняя цена товара каждой категории при условии что товаров в категории не менее двух
SELECT c.name AS category_name, AVG(p.price) AS average_price
FROM products p
JOIN categories c ON p.category_id = c.id
GROUP BY c.name
HAVING COUNT(p.id) >= 2;
