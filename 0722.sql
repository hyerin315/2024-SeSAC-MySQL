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

SELECT 'aaa'
FROM emp; # aaa를 14번 찍는 이유 : emp 테이블의 레코드 갯수가 14개라서


SELECT version();

-- 1987년에 입사한 사원의 이름과 봉급과 입사날짜를 입력하시오
SELECT ename, sal, hiredate
FROM emp
WHERE hiredate LIKE '1987%';
/* WHERE hiredate BETWEEN '1987-01-01' AND '1987-12-31'; */
/* WHERE hiredate >= '1987-01-01' AND hiredate <= '1987-12-31'; */

-- 우리회사 직원 중에서 직무가 회사원이거나 분석가인 사원의 사원이름, 사원의 직무를 출력하시오
SELECT ename, job
FROM emp
WHERE job in('CLERK', 'ANALYST'); # IN은 SQL에서 쓰는 연산자
-- WHERE job = 'CLERK' or job = 'ANALYST'

-- 패턴 매칭 
SELECT ename
FROM emp
WHERE ename LIKE '%T'; # 여러글자 대용 : %

SELECT ename
FROM emp
WHERE ename LIKE 'SMIT_'; # 한 글자 대용 : _

SELECT ename
FROM emp
WHERE ename LIKE '%I%';

-- 우리 회사 직원 중에 보너스를 받는 사람은?
SELECT empno, ename, comm, deptno
FROM emp
WHERE comm IS NOT NULL;

-- 입사일 기준 내림차순
SELECT empno, ename, hiredate, sal
FROM emp
ORDER BY hiredate DESC, sal ASC; # 1차 : 내림차순, 2차 : 같은 입사일일 경우 봉급 기준 오름차순 

-- 우리회사 직원 중 20번 부서 또는 30번 부사의 연봉 내림차순으로 출력하시오 *추출속성
SELECT deptno, ename, (sal + IFNULL(comm, 0)) * 12 AS Annual
FROM emp
WHERE deptno IN(20, 30)
ORDER BY Annual DESC;

-- 부서번호로 정렬한 후, 부서번호가 같을 경우 급여가 많은 순으로 사원번호, 사우너이름, 업무, 부서번호, 급여를 출력하시오

