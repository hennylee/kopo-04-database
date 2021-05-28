-- <04/23>

---------------------------------------------------------------------------------
-- [BETWEEN 연산자]
-- 1. 연봉이 1000과 2000사이 찾기
SELECT EMPNO, ENAME, SAL FROM EMP WHERE SAL BETWEEN 1000 AND 2000;


-- 2. BETWEEN과 OR는 성능 차이가 있을까?
-- X, 없다.
SELECT EMPNO, ENAME, SAL FROM EMP WHERE SAL >= 1000 and SAL <=2000;


-- 3. [between 작은값 and 큰값]의 순서를 잘 지켜야 한다. 
SELECT EMPNO, ENAME, HIREDATE, SAL FROM EMP WHERE SAL between 2000 and 1000;


-- 4. BETWEEN 조건에 문자가 들어가면 어떻게 될까?
-- 대소비교와 같이 해당 문자 사이의 글자로 시작되는 결과를 찾는다.
SELECT EMPNO, ENAME, HIREDATE, SAL FROM EMP WHERE ENAME between 'C' and 'K';


-- 5. BETWEEN 조건에 문자가 들어가면 어떻게 될까?
-- 대소비교와 같이 처리된다. 
SELECT EMPNO, HIREDATE, SAL FROM EMP WHERE HIREDATE between '81/02/20' and '82/12/09';



---------------------------------------------------------------------------------
-- 6~7. rr과 yy의 차이는?
-- 6. to_date와 to_char의 차이는?

SELECT ENAME, HIREDATE, SAL FROM EMP
WHERE HIREDATE between to_date('81/02/20', 'rr/mm/dd') and to_date('82/12/09', 'rr/mm/dd');


-- 7.
SELECT ENAME, HIREDATE, SAL FROM EMP WHERE HIREDATE between to_date('81/02/20','rr/mm/dd') 
and to_date('82/12/09','rr/mm/dd');


---------------------------------------------------------------------------------

-- [IN 연산자]
-- 8. IN 연산자란?
SELECT EMPNO, ENAME, JOB FROM EMP WHERE EMPNO IN (7369,7521,7654);


-- 9. OR와의 성능차이는?
-- X, 없다
SELECT EMPNO, ENAME, JOB FROM EMP WHERE EMPNO = 7369 or EMPNO = 7521 or EMPNO = 7654;


---------------------------------------------------------------------------------
-- 10. 데이터는 대소문자를 구분한다.
SELECT EMPNO, ENAME, JOB FROM EMP WHERE JOB in ('clerk', 'manager');


-- 11. 날짜와 문자의 암시적 형변환
-- 결과가 정상적으로 나오나요? O
-- 변환이 DBMS 내부적으로 잘 이루어졌나보네요?
SELECT EMPNO, ENAME, HIREDATE FROM EMP WHERE HIREDATE IN ('81/05/01', '81/02/20');


---------------------------------------------------------------------------------
-- 12. 다중 컬럼 리스트
SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE (JOB, DEPTNO) in (('MANAGER',20), ('CLERK',20));


-- 13. 중복된 것은 한 번만 나온다.
-- 왜 중복된 것은 한 번만 나올까?
-- A or B : 합집합이기 때문이다.
SELECT EMPNO, ENAME, JOB FROM EMP WHERE EMPNO IN(7369,7369,7654);



---------------------------------------------------------------------------------
-- [ANY, ALL] 
-- 수업 때 건너 뜀


---------------------------------------------------------------------------------
-- [LIKE]

-- 7. 이름이 A로 시작하는 사원은? 
SELECT ENAME FROM EMP WHERE ENAME like 'A%';


-- 8. 이름의 두번째 글자가 A인 사원은?
SELECT ENAME FROM EMP WHERE ENAME like '_A%';


-- 9. 이름에 L과 E가 있는 사원은?
-- L로 시작하거나 E로 끝나는 사람도 포함인가?
SELECT ENAME FROM EMP;
SELECT ENAME FROM EMP WHERE ENAME like '%L%E%';


-- 10. 이름에 LE가 있는 사원은?
-- LE로 시작하거나 끝나도 되나?
SELECT ENAME FROM EMP WHERE ENAME like '%LE%';


-- 11. 이름에 A가 있는 사원은?
-- A로 시작하거나 끝나도 되나? 
-- O
SELECT ENAME FROM EMP WHERE ENAME like '%A%';


-- 12. 이름에 A가 없는 사원은?
SELECT ENAME FROM EMP WHERE ENAME NOT like '%A%';


---------------------------------------------------------------------------------
-- 13~15. 잘 구분해야 함

-- 13. 날짜와 문자
-- 충돌나나요? X
-- 무엇이 무엇으로 형변환 됐나요?
-- LIKE 뒤에는 무조건 문자가 와야하기 때문에 HIREDATE가 형변환 되는 것이다.
SELECT ENAME, HIREDATE FROM EMP WHERE HIREDATE like '81%';


---------------------------------------------------------------------------------
-- 14. 숫자와 %
-- 에러발생
-- LIKE 뒤에는 문자가 와야해서 오류가 발생한다.
SELECT ENAME, SAL FROM EMP WHERE SAL like 2%;


---------------------------------------------------------------------------------
-- 15. 숫자와 문자
-- 숫자와 문자가 충돌나면?
-- 오라클 DBMS는 숫자를 좋아한다.

-- LIKE에서도 문자가 숫자로 암시적 형변환 될까? NO
-- 여기서는 숫자가 문자로 변환된다.
-- 누가 연산자 우선순위가 높은 걸까?
SELECT ENAME, SAL FROM EMP WHERE SAL like '2%';


---------------------------------------------------------------------------------
-- [요구] 이름에 _가 들어가 있는 사원들을 전부 찾고 싶다. 방법은?
-- 연산자를 사이에 두고 Lvalue와 Rvalue

-- [번외] CUSTOMER 테이블에서 고객 정보 조회하기
SELECT * FROM CUSTOMER;
SELECT * FROM CUSTOMER WHERE NAME LIKE '김%';
SELECT * FROM CUSTOMER WHERE NAME = '전지현';
SELECT * FROM CUSTOMER WHERE NAME = '전지현' AND ADDRESS1 LIKE '서울%';
