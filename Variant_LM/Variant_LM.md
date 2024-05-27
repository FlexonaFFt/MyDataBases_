# Основной код

```sqlite
-- Таблица Applicants
CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY,
    Category VARCHAR(255),
    Math INT,
    Russian INT,
    Informatics INT,
    Additional INT,
    Total INT
);

-- Таблица Applications
CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    ApplicantID INT,
    Specialty VARCHAR(255),
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
);

-- Вставка данных в таблицу Applicants
INSERT INTO Applicants (ApplicantID, Category, Math, Russian, Informatics, Additional, Total) VALUES
(1, 'На общих основаниях', 68, 69, 61, 0, 198),
(2, 'На общих основаниях', 70, 72, 0, 0, 142),
(3, 'На общих основаниях', 56, 65, 0, 0, 121),
(4, 'На общих основаниях', 70, 64, 42, 5, 181),
(5, 'На общих основаниях', 62, 65, 63, 5, 195),
(6, 'На общих основаниях', 68, 61, 66, 0, 170),
(7, 'На общих основаниях', 56, 61, 0, 0, 117),
(8, 'На общих основаниях', 82, 82, 0, 5, 167),
(9, 'На общих основаниях', 60, 64, 66, 5, 195),
(10, 'Особые права', 76, 87, 0, 10, 173),
(11, 'Особые права', 70, 73, 0, 0, 203),
(12, 'На общих основаниях', 70, 76, 66, 5, 217);

-- Вставка данных в таблицу Applications
INSERT INTO Applications (ApplicationID, ApplicantID, Specialty) VALUES
(1, 1, 'ПМИ'),
(2, 2, 'ПИ'),
(3, 3, 'ПИ'),
(4, 4, 'ПИ'),
(5, 5, 'ПИ'),
(6, 5, 'ПМИ'),
(7, 6, 'ПИ'),
(8, 8, 'ПИ'),
(9, 8, 'ПМИ'),
(10, 9, 'ИСТ'),
(11, 10, 'ПИ'),
(12, 11, 'ПИ'),
(13, 12, 'ПМИ');

```

####**Список абитуриентов с особым правом:**####

```sqlite
SELECT * FROM Applicants WHERE Category = 'Особые права';
```

####**Сколько абитуриентов подали на какую специальность:**####

```sqlite
SELECT Specialty, COUNT(*) AS NumApplicants
FROM Applications
GROUP BY Specialty;
```

####**На сколько специальностей подал абитуриент в среднем:**####

```sqlite
SELECT AVG(AppCount) AS AvgSpecialties
FROM (
    SELECT ApplicantID, COUNT(*) AS AppCount
    FROM Applications
    GROUP BY ApplicantID
) AS SubQuery;
```

####**Топ 5 абитуриентов для каждой специальности:**####

```sqlite
WITH RankedApplicants AS (
    SELECT a.ApplicantID, a.Specialty, ap.Total,
           ROW_NUMBER() OVER (PARTITION BY a.Specialty ORDER BY ap.Total DESC) AS Rank
    FROM Applications a
    JOIN Applicants ap ON a.ApplicantID = ap.ApplicantID
)
SELECT ApplicantID, Specialty, Total
FROM RankedApplicants
WHERE Rank <= 5;
```

####**Кто подал только на ПИ:**####

```sqlite
SELECT a.ApplicantID, ap.*
FROM Applications a
JOIN Applicants ap ON a.ApplicantID = ap.ApplicantID
WHERE a.Specialty = 'ПИ'
GROUP BY a.ApplicantID
HAVING COUNT(DISTINCT a.Specialty) = 1;
```

####**Место каждого абитуриента на каждой специальности по баллам:**####

```sqlite
WITH RankedApplicants AS (
    SELECT a.ApplicantID, a.Specialty, ap.Total,
           DENSE_RANK() OVER (PARTITION BY a.Specialty ORDER BY ap.Total DESC) AS Rank
    FROM Applications a
    JOIN Applicants ap ON a.ApplicantID = ap.ApplicantID
)
SELECT ApplicantID, Specialty, Total, Rank
FROM RankedApplicants;
```
