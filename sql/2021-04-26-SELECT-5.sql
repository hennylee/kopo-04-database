-- <04/26>
-- 함수는 많이 아는 것이 좋다. WHY? 생산성과 품질이 높이지니까

-- [단일행 함수]
-- 단일행 함수 : 함수에 한 개의 INPUT이 들어가서 한 개의 OUTPUT이 나온다.

-- 1. 함수 안에 함수가 들어갈 수 있다?
-- O, nested function(중첩함수)
SELECT ENAME, EMPNO, SAL, COMM FROM EMP;
SELECT ENAME, LOWER(ENAME),UPPER(LOWER(ENAME)), LENGTH(ENAME), ABS(SAL-EMPNO), COMM FROM EMP;

-- 2. substr : 부분문자 추출함수
SELECT ENAME, substr(ENAME, 1, 3) FROM EMP
WHERE HIREDATE between to_date('81/01/01', 'RR/MM/DD') and to_date('82/12/31','RR/MM/DD') 
ORDER BY length(ENAME);

-- [그룹행 함수]
-- 그룹행 함수 : INPUT이 여러개의 ROW, 그룹당 1개의 결과를 RETURN

-- 3. 
/*
- NULL이 있다면 SUM(COMM)는 NULL을 어떻게 처리하는가?
    - NULL을 0으로 인식하는 것 같다.
- COUNT(*)의 차이는?
*/
SELECT AVG(SAL), SUM(SAL), SUM(COMM), COUNT(*) FROM EMP;
SELECT COMM FROM EMP;

-- 4. GROUP BY란?
-- SINGLE ROW, GROUP ROW의 차이는?
-- 9i에서의 GROUP BY : ORDER BY가 자동으로 적용됨
-- 10g에서의 GROUP BY : ORDER BY가 적용되지 않음
SELECT DEPTNO, COUNT(*), SUM(SAL), AVG(SAL) FROM EMP ORDER BY DEPTNO;
SELECT DEPTNO, COUNT(*), SUM(SAL), AVG(SAL) FROM EMP GROUP BY DEPTNO;

-- 5. 다중 그룹
SELECT DEPTNO, JOB, COUNT(*), SUM(SAL), AVG(SAL) FROM EMP GROUP BY DEPTNO, JOB;


-- [단일행 : 문자함수]
-- INSTR/INSTRB 의 차이는? ASCII, UNICODE 차이...
-- LENGTH/LENGTHB의 차이는? ASCII, UNICODE 차이...

-- 1. 
SELECT ENAME, lower(ENAME), upper(ENAME), initcap(ENAME) FROM EMP;

-- 2. substr(a, b, c)
/*
- a : 자를 문자
- b : 시작 Index (1부터 시작)
- c : 자를 갯수 (생략 시, 끝까지)
*/

SELECT ENAME, substr(ENAME, 1, 3), substr(ENAME, 4), substr(ENAME, -3, 2) FROM EMP;

-- 3. INSTR : 특정 위치 반환 (없으면 0)
/*
- instr(a, b, c, d)
    - a : 대상 문자열
    - b : 찾을 문자
    - c : 찾기 시작할 위치
    - d : 찾기 끝낼 위치
*/
SELECT ENAME, instr(ENAME, 'A'), instr(ENAME, 'A', 2), instr(ENAME, 'A', 1, 2) FROM EMP;

-- 4. pad : 채우는 것

SELECT ENAME, rpad(ENAME, 10, '*'), lpad(ENAME, 10, '+') FROM EMP;
SELECT rpad(ENAME, 10,' ')||' ''S JOB is'||lpad(JOB,10,' ') as JOB_list FROM EMP;

-- 이게 뭘까?
-- INSERT시에 TESTCODE짜보기
SELECT rpad(ENAME, 10,'')||' ''S JOB is'||lpad(JOB,10,'') as JOB_list FROM EMP;

-- 5. REPLACE()
SELECT ENAME, REPLACE(ENAME, 'S', 's') FROM EMP;

-- 6. 함수와 연산차의 차이는?
SELECT ENAME, concat(ENAME, JOB), ENAME || JOB FROM EMP;


-- 7. 
SELECT ltrim(' 대한민국 '), rtrim(' 대한민국 '), trim(' 대한민국 ') FROM dual;

SELECT trim('장' from '장발장'), ltrim('장발장';

-- 8. 한글은 몇 byte인가?
-- 현재 오라클 DBMS는 어떤 인코딩으로 구성되어 있을까?
/*
- lengthb('대한민국') = 
- substrb('대한민국',2,2) = 
- vsize('대한민국') = 
*/

SELECT substrb('대한민국',2,11) FROM DUAL;
SELECT replace(substrb('대한민국',2,11),' ','*') FROM DUAL;
SELECT '공백' FROM DUAL WHERE substrb('대한민국',2,2) is null;
SELECT '공백' FROM DUAL WHERE substrb('대한민국',2,2) is not null;



-- [단일행 : 숫자함수]

-- ROUND() : 몇째자리까지 절삭하는가?


-- [DATE TYPE]
-- DATE TYPE은 연산이 가능하다.
-- Oracle 내부에 숫자와 날짜는 똑같이 Packed Decimal 형태로 표현되기 때문에 연산이 가능한 것이다.

-- 날짜는 DBMS내에 숫자처럼 저장되지만, 마치 날짜처럼 표현되는 것 뿐이다.
-- 왜 이렇게 다르게 표현하는 걸까?

-- 2. 날짜에서 정수는 1일 단위이다. 
-- 날짜에서 소수점은 1일 이하 단위(시간 단위) 이다.
-- 날짜에서 TRUNC 함수를 사용한다는 것은 시간의 찌꺼기를 버리는 것이다. 
-- 날짜 포맷을 활용해보면 시간 찌꺼기가 버려졌는지 확인할 수 있다. 

-- [중요] 
-- DATE라는 데이터타입은 고정된 7byte의 메모리 공간이 할당된다.
-- DATE라는 데이터타입은 날짜와 시간 정보를 가지고 있다.
-- DATE라는 데이터타입이 저장된 포맷은? Packed Decimal


-- 3. 날짜는 날짜를 표시하는 포맷에 의해 달리보인다.
-- SYSDATE도 데이터 타입이 DATE이다. 


-- 4. 
-- ALTER : DDL, Data Object를 변경


-- 5. 실행범위 중요하다!! 트랜젝션과 연관됨
-- ALTER SESSION
-- 새로운 SQL 워크시트를 열면 같은 세션일까 다른 세션일까?
