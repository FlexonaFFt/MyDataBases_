--- День принесший самую большую выручку
SELECT sale_date, daily_revenue
FROM (
    SELECT sale_date, SUM(total_amount) OVER (PARTITION BY sale_date) AS daily_revenue,
           ROW_NUMBER() OVER (ORDER BY SUM(total_amount) OVER (PARTITION BY sale_date) DESC) AS rn
    FROM sales
    GROUP BY sale_date
) AS subquery
WHERE rn = 1;

--- Средняя дневная выручка
SELECT sale_date, AVG(daily_revenue) OVER () AS average_daily_revenue
FROM (
    SELECT sale_date, SUM(total_amount) AS daily_revenue
    FROM sales
    GROUP BY sale_date
) AS daily_sales;

--- Три самых дорогих товара каждой категории
SELECT category_name, product_name, price
FROM (
    SELECT c.name AS category_name, p.name AS product_name, p.price,
           ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY p.price DESC) AS rn
    FROM products p
    JOIN categories c ON p.category_id = c.id
) AS ranked_products
WHERE rn <= 3;

--- Товары входящие в топ 25% по цене
SELECT name, price
FROM (
    SELECT name, price,
           NTILE(4) OVER (ORDER BY price DESC) AS price_quartile
    FROM products
) AS quartiled_products
WHERE price_quartile = 1;

--- Продажи нарастающим итогом по датам
SELECT sale_date, SUM(total_amount) OVER (ORDER BY sale_date) AS cumulative_sales
FROM sales
ORDER BY sale_date;

--- По каждому дню выручка и прирост по отношению к прошлому дню
SELECT sale_date, daily_revenue,
       daily_revenue - LAG(daily_revenue) OVER (ORDER BY sale_date) AS revenue_growth
FROM (
    SELECT sale_date, SUM(total_amount) AS daily_revenue
    FROM sales
    GROUP BY sale_date
) AS daily_sales;

--- Доля выручки каждой категории в общем объеме продаж
SELECT category_name, total_revenue,
       total_revenue / SUM(total_revenue) OVER () AS revenue_share
FROM (
    SELECT c.name AS category_name, SUM(s.total_amount) AS total_revenue
    FROM sales s
    JOIN products p ON s.product_id = p.id
    JOIN categories c ON p.category_id = c.id
    GROUP BY c.name
) AS category_revenue;

--- Доля выручки товара в своей категории
SELECT category_name, product_name, product_revenue,
       product_revenue / category_total AS revenue_share
FROM (
    SELECT c.name AS category_name, p.name AS product_name, SUM(s.total_amount) AS product_revenue,
           SUM(SUM(s.total_amount)) OVER (PARTITION BY p.category_id) AS category_total
    FROM sales s
    JOIN products p ON s.product_id = p.id
    JOIN categories c ON p.category_id = c.id
    GROUP BY c.name, p.name, p.category_id
) AS product_category_revenue;

--- Какой минимальный набор товаров дает 80% выручки
WITH total_revenue AS (
    SELECT SUM(total_amount) AS total FROM sales
),
product_revenue AS (
    SELECT p.name, SUM(s.total_amount) AS revenue,
           SUM(SUM(s.total_amount)) OVER (ORDER BY SUM(s.total_amount) DESC) AS cumulative_revenue
    FROM sales s
    JOIN products p ON s.product_id = p.id
    GROUP BY p.name
)
SELECT name, revenue
FROM product_revenue, total_revenue
WHERE cumulative_revenue <= total * 0.8;

--- Скользящая средняя выручки по трем дням
SELECT sale_date, daily_revenue,
       AVG(daily_revenue) OVER (ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_average
FROM (
    SELECT sale_date, SUM(total_amount) AS daily_revenue
    FROM sales
    GROUP BY sale_date
) AS daily_sales;
