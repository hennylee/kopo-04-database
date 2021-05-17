-- <05/12>
-- DML & Transaction


-- [INSERT]
-- 명료성과 안정성
-- 1. 컬럼을 명시적으로 입력하지 않은 경우
INSERT INTO DEPT VALUES(50,'연구소1', '서울');
DESC DEPT;


-- 2. 명시적으로 컬럼을 작성해주는 것이 더 좋은 코드이ㅏ.
INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES(51,'연구소2', '대전');

SELECT * FROM DEPT;

-- INTO 뒤에 컬럼을 생략하는 경우, NULL로 지정되는가?
-- NO ~ 에러 발생
-- 4. 
INSERT INTO DEPT VALUES('중부영업점','대구');

-- INTO 뒤에 일부 컬럼만 작성하고, 특정 컬럼을 빠뜨리면 없는 컬럼에는 NULL 값이 삽입된다. 
-- ORA-12899 에러 발생 : 지정해둔 SIZE보다 크기 때문에 발생한다.
-- 5.
INSERT INTO DEPT(DNAME, LOC) VALUES('중부영업점', '대구');



-- 근데 NULL을 허용하지 않는 컬럼이었다면?
-- ORA-01400의 공식적인 에러 Reference를 찾아보기


-- 명시적 방법 : INSERT 할 때 특정 컬럼에 NULL 값 삽입하는 방법
-- 6.
INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES(52,'북부', NULL);
SELECT * FROM DEPT;
ROLLBACK;

-- NULL과 'NULL'은 같은가?
-- 다르다.
-- 근데 NULL을 삽입하던지, ''을 삽입하던지 모두 (null)값이 들어간다.
-- 7. 
INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES(53, '남부영업', '');
SELECT * FROM DEPT;
ROLLBACK;

-- 암시적 방법 : INSERT 할 때 특정 컬럼에 NULL 값 삽입하는 방법
-- 8.
INSERT INTO DEPT(DEPTNO, DNAME) VALUES(54,'서부');
SELECT * FROM DEPT;

-- NVL()로 NULL 값 확인하기
-- 9.
SELECT DEPTNO, DNAME, NVL(LOC, '미지정지역') AS LOC FROM DEPT;
ROLLBACK;

-- COMMIT : 트랜젝션
-- 10.
DESC DEPT;




-- [UPDATE]

-- 특정 값만 변경하는 방법

-- SELECT 에 WHERE : 내가 원하는 값만 찾기
-- UPDATE 에 WHERE : 내가 원하는 값만 수정하기

-- 11.
INSERT INTO DEPT(DEPTNO, DNAME) VALUES(50,'서부');
SELECT * FROM DEPT;
UPDATE DEPT SET DNAME = '중부' WHERE DEPTNO = 50;
SELECT * FROM DEPT;
ROLLBACK;

-- 복수 개의 컬럼을 UPDATE 할 수 있는가?
-- 12.
INSERT INTO DEPT(DEPTNO,DNAME,LOC) VALUES(51,'서부',NULL);
UPDATE DEPT SET DNAME = '북서부', LOC='인천' WHERE DEPTNO = 51;
SELECT * FROM DEPT;




-- 1.
SELECT * FROM DEPT WHERE DEPTNO IN (50,51);
COMMIT;

-- ******************정말 조심해야 함*********************
-- UPDATE에 WHERE 절 조건이 생략된다면? 
-- SELECT에 WHERE 절 조건이 생략된다면? 전체 데이터가 조회된다.
-- 3. 
UPDATE DEPT SET LOC='미개척';
SELECT * FROM DEPT;

-- UPDATE 되돌리기
-- 5.
ROLLBACK;


-- [DELETE]
-- 1.
DELETE FROM DEPT WHERE LOC IS NULL;
SELECT * FROM DEPT;

-- FROM은 생략 가능한가?
-- 생략 가능하다. 전체 데이터가 지워짐
-- 2. 
DELETE DEPT;


-- ******************정말 조심해야 함*********************
-- DELETE에 WHERE 절 조건이 생략된다면? 
-- UPDATE에 WHERE 절 조건이 생략된다면? 
-- SELECT에 WHERE 절 조건이 생략된다면? 전체 데이터가 조회된다.
-- 3.
SELECT * FROM DEPT;

-- 4. ROLLBACK 결과 확인해보기
ROLLBACK;


-- [DML SUBQUERY]

-- 메인쿼리 : INSERT, 서브쿼리 : SELECT
-- 5.
INSERT INTO BONUS(ENAME, JOB, SAL, COMM) SELECT ENAME, JOB, SAL, COMM FROM EMP;

SELECT * FROM BONUS;
ROLLBACK;


-- 9.
INSERT INTO BONUS(ENAME, JOB, SAL, COMM) 
    SELECT ENAME, JOB, SAL, DECODE(DEPTNO, 10, SAL*0.3, 20, SAL*0.2)+ NVL(COMM,0)
FROM EMP
WHERE DEPTNO IN (10,20);

SELECT * FROM BONUS;

-- COMMIT 이후에 ROLLBACK을 날리면, COMMIT한게 취소될까?
-- 취소되지 않는다!
-- 11.
COMMIT;
SELECT * FROM BONUS;

-- 12.
ROLLBACK;
SELECT * FROM BONUS;


-- SUBQUERY가 상수로 변하고, 상수값이 UPDATE되는가? 아니면 그 반대인가?
-- 13.
UPDATE EMP SET COMM=(SELECT AVG(COMM)/2 FROM EMP)
WHERE COMM IS NULL OR COMM = 0;

SELECT * FROM EMP;


-- 평균 이상의 급여를 받는 사원들은 보너스 지금 대상자에서 제외
-- 15.
SELECT * FROM BONUS;
SELECT AVG(SAL) FROM EMP;
DELETE FROM BONUS WHERE SAL > (SELECT AVG(SAL) FROM EMP);

-- [TRANSACTION]
-- 트랜젝션 시작과 종료
ROLLBACK;
SELECT * FROM DEPT;
INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES(90, '신규사업', '경기도');
UPDATE EMP SET DEPTNO = 90 WHERE DEPTNO = 30;
DELETE FROM DEPT WHERE DEPTNO = 30;

SELECT * FROM EMP WHERE DEPTNO = 30;
SELECT * FROM DEPT;

ROLLBACK;
SELECT * FROM DEPT;

-- 트랜젝션 종료 후, 롤백 처리 범위
INSERT INTO EMP(EMPNO, ENAME, JOB, SAL);
DESC EMP;


-- 테이블 복제하는 법 : CTAS
ROLLBACK;

CREATE TABLE EMP_B 
AS SELECT * FROM EMP;

SELECT * FROM EMP_B;

DELETE FROM EMP;
COMMIT;

INSERT INTO EMP SELECT * FROM EMP_B;
COMMIT;


-- [Rollback Level]
-- 원자성이 보장되나요?
-- 아니오... 
ROLLBACK;
SELECT /* Before Transaction */ EMPNO, SAL FROM EMP WHERE EMPNO IN (7788,7902);


-- STATEMENT 레벨의 롤백
-- 암시적으로(자동으로) 업데이트가 하나라도 실패하면 전체를 ROLLBACK 시키는 것이다. 


-- TRANSACTION 레벨의 롤백




-- [트랜젝션과 읽기 일관성]


-- [트랜젝션과 Low 레벨 Lock]
-- 10번 부서 각 레코드(Row)에 LOW LEVEL Lock이 걸린다. 
-- 트랜젝션이 종료되면 Low Level Lock이 풀린다. 

-- 20번 부서 각 레코드(Row)에 락이 걸린다. 
-- 트랜젝션이 종료되면 Low Level Lock이 풀린다. 

-- Lock이 풀릴때까지 Wait


-- Low Level Lock (자동) <--> Table Level Lock (수동)

-- SELECT 는 Lock을 걸 필요가 없다.
-- 조회만 하기 때문에 동시성을 제어할 필요가 없기 때문이다. 