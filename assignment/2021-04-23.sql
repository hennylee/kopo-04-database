SELECT TO_BINARY_FLOAT(3) FROM DUAL
   INTERSECT
SELECT 3f FROM DUAL;

SELECT '3' FROM DUAL
   INTERSECT
SELECT 3f FROM DUAL;


SELECT SAL FROM EMP
UNION
SELECT COMM FROM EMP;


SELECT SAL FROM EMP
UNION
SELECT ENAME FROM EMP;

SELECT SAL FROM EMP
UNION ALL
SELECT COMM FROM EMP;


SELECT DEPTNO FROM EMP
INTERSECT
SELECT DEPTNO FROM DEPT;

SELECT * FROM DEPT;



SELECT DEPTNO FROM EMP
MINUS
SELECT DEPTNO FROM DEPT;

SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;


SELECT * FROM
   (SELECT * FROM EMP ORDER BY ENAME)
   WHERE ROWNUM < 11;
   
-- 행을 찾아가는 가장 빠른 방법   
SELECT ROWID FROM EMP;
SELECT ROWNUM FROM EMP;

-- 데이터 최종수정 시간
-- For each row, ORA_ROWSCN returns the conservative upper bound system change number (SCN) of the most recent change to the row.
SELECT * FROM EMP;
SELECT ORA_ROWSCN FROM EMP;
SELECT ORA_ROWSCN FROM DEPT;