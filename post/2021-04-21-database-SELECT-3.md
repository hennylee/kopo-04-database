## 1. ORDER BY

- 정렬 시 비교 기준

| 유형 |   정렬순서        |      예시     |
|-----|-------------------|--------------|
| 숫자 | 작은수/큰수        | `123 < 456` |
| 문자 | 알파벳 순서(ASCII) | `'SCOTT' < 'T'` |
| 날짜 | 숫자와 동일        | `'2003/11/16' > '19990916'` |
| NULL | 가장 큰 값으로 간주|                             |


- 정렬 방향

  - ASC : 오림차순 , Default 정렬 방향은 ASC이다.
  - DESC : 내름차순


- 문자열의 정렬기준을 비교할 때 LENGTH는 중요하지 않고 첫 글자를 가지고 비교한다.

- 날짜는 숫자와 동일한 형식으로 저장되어 있기 때문에 숫자와 동일한 특성을 가지고 있다 (연산이 가능)

- 그래서 날짜도 숫자와 동일하게 정렬 기준을 가지고 있는 것이다. 

- Oracle DBMS에서 NULL은 가장 큰 값으로 간주된다. 그 이유는 NULL자체는 데이터가 존재하지 않기 때문에 크다, 작다를 비교할 수 없기 때문이다. 


- 정렬의 종류
  - 명시적 정렬       : `ORDER BY` 연산을 사용한 정렬
  - 묵시(암시)적 정렬 : DBMS 내부에서는 암시적 정렬이 자주 일어난다.  


## 2. DISTINCT

- DISTINCT는 중복을 제거하는 필터링을 해준다. 

- DISTINCT와 UNIQUE는 동일한 기능이지만, DISTINCT가 ANSI 표준이라는 특징이 있다.

![image](https://user-images.githubusercontent.com/77392444/115485620-0bafe800-a290-11eb-84db-c68878830e0c.png)

- DISTINCT의 문법 구조 상 두 번 나올 수 없다. (loop 형이 아니기 때문이다)

- DISTINCT와 UNIQUE는 함께 쓰일 수 없고, ALL과도 함께 쓰일 수 없다. 

- DISTINCT는 `select_list` 앞에 위치해야 한다.


## 3. DECODE

- DECODE는 SQL문장 안에서 쓸 수 있는 조건문(IF)이다. 

- 조건처리를 PHP, Java같은 프로그램이 하는가, Oracle DBMS가 DECODE 등의 연산을 가지고 하는가에 따라 코드의 효율성이 높아질 수 있다.

- `DECODE(expr1, expr2, expr3, expr4)` : expr1이 expr2이면 expr3를 수행하고, expr1이 expr2가 아니면 expr4를 수행한다.

- 이처럼 DECODE는 동등비교만 가능하기 때문에 불편해서 DECODE 함수를 확장 개선한 것이 CASE이다. 

- DECODE에서 NULL은 어떻게 처리되는가? 
  - CASE 1. 아예 오류 처리가 나는가? X
  - CASE 2. ORDER BY처럼 처리하는 방법이 내부적으로 정해져 있나? O, 무조건 같다고 처리한다. 


## 4. CASE

```sql
CASE (컬럼)
  WHEN [조건] THEN [결과]
  WHEN [조건] THEN [결과]
  WHEN [조건] THEN [결과]
  ELSE [결과]
END (AS [별칭])
```

- DECODE와 CASE의 차이는?


## 5. ROWNUM 

- ROWNUM은 ROW에 부여된 절대적인 번호가 아니다. 

- 오라클의 실행순서는? [ 3 - 4 - (2 - 1) - 5 ]

```sql
1. SELECT select_list
2. ROWNUM 
3. FROM 
4. WHERE filter
5. ORDER BY           
```

- `ORDER BY`는 SELECT 문장의 가장 마자막에 실행된다. 

- 데이터를 레코드(ROW) 단위로 저장하는 DBMS : Oracle DBMS
- 데이터를 컬럼 단위로 저장하는 DBMS


- 조건절에서 ROWNUM 사용시 주의사항

```SQL
SELECT ROWNUM,ENAME, DEPTNO, SAL FROM EMP;

-- WHERE 조건절에서 필터링이 된 후에 ROWNUM이 생성되기 때문에? 실행 불가이다. 
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM = 5;
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM > 5;
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM >= 5;

-- 하지만 활용되는 빈도가 많기 때문에 아래 예시는 예외적으로 허용하는 CASE이다. 
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM = 1;
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM <= 5;
SELECT ENAME, DEPTNO, SAL FROM EMP WHERE ROWNUM < 5;
```

## SubQuery

- SubQuery는 SELECT문만 올 수 있다.

- Main Query보다는 SubQuery가 먼저 실행된다. 

- 테이블은 구조가 정적으로 이루어졌다. 

- SubQuery를 실행하면? resultSet 결과집합이 만들어 진다.

- resultSet도 생긴 모양은 테이블과 똑같다. (row + column , 2차원 구조)

- 테이블은 정적인 구조이다. 

- SubQuery은 테이블이 아니기 때문에 유연하게 사용할 수 있다.


## 6. 논리 연산자

- 종류 : AND, OR

- AND와 OR 중 어떤 것이 연산자 우선 순위가 더 높을까? AND!

- Oracle DBMS 내부적으로 가장 효율적인 처리방법과 처리순서를 결정하는 OPTIMIZER가 AND를 더 효율적이다고 판단했기 때문이다. 

- 왜냐하면, AND연산을 먼저 처리할 때 OR연산을 처리할 때보다 처리해야 할 중간 데이터 집합이 줄어들기 때문이다. 

- 예) [1건 AND 1만건] => 최소 0 ~ 최대 1건 처리해야함! , [1건 OR 1만건] => 최소 1만건 ~ 최대 1만1건 처리해야함!


- [요구]'OR 연산' 시 중복되는 ROW는 어떻게 처리되는가?
  - case 1 : 중복되어 출력된다. X
  - case 2 : 한 번만 출력된다. O



## 7. 집합연산자
- UNION : 합집합

- UNION ALL : 중복 포함 합집합

- MINUS : 먼저 위치한 SELECT문을 기준으로 차집합을 추출

- INTERSECT : 교집합


- [요구] UNION ALL 집합 연산자를 사용하여 OR와 동일한 결과를 생성하는 SQL을 작성 하십시오
  - 중복 데이터가 여러번 출력됨 => SUBQUERY와 DISTINCT 사용하기

```sql
SELECT DISTINCT * FROM (
  SELECT DEPTNO, JOB, ENAME FROM EMP WHERE DEPTNO = 20
  UNION ALL 
  SELECT DEPTNO, JOB, ENAME FROM EMP WHERE JOB = 'CLERK'
)
ORDER BY DEPTNO asc;
```
