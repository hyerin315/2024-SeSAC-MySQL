/*
	Auther : 임혜린
	Date : 2024.07.22
    Objective : Basic SELECT
    Environment : Microsoft Windows 11, MySQL Worckbench 8.0.38, MySQL 8.0.63
*/

-- SELECT deptno, dname, loc # 오라클은 FROM이 필수지만, Mysql은 아님
-- FROM dept # default 스키마를 잘해줘야 스키마 생략 후 사용 가능 

-- SELECT empno, ename, sal, hiredate, comm # 사원 번호, 사원 이름, 월급, 커미션
-- FROM emp

-- SELECT ename, sal, comm, sal + IFNULL(comm, 0) # SMITH의 comm = null / null 처리를 위해 IFNULL 사용
-- FROM emp
-- where ename = 'SMITH' # null 값은 연산이 안됨

-- SELECT mgr, IFNULL(mgr, 0)
-- FROM emp

-- SELECT empno AS "사원번호", ename AS "사원이름", (sal + IFNULL(comm, 0)) * 12 AS "연봉" # "연봉" 특수문자로 인식하게 하도록 하기 위해
-- FROM emp

-- SELECT CONCAT(ename, '의 봉급은 ', sal, '입니다.')
-- FROM emp

-- SELECT 'aaa'
-- FROM emp # aaa를 14번 찍는 이유 : emp 테이블의 레코드 갯수가 14개라서

SELECT /*ALL*/ DISTINCT job
FROM emp;

SELECT DISTINCT deptno
FROM emp;

SELECT *
FROM emp
WHERE ename = UPPER('smith'); # Windows에서는 대소문자 구별을 안하지만, 원래는 이렇게 작성해주어야함

-- 1980년 입사한 직원
SELECT empno, ename, hiredate
FROM emp
WHERE hiredate >= '1980-01-01'  AND hiredate <= '1980-12-31'; 

