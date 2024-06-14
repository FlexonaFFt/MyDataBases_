--- Самый дорогой товар
SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 1;

--- Дни, когда были продажи
SELECT DISTINCT sale_date
FROM sales;

--- Все товары, которые начинаются со слова "Колбаса"
SELECT name
FROM products
WHERE name LIKE 'Колбаса%';

--- Товар, его цена в рублях и его цена в евро по курсу 1EUR=90RUR
SELECT name, price AS price_rub, price / 90 AS price_eur
FROM products;

---	Все продажи за период от 02.02.2020 до 05.02.2020
SELECT *
FROM sales
WHERE sale_date BETWEEN '2020-02-02' AND '2020-02-05';

--- Товары категорий с кодами 1 ИЛИ 3 ИЛИ 5
SELECT name
FROM products
WHERE category_id IN (1, 3, 5);
