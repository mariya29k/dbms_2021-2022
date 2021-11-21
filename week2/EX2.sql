SET SCHEMA DB2SAMPLE;

-- Problem 1
-- Produce a report listing all employees whose last name ends with 'N'. List the
-- employee number, the last name, and the last character of the last name used to
-- control the result. The LASTNAME column is defined as VARCHAR. There is a
-- function which provides the length of the last name.

SELECT EMPNO, LASTNAME, SUBSTR(LASTNAME, LENGTH(LASTNAME), 1) AS LASTCHAR
FROM EMP
WHERE SUBSTR(LASTNAME, LENGTH(LASTNAME), 1) = 'N';

-- Problem 2
-- For each project, display the project number, project name, department number, and
-- project number of its associated major project (COLUMN = MAJPROJ). If the value
-- in MAJPROJ is NULL, show a literal of your choice instead of displaying a null value.
-- List only projects assigned to departments D01 or D11. The rows should be listed in
-- project number sequence.
SELECT PROJNO, PROJNAME, DEPTNO, COALESCE(MAJPROJ, 'NO MAJ PROJ') AS "MAJPROJ"
FROM PROJ
WHERE DEPTNO LIKE 'D01' OR 'D11'
ORDER BY PROJNO;

-- Problem 3
-- The salaries of the employees in department E11 will be increased by 3.75 percent.
-- What will be the increase in dollars? Display the last name, actual yearly salary, and
-- the salary increase rounded to the nearest dollar. Do not show any cents.
SELECT LASTNAME, SALARY, DECIMAL(SALARY * 0.0375 + 0.5, 5,0) AS "INCREASED"
FROM EMP
WHERE WORKDEPT = 'E11';

-- Problem 4
-- Repeat Problem 3 but this time express the amount of salary increase as an integer,
-- that is, a number with no decimal places and no decimal point. (QMF users, you do
-- not get a decimal point even for Problem 3, so there is no point in doing this problem
-- if you are using QMF.)
SELECT LASTNAME, SALARY, INTEGER(SALARY * 0.0375 + 0.5) AS "INCREASED"
FROM EMP
WHERE WORKDEPT = 'E11';


-- Problem 5
-- For each female employee in the company present her department, her job and her
-- last name with only one blank between job and last name.
SELECT WORKDEPT, CAST(RTRIM(JOB) AS VARCHAR(10))
 !! ': ' !! LASTNAME AS LISTING
FROM EMP
WHERE SEX = 'F';

-- Problem 6
-- Calculate the difference between the date of birth and the hiring date for all
-- employees for whom the hiring date is more than 30 years later than the date of
-- birth. Display employee number and calculated difference. The difference should be
-- shown in years, months, and days - each of which should be shown in a separate
-- column. Make sure that the rows are in employee number sequence.
SELECT EMPNO, YEAR(HIREDATE) - YEAR(BIRTHDATE) AS YEARS,
       MONTH(HIREDATE) - MONTH(BIRTHDATE) AS MONTHS,
       DAY(HIREDATE) - DAY(BIRTHDATE) AS DAYS
FROM EMP
WHERE YEAR(HIREDATE) - YEAR( BIRTHDATE) > 30
ORDER BY EMPNO;

-- Problem 7
-- Display project number, project name, project start date, and project end date of
-- those projects whose duration was less than 10 months. Display the project duration
-- in days.
SELECT PROJNO, PROJNAME, PRSTDATE, PRENDATE, DAYS(PRENDATE) - DAYS(PRSTDATE) AS "DAYS_DURATION"
FROM PROJ
WHERE PRSTDATE + 10 MONTHS <= PRENDATE;


-- Problem 8
-- List the employees in department D11 who had activities. Display employee number,
-- last name, and first name. Also, show the activity number and the activity duration
-- (in days) of the activities started last. Multiple activities may have been started on
-- the same day.
SELECT E.EMPNO, LASTNAME, FIRSTNME, A.ACTNO, DAYS(A.EMSTDATE) -  DAYS(A.EMENDATE) AS "DURATION"
FROM EMP E, EMPACT A
WHERE E.WORKDEPT = 'D11' AND A.ACTNO IS NOT NULL
AND E.EMPNO = A.EMPNO;


-- Problem 9
-- How many weeks are between the first manned landing on the moon (July 20, 1969)
-- and the first day of the year 2000?

-- Problem 10
-- Find out which employees were hired on a Saturday or a Sunday. List their last
-- names and their hiring dates.
SELECT LASTNAME, HIREDATE, DAYOFWEEK_ISO(HIREDATE), DAYNAME(HIREDATE), WEEK(HIREDATE), WEEK_ISO(HIREDATE)
FROM EMP
WHERE DAYOFWEEK_ISO(HIREDATE) IN (6,7);