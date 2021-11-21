SET SCHEMA DB2SAMPLE;

-- Problem 1
-- List those employees that have a salary which is greater than or equal to the
-- average salary of all employees plus $5,000.
-- Display department number, employee number, last name, and salary. Sort the list
-- by the department number and employee number.
SELECT WORKDEPT, EMPNO, LASTNAME, SALARY
FROM EMP
WHERE SALARY >= (SELECT AVG(SALARY) + 5000 FROM EMP)
ORDER BY WORKDEPT, EMPNO;

-- Problem 2
-- List employee number and last name of all employees not assigned to any projects.
-- This means that table EMP_ACT does not contain a row with their employee
-- number.
SELECT EMPNO, LASTNAME
FROM EMP
WHERE EMPNO NOT IN (SELECT EMPNO FROM EMPACT);

-- Problem 3
-- List project number and duration (in days) of the project with the shortest duration.
-- Name the derived column DAYS.
SELECT PROJNO, DAYS(PRENDATE)-DAYS(PRSTDATE) AS DAYS
FROM PROJECT
WHERE DAYS (PRENDATE) - DAYS(PRSTDATE) =
      (SELECT MIN(DAYS(PRENDATE) - DAYS(PRSTDATE)) FROM PROJ);

-- Problem 4
-- List department number, department name, last name, and first name of all those
-- employees in departments that have only male employees.
SELECT DEPTNO, DEPTNAME, LASTNAME, FIRSTNME
FROM EMP, DEPARTMENT
WHERE DEPTNO = WORKDEPT
AND DEPTNO NOT IN (SELECT WORKDEPT FROM EMPLOYEE WHERE SEX = 'F');

-- Problem 5
-- We want to do a salary analysis for people that have the same job and education
-- level as the employee Stern. Show the last name, job, edlevel, the number of years
-- they've worked as of January 1, 2000, and their salary.
-- Name the derived column YEARS.
-- Sort the listing by highest salary first.

SELECT LASTNAME, JOB, EDLEVEL, YEAR('2000-01-01' - HIREDATE) AS YEARS, SALARY
FROM EMP
WHERE (JOB, EDLEVEL) IN (SELECT JOB, EDLEVEL FROM EMP WHERE LASTNAME = 'STERN')
ORDER BY SALARY DESC;