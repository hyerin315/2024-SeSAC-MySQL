SELECT * FROM dept;

INSERT INTO dept
VALUES (50, 'Design', 'Busan'); # 좋은 방법이 아님 - 처음 보는 사람은 모르기 때문

INSERT INTO dept(deptno, dname, loc) # 직관적
VALUES(60, 'Development', 'Taejeon'); 

-- 컬럼 이름 명시할 땐, 순서 상관없음
INSERT INTO dept(loc, deptno, dname) 
VALUES('Taejeon', 60, 'Development'); 

INSERT INTO dept(deptno, dname, loc)
VALUES(70, NULL, 'Incheon'); # 명시적 Null - 부서이름은 미정

INSERT INTO dept(deptno, loc)
VALUES(80, 'Seoul'); # 암시적 Null - 부서이름은 미정

INSERT INTO dept(dname, loc)
VALUES('Account', 'Yongin'); # error - 프라이머리키인 부서 번호를 안넣었으므로

INSERT INTO emp(empno, deptno)
VALUES(9999, 90); # 90번 부서는 존재하지 않음 (제약조건 위배 - Insert할 때는 제약조건에 위배되는 것은 없는지 확인 후 넣어야함)

# now 쓰지 않기
INSERT INTO emp(empno, ename, hiredate, deptno)
VALUES(9998, 'Jimin', CURDATE(), 80);
/* VALUES(999, 'Jimin', NOW(), 80); # NOW() - 연, 월, 일, 시, 분 초를 갖고 있음 / hiredate는 날짜이기 때문에 짤림 그러므로 CURDATE 사용) */

CREATE TABLE emp_copy
AS
SELECT empno, ename, sal, hiredate
FROM emp # emp를 복제
WHERE deptno = 10; 

-- 스키마만 복제
CREATE TABLE emp_copy1
AS
SELECT empno, ename, sal, hiredate
FROM emp
WHERE 0 = 1;  # 데이터는 복사되지 않고 스키마만 복제 / 0 = 1을 충족하는 테이블은 없으니까 

SELECT * FROM emp_copy1; # 테이블만 카피

INSERT INTO emp_copy1(empno, ename)
VALUES(1111, '한지민');

SELECT * FROM emp_copy1;

SELECT * FROM dept;

UPDATE dept
SET dname = 'FINANCE'
WHERE deptno = 70;

UPDATE dept
SET dname = 'HR', loc = 'Busan'
WHERE deptno = 70;

-- 데이터 만들기
CREATE TABLE Student (
hakbun		CHAR(4)			PRIMARY KEY,
name		VARCHAR(20)		NOT NULL,
kor			TINYINT			NOT NULL,
eng			TINYINT			NOT NULL,		
mat			TINYINT			NOT NULL,
edp 		TINYINT			NOT NULL,
tot			SMALLINT,
avg			FLOAT(5,2),
grade		CHAR(1)
);