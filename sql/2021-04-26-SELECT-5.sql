-- <04/26>
-- 함수는 많이 아는 것이 좋다. WHY? 생산성과 품질이 높이지니까

-- [단일행 함수] (Single Row Function)
-- 단일행 함수 : 함수에 한 개의 INPUT이 들어가서 한 개의 OUTPUT이 나온다.

-- 1. 함수 안에 함수가 들어갈 수 있다?
-- O, nested function(중첩함수)
SELECT ENAME, EMPNO, SAL, COMM FROM EMP;
SELECT ENAME, LOWER(ENAME),UPPER(LOWER(ENAME)), LENGTH(ENAME), ABS(SAL-EMPNO), COMM FROM EMP;

-- 2. substr : 부분문자 추출함수
SELECT ENAME, substr(ENAME, 1, 3) FROM EMP
WHERE HIREDATE between to_date('81/01/01', 'RR/MM/DD') and to_date('82/12/31','RR/MM/DD') 
ORDER BY length(ENAME);

-- [그룹행 함수] (Group Row Function)
-- 그룹행 함수 : INPUT이 여러개의 ROW, 그룹당 1개의 결과를 RETURN

-- 3. 
/*
- NULL이 있다면 SUM(COMM)는 NULL을 어떻게 처리하는가?
    - NULL이 있다면 제외하고 계산한다.

- COUNT(*)의 차이는?
    - COUNT함수는 NULL도 하나의 데이터로 인식한다.
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
SELECT * FROM EMP ORDER BY DEPTNO, JOB;
SELECT DEPTNO, JOB, COUNT(*), SUM(SAL), AVG(SAL) FROM EMP GROUP BY DEPTNO, JOB ORDER BY DEPTNO, JOB;


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

SELECT replace(rpad(ENAME, 10,''),'','*')||' ''S JOB is'||lpad(JOB,10,'') as JOB_list FROM EMP;

-- 아래 예제 확인해보기
SELECT 'AND'||NULL FROM DUAL;
SELECT 'AND'||'' FROM DUAL;
Select rpad(NVL(NULL,' '),4) from dual;

-- 5. REPLACE()
SELECT ENAME, REPLACE(ENAME, 'S', 's') FROM EMP;

-- 6. 함수와 연산차의 차이는?
SELECT ENAME, concat(ENAME, JOB), ENAME || JOB FROM EMP;
SELECT ENAME, concat(COMM, SAL), COMM || SAL FROM EMP;
SELECT * FROM EMP WHERE ENAME = 'CLARK'; -- 0과 NULL을 붙이면 0이다.

-- 7. 
SELECT ltrim(' 대한  민국 '), rtrim(' 대한  민국 '), trim(' 대한  민국 ') FROM dual;

SELECT trim('장' from '장발장'),trim('발' from '장발장'),rtrim('장발장  '), ltrim(' 장발장') FROM DUAL;

-- 8. 한글은 몇 byte인가?
-- 현재 오라클 DBMS는 어떤 인코딩으로 구성되어 있을까?
/*
- length('대한민국') = 4
- lengthb('대한민국') = 12
- vsize('대한민국') = 12

- 한글 한 글자 당, 3 Bytes이다.
*/
SELECT length('대한민국') FROM DUAL;
SELECT lengthb('대한민국') FROM DUAL;
SELECT vsize('대한민국') FROM DUAL;

-- 3바이트씩 자르면 : 
-- 1  2  3  4  5  6 7  8  9 10 11 12
-- ㄷ ㅐ    ㅎ  ㅏ ㄴ ㅁ ㅣ ㄴ ㄱ ㅜ ㄱ
SELECT substrb('대한민국',2,2) FROM DUAL;
SELECT substrb('대한민국',1,3) FROM DUAL;
SELECT substrb('대한민국',2,11) FROM DUAL;

SELECT replace(substrb('대한민국',2,11),' ','*') FROM DUAL;
SELECT '공백' FROM DUAL WHERE substrb('대한민국',2,2) is null;
SELECT '공백' FROM DUAL WHERE substrb('대한민국',2,2) is not null;


-- [단일행 : 숫자함수]

-- 9. round() : 몇째자리까지 절삭하는가?
SELECT round(45.923, 2), round(45.923, 1), round(45.923, 0), round(45.923), round(45.923, -1) FROM dual;

-- 10. turnc() : 절삭함수
SELECT trunc(45.923,2), trunc(45.923,1), trunc(45.923,0), trunc(45.923), trunc(45.923,-1) FROM dual;

-- 11. mod() : 나눗셈 결과 나머지 값 반환 함수
SELECT mod(100,3), mod(100,2) FROM dual;

-- 12.
SELECT ENAME,SAL,SAL*0.053 as tax,round(SAL*0.053,0) as r_tax FROM EMP;

-- 13. ceil() : 입력된 값보다 큰 정수들 중 가장 작은 값 반환, 올림함수
SELECT CEIL(-45.594),CEIL(-45.294),CEIL(45.294), ROUND(-45.594),ROUND(-45.294),ROUND(45.594) FROM DUAL;

-- 14. floor() : 입력된 값보다 작은 정수들 중 가장 큰 값 반환, 내림함수
SELECT FLOOR(45.245),FLOOR(-45.245),FLOOR(45.545),FLOOR(-45.545) FROM DUAL;

-- abs() : 절대값 반환 함수
SELECT abs(45.923), abs(-45.923), abs(-433) FROM dual;

-- [DATE TYPE]
-- DATE TYPE은 연산이 가능하다.
-- Oracle 내부에 숫자와 날짜는 똑같이 Packed Decimal 형태로 표현되기 때문에 연산이 가능한 것이다.
-- 1. 오늘 날짜를 여러가지로 계산하세오.
SELECT sysdate, sysdate+7, sysdate-2, sysdate+1/24 FROM dual;

/*
- 날짜는 DBMS내에 숫자처럼 저장되지만, 마치 날짜처럼 표현되는 것 뿐이다.
- 왜 이렇게 다르게 표현하는 걸까?

- 날짜에서 정수는 1일 단위이다. 
- 날짜에서 소수점은 1일 이하 단위(시간 단위) 이다.
- 날짜에서 TRUNC 함수를 사용한다는 것은 시간의 찌꺼기를 버리는 것이다. 
- 날짜 포맷을 활용해보면 시간 찌꺼기가 버려졌는지 확인할 수 있다. 
*/

-- 2. 직원들의 부서와 근무일수를 구하시오
DESC EMP;
SELECT deptno,ename, (SYSDATE - HIREDATE) as work_day FROM emp ORDER BY deptno,work_day DESC;
SELECT deptno,ename, trunc((SYSDATE - HIREDATE)/30/12) as work_day FROM emp ORDER BY deptno,work_day DESC;


-- [중요] 
-- DATE라는 데이터타입은 고정된 7byte의 메모리 공간이 할당된다.
-- DATE라는 데이터타입은 날짜와 시간 정보를 가지고 있다.
-- DATE라는 데이터타입이 저장된 포맷은? Packed Decimal


-- 3. 날짜는 날짜를 표시하는 포맷에 의해 달리보인다.
-- SYSDATE도 데이터 타입이 DATE이다. 
SELECT ENAME, to_char(SYSDATE, 'YYYY-MM-DD:HH24:MI:SS'), to_char(HIREDATE, 'YYYY-MM-DD:HH12:MI:SS') FROM EMP;

-- 4. 
-- ALTER : DDL, Data Object를 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD:HH24:MI:SS';
SELECT ename,sysdate,hiredate FROM emp; -- SCOTT 계정에서는 바뀐채로 보이지만, DBA 계정에서는 안바뀜
SELECT SYSDATE FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';
SELECT ename,sysdate,hiredate FROM emp; 
SELECT SYSDATE FROM DUAL;

-- ALTER은 DDL이기 때문에 ROLLBACK 안먹힘
-- DDL : CREATE, DROP, ALTER, TRUNCATE


-- 5. 실행범위 중요하다!! 트랜젝션과 연관됨
-- ALTER SESSION
-- 새로운 SQL 워크시트를 열면 같은 세션일까 다른 세션일까? 같은 세션이다. 
-- 다른 세션에는 적용되지 않는다. 


-- [단일행 날짜 함수]
-- 6. months_between() : 두 날짜 사이의 개월수를 반환한다.
-- months_between(a, b) : (a - b)개월
SELECT HIREDATE, months_between(sysdate, HIREDATE), trunc(months_between(sysdate,HIREDATE)) FROM EMP;

-- 7. add_months(a, b) : a로부터 b개월 증가 함수
SELECT sysdate, add_months(sysdate,3), add_months(sysdate,-1) FROM dual;

-- 8. 
-- last_day() : 해당 월의 마지막 날짜를 반환하는 함수
-- next_day() : 지정한 날짜의 다음 요일의 날짜를 반환하는 함수
/*
- 1 : '일요일'
- 2 : '월요일'
*/
SELECT sysdate, last_day(sysdate), next_day(sysdate,'일요일'), next_day(sysdate,1),next_day(sysdate,2) FROM dual;


-- 9. round() : 날짜 반올림 함수
/*
- ROUND(날짜, 'MONTH') : 15일 기준으로 반올림
- ROUND(날짜, 'YEAR' ) : 6개월을 기준으로 반올림
*/
SELECT sysdate, round(sysdate, 'YEAR'), round(sysdate, 'MONTH'), round(sysdate, 'DAY'), round(sysdate) FROM dual;


-- 10. trunc() : 날짜 절삭 함수
/*
- TRUNC(날짜, 'MONTH') : 모든 날짜 데이터를 해당 월의 1일로 반환
- TRUNC(날짜, 'YEAR' ) : 모든 날짜 데이터를 해당 연도의 1월 1일로 반환
*/
SELECT sysdate,trunc(sysdate,'YEAR'),trunc(sysdate,'MONTH'),trunc(sysdate,'DAY'),trunc(sysdate)
FROM dual;

-- 11. 한글 형식의 숫자로 바꾸기
SELECT 
to_char(sysdate,'MM"월"DD"일"') as mmdd1,
to_char(sysdate,'MM')||'월'||to_char(sysdate,'DD')||'일' as mmdd2
FROM dual;

-- 12. EXTRACT(a FROM 날짜) : 날짜에서 a요소를 뽑아내 NUMBER 데이터 타입으로 출력한다.
SELECT SYSDATE,
EXTRACT(YEAR FROM SYSDATE),
EXTRACT(MONTH FROM SYSDATE),
EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

-- 사원들의 입사년도만 추출하시오
SELECT HIREDATE, EXTRACT(YEAR FROM HIREDATE) FROM EMP;



