CREATE VIEW mycompany.empview10
AS
SELECT empno, ename, job
FROM emp
WHERE deptno = 0;

DESC empview10;

-- 쿼리는 view에 날린다
SELECT *
FROM empview10; # 데이터를 가지고 있진 않지만, emp 테이블의 내용을 보여줌


CREATE VIEW mycompany.aaa
AS
SELECT empno, ename, job
FROM emp
WHERE deptno = 20;

DESC aaa;

CREATE VIEW bbb
AS
SELECT emp.empno, emp.ename, dept.dname, dept.loc
FROM emp
JOIN dept ON emp.deptno = dept.deptno
WHERE dept.deptno = 30;

SELECT *
FROM bbb;

DESC INFORMATION_SCHEMA.VIEWS; #  정보보기

SELECT * FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_NAME = 'emp20';

-- 단순 view (보안, 퍼포먼스를 위해 사용)
CREATE VIEW EMP_30_VU
AS
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno = 30;

SELECT *
FROM EMP_30_VU; # 기본테이블에 쿼리를 날리는 것과 같음 (view를 통해 read/wirte가 가능)

INSERT INTO EMP_30_VU
VALUES(1111, 'Jimin', 500, 30);

SELECT * FROM EMP_30_VU;
SELECT * FROM emp;

CREATE OR REPLACE VIEW emp_20
AS
SELECT * FROM emp
WHERE deptno = 20
WITH CHECK OPTION; # 일종의 안전장치


SELECT *
FROM emp_20;

UPDATE emp_20
SET deptno = 30
WHERE empno = 7369; # WITH CHECK OPTION 조건이 있으므로 에러 


SHOW INDEX FROM emp; # 유니크이거나 프라이머리 키는 자동부여


CREATE INDEX i_emp_ename ON emp(ename);




delimiter $$
CREATE PROCEDURE if_test()
BEGIN
	DECLARE var INT;
    SET var := 52;
    IF var % 2 = 0 THEN
		SELECT 'Even Number';
	ELSE
		SELECT 'Odd Number';
	END IF;
END
$$ 
delimiter ;


CALL if_test();



DELIMITER //
CREATE PROCEDURE hello_world()
BEGIN
	SELECT 'hello_world';
END
//
DELIMITER ;

CALL hello_world();


SELECT empno, ename, hiredate
FROM emp
-- WHERE hiredate BETWEEN '1987-1-1' AND '1987-12-31';
WHERE hiredate = '1987%';

SELECT * from emp
Where ename like 'B%' or ename like 'C%';


SELECT *
FROM emp
WHERE ename > 'B' AND ename < 'J';


