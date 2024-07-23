/*
*/

SELECT  AVG(sal), SUM(sal), MAX(sal), MIN(sal) # 하나의 그룹으로 묶음, 갯수가 일치
FROM emp
WHERE deptno = 20; 

SELECT  ename, LENGTH(ename) # 결과의 갯수가 일치하여 나옴
FROM emp
WHERE deptno = 20; 

SELECT AVG(comm), AVG(IFNULL(comm, 0)), SUM(IFNULL(comm, 0)) / COUNT(*) # null 제외, COUNT(*)는 중복 및 null 포함
FROM emp;

SELECT COUNT(DISTINCT job)
FROM emp;

SELECT MIN(hiredate), MAX(hiredate)
FROM emp;

-- SELECT ename, sal, MAX(sal) # 복수행 함수와 같이 기술되면 GROUP BY를 적어야한다
-- FROM emp
-- WHERE sal = MAX(sal);

SELECT deptno, AVG(sal), MIN(sal), MAX(sal)
FROM emp
GROUP BY deptno; # 복수행을 그룹으로 나눠서 3개로 분류

SELECT YEAR(hiredate), COUNT(*)
FROM emp
GROUP BY YEAR(hiredate)
ORDER BY YEAR(hiredate);

-- 부서별, 직무별
SELECT deptno, job, COUNT(*) # GROUP BY의 기준이 그대로 SELECT에 올라오도록
FROM emp
GROUP BY deptno, job
ORDER BY deptno ASC;

-- 직무별 월급의 합
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY deptno, job
WITH ROLLUP; 

-- Join
SELECT emp.ename, emp.sal, dept.deptno, dept.loc, salgrade.grade
FROM emp CROSS JOIN dept CROSS JOIN salgrade;

SELECT ename, d.deptno, loc # deptno : 어디서 가져올까?
FROM dept d, emp e # 별칭 쓸 수 있음 FROM이 가장 먼저 올라감으로 FROM 부터 별칭 작성
WHERE d.deptno = e.deptno AND ename = 'SMITH';

SELECT deptno
FROM emp
WHERE ename = 'SMITH'; # 20

SELECT loc
FROM dept
WHERE deptno = 20;

-- 표준 JOIN
SELECT ename, loc
/* FROM emp NATURAL JOIN dept # 많이 쓰지 않음 */ 
/* FROM emp INNER JOIN dept USING(deptno) */
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
/* JOIN aaa ON () JOIN bbb ON() JOIN ccc ON() # JOIN ON() 으로 계속 붙일 수 있어서 많이 씀 */
WHERE ename = 'SMITH';

-- WORLD 스키마로 변경
-- 등가 조인, 내부 조인, 조인
SELECT city.name, city.Population, country.name, country.IndepYear, countrylanguage.Language
FROM city JOIN country ON (city.countrycode = country.code)
	JOIN countrylanguage ON (country.code = countrylanguage.countrycode)
WHERE city.name =  'SEOUL';

-- 비등가 조인
SELECT ename, sal, grade
FROM emp, salgrade
WHERE (sal BETWEEN losal AND hisal)
	AND ename = 'SMITH';

SELECT emp.ename, emp.empno, dept.dname, dept.loc
FROM emp RIGHT OUTER JOIN dept ON(emp.deptno = dept.deptno);
/* FROM emp INNER JOIN dept ON(emp.deptno = dept.deptno); */

CREATE TABLE emp1
AS
SELECT * FROM emp;

INSERT INTO emp1(empno, ename, sal, job, deptno)
VALUES(8282, 'JACK', 3000, 'ANALYST', 50);

SELECT e.ename, e.job, e.sal, d.loc, d.dname
FROM emp1 e LEFT OUTER JOIN dept d
ON (e.deptno = d.deptno);

SELECT * FROM mycompany.emp;

SELECT mgr
FROM emp
WHERE ename = 'SMITH'; # 7902

SELECT ename
FROM emp
WHERE empno = 7902; # FORD

SELECT CONCAT(employee.ename, '의 관리자의 이름은 ', employer.ename, '입니다.')
FROM emp employee JOIN emp employer # 셀프조인은 같은 테이블이기때문에 별칭 사용 필요
ON employee.mgr = employer.empno;
/* WHERE employee.ename = 'SMITH'; */

SELECT CONCAT(worker.ename, '의 관리자의 이름은 ', manager.ename, '입니다.')
FROM emp worker JOIN emp manager # 셀프조인은 같은 테이블이기때문에 별칭 사용 필요
ON worker.mgr = manager.empno;

SELECT job, deptno
FROM emp
WHERE sal >= 3000
UNION ALL    # 중복을 허용하는 것이 UNION ALL / 허용하지 않는 것 UNION
SELECT job, deptno
FROM emp
WHERE deptno = 10;

-- 사번 7566의 급여보다 많이 받는 사원의 이름
SELECT sal FROM emp WHERE empno = 7566; # 2975.00
SELECT ename 
FROM emp 
WHERE sal > (SELECT sal FROM emp WHERE empno = 7566);

-- SMITH가 근무하는 곳은?
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

SELECT loc
FROM dept
WHERE deptno = 20;

-- 한 번에 출력하기
SELECT loc
FROM dept
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH');

-- 부서에서 최소 급여를 받는 사람 
IN(1300.00, 800.00, 950.00) # 복수행
SELECT ename, deptno, sal
FROM emp
WHERE sal IN(SELECT MIN(sal)
			 FROM emp
			 GROUP BY deptno);
    


