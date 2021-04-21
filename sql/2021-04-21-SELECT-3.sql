-- <04/21>
-- <ORDER BY>
-- 4. 정렬 기준 없을 때의 정렬은? 일반적으로는 INSERT된 순서이다.
SELECT ENAME, HIREDATE FROM EMP;

-- 5. Default 정렬 방향은? ASC이다.
SELECT ENAME, HIREDATE FROM EMP ORDER BY ENAME;

-- 6. ASC 정렬
-- 5번보다 가독성이 좋은 쿼리이다.
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

-- [요구] 선택하지 않은 column을 기준으로 정렬을 할 수 있는가?
-- 정렬할 수 있지만, 데이터가 보이지 않아서 의미가 없다.
SELECT ENAME, HIREDATE FROM EMP ORDER BY SAL;

-- [요구] NULL은 가장 큰값인가? 데이터가 없기 때문에 가장 큰값이라고 할 수없음. 하지만 그런 것처럼 처리 되는 것 뿐이다.
SELECT EMPNO, COMM FROM EMP ORDER BY COMM asc;
SELECT EMPNO, COMM FROM EMP ORDER BY COMM desc;





