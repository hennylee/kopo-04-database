

## FileSystem과 DBMS

- 예전에는 File System이 있었지만, 문제가 있어서 DBMS가 탄생하게 되었다. 

- File System은 데이터의 종속성과 중복성의 단점이 있었다. 

- 용어비교

|File|DBMS|
|----|----|
|Record|Row|
|Field, Attribute|Column|

## SQL SYNTAX Diagram

- SYNTAX Diagram이란 문법적인 구조를 그림으로 표현한 것이다.

- UNION, INTERSECT, MINUS라는 집합연산자 명령어도 함께 알아보기

## 실습

### SELECT *

- `SELECT * FROM EMP;`와 `SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO FROM EMP;`의 결과는? 같다. 

- 결과가 동일하지만 어떤 방식이 더 좋은 SQL일까? 필요한 컬럼을 일일히 나열하는 방법이 좋다.

- 그 이유는 1) SQL의 가독성 , 2) SQL 안정성 때문이다.

- 컬럼과 컬럼의 구분자는 `,`이다.

### COLUMN HEADING의 데이터 정렬

- 데이터 타입에 따라서 데이터 정렬 기준이 달라진다. 

- 문자와 날짜 데이터는 왼쪽 정렬이 원칙이다. 

![image](https://user-images.githubusercontent.com/77392444/115178594-98ca3400-a10c-11eb-9329-98047609c8c7.png)


- 숫자 데이터는 오른쪽 정렬이 원칙이다.

![image](https://user-images.githubusercontent.com/77392444/115178614-a4b5f600-a10c-11eb-899c-473b3d62772c.png)


### DESC

- `DESC EMP;`

![image](https://user-images.githubusercontent.com/77392444/115178171-b34fdd80-a10b-11eb-8221-c3f932dc059d.png)

- 테이블의 구조를 조회할 때 사용한다. 


### SELECT LIST

- SELECT LIST란? SELECT와 FROM 사이를 의미한다. 

- 원하는 컬럼(속성)만 조회하고 싶을 때 사용한다. 

```sql
-- 원하는 순서대로 컬럼을 조회할 수 있다.
SELECT EMPNO, ENAME, JOB, SAL FROM EMP;
SELECT SAL, JOB, EMPNO, ENAME FROM EMP; 

-- 같은 컬럼은 여러번 조회 가능하다
SELECT EMPNO, EMPNO, EMPNO, ENAME, JOB, SAL FROM EMP;

-- 존재하지 않는 컬럼을 만들어서 조회할 수 있다. 
-- 문자를 표기할 때는 ''로 감싼다.
SELECT EMPNO, SAL, 8, 'ORACLE' FROM EMP;
```
