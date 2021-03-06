-- <05/07>

--------------------------------------------------------------------------------
-- [ JOIN ]

-- 실습 환경 확인
SELECT * FROM TAB;
DESC EMP;
DESC DEPT;
DESC SALGRADE;

--------------------------------------------------------------------------------
-- [EQUI-JOIN (SIMPLE JOIN, INNER JOIN)]

-- 1. 열의 정의가 애매한 경우
-- 두 테이블에 같은 이름의 컬럼이 있을때 발생!
SELECT DNAME, ENAME, DEPTNO, JOB, SAL FROM EMP, DEPT WHERE DEPTNO = DEPTNO;


-- 2. 같은 컬럼명에만 테이블을 명시해주면 됨
SELECT DNAME, ENAME, JOB, SAL FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;


-- 3. WHERE 조건의 처리 순서는?

-- WHERE 조건으로 필터링이 먼저 되고, JOIN이 나중에 된다. 
-- 필터링을 통해 테이블을 축소시킨 후, JOIN하는 것이 더 효율적이기 때문이다. 

SELECT DNAME, ENAME, JOB, SAL FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO AND
        EMP.JOB IN ('MANAGER', 'CLERK')
ORDER BY DNAME;


-- 4. 

/*
- OBJECT NAME 표기법 : [SCHEMA.]OBJECT_NAME 
    - EX) SCOTT.EMP, EMP
- COLUMN NAME 표기법 : [TABLE_NAME.]COLUMN_NAME
    - EX) EMP.EMPNO, EMPNO
*/
SELECT DEPT.DNAME, EMP.ENAME, EMP.JOB, EMP.SAL 
FROM EMP, DEPT 
WHERE EMP.DEPTNO = DEPT.DEPTNO;


-- 1. TABLE ALIAS
SELECT D.DNAME, E.ENAME, E.JOB, E.SAL FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO;


--------------------------------------------------------------------------------
-- [ANSI/ISO : EQUI-JOIN]

-- 2. ON JOIN 조건 표기
SELECT D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;


-- 3. WHERE 조건
SELECT D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO IN (10, 20) AND D.DNAME = 'RESEARCH';


SELECT D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E 
INNER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO 
        AND E.DEPTNO IN (10, 20) 
        AND D.DNAME = 'RESEARCH';


--------------------------------------------------------------------------------
-- [NON EQUI-JOIN]
-- EQUAL(=) 이외의 연산자를 사용하여 JOIN


-- 4. 직원목록과 급여 등급을 구하시오
SELECT 
    E.ENAME, E.JOB, E.SAL, S.GRADE 
FROM 
    EMP E, SALGRADE S
WHERE 
    E.SAL BETWEEN S.LOSAL AND S.HISAL;


-- 5. 부서이름, 직원목록, 급여등급을 출력하시오

/*
    - 3개 테이블 JOIN할 때 필요한 최소 조건 갯수는?
    - 2개이다.
    - N개 테이블을 JOIN한다면, (N-1)개의 조건이 필요하다.
*/

SELECT 
    DNAME, ENAME, JOB, SAL, GRADE 
FROM 
    EMP E, DEPT D, SALGRADE S
WHERE 
    E.DEPTNO = D.DEPTNO 
AND 
    E.SAL BETWEEN S.LOSAL AND S.HISAL;


--------------------------------------------------------------------------------
-- 6. 부서가 10, 30인 사원들의 이름, 직무, 급여, 급여등급을 출력하시오

SELECT E.ENAME, E.JOB, E.SAL, S.GRADE 
FROM 
    EMP E, SALGRADE S
WHERE 
    E.SAL BETWEEN S.LOSAL AND S.HISAL AND E.DEPTNO IN (10, 30)
ORDER BY E.ENAME;



-- 7. 부서가 10, 30인 사원들 중, SAL이 LOWSAL보다 낮을 때의 이름, 직무, 급여, 등급을 출력하시오
SELECT 
    E.ENAME, E.JOB, E.SAL, S.GRADE 
FROM 
    EMP E, SALGRADE S
WHERE 
    E.SAL < S.LOSAL AND E.DEPTNO IN (10, 30)
ORDER BY 
    E.ENAME;

SELECT * FROM EMP;
SELECT * FROM SALGRADE;

SELECT E.DEPTNO, E.ENAME, E.JOB, E.SAL, S.GRADE 
FROM EMP E, SALGRADE S
WHERE E.SAL < S.LOSAL AND E.DEPTNO IN (10, 20)
ORDER BY E.ENAME;



--------------------------------------------------------------------------------
--[OUTER-JOIN]

-- OUT SIDER의 정보를 주겠다.
-- JOIN 조건에 만족되지 않는 정보도 조회된다. 


-- 8. 부서이름, 사원이름, 직무, 급여를 출력하시오 
-- INNER JOIN , EQUI-JOIN
SELECT 
    D.DNAME, E.ENAME, E.JOB, E.SAL 
FROM 
    EMP E, DEPT D
WHERE 
    E.DEPTNO = D.DEPTNO
ORDER BY 
    D.DNAME;


-- 9. 부서번호, 부서이름, 사원이름, 직무, 급여를 출력하시오
SELECT 
    D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM 
    EMP E, DEPT D
WHERE 
    E.DEPTNO = D.DEPTNO
ORDER BY 
    D.DEPTNO;


-- 10. 부서이름, 사원이름, 직업, 급여를 출력하는데, 직원이 없는 부서는 NULL로 표시하고 부서이름 순으로 오름차순해라

-- RIGHT OUTER JOIN
-- DEPT 전체 출력
SELECT * FROM DEPT;
SELECT * FROM EMP;

SELECT 
    D.DNAME, E.ENAME, E.JOB, E.SAL 
FROM 
    EMP E, DEPT D
WHERE 
    E.DEPTNO(+) = D.DEPTNO
ORDER BY 
    D.DNAME;
    
    
SELECT 
    D.DNAME, E.ENAME, E.JOB, E.SAL 
FROM 
    EMP E
RIGHT OUTER JOIN    
    DEPT D
ON
    E.DEPTNO = D.DEPTNO
ORDER BY 
    D.DNAME;
    


-- 11. 부서이름, 사원이름, 직업, 급여를 출력하는데, 직원이 없는 부서는 NULL로 표시하고 부서번호 순으로 오름차순해라
-- DEPT 전체 출력
SELECT 
    D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM 
    EMP E, DEPT D
WHERE 
    E.DEPTNO(+) = D.DEPTNO
ORDER BY 
    D.DEPTNO;
    
    

-- 12. 부서이름, 사원이름, 직무, 급여를 출력하시오. 단, 부서가 없는 직원까지 출력하고, 부서이름 순으로 정렬하시오

-- LEFT OUTER JOIN
-- EMP 전체 출력
SELECT 
    D.DNAME, E.ENAME, E.JOB, E.SAL 
FROM 
    EMP E, DEPT D
WHERE 
    E.DEPTNO = D.DEPTNO (+)
ORDER BY 
    D.DNAME;


SELECT 
    D.DNAME, E.ENAME, E.JOB, E.SAL 
FROM 
    EMP E
LEFT OUTER JOIN    
    DEPT D
ON
    E.DEPTNO = D.DEPTNO
ORDER BY 
    D.DNAME;



-- 13. 부서이름, 직원이름, 직업, 급여를 출력하시오.

-- 부서이름, 직원이름, 직업, 급여를 출력하고, 사원이 없는 부서는 '비상근부서'로 출력하시오

-- RIGHT JOIN
-- DEPT 전체 출력
-- NVL( A, B) : A가 NULL이면 B 출력하고, 디폴트로는 A출력

SELECT 
    D.DNAME, NVL(E.ENAME, '비상근부서'), E.JOB, E.SAL 
FROM 
    EMP E, DEPT D
WHERE 
    E.DEPTNO(+) = D.DEPTNO
ORDER BY 
    D.DNAME;


-- 14. ORA-01468 : outer-join된 테이블은 1개만 지정할 수 있습니다. 
SELECT 
    D.DNAME, E.ENAME, E.JOB, E.SAL 
FROM 
    EMP E, DEPT D
WHERE 
    E.DEPTNO(+) = D.DEPTNO(+)
ORDER BY 
    D.DNAME;
    

-- FULL OUTER JOIN
SELECT 
    D.DNAME, E.ENAME, E.JOB, E.SAL 
FROM 
    EMP E
FULL OUTER JOIN 
    DEPT D
ON 
    E.DEPTNO = D.DEPTNO
ORDER BY 
    D.DNAME;


--------------------------------------------------------------------------------
-- [요구] 아래의 2개 SQL을 실행하여 데이터를 비교 한후 원하는 결과집합이 나오도록 2번째 SQL을 수정 하십시오
-- [의도] 결과는 같게 나오지만, 아래 SQL은 불필요한 OUTER JOIN을 수행했기 때문에 성능저하를 일으킨다. 왜 그럴까?

SET AUTOTRACE ON
SELECT 
    D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL 
FROM 
    EMP E, DEPT D
WHERE 
    E.DEPTNO = D.DEPTNO 
AND
    E.SAL > 2000
ORDER BY D.DNAME;


SET AUTOTRACE ON
SELECT 
    D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL 
FROM 
    EMP E, DEPT D
WHERE 
    E.DEPTNO (+) = D.DEPTNO 
AND 
    E.SAL > 2000
ORDER BY 
    D.DNAME;


--------------------------------------------------------------------------------
-- [ANSI-SQL : LEFT OUTER JOIN , RIGHT OUTER JOIN , FULL OUTER JOIN]
-- 1. LEFT OUTER JOIN
-- EMP를 기준 테이블(Driving Table)
SELECT E.DEPTNO, D.DNAME, E.ENAME
FROM SCOTT.EMP E LEFT OUTER JOIN SCOTT.DEPT D
ON E.DEPTNO = D.DEPTNO
ORDER BY E.DEPTNO;


SELECT E.DEPTNO, D.DNAME, E.ENAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO (+)
ORDER BY E.DEPTNO;


SELECT D.DEPTNO, D.DNAME, E.ENAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO (+)
ORDER BY E.DEPTNO;



-- 2. RIGHT OUTER JOIN :  E.DEPTNO
-- DEPT을 기준 테이블(Driving Table)
SELECT E.DEPTNO, D.DNAME, E.ENAME
FROM SCOTT.EMP E RIGHT OUTER JOIN SCOTT.DEPT D
ON E.DEPTNO = D.DEPTNO
ORDER BY E.DEPTNO;


SELECT E.DEPTNO, D.DNAME, E.ENAME
FROM EMP E, DEPT D
WHERE E.DEPTNO (+) = D.DEPTNO
ORDER BY E.DEPTNO;


-- 3. RIGHT OUTER JOIN : D.DEPTNO
-- DEPT을 기준 테이블(Driving Table)
SELECT D.DEPTNO,D.DNAME,E.ENAME 
FROM SCOTT.EMP E RIGHT OUTER JOIN SCOTT.DEPT D
ON E.DEPTNO = D.DEPTNO
ORDER BY E.DEPTNO;


SELECT D.DEPTNO, D.DNAME, E.ENAME
FROM EMP E, DEPT D
WHERE E.DEPTNO (+) = D.DEPTNO
ORDER BY E.DEPTNO;


-- 4. FULL OUTER JOIN
-- ANSI JOIN에서만 제공되는 기능이다.
SELECT D.DEPTNO, D.DNAME, E.ENAME
FROM SCOTT.EMP E FULL OUTER JOIN SCOTT.DEPT D
ON E.DEPTNO = D.DEPTNO
ORDER BY E.DEPTNO;


-- ORACLE JOIN에서는 제공하지 않는 기능이다.
SELECT D.DEPTNO, D.DNAME, E.ENAME
FROM EMP E, DEPT D
WHERE E.DEPTNO (+) = D.DEPTNO (+)
ORDER BY E.DEPTNO;



--------------------------------------------------------------------------------
-- [SELF-JOIN]
SELECT E.ENAME||' ''S MANAGER IS '||M.ENAME
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO
ORDER BY M.ENAME;


SELECT E.ENAME||' ''S MANAGER IS '||M.ENAME
FROM EMP E, EMP M
WHERE E.MGR (+) = M.EMPNO
ORDER BY M.ENAME;



SELECT E.ENAME||' ''S MANAGER IS '||M.ENAME
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO (+)
ORDER BY M.ENAME;


SELECT E.ENAME||' ''S MANAGER IS '||NVL(M.ENAME, 'NOBODY')
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO (+)
ORDER BY M.ENAME;


--------------------------------------------------------------------------------
-- [카디션 곱]


-- 1. 14 * 6 = 84개
SELECT ENAME, JOB, DNAME FROM EMP, DEPT;

SELECT COUNT(*) FROM EMP; -- 14
SELECT COUNT(*) FROM DEPT; -- 6


-- 2. 
-- 결과 : 24개
SELECT ENAME, JOB, DNAME FROM EMP, DEPT
WHERE EMP.SAL > 2000;

-- 결과 : 8개
SELECT ENAME, JOB, DNAME FROM EMP, DEPT
WHERE EMP.SAL > 2000 AND DEPT.DEPTNO IN (10, 20);


-- 3. 
-- 결과 : 44개
SELECT ENAME, JOB, DNAME FROM EMP, DEPT
WHERE EMP.SAL > 2000 OR DEPT.DEPTNO IN (10, 20);


-- 4. 
-- 결과 : 30개
SELECT E.ENAME, E.JOB, E.SAL, S.GRADE FROM EMP E, SALGRADE S
WHERE E.SAL < S.LOSAL  AND E.DEPTNO IN (10, 30);



--------------------------------------------------------------------------------
-- [일일과제] FTP
SELECT * FROM RESOURCE_USAGE;
SELECT * FROM SYSTEM;

/*
  RESOURCE_USAGE       SYSTEM
*/

/*
SELECT 
    R.SYSTEM_ID, 
    () AS FTP, 
    () AS YYY, 
    () AS ZZZ
FROM 
    RESOURCE_USAGE R, SYSTEM S
WHERE 
    R.SYSTEM_ID (+) = S.SYSTEM_ID
ORDER BY
    R.SYSTEM_ID, S.SYSTEM_ID;
*/

/*
SELECT *
FROM 
    RESOURCE_USAGE R, SYSTEM S
WHERE 
    R.SYSTEM_ID (+) = S.SYSTEM_ID
ORDER BY
    R.SYSTEM_ID, S.SYSTEM_ID;
*/

SELECT *
FROM 
    RESOURCE_USAGE R, SYSTEM S
WHERE 
    R.SYSTEM_ID (+) = S.SYSTEM_ID
ORDER BY
    R.SYSTEM_ID, S.SYSTEM_ID;


-- 정답
SELECT  
    distinct S.SYSTEM_ID as system , S.SYSTEM_NAME,
    (DECODE((SELECT COUNT(*) FROM RESOURCE_USAGE WHERE SYSTEM_ID = R.SYSTEM_ID AND RESOURCE_NAME = 'FTP'), 1, '사용', '미사용')) AS FTP, 
    (DECODE((SELECT COUNT(*) FROM RESOURCE_USAGE WHERE SYSTEM_ID = R.SYSTEM_ID AND RESOURCE_NAME = 'TELNET'), 1, '사용', '미사용')) AS YYY, 
    (DECODE((SELECT COUNT(*) FROM RESOURCE_USAGE WHERE SYSTEM_ID = R.SYSTEM_ID AND RESOURCE_NAME = 'EMAIL'), 1, '사용', '미사용')) AS ZZZ
FROM 
    RESOURCE_USAGE R, SYSTEM S
WHERE 
    R.SYSTEM_ID (+) = S.SYSTEM_ID
ORDER BY
    S.SYSTEM_ID;


/*
SELECT SYSTEM_ID, SYSTEM_NAME,
() AS FTP,
() AS TELNET,
() AS EMAIL
FROM SYSTEM S, RESOURCE_USAGE R;
*/

SELECT DISTINCT S.SYSTEM_ID, S.SYSTEM_NAME, R.RESOURCE_NAME
FROM SYSTEM S, RESOURCE_USAGE R
WHERE S.SYSTEM_ID = R.SYSTEM_ID(+);

SELECT DISTINCT S.SYSTEM_ID, S.SYSTEM_NAME
FROM SYSTEM S, RESOURCE_USAGE R
WHERE S.SYSTEM_ID = R.SYSTEM_ID(+);

SELECT DISTINCT S.SYSTEM_ID, S.SYSTEM_NAME,
decode(
    (SELECT COUNT(*) FROM RESOURCE_USAGE WHERE SYSTEM_ID = S.SYSTEM_ID AND RESOURCE_NAME = 'FTP'),1, '사용', '미사용'
) AS FTP,
decode(
    (SELECT COUNT(*) FROM RESOURCE_USAGE WHERE SYSTEM_ID = S.SYSTEM_ID AND RESOURCE_NAME = 'TELNET'),1, '사용', '미사용'
) AS TELNET,
decode(
    (SELECT COUNT(*) FROM RESOURCE_USAGE WHERE SYSTEM_ID = S.SYSTEM_ID AND RESOURCE_NAME = 'EMAIL'),1, '사용', '미사용'
) AS EMAIL
FROM SYSTEM S, RESOURCE_USAGE R
WHERE S.SYSTEM_ID = R.SYSTEM_ID(+) 
GROUP BY S.SYSTEM_ID, S.SYSTEM_NAME;