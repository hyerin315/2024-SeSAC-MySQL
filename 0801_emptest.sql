
-- user 생성
CREATE USER 'lim'@'%' IDENTIFIED BY '1234';

-- user에 스키마에 대한 모든 권한 부여
GRANT ALL PRIVILEGES ON 0801_emptest.* TO 'lim'@'%';
FLUSH PRIVILEGES;

