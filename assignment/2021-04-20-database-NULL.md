
## 아래 SQL 문장에 대해 설명하시오 

```sql
SELECT SAL,COMM,NVL(COMM,SAL),nvl2(COMM,SAL,0), NULLIF(JOB,'MANAGER') FROM emp;
```

- `NVL(COMM,SAL)` : COMM가 NULL이면 SAL값이 반환되고, NULL이 아니면 COMM가 반환된다. 

- `nvl2(COMM,SAL,0)` : COMM가 NULL이 아니면 SAL값이 반환되고, NULL이면 0이 반환된다.

- `NULLIF(JOB,'MANAGER')` : JOB이 'MANAGER'면 NULL을 반환하고, 아니면 JOB을 반환한다.


## NVL


- `NVL(expr1, expr2)` : expr1이 null이면 expr2를 반환하고, null이 아니라면 expr1을 반환한다. 


- The arguments expr1 and expr2 can have any datatype. If their datatypes are different, then Oracle Database implicitly converts one to the other. If they are cannot be converted implicitly, the database returns an error. The implicit conversion is implemented as follows:

- If expr1 is character data, then Oracle Database converts expr2 to the datatype of expr1 before comparing them and returns VARCHAR2 in the character set of expr1.

- If expr1 is numeric, then Oracle determines which argument has the highest numeric precedence, implicitly converts the other argument to that datatype, and returns that datatype.

- 출처 : https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions105.htm

## NVL2


- `NVL2(expr1, expr2, expr3)` : 

- NVL2은 구체적 표현들이 null인지 아닌지에 따라 반환할 값을 결정한다.

- 만약 expr1이 null이 아니라면 expr2를 반환하고, expr1이 null이면 expr3를 반환한다.

```sql
SELECT COMM,SAL, nvl2(COMM,SAL,0) FROM emp;
```

![image](https://user-images.githubusercontent.com/77392444/115379483-86372400-a20c-11eb-9269-f8fc846c0cd0.png)


- argument expr1에는 어떤 데이터타입도 올 수 있다.

- arguments expr2와 expr3 는 LONG타입을 제외하고 모든 것을 데이터타입으로 가질 수 있다.

- 만약 expr2와 expr3의 데이터타입이 다르다면?

  - 만약 expr2는 charater이라면, Oracle Database는 비교하기 전에expr3를 expr2의 데이터 타입으로 변환한다. (expr3가 null이 아니라면)

  - 이 경우에는 형변환이 불필요하다. 오라클은 expr2의 캐릭터셋에 VARCHAR2를 반환한다.

  - 만약 expr2가 숫자라면, 오라클은 상위 숫자타입으로 형변환해서 반환한다.

- 출처 : https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions106.htm

## NULLIF


- `NULLIF(expr1, expr2)` : expr1과 expr2를 비교한다.

- 만약 둘이 같다면 함수는 NULL을 반환한다. 

- 만약 둘이 같지 않다면 함수는 expr1을 반환한다. 


```sql
-- NULLIF
SELECT JOB, NULLIF(JOB,'MANAGER') FROM emp;
```

![image](https://user-images.githubusercontent.com/77392444/115377289-70c0fa80-a20a-11eb-97a8-e7e5c6d5aafd.png)


- 만약 expr1이 null이라면, 함수는 null을 반환한다.

```sql
SELECT COMM, NULLIF(COMM,500) FROM emp;
```

![image](https://user-images.githubusercontent.com/77392444/115379325-63a50b00-a20c-11eb-8b6c-c62f378c9946.png)


- 만약 두 arguments가 숫자 데이터형이면, 오라클 DB는 암묵적으로 그 데이터를 상위 숫자 데이터 타입으로 변환해서 반환한다.

- 만약 두 arguments가 숫자가 아니라면, 그들은 반드시 같은 데이터 타입이어야 한다. (데이터 타입이 다르면 error)



- 출처 : https://docs.oracle.com/database/121/SQLRF/functions128.htm#SQLRF00681
