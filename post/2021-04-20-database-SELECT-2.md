# SELECT (2)

## 1. DUAL

- `to_char(DATA, format)` :  type conversion 함수, 자리수마다 콤마찍기


## 2. NULL
- 사전적 의미 : 데이터가 존재하지 않는, 값이 정의되지 않은

- 현재 데이터를 입력하지 못한 경우이다. 

- Unavailable, Unassigned, Unknown, Inapplicable

- NULL, 0, 공백문자는 모두 다르다. 

- NULL의 특징
  - 연산 불가 : NULL 사칙연산 결과는 무조건 NULL로 나온다.
  - 비교 불가 : 비교 결과에 NULL은 출력되지 않는다. 동등비교할 때는 `is null` , `is not null`을 사용해야 결과가 출력된다.
  - 적용 불가 : NULL 데이터에 함수를 적용하면 결과는 무조건 NULL이 나온다.

- NULL과 함수와의 관계
  - Single Row 함수이다.
  - Group Row 함수이다.
  - Null 무시함수이다.

- SQL*PLUS 에서의 결과 : NULL이 보이지 않음

![image](https://user-images.githubusercontent.com/77392444/115348905-2cbffc80-a1ee-11eb-937d-6f3d46d2e481.png)

- SQL Developer에서의 결과 : NULL값을 표시해줌

![image](https://user-images.githubusercontent.com/77392444/115348958-3c3f4580-a1ee-11eb-89cd-bc94d48201a5.png)

### 2.1 NULL 연산불가

- 결과가 NULL이 된다. 

```SQL
SELECT 300+400, 300+NULL, 300/NULL FROM dual;
```

![image](https://user-images.githubusercontent.com/77392444/115642171-6cedbf00-a355-11eb-84f8-b952f78a5ea8.png)

```SQL
SELECT ENAME, SAL, COMM, COMM+SAL*0.3 as bonus FROM EMP;
```

![image](https://user-images.githubusercontent.com/77392444/115642197-79721780-a355-11eb-8c72-7daa77137426.png)


### 2.2 NULL 비교불가

- NULL은 숫자 범위 어디에도 속할 수 없기 때문에 대소비교가 불가하다.

```sql
SELECT ENAME, SAL, COMM FROM EMP WHERE COMM > -1;
```

![image](https://user-images.githubusercontent.com/77392444/115642264-99a1d680-a355-11eb-91ca-94305e7d140e.png)

```sql
SELECT ENAME, SAL, COMM FROM EMP WHERE COMM < -1;
```

![image](https://user-images.githubusercontent.com/77392444/115642277-a0c8e480-a355-11eb-9c1c-15031a3f82e7.png)

- 비교 연산자로 비교할 수 없기 때문에 특별한 연산자를 만들었다.

- NULL을 비교하는 특별한 연산자는 `is null`,  `is not null` 뿐이다.


### 2.3 NULL 적용불가

- NULL은 함수 적용이 불가능하다. 결과는 무조건 NULL이 나오기 때문이다.

```SQL
SELECT ENAME, length(ENAME), COMM, length(COMM) FROM EMP;
```

![image](https://user-images.githubusercontent.com/77392444/115642385-d40b7380-a355-11eb-8a46-3ceca993906a.png)

- `length(COMM)` : 암시적 데이터타입 형변환이 발생한다. COMM이 문자로 바뀌게 된다. 좋은 방식은 아니다. 


### 2.4 NULL 처리 방법

- NULL을 처리할 수 있는 함수들  : NVL, decode, NVL2, NULLIF

- NVL(a, b) : a가 NULL이면 b로 치환한다.
- decode(a, b, c, d) : if조건절의 역할을 한다. if( a = b ) { c } else { d }

```SQL
SELECT concat(ENAME||' is ',COMM), NVL(COMM, -1), decode(COMM, null, -999, COMM) FROM EMP;
SELECT ENAME||' is '||COMM, NVL(COMM, -1), decode(COMM, null, -999, COMM) FROM EMP;
```


- NVL(a, b) : a가 NULL이면 b로, NULL이 아니면 a로 치환한다.

```SQL
SELECT SAL,COMM,NVL(COMM,SAL) FROM emp;
```


- NVL2(a, b, c) : a가 NULL이면 c, NULL이 아니면 b

```SQL
SELECT COMM,SAL, nvl2(COMM,SAL,0) FROM emp;
```

- NULLIF(a, b) : a와 b가 같으면 null, 같지 않으면 a

```SQL
SELECT JOB, NULLIF(JOB,'MANAGER') FROM emp;
SELECT COMM, NULLIF(COMM,500) FROM emp;
```
