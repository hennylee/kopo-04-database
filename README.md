# [한국폴리텍대학/데이터 분석학과] 04_데이터베이스


## 과제

### 과제 방법 

너무 자세한 내용 대신 짤막하게 2~3줄 정도의 분량으로 정리해서 발표하기 

### 0419 과제
1. [DB vs DBMS 정의, 사례, 차이점](https://github.com/hennylee/kopo-04-database/blob/main/post/2021-04-19-database-DB-DBMS.md)

2. [RDBMS 정의 및 개념, RDBMS의 R이란?](https://github.com/hennylee/kopo-04-database/blob/main/post/2021-04-19-database-RDBMS.md)

3. [SQL Syntax Diagram을 해석하기(SQL Manual을 참조한다)](https://github.com/hennylee/kopo-04-database/blob/main/post/2021-04-19-database-Syntax-Diagrams.md)

4. [Connection vs Session 설명](https://github.com/hennylee/kopo-04-database/blob/main/post/2021-04-19-database-Connection-Session.md)

5. EMP 테이블에서 사번,이름,직무,급여,부서번호 데이터 사이에 구분자 , 를 삽입하는 예제 SQL 작성하기

```
SELECT EMPNO||','||ENAME||','||JOB||','||SAL||','||DEPTNO FROM EMP;
````

6. [SELECT * FROM TAB ; 의 용도를 찾아 설명 하십시요](https://github.com/hennylee/kopo-04-database/blob/main/post/2021-04-19-database-TAB.md)


### 0420 과제

1. [DATE](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-20-database-sysdate.md)
  - 현재 시간, 분, 초, 1/100초 까지 표현하는 SQL 작성하기

  - 현재 시간, 분, 초, 1/1000초 까지 표현하는 SQL 작성하기

  - sysdate에서 왜 날짜는 보이고 시간은 안보일까?

2. [아래 SQL 문장에 대해 설명하시오](https://github.com/hennylee/kopo-04-database/blob/main/assignment/2021-04-20-database-NULL.md)

```
SELECT SAL,COMM,NVL(COMM,SAL),nvl2(COMM,SAL,0), NULLIF(JOB,'MANAGER') FROM emp;
```
