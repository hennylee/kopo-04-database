-- 1. PL/SQL 소스 보기
SELECT LINE, TEXT FROM USER_SOURCE WHERE NAME = 'CALC_BONUS';

-- 2. FUNCTION CALC_BONUS를 SELECT와 함께 실행해보기
SELECT EMPNO, ENAME, SAL, CALC_BONUS(SAL, DEPTNO) FROM EMP;

-- 3. FUNCTION DESC 해보기
DESC CALC_BONUS;

/*
FUNCTION CALC_BONUS RETURNS NUMBER
인수 이름    유형     In/Out 기본값? 
-------- ------ ------ ---- 
P_SALARY NUMBER IN          
P_DEPTNO NUMBER IN  
*/


-- 4. 데이터 딕셔너리에 생성된 함수 확인하기
SELECT OBJECT_NAME, OBJECT_TYPE, STATUS, CREATED FROM USER_OBJECTS WHERE OBJECT_NAME = 'CALC_BONUS';


-- 5. WRAP 으로 BINARY SOURCE 변환하기 => putty에서 실행함
-- WRAP IN=FUNCTION_1.SQL