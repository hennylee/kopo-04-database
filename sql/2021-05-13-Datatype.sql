-- <05/13>

-- [CHAR]
-- 오라클에서 '공백 문자'도 ASCII코드를 가지고 있는 엄연한 데이터이다. 


-- [VARCHAR2]
-- 1~4000 바이트 저장 가능
-- 입력된 길이만큼 저장 공간이 할당된다. 
-- 대부분의 문자 데이터에 사용한다. 
-- 데이터 저장 공간을 유용하게 사용할 수 있다.

-- [NUMBER]
-- P, S 부분을 생략하면 정수와 실수 모두 유연하게 사용가능하게 되지만, 명시적으로 표기해줘야 좋은 쿼리이다. 
-- 예기치못한 오류 발생을 피할 수 있기 때문이다.

-- 숫자에서 정수차리 초과하면 에러, 소수점 차리를 초과하면 자동으로 ROUND 처리가 된다. 



-- [ROWID]
-- ROWID를 저장할 수 있도록 하는 데이터 타입이다. 
-- INDEX를 제대로 이해하려면 ROWID를 알고 있어야 한다. 


-- [DECIMAL, INTEGER,SMALL INTEGER,FLOAT]
-- ANSI 호환 및 DB2등과의 TABLE 생성 SQL문장 레벨 호환성을 위해 존재 하며 실제 생성시에는 내부적으로는 ORACLE DATA TYPE으로 바뀐다.



-- [테이블 생성 (문자 Data Type) ]

-- 1. 테이블 생성
CREATE TABLE TEST_CUSTOMER(
    ID VARCHAR2(8),
    PWD CHAR(8),
    SEX CHAR(1)
);

-- 2. 내 소유의 모든 테이블 목록 보기
-- BIN$weXmVH/d7SfgVZyARt1nQQ==$0의 정체 : https://opensrc.tistory.com/31
SELECT * FROM TAB;

-- 3. 생성된 테이블의 구조 확인
DESC TEST_CUSTOMER;

-- 4. 컬럼명 생략하고 INSERT
INSERT INTO TEST_CUSTOMER VALUES('XMAN','XMAN','M');

-- 5. 컬럼명 지정하고 INSERT
INSERT INTO TEST_CUSTOMER(ID,PWD,SEX) VALUES('ORACLE','OCM','F');

-- 6. 변경사항을 DB에 영구히 반영
COMMIT;


-- INSERT시에 특정 COLUM에 NULL값 삽입방법
-- 8~9. 명시적 방법
-- NULL과 ''의 차이는?
INSERT INTO TEST_CUSTOMER(ID, PWD, SEX) VALUES('NULL1', 'ZMAN', NULL);
INSERT INTO TEST_CUSTOMER(ID, PWD, SEX) VALUES('NULL2', 'ZMAN', '');

-- 10. 암시적 방법
INSERT INTO TEST_CUSTOMER(ID, PWD) VALUES('NULL3', 'ZMAN');

-- 저장 및 결과 확인
COMMIT;
SELECT * FROM TEST_CUSTOMER;

-- [고정 길이와 가변 길이 차이점 비교]

-- 데이터 저장 시 차이점
-- 11. LENGTH(), VSIZE()로 할당된 바이트를 비교하기
-- 결론 : ID는 가변길이, PWD는 고정길이로 데이터 타입을 설정했기 때문에 ID는 길이가 제각각이고 PWD는 길이가 동일하다.
SELECT ID, LENGTH(ID), VSIZE(ID), PWD, LENGTH(PWD), VSIZE(PWD) FROM TEST_CUSTOMER;

-- 12. REPLACE()로 공백문자가 있는지 확인하기
-- 결론 : 가변 길이에는 남은 길이만큼 공백이 저장되지 않지만, 고정길이 데이터타입은 남은 공간만큼 공백이 채워진다.
SELECT ID, REPLACE(ID, ' ', '?'), PWD, REPLACE(PWD, ' ', '?') FROM TEST_CUSTOMER;

-- 비교시 차이점 (BLANK-PADDING, NON-BLANK PADDING)]
-- 가변길이와 고정길이 중에 어떤 것으로 암시적 형변환이 되는지 비교시 우선순위 알아보기

-- VARCHAR2 TYPE 비교시에는 NON-BLOCK PADDING 방식

/*
    ID VARCHAR2(8),
    PWD CHAR(8),
*/
-- 13. VARCHAR2 TYPE은 문자 길이만큼만 공간이 할당됨
SELECT * FROM TEST_CUSTOMER WHERE ID = 'XMAN';
SELECT * FROM TEST_CUSTOMER WHERE ID = 'XMAN ';
SELECT * FROM TEST_CUSTOMER WHERE ID = 'XMAN    ';


-- 14. VARCHAR2 와 CHAR를 비교 불가?
-- 둘이 길이가 같으면 비교 가능하지만, 둘이 크기가 다르다면 비교 불가능!
-- 'XMANXMAN' = 'XMANXMAN'
-- 'XMAN'    != 'XMAN    '
-- 큰 타입으로 데이터 형변환이 발생하지 않기 때문이다.
/*
    ID VARCHAR2(8),
    PWD CHAR(8),
*/
INSERT INTO TEST_CUSTOMER VALUES('XMANXMAN','XMANXMAN','M');
ROLLBACK;

-- 가변길이를 더 좋아함
-- 가변길이 방식으로 PWD와 ID를 비교하는 것이다.
SELECT * FROM TEST_CUSTOMER WHERE ID = PWD;
SELECT * FROM TEST_CUSTOMER WHERE PWD = ID;

-- 15. 
-- SUBSTR('XMAN', 1, 2) = 'XM'
-- SUBSTR('XMAN', 3, 2) = 'AN'
-- SUBSTR('XMAN', 1, 2)|| SUBSTR('XMAN',3,2) = 'XMAN'
SELECT * FROM TEST_CUSTOMER WHERE ID = SUBSTR('XMAN', 1, 2)|| SUBSTR('XMAN',3,2);

-- CHAR TYPE 비교시에는 BLOCK PADDING 방식
-- 1. 
/*
    ID VARCHAR2(8),
    PWD CHAR(8),
*/
SELECT * FROM TEST_CUSTOMER WHERE PWD = 'XMAN';
SELECT * FROM TEST_CUSTOMER WHERE PWD = 'XMAN ';
SELECT * FROM TEST_CUSTOMER WHERE PWD = 'XMAN    ';

-- 2. 
-- SUBSTR('XMAN', 1, 2) = 'XM'
-- SUBSTR('XMAN', 3, 2) = 'AN'
-- SUBSTR('XMAN', 1, 2)|| SUBSTR('XMAN',3,2) = 'XMAN'
-- PWD는 고정길이, SUBSTR('XMAN', 1, 2)|| SUBSTR('XMAN',3,2) = 'XMAN'는 가변길이
SELECT * FROM TEST_CUSTOMER WHERE PWD = SUBSTR('XMAN', 1, 2)|| SUBSTR('XMAN',3,2);
SELECT * FROM TEST_CUSTOMER;

-- 3. 
SELECT * FROM TEST_CUSTOMER WHERE PWD LIKE SUBSTR('XMAN', 1, 2)|| SUBSTR('XMAN',3,2)||'%';


-- rpad로 공백 확인하기
SELECT rpad(ENAME, 10, '')||'@@' FROM EMP;
SELECT rpad(ENAME, 10, ' ')||'@@' FROM EMP;

SELECT rpad(ENAME, 10, NVL('','*'))||'@@' FROM EMP;



-- [테이블 생성 (숫자 DATA TYPE) ]

-- 5. 테이블 생성
-- LENGTH 지정 안하고 컬럼 정의하면 안된다. => 매우 좋지 않은 코딩 방식이다. => 명시적 코딩하세요
-- DEFAULT를 지정하면 NULL으로 초기화되지 않고 설정한 값으로 초기화된다.

CREATE TABLE TST_NUMBER(
    NUM NUMBER,
    AGE NUMBER(3) DEFAULT 18,
    TAX NUMBER(7, 2)
);

-- 6.
INSERT INTO TST_NUMBER VALUES(123.5, 123.5, 123.5);

-- 7.
INSERT INTO TST_NUMBER VALUES(123, 123, 123);

-- 8~9. 정수형 자리수를 초과하면 ERROR, 실수형 자릿수를 초과하면 ROUND
INSERT INTO TST_NUMBER VALUES(123, 12345, 123); -- 오류 : 정수형 자리 초과
INSERT INTO TST_NUMBER VALUES(123, 123, 123.56789); -- 오류 : 소수점 자리 초과

-- 10.
INSERT INTO TST_NUMBER VALUES(123, '123', 123.56789); -- 반올림되어서 들어감

-- 11. (오타 : 컬럼명 NUM, TAX로 바꾸기)
INSERT INTO TST_NUMBER(ALL_NUM,F_TAX) VALUES(456, 456); -- 에러
SELECT * FROM TST_NUMBER;

-- [ 테이블 생성 (날짜 DATA TYPE) ]

-- 날짜 정보를 저장할때 무조건 DATE를 사용해야 하는 것은 아니다.
-- 상황에 따라 VARCHAR2()로 저장해도 된다. 

-- DATE는 고정길이, 숫자처럼 내부에 저장되고, 연산이 가능하고, 년월일+시분초의 정보까지 저장된다. 
-- 만약 DATE의 이러한 기능이 필요없다면 VARCHAR2로 데이터타입을 지정해도 된다. 


CREATE TABLE TST_DATE(
    CHAR_HIREDATE   VARCHAR2(8),
    DATE_HIREDATE DATE,
    LOG_DATE DATE DEFAULT SYSDATE
);

-- [ LOG ]
-- 보통 기록, ERROR, WARNING, MESSAGE 등을 로그로 남긴다. 
-- 로그는 주로 FILE에 남기거나 DB에 남긴다. 
-- 전체 운영시스템의 로그는 주로 각 시스템이 아니라 하나에 공간에 모아져서 기록된다.



-- 15. 
-- 날짜 정보를 문자 타입으로 바꿔서 저장할 수 있다.
-- DEFAULT를 SYSDATE로 설정하고 VALUES를 비워두면, INSERT가 발생한 시각을 기록할 수 있다. 

INSERT INTO TST_DATE(CHAR_HIREDATE, DATE_HIREDATE) VALUES(TO_CHAR(SYSDATE,'YYYYMMDD'), SYSDATE);

-- 1. 
INSERT INTO TST_DATE(CHAR_HIREDATE, DATE_HIREDATE) VALUES('19990921', TO_DATE('990921', 'YYMMDD'));

-- 2. 결과 확인
SELECT * FROM TST_DATE;


-- [ ALTER ]

-- 3. 
ALTER TABLE TST_DATE ADD(NAME VARCHAR2(20), AGE NUMBER(3));
DESC TST_DATE;

-- 4.
ALTER TABLE TST_DATE DROP COLUMN AGE;
DESC TST_DATE;


-- [  DROP ]

-- 5.
SELECT * FROM TAB;
DROP TABLE TST_DATE;
DESC TST_DATE;
SELECT * FROM TAB;


-- [ SUBQUERY에 의한 TABLE 생성 ]

-- CTAS 테이블 복제
CREATE TABLE EMP_CTAS AS SELECT * FROM EMP;


-- CTAS로 복사하면 NOT NULL 제약사항도 복사되는가? YES~!
-- 5개의 제약 사항 참고
DESC EMP_CTAS;
SELECT * FROM EMP_CTAS;

SELECT * FROM EMP_CTAS_WHERE;
DROP TABLE EMP_CTAS_WHERE;

CREATE TABLE EMP_CTAS_J
AS SELECT EMPNO, ENAME, DEPT.DNAME, SAL*12 AS ANNUAL_SAL
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.DEPTNO IN (10,20);

DESC EMP_CTAS_J;
SELECT * FROM EMP_CTAS_J;


-- [ DELETE,TRUNCATE, DROP 의 차이점 ]
SHOW USER;
SELECT COUNT(*) FROM DBA_OBJECTS;
SELECT * FROM DBA_OBJECTS;

------------------------------------------ DBA 계정에서 실행 --------------------------------------------
SHOW USER;
SELECT COUNT(*) FROM DBA_OBJECTS;
SELECT * FROM DBA_OBJECTS; -- 73000건

SELECT * FROM DBA_OBJECTS O, SCOTT.EMP E;

-- DBA계정으로 SCOTT 계정에 SCOTT 소유의 LARGE_TBL을 만든다.
-- 카디션 곱으로 쓰레기 데이터가 생겨남
CREATE TABLE SCOTT.LARGE_TBL
AS
SELECT O.OWNER, O.OBJECT_NAME, E.ENAME FROM DBA_OBJECTS O, SCOTT.EMP E; 

SELECT COUNT(*) FROM SCOTT.LARGE_TBL;

-- 데이터 추가하기
INSERT INTO SCOTT.LARGE_TBL SELECT * FROM SCOTT.LARGE_TBL;
SELECT COUNT(*) FROM SCOTT.LARGE_TBL;

-- 데이터 저장하기
COMMIT;
-------------------------------------------------------------------------------------------------------
SHOW USER;
CREATE TABLE DROP_TBL AS SELECT * FROM LARGE_TBL;
CREATE TABLE TRUNCATE_TBL AS SELECT * FROM LARGE_TBL;
CREATE TABLE DELETE_TBL AS SELECT * FROM LARGE_TBL;

-- 용량이 부족하다면? 
-- 에러 : ORA-01652, ORA-01653
SELECT TABLESPACE_NAME, SUM(BYTES)/1024/1024 AS FREE_MB FROM DBA_FREE_SPACE GROUP BY TABLESPACE_NAME;
SELECT SEGMENT_NAME, BYTES/1024/1024 AS SIZE_MB FROM DBA_SEGMENTS WHERE TABLESPACE_NAME = 'USERS'ORDER BY 2 DESC;
DROP TABLE DROP_TBL;
PURGE RECYCLEBIN;

-- 쿼리수행시간을 조회하는 방법
SET TIMING ON

-- DROP & 시간체크
DROP TABLE DROP_TBL;
ROLLBACK;
DESC DROP_TBL;
SELECT * FROM DROP_TBL;

-- TRUNCATE & 시간체크
TRUNCATE TABLE TRUNCATE_TBL;
ROLLBACK;
DESC TRUNCATE_TBL;
SELECT * FROM TRUNCATE_TBL;

-- DELETE & 시간 체크
DELETE FROM DELETE_TBL;
ROLLBACK;
DESC DELETE_TBL;
SELECT * FROM DELETE_TBL;


-- ALTER
ALTER TABLE DELETE_TBL ADD(ADDR VARCHAR2(60));

-- 왜 오랜 시간이?
-- DROP과 TRUNCATE는 금방 끝나지만, DELETE는 백업하는 과정이 필요하기 때문에 오래 걸린다.
ALTER TABLE DELETE_TBL ADD(AGE NUMBER(3) DEFAULT 18);

SELECT * FROM DELETE_TBL WHERE ROWNUM < 10;

-- 실습 끝났으면 삭제하기
DROP TABLE DROP_TBL;
DROP TABLE DELETE_TBL;
DROP TABLE TRUNCATE_TBL;
PURGE RECYCLEBIN;


-- [ 테이블명 ]

-- 테이블명은 A~Z, a~z, 0~0, #,_,$ 만 허용한다
-- 테이블명은 문자명으로 시작해야 한다. 숫자로 시작하면 안된다.
-- 테이블명은 대소문자 구분하지 않는다-> 대문자로 만들어진다
CREATE TABLE SCOTT.TBL-NM;
CREATE TABLE SCOTT.TBL_NM;
CREATE TABLE SCOTT.tbl_nm;
CREATE TABLE SCOTT.10_TBL_NM;