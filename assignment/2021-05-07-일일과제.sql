-- 05/07 일일 과제
-- 1번
SELECT E.ENAME||' ''S MANAGER IS '||NVL(M.ENAME, 'NOBODY') AS MANAGER
FROM EMP E,EMP M 
WHERE E.MGR = M.EMPNO(+) 
ORDER BY M.ENAME;

SELECT E.ENAME||' ''S MANAGER IS '||M.ENAME AS MANAGER
FROM EMP E,EMP M 
WHERE E.MGR = M.EMPNO(+) 
ORDER BY M.ENAME;

SELECT E.ENAME||' ''S MANAGER IS '||M.ENAME AS MANAGER
FROM EMP E,EMP M 
WHERE E.MGR = M.EMPNO
ORDER BY M.ENAME;

SELECT * FROM EMP;

SELECT E.ENAME,M.ENAME
FROM EMP E,EMP M 
WHERE E.MGR = M.EMPNO
ORDER BY M.ENAME;

SELECT E.*, M.*
FROM EMP E,EMP M 
WHERE E.MGR = M.EMPNO(+)
ORDER BY M.ENAME;

SELECT E.*, M.*
FROM EMP E,EMP M 
WHERE E.MGR(+) = M.EMPNO
ORDER BY M.ENAME;

SELECT E.ENAME,M.ENAME,E.*, M.*
FROM EMP E,EMP M 
WHERE E.MGR = M.EMPNO(+)
ORDER BY M.ENAME;

SELECT E.ENAME,M.ENAME, E.*, M.*
FROM EMP E,EMP M 
WHERE E.MGR(+) = M.EMPNO
ORDER BY M.ENAME;

-- 2번

-- MAKE_ENV.SQL
/*
DROP TABLE SYSTEM;
COMMIT;
CREATE TABLE SYSTEM( SYSTEM_ID VARCHAR2(5),
SYSTEM_NAME VARCHAR2(11)
);
INSERT INTO SYSTEM VALUES('XXX','혜화DB');
INSERT INTO SYSTEM VALUES('YYY','강남DB');
INSERT INTO SYSTEM VALUES('ZZZ','영등포DB');
CREATE TABLE RESOURCE_USAGE(SYSTEM_ID
VARCHAR2(5), 
RESOURCE_NAME VARCHAR2(10)
);
INSERT INTO RESOURCE_USAGE VALUES('XXX','FTP');
INSERT INTO RESOURCE_USAGE VALUES('YYY','FTP');
INSERT INTO RESOURCE_USAGE VALUES('YYY','TELNET');
INSERT INTO RESOURCE_USAGE VALUES('YYY','EMAIL');
COMMIT;
*/

SELECT * FROM SYSTEM;
SELECT * FROM RESOURCE_USAGE;

-- 11G부터는 WM_CONCAT 사용 불가
SELECT SYSTEM_ID, 
WM_CONCAT(RESOURCE_NAME)
FROM RESOURCE_USAGE 
GROUP BY SYSTEM_ID;

SELECT SYSTEM_ID, 
LISTAGG(RESOURCE_NAME,',') WITHIN GROUP(ORDER BY SYSTEM_ID)
FROM RESOURCE_USAGE;



SELECT S.*, R.RESOURCE_NAME
FROM SYSTEM S, RESOURCE_USAGE R
WHERE S.SYSTEM_ID = R.SYSTEM_ID(+);

SELECT S.*, R.RESOURCE_NAME, R.RESOURCE_NAME, R.RESOURCE_NAME
FROM SYSTEM S, RESOURCE_USAGE R
WHERE S.SYSTEM_ID = R.SYSTEM_ID(+);

SELECT S.SYSTEM_ID, S.SYSTEM_NAME, 
R.RESOURCE_NAME AS FTP, 
R.RESOURCE_NAME AS TELNET, 
R.RESOURCE_NAME AS EMAIL
FROM SYSTEM S, RESOURCE_USAGE R
WHERE S.SYSTEM_ID = R.SYSTEM_ID(+);



SELECT S.*, 
CASE 
    WHEN S.SYSTEM_ID = 'XXX' AND R.RESOURCE_NAME = 'FTP' THEN '사용'
    WHEN S.SYSTEM_ID = 'YYY' AND R.RESOURCE_NAME = 'FTP' THEN '사용'
    WHEN S.SYSTEM_ID = 'ZZZ' AND R.RESOURCE_NAME = 'FTP' THEN '사용'
    ELSE '미사용'
END AS FTP, 
CASE 
    WHEN S.SYSTEM_ID = 'XXX' AND R.RESOURCE_NAME = 'TELNET' THEN '사용'
    WHEN S.SYSTEM_ID = 'YYY' AND R.RESOURCE_NAME = 'TELNET' THEN '사용'
    WHEN S.SYSTEM_ID = 'ZZZ' AND R.RESOURCE_NAME = 'TELNET' THEN '사용'
    ELSE '미사용'
END AS TELNET, 
CASE 
    WHEN S.SYSTEM_ID = 'XXX' AND R.RESOURCE_NAME = 'EMAIL' THEN '사용'
    WHEN S.SYSTEM_ID = 'YYY' AND R.RESOURCE_NAME = 'EMAIL' THEN '사용'
    WHEN S.SYSTEM_ID = 'ZZZ' AND R.RESOURCE_NAME = 'EMAIL' THEN '사용'
    ELSE '미사용'
END AS EMAIL
FROM SYSTEM S, RESOURCE_USAGE R
WHERE S.SYSTEM_ID = R.SYSTEM_ID(+);

SELECT S.*, 
CASE 
    WHEN S.SYSTEM_ID = 'XXX' AND R.RESOURCE_NAME = 'FTP' THEN '사용'
    WHEN S.SYSTEM_ID = 'YYY' AND R.RESOURCE_NAME = 'FTP' THEN '사용'
    WHEN S.SYSTEM_ID = 'ZZZ' AND R.RESOURCE_NAME = 'FTP' THEN '사용'
    ELSE '미사용'
END AS FTP, 
CASE 
    WHEN S.SYSTEM_ID = 'XXX' AND R.RESOURCE_NAME = 'TELNET' THEN '사용'
    WHEN S.SYSTEM_ID = 'YYY' AND R.RESOURCE_NAME = 'TELNET' THEN '사용'
    WHEN S.SYSTEM_ID = 'ZZZ' AND R.RESOURCE_NAME = 'TELNET' THEN '사용'
    ELSE '미사용'
END AS TELNET, 
CASE 
    WHEN S.SYSTEM_ID = 'XXX' AND R.RESOURCE_NAME = 'EMAIL' THEN '사용'
    WHEN S.SYSTEM_ID = 'YYY' AND R.RESOURCE_NAME = 'EMAIL' THEN '사용'
    WHEN S.SYSTEM_ID = 'ZZZ' AND R.RESOURCE_NAME = 'EMAIL' THEN '사용'
    ELSE '미사용'
END AS EMAIL
FROM SYSTEM S, RESOURCE_USAGE R
WHERE S.SYSTEM_ID = R.SYSTEM_ID(+);



-- 답안
select  s.system_id, s.system_name,
        decode((select  count(*) 
                from    system s2, resource_usage r2
                where   s2.system_id = r2.system_id 
                        and s2.system_id = s.system_id 
                        and r2.resource_name = 'FTP'), 1, '사용','미사용') as ftp,
        decode((select  count(*) 
                from    system s2, resource_usage r2 
                where   s2.system_id = r2.system_id 
                        and s2.system_id = s.system_id 
                        and r2.resource_name = 'TELNET'), 1, '사용','미사용') as telnet,
        decode((select  count(*) 
                from    system s2, resource_usage r2
                where   s2.system_id = r2.system_id 
                        and s2.system_id = s.system_id 
                        and r2.resource_name = 'EMAIL'), 1, '사용','미사용') as email
from system s, resource_usage r
where s.system_id = r.system_id(+)
group by s.system_id, s.system_name
order by s.system_id;


-- 더 짧은 버전
select distinct s.system_id as system , s.system_name, 
decode(
    (select count(*) from RESOURCE_USAGE where system_id=s.system_id and RESOURCE_NAME = 'FTP'  ),1 ,'사용', '미사용') as FTP,
decode(
    (select count(*) from RESOURCE_USAGE where system_id=s.system_id and RESOURCE_NAME = 'TELNET'  ),1,'사용','미사용') as TELNET, 
decode(
    (select count(*) from RESOURCE_USAGE where system_id=s.system_id and RESOURCE_NAME = 'EMAIL'  ),1,'사용','미사용') as EMAIL 
from system s, RESOURCE_USAGE r 
where s.system_id = r.system_id(+)
ORDER BY S.SYSTEM_ID;


-- 3번
-- JOIN을 사용하여 부서별 급여 지급 순위를 구하여라
-- EMPNO, ENAME, JOB, MGR, HIREDATE, SAL,COMM, DEPTNO

-- JOIN을 활용한 방법은?

-- 카디너리합 => 오류
SELECT E1.DEPTNO, E1.ENAME, E2.DEPTNO, E2.ENAME, E1.SAL, E2.SAL, E1.EMPNO,E1.JOB, E1.MGR, E1.HIREDATE, E1.COMM
FROM EMP E1, EMP E2
ORDER BY E1.DEPTNO, E1.ENAME;

SELECT E1.DEPTNO, E1.ENAME, E2.DEPTNO, E2.ENAME, E1.SAL, E2.SAL, E1.EMPNO,E1.JOB, E1.MGR, E1.HIREDATE, E1.COMM
FROM EMP E1, EMP E2
WHERE E1.DEPTNO = E2.DEPTNO
ORDER BY E1.DEPTNO, E1.ENAME;

SELECT E1.DEPTNO, E1.ENAME,E1.JOB, E2.DEPTNO, E2.ENAME,E2.JOB, E1.SAL, E2.SAL
FROM EMP E1, EMP E2
WHERE E1.DEPTNO = E2.DEPTNO
ORDER BY E1.DEPTNO, E1.ENAME;

SELECT E1.DEPTNO, E1.ENAME,E1.JOB, E2.DEPTNO, E2.ENAME,E2.JOB, E1.SAL, E2.SAL
FROM EMP E1, EMP E2
WHERE E1.DEPTNO = E2.DEPTNO
GROUP BY E1.DEPTNO, E1. ENAME, E1. JOB, E2.DEPTNO, E2.ENAME,E2.JOB, E1.SAL, E2.SAL
ORDER BY E1.DEPTNO, E1.ENAME;

SELECT E1.DEPTNO, E1.ENAME,E1.JOB, E2.DEPTNO, E2.ENAME,E2.JOB, E1.SAL, E2.SAL, COUNT(*)
FROM EMP E1, EMP E2
WHERE E1.DEPTNO = E2.DEPTNO
GROUP BY E1.DEPTNO, E1. ENAME, E1. JOB, E2.DEPTNO, E2.ENAME,E2.JOB, E1.SAL, E2.SAL
ORDER BY E1.DEPTNO, E1.ENAME;

SELECT E1.DEPTNO, E1.ENAME,E1.JOB, E1.SAL, COUNT(*)
FROM EMP E1, EMP E2
WHERE E1.DEPTNO = E2.DEPTNO AND E1.SAL <= E2.SAL 
GROUP BY E1.DEPTNO, E1. ENAME, E1. JOB, E1.SAL 
ORDER BY E1.DEPTNO, COUNT(*);

-- 최종 답안 : 틀림, 동률인 애들 한 번씩 더 구함
SELECT E1.DEPTNO, E1.ENAME,E1.JOB, E1.SAL, COUNT(*)
FROM EMP E1, EMP E2
WHERE E1.DEPTNO = E2.DEPTNO AND E1.SAL <= E2.SAL 
GROUP BY E1.DEPTNO, E1. ENAME, E1. JOB, E1.SAL
ORDER BY E1.DEPTNO, COUNT(*) ASC;


-- 답안
SELECT E1.DEPTNO, E1.ENAME, E1.JOB, E1.SAL, 
    COUNT(DECODE(E1.DEPTNO, E2.DEPTNO,1)) + 1 as RANK 
FROM EMP E1, EMP E2
WHERE E1.SAL < E2.SAL(+)
GROUP BY E1.DEPTNO, E1.ENAME, E1.JOB, E1.SAL
ORDER BY DEPTNO, RANK;

-- 3.2 

-- DENSE_RANK를 활용한 방법
SELECT DEPTNO, ENAME, JOB, SAL, 
    DENSE_RANK() OVER (PARTITION BY DEPTNO ORDER BY SAL DESC) AS GRADE
FROM EMP ORDER BY DEPTNO, SAL DESC;


-- RANK를 사용한 방법
SELECT DEPTNO, ENAME, JOB, SAL,
    RANK() OVER (PARTITION BY DEPTNO ORDER BY SAL DESC) RANK
FROM EMP ORDER BY DEPTNO;
