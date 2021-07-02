

## 1. Block

PL/SQL은 BLOCK 구조의 언어이다.

BLOCK은 (1) 선언부, (2) 실행부, (3) 예외처리부 3부분으로 구성되어 있다. 

BLOCK이 종료되면 문장종결자인 `;`로 종료시켜줘야 한다. 

문장종결자 뒤에 `/`은 앞에까지의 결과를 서버로 보내라는 뜻이다.

#### [PL/SQL Block의 종류]

|           |Named Block      |Anonymous Block    |
|---------------------|-----------------|-------------------|
|Block Name |있다             |없다                |
|저장위치    |- DBMS Server내에 저장<br>(구체적으로는Data Dictionary내에 저장)|Client Program내에 저장 되어 있거나 별도의 SQL Script 파일형태로 존재.
|실행방식    |- Client Process가 DBMS Server내에 저장되어 있는 Block을 호출하여 실행|실행시마다 Client Program에서 해당 Block Source를 DBMS Server에게 전달하여 실행
|선언부      |Named Block은 `IS(AS) ~ BEGIN` 사이가 선언부이다. |Anonymous Block은 `DECLARE ~ BEGIN` 사이가 선언부이다. |


## 2. 변수

변수를 정의할 때 `NOT NULL`이나 `CONSTANT` 로 정의하여 변수의 데이터에 제약사항 정의가 가능하다.
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
|산술연산자  |+ , / , * ,-,**|
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

- condition이 TRUE 인경우 실행 되고 FALSE, NULL인 경우 패스

## 5. 반복문

#### [PL/SQL의 반복문 유형]

```
1. 기본 Loop : LOOP ~ END LOOP;
2. For Loop : FOR loop_index in [REVERSE] lower_bound ... upper_bound LOOP ~ END LOOP;
3. WHELE Loop : WHILE condition LOOP statement.. END LOOP;
```

### 5.1 LOOP

```SQL
-- 1.
LOOP 
  statement1;
  statement2;
  EXIT [ WHEN conditon ]; 
 
END LOOP;

-- 2.
LOOP 
  statement1;
  statement2;
  IF condition THEN
    EXIT; 
  END IF;
END LOOP;
```

LOOP에서 EXIT으로 LOOP를 종료하지 않으면, 무한 LOOP를 수행하게 된다. 


### 5.1 LOOP

```SQL
-- 1.
LOOP 
  statement1;
  statement2;
  EXIT [ WHEN conditon ]; 
 
END LOOP;

-- 2.
LOOP 
  statement1;
  statement2;
  IF condition THEN
    EXIT; 
  END IF;
END LOOP;
```

### 5.2 FOR LOOP

```SQL
FOR loop_index in [REVERSE] lower_bound ... upper_bound LOOP 
  statement1
  statement2
END LOOP;
```

FOR LOOP는 기본 LOOP에 LOOP COUNTER 기능이 추가된 형태이다.

- LOOP COUNTER란? LOOP INDEX(LOOP 첨자)를 제어하는 것을 의미한다. 
- LOOP INDEX(LOOP 첨자)란 암시적(자동)으로 생성되는 정수 데이터타입이다.

FOR LOOP의 LOOP INDEX(LOOP 첨자)는 1씩 증가하거나, 1씩 감소하기만 한다. 임의로 2, 3, 4... 씩 증가/감소 시킬 수 없다. 

WHILE LOOP 에선 조건식이 TRUE 인 경우에만 실행되고, 조건식이 FALSE나 NULL인 경우에는 실행되지 않는다. 


### 5.2 WHILE LOOP

```SQL
WHILE condition 
LOOP 
  statement1;
  statement2;
END LOOP;
```

WHILE LOOP에서는 조건식(condition)이 TRUE인 경우만 실행되고 FALSE 나 NULL인 경우 실행되지 않는다.


## 6. NULL

`NULL > 1` 이면 NULL일까 FALSE일까? => NULL이다.


#### [NULL과 관련된 논리연산]

PL/SQL은 TRUE, FALSE 이외에도 NULL을 포함해서 3항 연산이라고 한다. 

![image](https://user-images.githubusercontent.com/77392444/124071090-d1c24580-da79-11eb-986c-f288e08c4940.png)


