-- SQL : 3.675초 , COST : 7
SELECT A.ENAME,
      A.SAL,
      A.DNAME
  FROM (SELECT A.ENAME,
              B.DNAME,
              A.SAL,
              RANK() OVER (PARTITION BY A.DEPTNO
                ORDER BY A.SAL DESC) AS RANKING
          FROM EMP A,
              DEPT B
        WHERE A.DEPTNO = B.DEPTNO ) A
 WHERE A.RANKING = 1;
 

-- MView만들기

DROP MATERIALIZED VIEW TST_MView;

CREATE MATERIALIZED VIEW TST_MView
    BUILD IMMEDIATE
    REFRESH
        COMPLETE
        ON DEMAND
ENABLE QUERY REWRITE AS
    SELECT
        a.ename,
        a.sal,
        a.dname
    FROM
        (
            SELECT
                a.ename,
                b.dname,
                a.sal,
                RANK() OVER(PARTITION BY
                    a.deptno
                    ORDER BY
                        a.sal
                    DESC
                ) AS ranking
            FROM
                emp a,
                dept b
            WHERE
                a.deptno = b.deptno
        ) a
    WHERE
        a.ranking = 1;
 
 
 /*
 오류 보고 -
ORA-01031: 권한이 불충분합니다
01031. 00000 -  "insufficient privileges"
*Cause:    An attempt was made to perform a database operation without
           the necessary privileges.
*Action:   Ask your database administrator or designated security
           administrator to grant you the necessary privileges
*/


--  GRANT QUERY REWRITE TO SCOTT;
 /*
 오류 보고 -
ORA-01031: 권한이 불충분합니다
01031. 00000 -  "insufficient privileges"
*Cause:    An attempt was made to perform a database operation without
           the necessary privileges.
*Action:   Ask your database administrator or designated security
           administrator to grant you the necessary privileges
*/

-- GRANT CREATE MATERIALIZED VIEW TO SCOTT;

CREATE MATERIALIZED VIEW TST_MView
    BUILD IMMEDIATE
    REFRESH
        COMPLETE
        ON DEMAND
ENABLE QUERY REWRITE AS
    SELECT
        a.ename,
        a.sal,
        a.dname
    FROM
        (
            SELECT
                a.ename,
                b.dname,
                a.sal,
                RANK() OVER(PARTITION BY
                    a.deptno
                    ORDER BY
                        a.sal
                    DESC
                ) AS ranking
            FROM
                emp a,
                dept b
            WHERE
                a.deptno = b.deptno
        ) a
    WHERE
        a.ranking = 1;
 
 
-- 이전 쿼리 실행하기
-- SQL : 0.011초 , COST : 3
SELECT A.ENAME,
      A.SAL,
      A.DNAME
  FROM (SELECT A.ENAME,
              B.DNAME,
              A.SAL,
              RANK() OVER (PARTITION BY A.DEPTNO
                ORDER BY A.SAL DESC) AS RANKING
          FROM EMP A,
              DEPT B
        WHERE A.DEPTNO = B.DEPTNO ) A
 WHERE A.RANKING = 1;
 
 
SELECT ENAME,SAL,DNAME FROM TST_MView;
 