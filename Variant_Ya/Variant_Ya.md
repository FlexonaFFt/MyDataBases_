# Основной код

```
-- Создание таблицы Employees
CREATE TABLE Employees (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    skills TEXT,
    desired_position TEXT,
    current_jobs TEXT,
    desired_salary INTEGER
);

-- Вставка данных в таблицу
INSERT INTO Employees (name, skills, desired_position, current_jobs, desired_salary) VALUES
('Иванов И.И.', 'SQL, Java, UML', 'разработчик', 'РИНХ, системный администратор, РИНХ, разработчик', 60),
('Петров П.П.', 'Java, SQL', 'разработчик', 'РИНХ, разработчик, FastReports, разработчик', 70),
('Сидоров С.С.', 'C#', 'аналитик', '', 45);

```

####Первый запрос####

```
SELECT * FROM Employees WHERE current_jobs = '';
```

####Второй запрос####

```
SELECT * FROM Employees WHERE skills LIKE '%SQL%';
```

####Третий запрос####

```
SELECT * FROM Employees ORDER BY desired_salary DESC LIMIT 1;
```

####Четвёртый запрос####

```
SELECT desired_position, AVG(desired_salary) AS avg_salary FROM Employees GROUP BY desired_position;
```

####Пятый запрос####

```
SELECT * FROM Employees WHERE current_jobs LIKE '%,%';
```

####Шестой запрос####

```
SELECT * FROM Employees WHERE skills NOT LIKE '%SQL%';
```

####Седьмой запрос####

```
SELECT * FROM Employees WHERE desired_salary < 50;
```

