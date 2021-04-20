-- <04/20> SELECT (1)
-- <SELECT>
-- 1~2. *를 통해서 전체 COLUMN을 조회할 수 있다. 
SELECT * FROM EMP;
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO FROM EMP;

-- DESC : 테이블 구조를 조회할 수 있다. 
DESC EMP;

-- <SELECT LIST>
-- 3~4. 원하는 순서대로 컬럼을 조회할 수 있다.
SELECT EMPNO, ENAME, JOB, SAL FROM EMP;
SELECT SAL, JOB, EMPNO, ENAME FROM EMP; 

-- 5. 같은 컬럼은 여러번 조회 가능하다
SELECT EMPNO, EMPNO, EMPNO, ENAME, JOB, SAL FROM EMP;

-- 6. 존재하지 않는 컬럼을 만들어서 조회할 수 있다. 
-- 문자를 표기할 때는 ''로 감싼다.
SELECT EMPNO, SAL, 8, 'ORACLE' FROM EMP;

-- <WHERE 조건절>
-- 7. WHERE 조건절을 통해 원하는 ROW(Record)만 조회할 수 있다.
-- WHERE 조건절은 SELECT LIST와 함께 쓸 수 있다.
SELECT * FROM EMP WHERE DEPTNO = 10;

-- 8~9. 공백 유무의 차이 : DBMS 서버 입장에서 다른 SQL일 수도 있다.
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SAL > 200;
SELECT  EMPNO,ENAME, JOB, SAL FROM  EMP  WHERE SAL > 200;

-- 10. WHERE절의 AND 키워드를 사용하면 조건의 교집합을 구할 수 있다.
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP WHERE DEPTNO = 10 AND SAL > 2000;

-- 11. 데이터는 대소문자를 비교한다.
SELECT DEPTNO, ENAME, JOB FROM EMP WHERE JOB = 'manager';
SELECT DEPTNO, ENAME, JOB FROM EMP WHERE JOB = 'MANAGER';

-- 12. WHERE 조건이 참이면 전체 결과를 출력한다.
-- 1=1 은 항상 참이다.
SELECT DEPTNO, ENAME, JOB FROM EMP;
SELECT DEPTNO, ENAME, JOB FROM EMP WHERE 1=1;

-- 13. WHERE 조건이 거짓이면 아무것도 출력되지 않는다. 
-- 1=2는 항상 거짓이다. 
SELECT DEPTNO, ENAME, JOB FROM EMP WHERE 1=2;

-- 14. SQL 명령어 안에서 산술연산자를 사용할 수 있다. 
-- SAL*12 : 데이터 베이스 서버 내에는 사원의 급여 정보만 저장되어 있는데 해당 사원의 연봉을 보고 싶을 때 사용한다. 
-- (방식1) 쿼리 문장에서 연산을 수행하여 DBMS 연산을 DBMS Server에게 담당시킨다. ==> DBMS를 가공/처리/연산/보관의 용도로 사용하는 경우
-- (방식2) DBMS에서는 SAL만 조회하고 자바 등의 클라이언트 프로그램 코드에서 연산을 수행한다. ==> DBMS를 보관의 용도로만 사용하는 경우
-- 데이터를 가공, 처리는 DBMS에서 수행하는 것이 더 DBMS를 잘 활용하는 것이라고 볼 수 있다. 
-- SQL문장에 사칙연산을 사용할 수 있다. 
SELECT ENAME, SAL, SAL*12, COMM, COMM+300 FROM EMP;

-- 15. 연산자 우선순위 
-- 일반적인 연산자 우선순위가 SQL에도 적용된다. 
-- 어떤게 좋은 방식일까? 명확하게 괄호로 표시하는 것이 좋은 방식이다. (SQL코드의 명료화)
SELECT SAL, SAL+300*12, (SAL+300)*12 FROM EMP;

-- [요구] NUMBER와 DATE자료형에 사칙연산 적용하는 SQL 예제 작성하기
DESC EMP;
SELECT HIREDATE, HIREDATE+365, HIREDATE-7 FROM EMP;
SELECT SAL, COMM, SAL+COMM FROM EMP;
SELECT SAL/12, COMM/12 FROM EMP;

-- [요구] SELECT List와 WHERE절에 사칙연산 사용할 수 있는 SQL 예제 작성하기
DESC EMP;
SELECT HIREDATE FROM EMP WHERE HIREDATE >= '80/01/01' AND HIREDATE < '80/12/31';
SELECT HIREDATE FROM EMP WHERE HIREDATE >= '81/01/01' AND HIREDATE < '81/12/31';
SELECT HIREDATE FROM EMP WHERE HIREDATE >= '82/01/01' AND HIREDATE < '82/12/31';
SELECT HIREDATE FROM EMP WHERE HIREDATE >= '83/01/01' AND HIREDATE < '83/12/31';


-- <COLUMN ALIAS>
-- 1. COLUMN ALIAS 방법은 3가지가 존재한다.
SELECT ENAME, SAL+200 bonus, SAL*12 as annual_SAL, COMM, COMM+300 "Special Bonus" FROM EMP;

-- 2. 특수문자, 공백문자, 대소문자 구분이 필요한 경우 ""로 묶어서 표현해준다.
SELECT ENAME, COMM+300 AS    "Special Bonus" FROM EMP;

-- 3. AS 또는 as 뒤에 별칭을 주는 것이 ANSI표준 방식이다. (SQL의 명료성)
SELECT ENAME, COMM+300 보너스 FROM EMP;

-- <TABLE ALIALS> 
-- 일반적으로는 SELF JOIN시에 사용한다.
SELECT E.EMPNO, E.ENAME FROM EMP E;

-- <문자열 결합/합성 연산자 : ||>
-- 4~5. ENAME과 JOB 컬럼의 데이터를 합성할 수 있다.
SELECT ENAME, JOB FROM EMP;
SELECT ENAME||JOB FROM EMP;


-- 6~8. 문자열과 COLUMN의 데이터도 결합할 수 있다. 
-- 문자열에 대한 가공처리를 DB서버에 넘긴 것이다.
SELECT DNAME||'부서는 '||LOC||'에 위치하고 있습니다' FROM DEPT;
SELECT ENAME||'is a '||JOB FROM EMP;

-- 9. 바깥에 있는 ''은 문자열을 묶어준다. 안쪽에 있는 ''은 문자 데이터 싱글 포텐셜?이다.
-- 헷갈리기 쉬우니 잘 기억해야 한다.
SELECT ENAME||'''s JOB is '||JOB FROM EMP;

-- 10. COLUMN ALIAS 를 수행하면 COLUMN HEAD를 깔끔하게 표현할 수 있다. 
SELECT ENAME||'''s JOB is'||JOB as JOB_list FROM EMP;
SELECT DNAME||'부서는 '||LOC||'에 위치하고 있습니다' AS 부서위치 FROM DEPT;

-- 11. 데이터베이스에 저장될 수 있는 데이터타입은 대부분 숫자, 문자, 날짜 유형을 벗어나지 않는다.

SELECT EMPNO, ENAME, HIREDATE FROM EMP;

-- 12. Data type Conversion
-- [Implicit Conversion  vs  Explicit Conversion]
-- Implicit Conversion : 암시적 변환, 자동형변환, DBMS 서버가 자동으로 수행한다.
-- Explicit Conversion : 명시적 변환, 강제형변환, 개발자가 직접 명기하는 방식이다.
-- 코드의 명료성과 안정성 때문에 Explicit Conversion을 쓰는 것을 권고한다.
SELECT ENAME, SAL, SAL*100, SAL||'00', to_char(SAL)||'00' FROM EMP;

-- SAL*100  vs  SAL||'00'
-- 정렬된 결과를 보면, SAL*100은 숫자이고 SAL||'00'은 문자임을 알 수 있다. 
SELECT ENAME, SAL*100, SAL||'00' FROM EMP;

-- SAL||'00'  vs  to_char(sal)||'00'
-- to_char() : 형변환 함수
-- 정렬된 결과를 보면, 둘다 문자임을 알 수 있다.
-- SAL||'00' : Implicit Conversion
-- to_char(sal)||'00' : Explicit Conversion
SELECT ENAME, SAL||'00', to_char(SAL)||'00' FROM EMP;


-- [0419 과제]



-- 4.
SELECT * FROM V$SESSION;
SELECT * FROM V$PROCESS;
SELECT * FROM SYS.V_$SESS_IO;

-- 5.
SELECT EMPNO||','||ENAME||','||JOB||','||SAL||','||DEPTNO FROM EMP;

-- 6.
SELECT * FROM TAB ;
SELECT * FROM ALL_TABLES;

DESC EMP;