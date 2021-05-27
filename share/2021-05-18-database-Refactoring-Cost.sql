-- <05/18> SQL재구성(Refactoring) : COST

-- [수정 1] : 길이는 짧아졌지만 COST는 동일 , HASH GROUP BY
SET AUTOTRACE ON
/* 실행계획 : 단축키 F6 
    - 전체 COST : 4
    - 전체 4 COST 중에 TABLE ACCESS FULL가 3 , HASH GROUP BY는 1 차지
*/
SELECT 
    MAX(DECODE(DEPTNO, 10, COUNT(*),0)) AS "10번 부서",
    MAX(DECODE(DEPTNO, 20, COUNT(*),0)) AS "20번 부서",
    MAX(DECODE(DEPTNO, 30, COUNT(*),0)) AS "30번 부서"
FROM EMP
GROUP BY DEPTNO;
    
-- [수정 2] : COST가 줄어듬 : VIEW
SET AUTOTRACE ON
/* 실행계획 : 단축키 F6 
    - 전체 COST 3
*/
SELECT * FROM (SELECT DEPTNO FROM EMP)
PIVOT (COUNT(*)
    for DEPTNO in (10 AS "10번부서", 20 AS "20번부서", 30 AS "30번부서")
);

-- [수정 3] : 
SET AUTOTRACE ON
/* 실행계획 : 단축키 F6 
    - 전체 COST : 3
*/
SELECT 
    SUM(DECODE(DEPTNO, 10, 1, 0)) AS "10번부서",
    SUM(DECODE(DEPTNO, 20, 1, 0)) AS "20번부서",
    SUM(DECODE(DEPTNO, 30, 1, 0)) AS "30번부서"
FROM EMP;