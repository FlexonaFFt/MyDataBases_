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

INSERT INTO Employees (employee_name) VALUES
('Светлая Ирина'),
('Раменец Светлана'),
('Исаева Анна'),
('Журавлева Мария'),
('Жданов Михаил'),
('Зайцев Игорь'),
('Корунный Петр');

INSERT INTO Roles (role_name) VALUES
('Исполнитель'),
('Руководитель');

-- Предполагается, что ID сотрудников и ролей известны:
INSERT INTO Requests (request_date, employee_id, role_id, num_requests) VALUES
('2014-01-01', 1, 1, 5),
('2014-01-02', 2, 1, 9),
('2014-01-03', 2, 2, 3),
('2014-01-04', 3, 2, 0),
('2014-01-05', 1, 1, 11),
('2014-01-06', 4, 2, 0),
('2014-01-07', 5, 1, 2),
('2014-01-08', 6, 2, 9),
('2014-01-09', 5, 2, 12),
('2014-01-10', 7, 1, 4),
('2014-01-11', 1, 1, 11),
('2014-01-12', 3, 2, 0),
('2014-01-13', 2, 1, 7),
('2014-01-14', 4, 2, 0),
('2014-02-15', 6, 1, 5),
('2014-04-16', 3, 2, 6);