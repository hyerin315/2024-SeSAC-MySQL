-- out
DELIMITER //
CREATE PROCEDURE sp_test
(
	OUT v_now DATETIME,
    OUT v_version VARCHAR(30)
)
BEGIN 
	SELECT now(), version() INTO v_now, v_version; # SQL 프로그래밍 할 때만 사용
END
//
DELIMITER ;

CALL sp_test(@t_now, @t_version); # 임시변수 활용 - v_now / v_version과 바인딩 됨 => 값은 t_now, t_version에 있음 & 내부적으로 동작해서 출력이 안됨

SELECT @t_now, @t_version;


DROP TABLE dept_clone;

CREATE TABLE dept_clone
AS
SELECT * FROM dept;



-- delete
DELIMITER //
CREATE PROCEDURE sp_deleteDept()
BEGIN
	DELETE FROM dept_clone;
END
//
DELIMITER ;

CALL sp_deleteDept(); # 파라미터 없이 호출


SELECT * 
FROM mycompany.dept_clone;

-- in
DELIMITER $$
CREATE PROCEDURE sp_insertDept
(
	IN v_deptno		TINYINT,
    IN v_dname		VARCHAR(14),
    IN v_loc		VARCHAR(13)
)
BEGIN
	INSERT INTO dept_clone(deptno, dname, loc)
    VALUES (v_deptno, v_dname, v_loc);
    COMMIT; # insert는 DML이며, DML은 트랜잭션이 필요함
END
$$
DELIMITER ;

CALL sp_insertDept(50, 'Design', 'Seoul');




-- 사원 이름을 입력받아서 부서 이름과 부서 위치를 출력하시오
DELIMITER $$
CREATE PROCEDURE sp_selectEMP
(
	IN v_empno	 	SMALLINT,
    OUT v_dname 	VARCHAR(14),
    OUT v_loc       VARCHAR(13)
)
BEGIN
	SELECT dname, loc INTO v_dname, v_loc
	FROM emp JOIN dept ON (emp.deptno = dept.deptno)
    WHERE empno = v_empno;
END
$$
DELIMITER ;

CALL sp_selectEMP(7369, @t_dname, @t_loc);
SELECT @t_dname, @t_loc;




--  inout
DELIMITER //
CREATE PROCEDURE sp_selectDname
(
	INOUT v_name 	VARCHAR(14)
)
BEGIN
	DECLARE v_str 	VARCHAR(14); # InOut 할 때에는 DECLARE를 만들어줘야함
	SELECT loc INTO v_str
    FROM dept
    WHERE dname = v_name;
    SET v_name = v_str;
END
//
DELIMITER ;


SET @t_str := 'RESEARCH';
CALL sp_selectDname(@t_str);
SELECT @t_str;



-- 부서 이름으로 부서 위치를 출력하는 StoredProcedure
DELIMITER //
CREATE PROCEDURE sp_select_emp_dept
(
	IN 		v_deptno	TINYINT
)
BEGIN
	SELECT  empno, ename, dname, loc, dept.deptno
	FROM	emp  NATURAL JOIN	 dept
    WHERE	deptno = v_deptno;
END
//
DELIMITER ;


CALL sp_select_emp_dept(20);


-- 번호,, 진찰부서, 진찰비, 입원비, 진료비 가져오기
DELIMITER $$
CREATE PROCEDURE sp_select_all_patient()
BEGIN
	SELECT number, dept, operfee, hospitalfee, money
    FROM Patient
    ORDER BY number DESC;
END
$$
DELIMITER ;


-- 환자 1명에 대한 정보 가져오기
DELIMITER $$
CREATE PROCEDURE sp_select_one_patient
(
	IN v_number TINYINT
)
BEGIN
	SELECT *
    FROM Patient
    WHERE number = v_number;
END
$$
DELIMITER ;

CALL sp_select_one_patient(5);



-- 환자의 7개의 정보 가져오기alter
DELIMITER //
CREATE PROCEDURE sp_update_patient
( 	#IN은 생략 가능
	IN	v_number		TINYINT,
    IN  v_code			CHAR(2),
    IN  v_days			SMALLINT,		
    IN  v_age			TINYINT,
    IN  v_dept          VARCHAR(20),
    IN  v_operfee       INT,
    IN  v_hospitalfee   INT,
    IN  v_money			INT
)
BEGIN
	UPDATE Patient
    SET code = v_code, days = v_days, age = v_age,
		dept = v_dept, operfee = v_operfee, hospitalfee = v_hospitalfee,
        money = v_money
    WHERE number = v_number;
    COMMIT;
END
//
DELIMITER ;
