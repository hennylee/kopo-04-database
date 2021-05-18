-- <05/18> SQL 재구성(Refactoring) 및 DATE TYPE 변경

-- SESSION LEVEL에서 변경 ( <-> SQL STATEMENT LEVEL에서 변경 <-> Instance LEVEL에서 변경)
/*
- SQL STATEMENT LEVEL : SQL 문장 내에서만 영향 / 우선 순위 가장 높음
- SESSION LEVEL : SESSION 내에서만 영향
- Instance LEVEL : DBMS 전체에 영향 / 우선 순위 가장 낮음
*/
ALTER SESSION SET NLS_TERRITORY='AMERICA';
ALTER SESSION SET NLS_LANGUAGE='AMERICAN';

ALTER SESSION SET NLS_TERRITORY='KOREA';
ALTER SESSION SET NLS_LANGUAGE='KOREAN';

-- 1.
SET AUTOTRACE ON
SELECT * FROM EMP WHERE HIREDATE LIKE '82%';

-- 이 문장의 오류 => 형식이 AMERICA로 바뀌면 년도가 가장 뒤로 가서 찾을 수 없게 된다. 
ALTER SESSION SET NLS_TERRITORY='AMERICA';
SELECT * FROM EMP WHERE HIREDATE LIKE '82%'; -- 에러! 원하는 결과를 못찾음


-- 2. L-VALUE를 가공한 기법
-- 문자가 우선 순위가 낮으니, TO_CHAR(HIREDATE, 'YYYY')가 숫자로 바뀌어 비효율적이다.
SET AUTOTRACE ON
SELECT * FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') = 1982;

-- 둘을 비교할 때는 R-VALUE 데이터 타입을 L-VALUE에 맞게 맞춰주는 것이 좋다.
SET AUTOTRACE ON
SELECT * FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') = '1982';

/*
- L-VALUE, 연산자 왼쪽 COLUMN을 가공하면 비효율적이다. 
    - 1) 함수의 실행횟수가 늘어나기 때문이다. 
    - 2) 만약 HIREDATE에 인덱스가 걸려있을때, HIREDATE를 조작하면 인덱스를 사용할 수 없게 되기 때문에 비효율적이다. 
*/

-- 3. R-VALUE를 가공한 기법
-- 년, 월, 일, 시, 분, 초 전체가 필요한 것이 아니라면 굳이 date 데이터 타입을 사용할 필요가 없다.
SET AUTOTRACE ON
SELECT * FROM EMP 
WHERE HIREDATE BETWEEN 
    TO_DATE('1982-01-01', 'yyyy-mm-dd') AND -- 0시 0분 0초로 셋팅된다. 만약 시간 정보까지 필요하다면 원하는 정보가 조회되지 않을 수 있다. 
    TO_DATE('1982-12-31', 'yyyy-mm-dd');
    
-- 문자열로 BETWEEN 을 사용해도 상관 없다.
SET AUTOTRACE ON
SELECT * FROM EMP 
WHERE HIREDATE BETWEEN '1982-01-01' AND '1982-12-31';    
    
-- 4. 
-- SQL STATEMENT LEVEL이 가장 우선순위가 높기 때문에 SESSION LEVEL의 설정보다 우선순위가 높다.
SELECT * FROM EMP 
WHERE HIREDATE BETWEEN 
    TO_DATE('1982-01-01', 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=KOREAN') AND -- SQL STATEMENT LEVEL에서 변경
    TO_DATE('1982-12-31', 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=KOREAN');
    
    
-- 만약 미국 날짜와 한국 날짜를 비교하려면?
-- 에러 : 한국 MONTH에는 DEC라는 표현이 없기 때문이다.
SELECT * FROM EMP 
WHERE HIREDATE BETWEEN 
    TO_DATE('1982-01-01', 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=KOREAN') AND -- SQL STATEMENT LEVEL에서 변경
    TO_DATE('31-DEC-1982', 'dd-MON-yyyy', 'NLS_DATE_LANGUAGE=KOREAN');
    
SELECT * FROM EMP 
WHERE HIREDATE BETWEEN 
    TO_DATE('1982-01-01', 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=KOREAN') AND -- SQL STATEMENT LEVEL에서 변경
    TO_DATE('31-DEC-1982', 'dd-MON-yyyy', 'NLS_DATE_LANGUAGE=AMERICAN');

-- 5. 
ALTER SESSION SET NLS_TERRITORY='KOREA';
ALTER SESSION SET NLS_LANGUAGE='KOREAN';

-- 에러! : KOREAN에는 January라는 MONTH가 없기 때문이다.
SELECT TO_DATE(
    'January 15, 1989, 11:00 A.M.',
    'Month dd, YYYY, HH:MI A.M.',
    'NLS_DATE_LANGUAGE = KOREAN'
) FROM DUAL;

-- 'NLS_DATE_LANGUAGE = AMERICAN'으로 설정하면 정상 조회된다.
SELECT TO_DATE(
    'January 15, 1989, 11:00 A.M.',
    'Month dd, YYYY, HH:MI A.M.',
    'NLS_DATE_LANGUAGE = AMERICAN'
) FROM DUAL;