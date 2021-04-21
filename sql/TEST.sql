-- <04/20> SELECT(2)

-- <DUAL>
-- 1. Dual
-- dual 테이블은 DummyTable이다. 
DESC dual;
DESCRIBE dual;

-- 2. Dual의 데이터
-- DUAL 데이터에 실제로 저장된 데이터는 없다.
-- DUAL은 DBMS에 연산 등의 일을 떠넘기고 싶을 때 ~ FROM DUAL; 로 작성한다.
SELECT * FROM dual;

-- 3. sysdate
-- sysdate : system + date
-- DBMS가 설치되어 있는 System의 날짜와 시간을 return한다. 
-- 시간은 왜 안보일까?
SELECT sysdate FROM dual;

-- 4. to_char (type conversion 함수), 자리수마다 콤마찍기
SELECT 143475*127363, to_char(143475*127363, '999,999,999,999') FROM dual;

-- <NULL>
-- 사전적 의미 : 데이터가 존재하지 않는, 값이 정의되지 않은

-- [NULL 연산불가]
-- 5. 값을 0으로 나누면 예외 발생
SELECT 300+400, 300/0 FROM dual;

-- 6~7. 값을 NULL로 연산하면? 결과는 NULL이다.
SELECT 300+400, 300+NULL, 300/NULL FROM dual;
SELECT ENAME, SAL, COMM, COMM+SAL*0.3 as bonus FROM EMP;

-- [NULL 비교불가]
-- 8. NULL 이 존재하는 TABLE
SELECT EMPNO, SAL, COMM FROM EMP;

-- 9. NULL이 없는 경우 1000보다 큰 범위를 잘 찾을 수 있다.
SELECT EMPNO, SAL, COMM FROM EMP;
SELECT ENAME, SAL, COMM FROM EMP WHERE SAL > 1000;

-- 10. NULL은 숫자 범위 어디에도 속하지 않는다.
SELECT EMPNO, SAL, COMM FROM EMP;
SELECT ENAME, SAL, COMM FROM EMP WHERE COMM > -1;
SELECT ENAME, SAL, COMM FROM EMP WHERE COMM < -1;

-- 11. NULL에 = 연산자를 사용할 수 없다. 
SELECT ENAME, SAL, COMM FROM EMP WHERE COMM=NULL;

-- 12. NULL에 !=, <>, ^= 연산자를 사용할 수 없다.
SELECT ENAME, SAL, COMM FROM EMP WHERE COMM <> null;
SELECT ENAME, SAL, COMM FROM EMP WHERE COMM != null;
SELECT ENAME, SAL, COMM FROM EMP WHERE COMM ^= null;

-- 13. NULL을 찾는 연산자는 is null이다.
SELECT ENAME, SAL, COMM FROM EMP WHERE COMM is null;

-- 14. NULL이 아닌 데이터를 찾는 연산자는 is not null이다.
SELECT ENAME, SAL, COMM FROM EMP WHERE COMM is not null;

-- [NULL 적용불가]
-- 1~2. NULL은 함수적용 불가하다. 
-- `length(COMM)` : 암시적 데이터타입 형변환이 발생한다. COMM이 문자로 바뀌게 된다. 좋은 방식은 아니다. 
SELECT ENAME, length(ENAME), COMM, length(COMM) FROM EMP;
SELECT SAL-EMPNO, abs(SAL-EMPNO), abs(SAL-COMM)+100 FROM EMP;

-- 3. NULL을 무시하는 함수들  : NVL, decode
-- NVL(a, b) : a가 NULL이면 b로 치환한다.
-- decode(a, b, c, d) : if조건절의 역할을 한다. if( a = b ) { c } else { d }
SELECT concat(ENAME||'is ',COMM), NVL(COMM, -1), decode(COMM, null, -999, COMM) FROM EMP;


-- <0420> 숙제
-- 1. SYSDATE
-- NLS_DATE_FORMAT이 저장되어 있는 Table
SELECT * FROM nls_session_parameters WHERE parameter LIKE '%FORMAT%';
SELECT sysdate FROM dual;
SELECT systimestamp FROM dual; 

-- 시간 정보까지 출력하는 방법
SELECT TO_CHAR(SYSDATE, 'MM-DD-YYYY HH24:MI:SS') "NOW" FROM DUAL;

-- 오라클에서 초단위 이하의 밀리세컨드 처리를 위해선 TIMESTAMP형을 사용해야 한다.
-- 9i에서 추가된것 같다.
SELECT TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.FF') "NOW" FROM DUAL;

-- 연도 : YYYY, YY, RR
SELECT TO_CHAR(SYSTIMESTAMP, 'RR-MM-DD HH24:MI:SS.FF') "NOW" FROM DUAL;
SELECT TO_CHAR(SYSTIMESTAMP, 'YY-MM-DD HH24:MI:SS.FF') "NOW" FROM DUAL;
SELECT TO_CHAR(SYSTIMESTAMP, 'RRRR-MM-DD HH24:MI:SS.FF') "NOW" FROM DUAL;

-- 초단위를 formating하려면 FF 뒤에 소수점 자리를 표현하면 된다. 
SELECT TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.FF2') "NOW" FROM DUAL;
SELECT TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.FF3') "NOW" FROM DUAL;
SELECT TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.FF4') "NOW" FROM DUAL;

-- 2. NULL
SELECT SAL,COMM,NVL(COMM,SAL),nvl2(COMM,SAL,0), NULLIF(JOB,'MANAGER') FROM emp;

-- NVL2
SELECT COMM,SAL, nvl2(COMM,SAL,0) FROM emp;

-- NULLIF
SELECT JOB, NULLIF(JOB,'MANAGER') FROM emp;
SELECT COMM, NULLIF(COMM,500) FROM emp;