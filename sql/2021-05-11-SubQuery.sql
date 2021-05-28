-- <05/10> 서브쿼리


--------------------------------------------------------------------------------------

-- [SINGLE COLUMN, SINGLE ROW]

-- 1. SMITH와 부서가 같은 애들을 출력하시오
SELECT ENAME,JOB
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'SMITH' );

-- 결과가 1건이다.
SELECT DEPTNO FROM EMP WHERE ENAME = 'SMITH';

-- 2. 전체 평균보다 급여가 작은 애들을 출력하시오
SELECT ENAME,SAL FROM EMP 
WHERE SAL < ( SELECT AVG(SAL) FROM EMP);

-- 결과가 1건이다.
SELECT AVG(SAL) FROM EMP;

--------------------------------------------------------------------------------------

-- [SINGLE COLUMN, MULTIPLE ROW RETURN SUBQUERY]

-- 1~2.
SELECT ENAME,JOB FROM EMP WHERE DEPTNO = 10 OR DEPTNO = 30;     -- 9개

SELECT ENAME,JOB FROM EMP WHERE DEPTNO IN (10,30); -- // Multiple Rows


-- 그림 잘 이해하기
-- 3. 
SELECT DNAME,LOC FROM DEPT
WHERE DEPTNO = (SELECT DEPTNO FROM EMP GROUP BY DEPTNO HAVING COUNT(*) > 3 );

-- 리턴되는 결과가 2건이니까 WHERE 조건 = 뒤에 사용할 수 없다. 
SELECT COUNT(*), DEPTNO FROM EMP GROUP BY DEPTNO HAVING COUNT(*) > 3;

-- WHERE 조건이 두 개 이상일 때는 = 대신 IN을 써야 한다.
SELECT DNAME,LOC FROM DEPT
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP GROUP BY DEPTNO HAVING COUNT(*) > 3 );


--------------------------------------------------------------------------------------

-- [MULTIPLE COLUMN, MULTIPLE ROW RETURN]
-- 서브쿼리가 여러개의 컬럼을 리턴할 때 확인하기

-- 4. 

-- 급여 평균이 2000보다 많은 직원들의 부서와 직무를 출력하시오
SELECT DEPTNO,JOB,ENAME,SAL FROM EMP
WHERE (DEPTNO,JOB) 
    IN (SELECT DEPTNO,JOB FROM EMP
        GROUP BY DEPTNO,JOB 
            HAVING AVG(SAL) > 2000
        );
    
-- 부서별, 직업별 평균 급여가 2000 이상인 부서
SELECT DEPTNO,JOB,AVG(SAL) FROM EMP
GROUP BY DEPTNO,JOB 
    HAVING AVG(SAL) > 2000;


--------------------------------------------------------------------------------------

-- [스칼라 서브쿼리]

-- 5. SELECT LIST 자리에 서브쿼리가 오는 스칼라 서브쿼리

-- 부서별 평균과 부서번호, 이름, 직업, 급여, 직업별 평균 급여를 출력하시오
SELECT DEPTNO,ENAME,JOB,SAL, 
    (SELECT ROUND(AVG(SAL),0) FROM EMP S WHERE S.JOB=M.JOB) AS JOB_AVG_SAL 
FROM EMP M
ORDER BY JOB;

SELECT DEPTNO,ENAME,JOB,SAL, 
    (SELECT ROUND(AVG(SAL),0) FROM EMP WHERE JOB=M.JOB) AS JOB_AVG_SAL 
FROM EMP M
ORDER BY JOB;

-- GROUP BY로 실행한 경우 사원들의 이름, 부서번호를 출력하기 어렵다.
SELECT JOB, ROUND(AVG(SAL),0) FROM EMP GROUP BY JOB;


--------------------------------------------------------------------------------------

-- [CORRELATED SUBQUERY(상관서브쿼리)]

-- Corealted SubQuery : 메인쿼리가 실행된 후에야 서브쿼리를 사용할 수 있을 때!
-- Subquery는 Mainquery의 컬럼을 참조할수 있지만 Mainquery는 Subquery의 컬럼을 참조할수 없다
-- Mainquery에서 Subquery의 컬럼을 참조 하려면  ① Join 으로 변환 ② Scalar Subquery


-- 6. 
-- 급여가 부서별 평균급여보가 높은 직원들의 목록을 출력하시오
SELECT DEPTNO,ENAME,JOB,SAL
FROM EMP M
WHERE SAL 
    > ( SELECT AVG(SAL) AS AVG_SAL FROM EMP WHERE JOB = M.JOB );


-- 급여가 부서별 평균급여보가 높은 직원들의 목록과 직업별 평균급여를 함께 출력하시오
SELECT DEPTNO,ENAME,JOB,SAL,
    (SELECT ROUND(AVG(SAL),0) FROM EMP WHERE JOB=M.JOB) AS JOB_AVG_SAL 
FROM EMP M
WHERE SAL 
    > ( SELECT AVG(SAL) AS AVG_SAL FROM EMP WHERE JOB = M.JOB );


--------------------------------------------------------------------------------------

-- [인라인 뷰]

-- 테이블은 정형화된 데이터 구조인데, 인라인뷰 서브쿼리를 사용하면 동적 테이블 구조를 생성해내서 활용할 수 있어서 편리하다.
-- 이때 활용한 동적 테이블 구조는 메모리 상에서만 실행되고 쿼리가 끝나면 사라진다. 
-- 정적 데이터 구조는 디스크 상에서 저장되어 사용된다는 차이가 있다. 


-- 7. 
-- 급여가 부서별 평균급여보가 높은 직원들의 목록과 직업별 평균급여를 함께 출력하시오
SELECT DEPTNO, ENAME, EMP.JOB, SAL, IV.AVG_SAL
FROM 
    EMP, 
    (SELECT JOB,ROUND(AVG(SAL)) AS AVG_SAL FROM EMP GROUP BY JOB ) IV
WHERE 
    EMP.JOB = IV.JOB 
AND 
    SAL > IV.AVG_SAL
ORDER BY DEPTNO ,SAL DESC;


--------------------------------------------------------------------------------------
-- [1:M vs M:1]

SELECT * FROM SCOTT.EMP WHERE DEPTNO IN (SELECT DEPTNO FROM SCOTT.DEPT); -- 14개 행

SELECT * FROM SCOTT.DEPT WHERE DEPTNO IN (SELECT DEPTNO FROM SCOTT.EMP); -- 3개 행

-- 원래 테이블과 비교해보면서 결과가 이렇게 나온 이유를 예측해보면?
SELECT * FROM EMP;
SELECT * FROM DEPT;

/*
1번은 EMP 테이블과 DEPT 테이블의 DEPTNO가 일치하는 경우 EMP를 전부 출력
2번은 EMP 테이블과 DEPT 테이블의 DEPTNO가 일치하는 경우 DEPT를 전부 출력
*/


--------------------------------------------------------------------------------------
-- [TOP-N,BOTTOM-M]
-- IN-LINE VIEW 에서 ORDER BY

-- 급여가 낮은 상위 5명의 정보
SELECT * FROM 
    ( SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL ASC)
WHERE ROWNUM <= 5;

-- 급여가 높은 상위 5명
SELECT TN.EMPNO,TN.ENAME,TN.SAL FROM 
    (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TN
WHERE ROWNUM <= 5;

-- 급여 순으로 정렬한 결과
SELECT * FROM EMP ORDER BY SAL ASC;


--------------------------------------------------------------------------------------
/*
    ROWNUM은 ORDER BY보다 먼저 실행된다.
*/

-- 급여순으로 정렬하지 않고, 5명 뽑은 뒤 급여순으로 정렬
SELECT EMPNO,ENAME,SAL FROM EMP
WHERE ROWNUM <= 5
ORDER BY SAL ASC;

-- 급여순으로 정렬하지 않은 상위 5명
SELECT EMPNO,ENAME,SAL FROM EMP
WHERE ROWNUM <= 5;



--------------------------------------------------------------------------------------
-- [DML]
-- SELECT가 서브쿼리이고, INSERT가 메인 쿼리이다. 
INSERT INTO BONUS(ENAME,JOB,SAL,COMM)
    SELECT ENAME,JOB,SAL,COMM FROM EMP;
ROLLBACK;



-- DML 내의 SELECT 문에는 DECODE, WHERE IN 등을 모두 사용할 수 있다.

/*
    DECODE(a, b, c, d, e)
        if ( a = b )?     b
        else if( a = c )? d
        else?             e
*/

-- 10번 부서는 급여의 30% + 커미션, 20번 부서는 급여의 20% + 커미션을 보너스로 주어라. 
INSERT INTO BONUS(ENAME,JOB,SAL,COMM)
    SELECT ENAME,JOB,SAL,DECODE(DEPTNO,10,SAL*0.3,20,SAL*0.2)+NVL(COMM,0)
FROM EMP 
WHERE DEPTNO IN (10,20);
ROLLBACK;


-- 평상시에 COMM을 받지 못하는 사원들에게 평균 COMM 금액의 50%를 보너스로 지급
UPDATE EMP SET COMM = (SELECT AVG(COMM)/2 FROM EMP)
WHERE COMM IS NULL OR COMM = 0;
ROLLBACK;


-- 평균 이상의 급여를 받는 사원들은 보너스 지급 대상자에서 제외
DELETE FROM BONUS
WHERE 
    SAL > (SELECT AVG(SAL) FROM EMP) ;
ROLLBACK;