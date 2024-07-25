-- 1987년에 입사한 사원 정보를 출력하시오
SELECT empno, ename, hiredate
FROM emp;
/* WHERE hiredate >= '1987-01-01' AND hiredate <= '1987-12-31'; */
/* WHERE hiredate BETWEEN '1987-01-01' AND '1987-12-31' */
/* WHERE hiredate LIKE '1987%'; */
/* WHERE YEAR(hiredate) = 1987; */

SELECT * FROM mycompany.Patient;



START TRANSACTION;

SELECT * FROM emp
WHERE empno = 7782;

UPDATE emp
SET deptno = 30
WHERE empno = 7782;

SAVEPOINT aaa;

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7999, 'TOM', 'SALESMAN', 7782, CURDATE(), 2000, 2000, 10);

ROLLBACK TO aaa;

-- 
CREATE TABLE emp_copy2
AS
SELECT empno, ename, sal
FROM emp
WHERE deptno = 20;

SELECT * FROM emp_copy2;

DROP TABLE emp_copy2;

ALTER TABLE emp_copy2
ADD age TINYINT AFTER ename; # ename 뒤에 age를 넣는 대신 다 null, 오라클은 이렇게 하지 말라고 함 (null을 없애는 게 목적이므로)

ALTER TABLE emp_copy2
DROP COLUMN sal;

ALTER TABLE emp_copy2
MODIFY ename VARCHAR(20);


-- DEFAULT
CREATE TABLE Jusorok
(
	bunho SMALLINT,
    gender CHAR(8) DEFAULT 'MALE'
);

INSERT INTO Jusorok VALUE(1, 'FEMALE');
INSERT INTO Jusorok VALUE(2, 'DEFAULT');

CREATE TABLE Student( # 툴은 제약조건을 넣고 나중에 바꿈
	hakbun		CHAR(4),
    name		VARCHAR(20) 	NOT NULL,
    kor			TINYINT		    NOT NULL	CHECK(kor BETWEEN 0 AND 100),
    eng			TINYINT			NOT NULL,
    mat			TINYINT			NOT NULL	DEFAULT 0,
    edp			TINYINT,
    tot			SMALLINT,
    avg			FLOAT(5,2),
    grade		CHAR(1),
    deptno      TINYINT, 
    CONSTRAINT student_hakbun_pk PRIMARY KEY(hakbun),
    CONSTRAINT student_name_uk UNIQUE(name),
    CONSTRAINT student_grade_ck CHECK(grade IN('A', 'B', 'C', 'D', 'F')),
    CONSTRAINT student_deptno_fk FOREIGN KEY(deptno)
    REFERENCES dept(deptno)
) DEFAULT CHARSET utf8;

ALTER TABLE Student
MODIFY edp TINYINT NOT NULL; # NULL은 MODIFY 제약조건을 따름

ALTER TABLE Student 
ADD CONSTRAINT student_tot_ck CHECK(tot BETWEEN 0 AND 400); # 제약조건 추가는 ADD CONSTRAINT 사용

ALTER TABLE Student
MODIFY eng TINYINT; # 기본값이 not null 

ALTER TABLE Student
DROP CONSTRAINT student_name_uk; # 제약조건 삭제


