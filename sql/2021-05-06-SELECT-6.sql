-- <05/06>


---------------------------------------------------------------------------------
-- [그룹행 함수]

-- 8. min(), max()
-- MIN, MAX를 구하기 위해서 SORT, FULL SCAN 방식으로 처리한다.
SELECT MIN(ENAME),MAX(ENAME),MIN(SAL),MAX(SAL),MIN(HIREDATE),MAX(HIREDATE) FROM EMP;
-- ENAME:문자, SAL:숫자,HIREDATE:날짜

-- 9. 
SELECT COUNT(*),COUNT(EMPNO),COUNT(MGR),COUNT(COMM) FROM EMP;

-- 10. 
SELECT 
COUNT(JOB), COUNT(ALL JOB), COUNT(DISTINCT JOB),
SUM(SAL), SUM(ALL SAL), SUM(DISTINCT SAL)
FROM EMP;

SELECT * FROM EMP;

-- 11.
SELECT COUNT(*), SUM(COMM), 
SUM(COMM)/COUNT(*),
AVG(COMM),
SUM(COMM)/COUNT(COMM)
FROM EMP;

-- 12 ~ 13. SUM을 할 때 어차피 NULL을 제외하기 때문에 NVL을 사용할 필요가 없다.
SELECT SAL,COMM FROM EMP;

SELECT SUM(NVL(COMM,0)) AS SUM_COMM1,
SUM(COMM) AS SUM_COMM2, 
NVL(SUM(COMM),0) AS SUM_COMM3 
FROM EMP;



---------------------------------------------------------------------------------
-- [GROUP BY]
-- GROUP BY 실행 방식이 10g 부터 hash 방식으로 변경된후에는 정렬된 결과 집합이 되지 않는다.
-- 그래서 GROUP BY 다음에 무조건 명시적으로 ORDER BY 정렬을 해줘야 정렬이 된다.


-- 1. 부서단위로 그룹핑하여 결과 출력, ALIAS, 정렬(?), 소수점 이하(?)
SELECT * FROM EMP;
SELECT DEPTNO, COUNT(*), SUM(SAL), AVG(SAL) FROM EMP 
GROUP BY DEPTNO;

SELECT JOB, COUNT(*), SUM(SAL), AVG(SAL) FROM EMP 
GROUP BY JOB;


-- 정렬
SELECT DEPTNO,COUNT(*),SUM(SAL),AVG(SAL) FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;


-- NULL은? 그룹핑 대상에 포함됨
SELECT COMM,COUNT(*) FROM EMP
GROUP BY COMM;


-- 2. COLUMN HEADING의 가독성을 높이고 급여 평균에서 소수점 이하 자리 처리하는 방법은 ?

SELECT DEPTNO,
    COUNT(*) AS CNT_DEPT,
    SUM(SAL) AS SUM_SAL,
    ROUND(AVG(SAL),0) AS AVG_SAL
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO,SUM_SAL;


---------------------------------------------------------------------------------
-- [요구] 아래의 SQL 실행 결과를 설명하고 문제를 해결 하십시오
SELECT JOB,COUNT(*),SUM(SAL),AVG(SAL) FROM EMP GROUP BY JOB; --??
SELECT DEPTNO, JOB,COUNT(*),SUM(SAL),AVG(SAL) FROM EMP GROUP BY DEPTNO,JOB; --??


---------------------------------------------------------------------------------
-- 다음과 같은 결과를 생성하는 SQL문장을 작성하십시오. CAN!!!!

/*
10번부서       20번부서   30번부서
---------- ---------- ----------
    3           5          6
*/

SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO;
SELECT COUNT(*) FROM EMP GROUP BY DEPTNO;

-- 위의 결과를 가로로 출력되도록 한다. 

SELECT 
    (SELECT COUNT(*) FROM EMP GROUP BY DEPTNO HAVING DEPTNO = 10) AS "10번부서",
    (SELECT COUNT(*) FROM EMP GROUP BY DEPTNO HAVING DEPTNO = 20) AS "20번부서",
    (SELECT COUNT(*) FROM EMP GROUP BY DEPTNO HAVING DEPTNO = 30) AS "30번부서"
FROM EMP;


-- 방법 1
SELECT DISTINCT
    (SELECT COUNT(*) FROM EMP GROUP BY DEPTNO HAVING DEPTNO = 10) AS "10번부서",
    (SELECT COUNT(*) FROM EMP GROUP BY DEPTNO HAVING DEPTNO = 20) AS "20번부서",
    (SELECT COUNT(*) FROM EMP GROUP BY DEPTNO HAVING DEPTNO = 30) AS "30번부서"
FROM EMP;


-- 방법 2 : 틀림
SELECT * FROM EMP;

SELECT DISTINCT DEPTNO,
DECODE(DEPTNO, 10, (SELECT COUNT(*) FROM EMP WHERE DEPTNO = E.DEPTNO)) AS "10번 부서",
DECODE(DEPTNO, 20, (SELECT COUNT(*) FROM EMP WHERE DEPTNO = E.DEPTNO)) AS "20번 부서",
DECODE(DEPTNO, 30, (SELECT COUNT(*) FROM EMP WHERE DEPTNO = E.DEPTNO)) AS "30번 부서"
FROM EMP E;

SELECT 
DECODE(DEPTNO, 10, (SELECT COUNT(*) FROM EMP WHERE DEPTNO = E.DEPTNO)) AS "10번 부서",
DECODE(DEPTNO, 20, (SELECT COUNT(*) FROM EMP WHERE DEPTNO = E.DEPTNO)) AS "20번 부서",
DECODE(DEPTNO, 30, (SELECT COUNT(*) FROM EMP WHERE DEPTNO = E.DEPTNO)) AS "30번 부서"
FROM EMP E;


-- 방법 3

SELECT 
MIN(DECODE(DEPTNO, 10, (SELECT COUNT(*) FROM EMP WHERE DEPTNO = E.DEPTNO))) AS "10번 부서",
MIN(DECODE(DEPTNO, 20, (SELECT COUNT(*) FROM EMP WHERE DEPTNO = E.DEPTNO))) AS "20번 부서",
MIN(DECODE(DEPTNO, 30, (SELECT COUNT(*) FROM EMP WHERE DEPTNO = E.DEPTNO))) AS "30번 부서"
FROM EMP E;


SELECT 
DECODE(DEPTNO, 10, COUNT(DEPTNO)) AS "10번부서",
DECODE(DEPTNO, 20, COUNT(DEPTNO)) AS "20번부서",
DECODE(DEPTNO, 30, COUNT(DEPTNO)) AS "30번부서"
FROM EMP
GROUP BY DEPTNO;


-- 방법 4

SELECT 
MIN(DECODE(DEPTNO, 10, COUNT(DEPTNO))) AS "10번부서",
MIN(DECODE(DEPTNO, 20, COUNT(DEPTNO))) AS "20번부서",
MIN(DECODE(DEPTNO, 30, COUNT(DEPTNO))) AS "30번부서"
FROM EMP
GROUP BY DEPTNO;


-- 방법 5
SELECT 
MAX(NVL(DECODE(DEPTNO, 10, COUNT(*)),0)),
MAX(NVL(DECODE(DEPTNO,20,COUNT(*)),0)),
MAX(NVL(DECODE(DEPTNO,30,COUNT(*)),0)) 
FROM EMP GROUP BY DEPTNO;




---------------------------------------------------------------------------------
-- 부서번호,사번,이름,급여,급여비율(소수점이하2자리)을 출력하는 SQL을 CARTESIAN PRODUCT를 응용하여 작성 하십시오
SELECT * FROM EMP;

SELECT E.DEPTNO, E.ENAME, M.ENAME, M.SAL --,() AS SAL_RATE
FROM EMP E, EMP M;


SELECT 
    E.DEPTNO, E.ENAME, M.ENAME, M.SAL ,
    (SELECT E.DEPTNO, E.ENAME, SUM(M.SAL)
    FROM EMP E, EMP M
    GROUP BY E.ENAME
    ) AS SAL_RATE
FROM EMP E, EMP M;

SELECT E.DEPTNO, E.ENAME, SUM(E.SAL)
FROM EMP E, EMP M
GROUP BY E.DEPTNO, E.ENAME
ORDER BY E.DEPTNO;


SELECT 
    E.DEPTNO, E.ENAME, TRUNC(E.SAL/SUM(M.SAL) * 100,2) AS SAL_RATE 
FROM EMP E, EMP M
GROUP BY E.ENAME,  E.DEPTNO, E.SAL;

SELECT * FROM EMP;



---------------------------------------------------------------------------------
-- [HAVING]
-- HAVING 은 WHERE 절과 비슷하지만 그룹을 나타내는 결과 집합의 행에 조건이 적용되는 차이가 있습니다.
-- WHERE 절은 전체 데이터를 GROUP 으로 나누기 전에 행들을 미리 제거시킨다.

-- 3.
SELECT DEPTNO,COUNT(*),SUM(SAL),AVG(SAL) FROM EMP 
GROUP BY DEPTNO;


-- 4.
SELECT DEPTNO,COUNT(*),SUM(SAL),AVG(SAL) FROM EMP
GROUP BY DEPTNO HAVING SUM(SAL) > 9000;


-- 5.
SELECT DEPTNO,COUNT(*),SUM(SAL),AVG(SAL) FROM EMP
GROUP BY DEPTNO HAVING DEPTNO in (10,20);


-- 6.
SELECT DEPTNO,COUNT(*),SUM(SAL),AVG(SAL) FROM EMP
WHERE DEPTNO IN (10,20)
GROUP BY DEPTNO 
HAVING SUM(SAL) > 9000
ORDER BY SUM(SAL);
