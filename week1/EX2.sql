SET SCHEMA DB2SAMPLE;

-- Problem 1
-- Produce a report that lists employees' last names, first names, and department
-- names. Sequence the report on first name within last name, within department
-- name.
SELECT LASTNAME, FIRSTNME, DEPTNAME
FROM EMP, DEPT
WHERE WORKDEPT = DEPTNO
ORDER BY DEPTNAME, LASTNAME, FIRSTNME;

-- Problem 2
-- Modify the previous query to include job. Also, list data for only departments
-- between A02 and D22, and exclude managers from the list. Sequence the report on
-- first name within last name, within job, within department name.
SELECT LASTNAME, FIRSTNME, DEPTNAME, JOB
FROM EMP, DEPT
WHERE WORKDEPT = DEPTNO
AND DEPTNO BETWEEN 'A02' AND 'D22' AND JOB NOT IN ('MANAGER')
--JOB <> 'MANAGER'
ORDER BY DEPTNAME, LASTNAME, FIRSTNME;

--OR
-- SELECT E.LASTNAME, E.FIRSTNME, D.DEPTNAME, E.JOB
-- FROM EMPLOYEE E, DEPARTMENT D
-- WHERE E.WORKDEPT = D.DEPTNO
--  AND E.WORKDEPT BETWEEN 'A02' AND 'D22'
--  AND JOB <> 'MANAGER'
-- ORDER BY D.DEPTNAME, E.LASTNAME, E.FIRSTNME

-- Problem 3
-- List the name of each department and the lastname and first name of its manager.
-- Sequence the list by department name. Use the EMPNO and MGRNO columns to
-- relate the two tables. Sequence the result rows by department name.
SELECT DEPTNAME, FIRSTNME, LASTNAME
FROM EMP, DEPT
WHERE EMPNO = MGRNO
ORDER BY DEPTNAME;

-- Problem 4
-- Try the following: modify the previous query using WORKDEPT and DEPTNO as the
-- join predicate. Include a local predicate that looks for people whose job is manager.
SELECT DEPTNAME, FIRSTNME, LASTNAME
FROM EMP, DEPT
WHERE WORKDEPT = DEPTNO
AND JOB = 'MANAGER'
ORDER BY DEPTNAME;

-- Problem 5
-- For all projects that have a project number beginning with AD, list project number,
-- project name, and activity number. List identical rows once. Order the list by project
-- number and then by activity number.
SELECT DISTINCT A.PROJNO, PROJNAME, ACTNO
FROM EMPACT A, PROJECT P
WHERE PROJNAME LIKE 'AD%'
AND A.PROJNO = P.PROJNO
ORDER BY PROJNO, ACTNO;

-- Problem 6
-- Which employees are assigned to project number AD3113? List employee number,
-- last name, and project number. Order the list by employee number and then by
-- project number. List only one occurrence of duplicate result rows.
SELECT DISTINCT E.EMPNO, LASTNAME, PROJNO
FROM EMPLOYEE E, EMPACT P
WHERE E.EMPNO = P.EMPNO
AND PROJNO = 'AD3113'
ORDER  BY EMPNO, PROJNO;

-- Problem 7
-- Which activities began on October 1, 1982? For each of these activities, list the
-- employee number of the person performing the activity, the project number, project
-- name, activity number, and starting date of the activity. Order the list by project
-- number, then by employee number, and then by activity number.
SELECT E.EMPNO, P.PROJNO, PROJNAME, ACTNO, EMSTDATE
FROM PROJECT P, EMP_ACT E
WHERE P.PROJNO = E.PROJNO
AND EMSTDATE = '1982-10-01'
ORDER BY E.PROJNO, E.EMPNO, ACTNO;

-- Problem 8
-- Display department number, last name, project name, and activity number for
-- activities performed by the employees in department A00.
-- Sequence the results first by project name and then by activity number.
SELECT P.DEPTNO, E.LASTNAME, A.PROJNO, ACTNO
FROM EMP E, PROJ P, EMPACT A
WHERE E.EMPNO = A.EMPNO
  AND A.PROJNO = P.PROJNO
  AND E.WORKDEPT = 'A00'
ORDER BY PROJNO, ACTNO;


-- Problem 9
-- List department number, last name, project name, and activity number for those
-- employees in work departments A00 through C01. Suppress identical rows.
-- Sort the list by department number, last name, and activity number.
SELECT DISTINCT P.DEPTNO, E.LASTNAME, A.PROJNO, ACTNO
FROM EMP E, PROJ P, EMPACT A
WHERE E.EMPNO = A.EMPNO
  AND A.PROJNO = P.PROJNO
AND DEPTNO BETWEEN 'A00' AND 'C01'
ORDER BY DEPTNO, LASTNAME, ACTNO;

-- Problem 10
-- The second line manager needs a list of activities which began on October 15, 1982
-- or thereafter.
-- For these activities, list the activity number, the manager number of the manager of
-- the department assigned to the project, the starting date for the activity, the project
-- number, and the last name of the employee performing the activity.
-- The list should be ordered by the activity number and then by the activity start date.
SELECT A.ACTNO, D.MGRNO, A.EMSTDATE, E.LASTNAME
FROM DEPARTMENT D, EMP E, PROJ P, EMPACT A
WHERE E.EMPNO = A.EMPNO
AND A.PROJNO = P.PROJNO
AND E.WORKDEPT = D.DEPTNO
AND EMSTDATE >= '1982-10-15'
ORDER BY ACTNO, EMSTDATE;

-- Problem 11
-- Which employees in department A00 were hired before their manager?
-- List department number, the manager's last name, the employee's last name, and
-- the hiring dates of both the manager and the employee.
-- Order the list by the employee's last name

SELECT D.DEPTNO, M.LASTNAME AS MANAGER, E.LASTNAME AS EMPLOYEE, M.HIREDATE AS M_HIREDATE, E.HIREDATE AS E_HIREDATE
FROM EMP E, DEPT D, EMP M
WHERE E.WORKDEPT = D.DEPTNO
AND M.EMPNO = D.MGRNO
AND E.WORKDEPT = D.DEPTNO
AND M.HIREDATE > E.HIREDATE
AND E.WORKDEPT = 'A00'
ORDER BY E.LASTNAME;