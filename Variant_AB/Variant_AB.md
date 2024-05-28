# Основной код

```sqlite
CREATE TABLE Employees (
    id INTEGER PRIMARY KEY,
    fio TEXT NOT NULL,
    skills TEXT,
    desired_position TEXT,
    work TEXT,
    desired_salary INTEGER
);

INSERT INTO Employees (fio, skills, desired_position, work, desired_salary) VALUES
('Иванов И.И.', 'SQL, Java, UML', 'разработчик', 'РИНХ, системный администратор', NULL),
('Иванов И.И.', 'SQL, Java, UML', 'разработчик', 'РИНХ, разработчик', 60),
('Петров П.П.', 'Java, SQL', 'разработчик', 'FastReports, разработчик', 70),
('Сидоров С.С.', 'C#', 'аналитик', '', 45);

```

####**1 сотрудник без оплаты работы:**####

```sqlite
SELECT * FROM Employees WHERE desired_salary IS NULL;
```

####**2 сотрудника, знающие SQL:**####

```sqlite
SELECT * FROM Employees WHERE skills LIKE '%SQL%' LIMIT 2;
```

####**3 сотрудника с самыми большими запросами:**####

```sqlite
SELECT * FROM Employees ORDER BY desired_salary DESC LIMIT 3;
```

####**4 сотрудника с средней желаемой зарплатой по позиции:**####

```sqlite
SELECT desired_position, AVG(desired_salary) as avg_salary
FROM Employees
GROUP BY desired_position
LIMIT 4;
```

####**6 сотрудников, не знающих SQL:**####

```sqlite
SELECT fio, COUNT(work) as work_count
FROM Employees
GROUP BY fio
HAVING work_count > 1
LIMIT 5;
```

####**7 сотрудников, с ожидаемой зарплатой менее 50:**####

```sqlite
SELECT * FROM Employees WHERE desired_salary < 50 LIMIT 7;
```

####**Разработка триггера для изменения желаемой заработной платы - не более, чем в 2 раза**####

```sqlite
CREATE TRIGGER check_salary_update
BEFORE UPDATE OF desired_salary ON Employees
FOR EACH ROW
WHEN NEW.desired_salary > 2 * OLD.desired_salary
BEGIN
    SELECT RAISE(ABORT, 'Зарплата не может быть увеличена более, чем в 2 раза');
END;
```

