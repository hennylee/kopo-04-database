

## 1. Block


PL/SQL Block의 종류


![image](https://user-images.githubusercontent.com/77392444/124065093-fd8cfd80-da70-11eb-88c1-143b45846411.png)

- Named Block은 `IS(AS) ~ BEGIN` 사이가 선언부이다. 

- Anonymous Block은 `DECLARE ~ BEGIN` 사이가 선언부이다. 





## 2. 변수

변수를 정의할 때 NOT NULL이나 CONSTANT 로 정의하여 변수의 데이터에 제약사항 정의가 가능하다.
  - `CONSTANT` : 변하지 않는 변수

```SQL
DECLARE
  V_SAL NUMBER(8) NOT NULL := 5000;
  C_TAX_RATE CONSTANT NUMBER(2,3) := 0.054;
BEGIN
```

변수는 테이블의 변수명, 데이터타입과 일치시켜야 한다. 
 

## 3. 연산자

PL/SQL은 SQL을 확장한 것이기 때문에 SQL 연산자를 사용할 수 있다.

|연산자 구분 |내용|
|-----------|-----|
|산술연산자 |+ , / , * ,-,**|
|비교연산자 |= , != , <> ,~=, <,>, <=,>=|
|논리연산자 |AND,OR,NOT|
|SQL 연산자 |LIKE, BETWEEN,IN, IS NULL|


## 4. 조건식

```SQL
IF condition THEN
  statement
ELSIF condition THEN
  statement
ELSE
  statement
END IF;
```

- ELSEIF 가 아니라 ELSIF 임을 주의해야 한다.


## 5. 반복문

```
1. 기본 Loop : LOOP ~ END LOOP;
2. For Loop : FOR loop_index in [REVERSE] lower_bound ... upper_bound LOOP ~ END LOOP;
3. WHELE Loop : WHILE condition LOOP statement.. END LOOP;
```

FOR LOOP의 LOOP 첨자는 1씩 증가하거나, 1씩 감소하기만 한다. 임의로 2, 3, 4... 씩 증가/감소 시킬 수 없다. 

WHILE LOOP 에선 조건식이 TRUE 인 경우에만 실행되고, 조건식이 FALSE나 NULL인 경우에는 실행되지 않는다. 



## 6. NULL

`NULL > 1` 이면 NULL일까 FALSE일까? => NULL이다.


#### [NULL과 관련된 논리연산]

PL/SQL은 TRUE, FALSE 이외에도 NULL을 포함해서 3항 연산이라고 한다. 

![image](https://user-images.githubusercontent.com/77392444/124071090-d1c24580-da79-11eb-986c-f288e08c4940.png)


