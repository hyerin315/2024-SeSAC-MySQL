SELECT user();


-- jimin localhost 계정 생성
CREATE USER 'jimin'@'localhost' IDENTIFIED BY '1234';

DROP USER 'jimin'@'localhost';


-- 어느 머신에서도 접근 가능한 jimin 계정 생성
CREATE USER 'jimin'@'%' IDENTIFIED BY '1234'; # 아무것도 못보는 권한



-- user 테이블의 구조 확인
DESC mysql.user; # mysql이라는 데이터베이스에 user라는 테이블이 있음

-- user 테이블의 모든 정보 출력
SELECT * FROM mysql.user;


-- jimin mycompany.emp에 대한 권한 부여 
GRANT SELECT ON mycompany.emp TO 'jimin'@'%';
FLUSH PRIVILEGES; #권한 save ** 반드시 해야함

-- jimin mycompany.모든 것에 대한 권한 부여 
GRANT SELECT ON mycompany.* TO 'jimin'@'%';
FLUSH PRIVILEGES; #권한 save ** 반드시 해야함



-- jimin이 Patient에 대한 모든 권한을 가질 수 있도록 부여
GRANT ALL PRIVILEGES ON mycompany.Patient TO 'jimin'@'%';
FLUSH PRIVILEGES;

--  jimin에게 프로시져 권한 부여
GRANT ALL PRIVILEGES ON mycompany.sp_select_all_patient TO 'jimin'@'%';
FLUSH PRIVILEGES;

-- jimin에게 모든 권한 부여
GRANT ALL PRIVILEGES ON mycompany.* TO 'jimin'@'%';
FLUSH PRIVILEGES;



-- jimin의 권한 보기
SHOW GRANTS FOR 'jimin'@'%';

-- jimin의 모든 권한을 모두 취소하기
REVOKE ALL PRIVILEGES ON mycompany.* FROM 'jimin'@'%';
FLUSH PRIVILEGES;



-- 테이블 백업하기 (\MySQL\Mysql 8.0\bin\mysqldump.exe : 백업)

