# [한국폴리텍대학/데이터 분석학과] 04_데이터베이스


## 과제

### 과제 방법 

너무 자세한 내용 대신 짤막하게 2~3줄 정도의 분량으로 정리해서 발표하기 

### 0419 과제
1. [DB vs DBMS 정의, 사례, 차이점](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-19-database-DB-DBMS.md)

2. [RDBMS 정의 및 개념, RDBMS의 R이란?](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-19-database-RDBMS.md)

3. [SQL Syntax Diagram을 해석하기(SQL Manual을 참조한다)](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-19-database-Syntax-Diagrams.md)

4. [Connection vs Session 설명](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-19-database-Connection-Session.md)

5. EMP 테이블에서 사번,이름,직무,급여,부서번호 데이터 사이에 구분자 , 를 삽입하는 예제 SQL 작성하기

```
SELECT EMPNO||','||ENAME||','||JOB||','||SAL||','||DEPTNO FROM EMP;
````

6. [SELECT * FROM TAB ; 의 용도를 찾아 설명 하십시요](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-19-database-TAB.md)


### 0420 과제

1. [DATE, TIMESTAMP](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-20-database-sysdate.md)
    - 현재 시간, 분, 초, 1/100초 까지 표현하는 SQL 작성하기

    - 현재 시간, 분, 초, 1/1000초 까지 표현하는 SQL 작성하기

    - sysdate에서 왜 날짜는 보이고 시간은 안보일까?

2. [NVL, NVL2, NULLIF](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-20-database-NULL.md)

    - 아래 SQL 문장에 대해 설명하시오

```
SELECT SAL,COMM,NVL(COMM,SAL),nvl2(COMM,SAL,0), NULLIF(JOB,'MANAGER') FROM emp;
```


### 0421 과제

1. [실행 결과가 Oracle 9i 에서는 정렬되어 나타나지만 Oracle 10g이후 버전부터는 정렬된 결과가 나타나지 않는다. 이유를 찾아 설명 하십시요](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-22-database-10g-HashSort.md)
 
2. [다음의 집합 연산자 UNION, UNION ALL,INTERSECT, MINUS를 공부한후 각각의 예제 SQL을 만든 후 결과가 왜 정렬되는지 설명 하십시오.](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-22-database-SetOperator.md)

    - 명시적 정렬, 암시적 정렬과 연관되어 있다. 

3. [Interactive SQL 과 Embeded SQL를 설명 하고 각각의 사용예를 찾아서 기록하고 해석 하십시요](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-22-database-EmbededSQL.md)

    - 사례는 인터넷 검색으로 찾아서 직접 보여줘야 함

4. 부서별 차등 보너스 계산 SQL을 작성하시오

```SQL
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
END AS bonus
FROM EMP
ORDER BY bonus; 
```

5. [Pseudo 컬럼 정의 및 예제 SQL문장들](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-22-database-PseudoColumn.md)

6. Top-N, Bottom-M의 개념, 최상의 급여자 5명을 조회하는 SQL문을 작성하기(Sub Query)
    - Top-N, Bottom-M

    - Psuecode인 ROWNUM을 사용하여 구한다.

    - ROWNUM은 1부터 생성된 뒤, 순차적으로 증가한다. 

```SQL
-- ROWNUM까지 상위 5명만 출력하고 싶다면
SELECT ROWNUM, DEPTNO, ENAME, SAL FROM (SELECT DEPTNO, ENAME, SAL FROM EMP ORDER BY SAL DESC) 
WHERE ROWNUM <= 5 ORDER BY ROWNUM;

-- * 를 사용한 상위 5명의 데이터 출력
SELECT * FROM (SELECT DEPTNO, ENAME, SAL FROM EMP ORDER BY SAL DESC) 
WHERE ROWNUM <= 5 ORDER BY ROWNUM;
```


## 0423 과제

1. [to_date()날짜 포맷 YY, RR yy가 안나오는 이유 ,차이점 조사 후 설명](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-20-database-sysdate.md#yyrr-차이는)

2. `SELECT * FROM SALGRADE WHERE 3000 BETWEEN LOSAL AND HISAL;` 해석



3. [SCOTT.EMP 해석 & Schema 설명](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-26-database-schema.md)

4. [형 변환 우선순위 문자와 날짜 설명](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-26-database-TypeConversion.md)
