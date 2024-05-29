# Основной код

```sqlite
CREATE TABLE Employees (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    employee_name TEXT NOT NULL
);

CREATE TABLE Roles (
    role_id INTEGER PRIMARY KEY AUTOINCREMENT,
    role_name TEXT NOT NULL
);

CREATE TABLE Requests (
    request_id INTEGER PRIMARY KEY AUTOINCREMENT,
    request_date DATE NOT NULL,
    employee_id INTEGER,
    role_id INTEGER,
    num_requests INTEGER,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

```

###**Примеры связей**###

####**Сотрудники и их запросы**####

Если сотрудник “Светлая Ирина” имеет employee_id = 1 и обрабатывает запросы, то в таблице Requests будет несколько записей с employee_id = 1.

```sqlite
-- Данные в таблице Employees
INSERT INTO Employees (employee_name) VALUES ('Светлая Ирина');

-- Данные в таблице Requests
INSERT INTO Requests (request_date, employee_id, role_id, num_requests) VALUES
('2014-01-01', 1, 1, 5),
('2014-01-05', 1, 1, 11),
('2014-01-11', 1, 1, 11);
```

####**Роли и их запросы**####

Если роль “Исполнитель” имеет role_id = 1, то в таблице Requests будет несколько записей с role_id = 1.

```sqlite
-- Данные в таблице Roles
INSERT INTO Roles (role_name) VALUES ('Исполнитель');

-- Данные в таблице Requests
INSERT INTO Requests (request_date, employee_id, role_id, num_requests) VALUES
('2014-01-01', 1, 1, 5),
('2014-01-02', 2, 1, 9),
('2014-01-07', 5, 1, 2);
```

###**Запросы**###

####**Общее число обработанных заявок**####

```sqlite
SELECT SUM(num_requests) AS total_requests
FROM Requests;
```

####**Число заявок по месяцам**####

```sqlite
SELECT DATE_FORMAT(request_date, '%Y-%m') AS month, SUM(num_requests) AS total_requests
FROM Requests
GROUP BY month
ORDER BY month;
```

####**Список сотрудников, отсортированный по убыванию общего числа заявок**####

```sqlite
SELECT e.employee_name, SUM(r.num_requests) AS total_requests
FROM Requests r
JOIN Employees e ON r.employee_id = e.employee_id
GROUP BY e.employee_name
ORDER BY total_requests DESC;
```

####**Число заявок по сотрудникам, годам и ролям**####

```sqlite
SELECT e.employee_name, DATE_FORMAT(r.request_date, '%Y') AS year, ro.role_name, SUM(r.num_requests) AS total_requests
FROM Requests r
JOIN Employees e ON r.employee_id = e.employee_id
JOIN Roles ro ON r.role_id = ro.role_id
GROUP BY e.employee_name, year, ro.role_name
ORDER BY e.employee_name, year, ro.role_name;
```

####**Самый продуктивный сотрудник**####

```sqlite
SELECT e.employee_name, SUM(r.num_requests) AS total_requests
FROM Requests r
JOIN Employees e ON r.employee_id = e.employee_id
GROUP BY e.employee_name
ORDER BY total_requests DESC
LIMIT 1;
```

####**Смены с 0 выполненных заявок**####

```sqlite
SELECT r.request_date, e.employee_name, ro.role_name
FROM Requests r
JOIN Employees e ON r.employee_id = e.employee_id
JOIN Roles ro ON r.role_id = ro.role_id
WHERE r.num_requests = 0;
```

####**Сотрудники, выходившие и в качестве исполнителя, и в качестве руководителя**####

```sqlite
SELECT e.employee_name
FROM Requests r
JOIN Employees e ON r.employee_id = e.employee_id
WHERE r.role_id = 1 -- Исполнитель
INTERSECT
SELECT e.employee_name
FROM Requests r
JOIN Employees e ON r.employee_id = e.employee_id
WHERE r.role_id = 2; -- Руководитель
```

