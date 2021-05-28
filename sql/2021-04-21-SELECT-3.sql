-- <04/21>


---------------------------------------------------------------------------------
-- <ORDER BY>

-- 4. 정렬 기준 없을 때의 정렬은? 일반적으로는 INSERT된 순서이다.
SELECT ENAME, HIREDATE FROM EMP;


-- 5. Default 정렬 방향은? ASC이다.
SELECT ENAME, HIREDATE FROM EMP ORDER BY ENAME;


-- 6. ASC 정렬
-- asc를 명시해주는 것이 5번보다 가독성이 좋은 쿼리이다.
SELECT ENAME, HIREDATE FROM EMP ORDER BY ENAME asc;


-- 7. DESC 정렬
SELECT ENAME, HIREDATE FROM EMP ORDER BY ENAME desc;

-- 9. 정렬 기준 : Column명
SELECT ENAME, SAL, HIREDATE FROM EMP ORDER BY ENAME;


-- 10. 정렬 기준 : Column Position
-- column position을 정렬 기준으로 작성할 수도 있다.
-- 코드의 명료성이 떨어지는 방식으로 TEST CODE를 작성할 때만 사용하는 것을 권장한다.
SELECT ENAME, SAL, HIREDATE FROM EMP ORDER BY 2;


-- 11. 정렬 기준 : Column Alias
-- column의 heading ALIAS(별칭)도 정렬 기준으로 올 수 있다. 
SELECT ENAME, SAL*12 as annual_SAL FROM EMP ORDER BY annual_SAL;


-- 12. 정렬 기준 : 계산식
-- 정렬 기준으로 계산식도 올 수 있다.
SELECT EMPNO, ENAME, COMM, JOB FROM EMP ORDER BY COMM*12;


-- 13. 정렬 기준의 갯수 : 1개
SELECT DEPTNO, JOB, ENAME FROM EMP ORDER BY DEPTNO;


-- 14. 정렬 기준의 갯수 : 2개
-- DEPTNO로 먼저 asc 정렬 -> DEPTNO가 같으면 JOB으로 asc 정렬
SELECT DEPTNO, JOB, ENAME FROM EMP ORDER BY DEPTNO, JOB;


-- 15. 정렬 기준의 갯수 : 2개 + 정렬 방향 : 내림차순
-- DEPTNO으로 먼저 asc 정렬 -> DEPTNO가 같으면 JOB desc 정렬
SELECT DEPTNO, JOB, ENAME FROM EMP ORDER BY DEPTNO, JOB desc;


-- DEPTNO으로 먼저 desc 정렬 -> DEPTNO가 같으면 JOB asc 정렬
SELECT DEPTNO, JOB, ENAME FROM EMP ORDER BY DEPTNO desc, JOB asc;



---------------------------------------------------------------------------------
-- [요구] 선택하지 않은 column을 기준으로 정렬을 할 수 있는가?
-- 정렬할 수 있지만, 데이터가 보이지 않아서 의미가 없다.
SELECT ENAME, HIREDATE FROM EMP ORDER BY SAL;
SELECT SAL, ENAME, HIREDATE FROM EMP ORDER BY SAL;


---------------------------------------------------------------------------------
-- [요구] NULL은 가장 큰값인가? 데이터가 없기 때문에 가장 큰값이라고 할 수없음. 하지만 그런 것처럼 처리 되는 것 뿐이다.
SELECT EMPNO, COMM FROM EMP ORDER BY COMM asc;
SELECT EMPNO, COMM FROM EMP ORDER BY COMM desc;



---------------------------------------------------------------------------------
-- <DISTINCT>
-- 1. ALL : 전체 다 출력하기, ALL은 잘 안쓰인다. 
SELECT JOB FROM EMP;
SELECT ALL JOB FROM EMP;

-- 중복된 값 제외하고 유일한 값만 보여주는 두 가지 방식 : UNIQUE, DISTINCT
-- DISTINCT가 ANSI 표준일 뿐 둘의 차이는 없다.
-- 필터링의 기능만 있고, 데이터를 수정하지 않는다.

-- 2. UNIQUE
SELECT UNIQUE JOB FROM EMP;

-- 3. DISTINCT
-- Oracle 10이후 버전부터는 정렬된 결과가 나타나지 않는다.
SELECT DISTINCT JOB FROM EMP;


---------------------------------------------------------------------------------
-- 4. 순서쌍의 중복제거 원리 이해하기
-- DISTINCT 뒤에 두 개의 인자가 나오면 두개를 합쳐서 DISTINCT한 값들을 찾아냄
SELECT DISTINCT DEPTNO, JOB FROM EMP;
SELECT DEPTNO, JOB FROM EMP;


---------------------------------------------------------------------------------
-- 5. ORDER BY 와 비교해서 DISTINCT의 원리 이해해보기
-- DISTINCT는 원본 데이터에 순서와 동일하다
-- 원본데이터에서 쭉 순회하면서 중복되는 값은 제외하고 고유의 값들만 출력한다.
SELECT JOB FROM EMP ORDER BY JOB;
SELECT JOB FROM EMP;
SELECT DISTINCT JOB FROM EMP;


---------------------------------------------------------------------------------
-- 6~7. DISTINCT 연산자가 2번 나오면? 왜 에러가 나지? Syntax diagram 보고 이해하기
-- DISTINCT는 중복해서 사용할 수 없다.
SELECT DISTINCT JOB, DISTINCT DEPTNO FROM EMP;
SELECT JOB, DISTINCT DEPTNO FROM EMP; 


---------------------------------------------------------------------------------
-- 8. NULL이 있는 데이터는 포함하는 거야 빼는거야?
-- DISTINCT는 NULL도 하나의 군집으로 본다.
SELECT COMM FROM EMP WHERE COMM IS NOT NULL;
SELECT DISTINCT COMM FROM EMP;

-- 9. SQL*PLUS에서 실습하기


---------------------------------------------------------------------------------
-- <DECODE>
-- [동등비교]
-- 1. DECODE(expr1, expr2, expr3, expr4, expr5...) : expr1이 expr2이면 expr3,   expr1이 expr4이면 expr5...
SELECT DEPTNO, ENAME, DECODE(DEPTNO, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 'ETC') FROM EMP ORDER BY DEPTNO; 
SELECT DEPTNO, ENAME FROM EMP ORDER BY DEPTNO; 

-- 2. DECODE 조건에서 null을 찾으려면 null/NULL이라고 쓰면 된다.
SELECT COMM, DECODE(COMM, NULL, -99, COMM) FROM EMP;
SELECT COMM, DECODE(COMM, null, -99, COMM) FROM EMP;


---------------------------------------------------------------------------------
-- [범위비교]

-- 3. 
-- GREATEST() : 최대값 찾는 함수, LEAST() : 최소값 찾는 함수
SELECT GREATEST(3000, 1500, 2100, 5000, 10), LEAST(10, 3000, 1500, 2100, 5000) FROM DUAL;
 
-- GREATEST함수는 NULL이면 NULL을 반환한다.
SELECT COMM, GREATEST(COMM, 5000) FROM EMP ORDER BY COMM;

---------------------------------------------------------------------------------
-- DECODE는 기본적으로 동등비교만 가능하기 때문에 불편해서 DECODE 함수를 확장 개선한 것이 CASE이다. 
SELECT DEPTNO, ENAME, SAL, 
DECODE(GREATEST(SAL, 5000), SAL, 
    'HIGH', DECODE(GREATEST(SAL, 2500), SAL, 'MID', 'LOW')) 
FROM EMP ORDER BY DEPTNO;

-- DECODE에서 조건이 중복되면 앞의 것만 실행된다.
SELECT DEPTNO, ENAME, SAL, 
DECODE(GREATEST(SAL, 500), SAL, 
    'HIGH', DECODE(GREATEST(SAL, 2500), SAL, 'MID', 'LOW')) 
FROM EMP ORDER BY DEPTNO;


-- 4. DECODE에서 NULL은 어떻게 처리되는가? 

-- CASE 1. 아예 오류 처리가 나는가? X 오류가 발생하지 않는다.
-- CASE 2. ORDER BY처럼 처리하는 방법이 내부적으로 정해져 있나? O, 무조건 조건을 만족한다고 처리하는 것 같다.

SELECT DEPTNO, ENAME, SAL, COMM, 
DECODE(GREATEST(COMM, 5000), COMM, 
    'HIGH', DECODE(GREATEST(COMM,2500),COMM,'MID','LOW'))
FROM EMP ORDER BY DEPTNO;

/*
    NULLS FIRST
    NULLS LAST
*/

---------------------------------------------------------------------------------
-- SQL 내에서 NULL 처리해보기
-- 가장 OUTER DECODE에서 NULL이면 NULL을 출력하고 아니면 다른 DECODE를 수행하라.
SELECT DEPTNO, ENAME, SAL, COMM,
DECODE(COMM, NULL, NULL, 
    DECODE(GREATEST(COMM, 5000), COMM, 'HIGH', 
        DECODE(GREATEST(COMM,2500),COMM,'MID','LOW')
    )
) AS COMM_GRADE
FROM EMP ORDER BY DEPTNO;


---------------------------------------------------------------------------------
-- <CASE>

-- 5. CASE문 형식 : CASE WHEN ~ THEN ~[, WHEN ~ THEN ~, WHEN ~ THEN ~] ELSE ~ END
-- CASE의 조건에는 연산이 가능하다.
SELECT DEPTNO, ENAME, SAL, 
    CASE WHEN SAL >= 5000 THEN 'HIGH'
         WHEN SAL >= 2500 THEN 'MID'
         WHEN SAL < 2500 THEN 'LOW'
    ELSE
         'UNKNOWN'
    END
FROM EMP
ORDER BY DEPTNO;


-- CASE문의 WHEN 조건에는 BETWEEN 사용이 가능하다.
SELECT DEPTNO, ENAME, SAL, 
CASE 
    WHEN SAL >= 5000 THEN 'HIGH'
    WHEN SAL >= 2500 THEN 'MID'
    WHEN SAL BETWEEN 300 AND 2500 THEN 'LOW'
    ELSE 'UNKNOWN'
END AS grade
FROM EMP
ORDER BY DEPTNO;


-- CASE에서 NULL은 어떻게 처리되는가? 크기 비교시에는 ELSE에서 처리된다. 
SELECT DEPTNO, ENAME, SAL, COMM, 
CASE
    WHEN COMM >= 5000 THEN 'HIGH'
    WHEN COMM >= 500 THEN 'MID'
    WHEN COMM BETWEEN 0 AND 500 THEN 'LOW'
    ELSE 'UNKNOWN'
END as grade
FROM EMP
ORDER BY DEPTNO;


-- 6. CASE문을 가지고 DECODE처럼 사용할 수 있다.
SELECT DEPTNO, 
    CASE DEPTNO
        WHEN 10 THEN 'Accountion'
        WHEN 20 THEN 'Research'
        WHEN 30 THEN 'Sales'
        WHEN 40 THEN 'Operations'
        ELSE 'Unknown'
    END as DNAME
FROM EMP
ORDER BY DEPTNO;


-- 7~8. CASE문의 WHEN 조건이 중첩되는 경우 어떻게 처리되는가?
-- 7. 첫번째 조건과 중복되면 아래 조건을 수행하지 않고 바로 ELSE로 넘어간다.
SELECT SAL, 
CASE  
    WHEN SAL>= 1000 THEN 1
    WHEN SAL>= 2000 THEN 2
    WHEN SAL>= 3000 THEN 3
    WHEN SAL>= 4000 THEN 4
    WHEN SAL>= 5000 THEN 5
ELSE 0
END AS SAL_CHK
FROM EMP
ORDER BY SAL;


-- 8.CASE문에서는 앞의 조건을 만족하지 않는 결과에 대해서만 아래 조건을 수행한다. 
SELECT SAL, 
CASE
    WHEN SAL >= 5000 THEN 5
    WHEN SAL >= 4000 THEN 4
    WHEN SAL >= 3000 THEN 3
    WHEN SAL >= 2000 THEN 2
    WHEN SAL >= 1000 THEN 1
ELSE 0
END AS SAL_CHK
FROM EMP
ORDER BY SAL;


-- 9. NULLIF함수를 CASE를 가지고 SIMULATION해보기
SELECT JOB,
NULLIF(JOB,'MANAGER'),
    CASE
        WHEN JOB='MANAGER' THEN NULL
        ELSE JOB
    END AS NULLIF_SIM
FROM EMP;

---------------------------------------------------------------------------------
-- [요구] 부서별 차등 보너스 계산 SQL을 작성하시오.
    -- 10번 부서 급여의 0.3% , 20번부서 급여의 20%, 30번 부서 급여의 10%, 나머지 모든 부서 1%
    -- 부서 번호, 이름, 직무, 급여, 보너스
    -- 부서별, 최고 보너스 순으로 정렬
    -- 소수점 절삭  : ROUND, TRUNC 함수

-- 기본
SELECT DEPTNO, ENAME, JOB, SAL, COMM
FROM EMP
ORDER BY DEPTNO; 

-- CASE 중복 변수 처리 X
SELECT DEPTNO, ENAME, JOB, SAL,
CASE 
    WHEN DEPTNO=10 
        THEN SAL*1.003
    WHEN DEPTNO=20
        THEN SAL*1.2
    WHEN DEPTNO=30
        THEN SAL*1.1
    ELSE SAL*1.01
END AS bonus
FROM EMP
ORDER BY bonus; 

-- CASE 중복 변수 처리 X + ROUND() 반올림 함수 사용
SELECT DEPTNO, ENAME, JOB, SAL, COMM,
CASE WHEN DEPTNO=10 
    THEN ROUND(SAL*1.003)
    WHEN DEPTNO=20
    THEN SAL*1.2
    WHEN DEPTNO=30
    THEN SAL*1.1
    ELSE
        SAL*1.01
END AS bonus,
CASE WHEN DEPTNO=10 
    THEN SAL*1.003
    WHEN DEPTNO=20
    THEN SAL*1.2
    WHEN DEPTNO=30
    THEN SAL*1.1
    ELSE
        SAL*1.01
END AS bonus2
FROM EMP
ORDER BY bonus; 

-- CASE 중복 변수 처리 O
SELECT DEPTNO, ENAME, JOB, SAL,
CASE DEPTNO
    WHEN 10 
    THEN SAL*1.003
    WHEN 20
    THEN SAL*1.2
    WHEN 30
    THEN SAL*1.1
    ELSE
        SAL*1.01
END AS bonus
FROM EMP
ORDER BY bonus; 

-- CASE 중복 변수 처리 O + TRUC() 내림 함수
SELECT DEPTNO, ENAME, JOB, SAL,
CASE DEPTNO
    WHEN 10 
    THEN TRUNC(SAL*1.003)
    WHEN 20
    THEN SAL*1.2
    WHEN 30
    THEN SAL*1.1
    ELSE
        SAL*1.01
END AS bonus,
CASE DEPTNO
    WHEN 10 
    THEN SAL*1.003
    WHEN 20
    THEN SAL*1.2
    WHEN 30
    THEN SAL*1.1
    ELSE
        SAL*1.01
END AS bonus2
FROM EMP
ORDER BY bonus; 


---------------------------------------------------------------------------------
-- <ROWNUM>

-- 실행 순서 : WHERE   ->  ROWNUM   ->   ORDER BY

-- 1~2. ROWNUM이 ORDER BY보다 먼저 실행된다. 
SELECT ROWNUM, ENAME, DEPTNO, SAL FROM EMP;
SELECT ROWNUM, ENAME, DEPTNO, SAL FROM EMP ORDER BY DEPTNO, SAL;


-- WHERE 조건이 ROWNUM보다 먼저 실행된다.
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE DEPTNO=10;
SELECT ROWNUM, ENAME, DEPTNO, SAL FROM EMP WHERE DEPTNO=10;


-- 3. SELECT 문의 실행 순서 : ROWNUM이 ORDER BY보다 먼저 실행됨
-- WHERE 컬럼 IN(a, b) : WHERE 컬럼 = a OR 컬럼 = b
SELECT ROWNUM, ENAME, DEPTNO,SAL FROM EMP WHERE DEPTNO IN (10,20) ORDER BY DEPTNO, SAL;


-- 4. 조건절에서 ROWNUM 사용시 주의사항
SELECT ROWNUM,ENAME, DEPTNO, SAL FROM EMP;


-- WHERE 조건절에서 필터링이 된 후에 ROWNUM이 생성되기 때문에? 실행 불가이다. 
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM = 5;
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM > 5;
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM >= 5;

SELECT * FROM (SELECT ROWNUM as num, ENAME, DEPTNO, SAL FROM EMP) WHERE num = 5;
SELECT * FROM (SELECT ROWNUM AS num, ENAME, DEPTNO, SAL FROM EMP) WHERE num > 5;
SELECT * FROM (SELECT ROWNUM AS num, ENAME, DEPTNO, SAL FROM EMP) WHERE num >= 5;


-- 하지만 활용되는 빈도가 많기 때문에 아래 예시는 예외적으로 허용하는 CASE이다. 
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM = 1;
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM <= 5;
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM < 5;


---------------------------------------------------------------------------------
-- [요구] 최상위 급여자 5명을 조회하기


-- 전체 급여 순위
SELECT * FROM (SELECT DEPTNO, ENAME, SAL FROM EMP ORDER BY SAL DESC);


-- ROWNUM까지 상위 5명만 출력하고 싶다면
SELECT 
    ROWNUM, DEPTNO, ENAME, SAL 
FROM 
    (SELECT DEPTNO, ENAME, SAL FROM EMP ORDER BY SAL DESC) 
WHERE 
    ROWNUM <= 5 ORDER BY ROWNUM;
    
    
SELECT 
    ROWNUM, DEPTNO, ENAME, SAL 
FROM 
    (SELECT DEPTNO, ENAME, SAL, ROWNUM AS NUM FROM EMP ORDER BY SAL DESC) 
WHERE 
    NUM <= 5 ORDER BY ROWNUM;
    


-- * 를 사용한 상위 5명의 데이터 출력
SELECT * 
FROM 
    (SELECT DEPTNO, ENAME, SAL FROM EMP ORDER BY SAL DESC) 
WHERE 
    ROWNUM <= 5 ORDER BY ROWNUM;


---------------------------------------------------------------------------------
-- <논리 연산자>

-- 5. AND 연산 
SELECT ENAME, JOB, SAL, DEPTNO FROM EMP WHERE DEPTNO=10 AND SAL > 2000;


-- 6. OR 연산
SELECT ENAME, JOB, SAL, DEPTNO FROM EMP WHERE DEPTNO = 10 OR SAL > 2000;


-- 같은 조건을 OR로 연결하면? 한 번만 수행한다. 
SELECT ENAME, JOB, SAL, DEPTNO FROM EMP WHERE SAL > 2000;
SELECT ENAME, JOB, SAL, DEPTNO FROM EMP WHERE SAL > 2000 OR SAL > 2000;


-- 하위 조건과 상위조건을 OR로 연결하면?
SELECT ENAME, JOB, SAL, DEPTNO FROM EMP WHERE SAL > 1000 OR SAL > 2000;


---------------------------------------------------------------------------------
-- 7.
-- WHERE A and B or C : A and B / B or C 중에 무엇이 실행 우선 순위가 높은가? AND가 연산자 우선 순위가 높다. 

-- 1) AND -> OR
SELECT ENAME, JOB, SAL, DEPTNO FROM EMP 
WHERE DEPTNO=10 AND SAL > 2000 OR JOB = 'CLERK';

SELECT ENAME, JOB, SAL, DEPTNO FROM EMP 
WHERE (DEPTNO=10 AND SAL > 2000) OR JOB = 'CLERK';

SELECT ENAME, JOB, SAL, DEPTNO FROM EMP 
WHERE DEPTNO=10 AND (SAL > 2000 OR JOB = 'CLERK');


-- 2) OR -> AND
SELECT ENAME, JOB, SAL, DEPTNO FROM EMP 
WHERE DEPTNO=10 OR SAL > 2000 AND JOB = 'CLERK';

SELECT ENAME, JOB, SAL, DEPTNO FROM EMP 
WHERE DEPTNO=10 OR (SAL > 2000 AND JOB = 'CLERK');

SELECT ENAME, JOB, SAL, DEPTNO FROM EMP 
WHERE (DEPTNO=10 OR SAL > 2000) AND JOB = 'CLERK';

-- 연산자 우선순위를 외워서 쓰는 방식은 좋은 쿼리가 아니다.
-- ()를 쳐서 우선 순위를 표현해 주는 것이 좋다.

-- SQL은 비 절차적 언어이지만 OPTIMIZER는 DBMS 내부에서 처리 방법과 처리 순서의 가장 효율적인 방법을 찾아주는 역할을 한다. 
-- Optimizer는 누구를 더 좋아할까? AND
-- AND연산을 먼저 처리하면 처리해야 할 중간 데이터의 집합이 줄어들기 때문이다.
-- 예) [1건 AND 1만건] => 최소 0 ~ 최대 1건 , [1건 OR 1만건] => 최소 1만건 ~ 최대 1만1건 


-- 8. ()를 쳐서 연산자 우선 순위를 명확하게 표현해 주는 것이 좋다.
SELECT ENAME, JOB, SAL, DEPTNO FROM EMP
WHERE (DEPTNO = 10 AND SAL > 2000) OR JOB = 'CLERK';

SELECT ENAME, JOB, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10 AND SAL > 2000 OR JOB = 'CLERK';


---------------------------------------------------------------------------------
-- 9. 
-- Oracle의 '같지 않다' 연산자 : != , ^= , <>
SELECT ENAME, JOB, SAL FROM EMP WHERE JOB !='CLERK';


---------------------------------------------------------------------------------
-- LIST 연산자
-- IN(a, b) : a OR b  
SELECT ENAME, JOB, SAL FROM EMP WHERE JOB = 'CLERK' OR JOB = 'MANAGER';
SELECT ENAME, JOB, SAL FROM EMP WHERE JOB IN('CLERK', 'MANAGER');

-- NOT IN(a, b) : a AND b가 아닌
SELECT ENAME, JOB, SAL FROM EMP WHERE JOB != 'CLERK' AND JOB != 'MANAGER';
SELECT ENAME, JOB, SAL FROM EMP WHERE JOB NOT IN('CLERK', 'MANAGER');


---------------------------------------------------------------------------------
-- 10. AND, OR 연산자 차이 비교
SELECT ENAME, JOB, SAL FROM EMP WHERE SAL > 2000 OR JOB = 'CLERK';
SELECT ENAME, JOB, SAL FROM EMP WHERE SAL > 2000 AND JOB = 'CLERK';

-- [요구]'OR 연산' 시 중복되는 ROW는 어떻게 처리되는가?
-- case 1 : 중복되어 출력된다. X
-- case 2 : 한 번만 출력된다. O
SELECT DEPTNO, JOB, ENAME FROM EMP WHERE DEPTNO = 20;
SELECT DEPTNO, JOB, ENAME FROM EMP WHERE JOB = 'CLERK';
SELECT DEPTNO, JOB, ENAME FROM EMP WHERE DEPTNO = 20 OR JOB = 'CLERK';


---------------------------------------------------------------------------------
-- <집합연산자>

-- UNION : 합집합
-- UNION ALL : 중복 포함 합집합
-- MINUS : 먼저 위치한 SELECT문을 기준으로 차집합을 추출
-- INTERSECT : 교집합

---------------------------------------------------------------------------------
-- [요구] 집합연산자(UNION, UNION ALL, MINUS, INTERSECT) 중 하나를 사용하여 위 2개 SQL에서의 중복된 데이터를 찾으시오


-- INTERSECT 교집합
SELECT DEPTNO, JOB, ENAME FROM EMP WHERE DEPTNO = 20 
INTERSECT 
SELECT DEPTNO, JOB, ENAME FROM EMP WHERE JOB = 'CLERK';


-- UNION 합집합
SELECT DEPTNO, JOB, ENAME FROM EMP WHERE DEPTNO = 20 
UNION
SELECT DEPTNO, JOB, ENAME FROM EMP WHERE JOB = 'CLERK';


-- UNION ALL 중복포함 합집합
SELECT DEPTNO, JOB, ENAME FROM EMP WHERE DEPTNO = 20 
UNION ALL
SELECT DEPTNO, JOB, ENAME FROM EMP WHERE JOB = 'CLERK';


-- MINUS 차집합
SELECT DEPTNO, JOB, ENAME FROM EMP WHERE DEPTNO = 20 
MINUS
SELECT DEPTNO, JOB, ENAME FROM EMP WHERE JOB = 'CLERK';


---------------------------------------------------------------------------------
-- [요구] UNION ALL 집합 연산자를 사용하여 OR와 동일한 결과를 생성하는 SQL을 작성 하십시오
-- 중복 데이터가 여러번 출력됨 => SUBQUERY와 DISTINCT 사용하기
SELECT DISTINCT * 
FROM (
    SELECT DEPTNO, JOB, ENAME FROM EMP WHERE DEPTNO = 20
    UNION ALL 
    SELECT DEPTNO, JOB, ENAME FROM EMP WHERE JOB = 'CLERK'
)
ORDER BY DEPTNO asc;

