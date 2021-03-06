GRANT QUERY REWRITE TO SCOTT;
REVOKE QUERY REWRITE FROM SCOTT;

GRANT CREATE MATERIALIZED VIEW TO SCOTT;
REVOKE CREATE MATERIALIZED VIEW FROM SCOTT;


SELECT A.ENAME,
      A.SAL,
      A.DNAME
  FROM (SELECT A.ENAME,
              B.DNAME,
              A.SAL,
              RANK() OVER (PARTITION BY A.DEPTNO
                ORDER BY A.SAL DESC) AS RANKING
          FROM SCOTT.EMP A,
              SCOTT.DEPT B
        WHERE A.DEPTNO = B.DEPTNO ) A
 WHERE A.RANKING = 1;
 
 
 SELECT ENAME,SAL,DNAME FROM SCOTT.TST_MView;