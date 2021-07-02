## 1. DATA TYPE 개요

|DATA TYPE유형 |주요특징|
|-------------------|---------------------------|
|SCALAR DATA TYPE |단일값을 저장하는 DATA TYPE
|COMPOSITE DATA TYPE |복수값을 저장하는 DATA TYPE
|REFERENCE DATA TYPE |- 다른 DATA TYPE을 참조하는 DATA TYPE<br> - 타언어의 포인터와 유사한 개념으로 커서 참조 유형과 객체 참조 유형으로 구분
|LOB(Large Object) DATA TYPE|Large Object를 저장하는 DATA TYPE
|OBJECT DATA TYPE |객체지향 언어 개념의 객체를 저장하는 DATA TYPE



## 2. SCALAR DATA TYPE


#### [BINARY_INTEGER]
- 저장하는 용도보다는 고속으로 빠르게 연산하기 위한 용도의 데이터 타입이다. 



#### [참고] NUMBER 데이터타입
- NUMBER는 가변길이 데이터 타입이다.
- NUMBER는 Packed Decimal 데이터 타입이다.
  - 4bit = 1개의 Digit을 저장  
  - 40은 2자리니까 8byte로 저장? 40(10진법) = 0100 0000 (2진법)

- 그래서 NUMBER를 연산하려면, 2번의 변환 과정을 거친다.
  - Binary로 변환 후 CPU에서 연산
  - DB에 저장할때는 Binary를 다시 Packed Decimal로 변환



#### [PLS_INTEGER]

- 직접적으로 사용할 일은 없고, 간접적으로 사용하게 된다.
- BINARY_INTEGER를 대체하는 Data Type 유형이다.






## 3. COMPOSITE DATA TYPE


#### [COMPOSITE DATA TYPE이란?]
- 변수 하나가 여러개를 저장하는 것
- 자바에서 array 등의 자료구조와 같다.


|데이터 형      |유사설명| 
|--------------|--------|
|RECORD        |- C 언어의 구조체(STRUCTURE)와 동일한 개념  <br>- 서로 다른 데이터형들을 논리적인 하나의 그룹으로 정의<br> - PL/SQL 에서만 지원|
|INDEX-BY TABLE|- C 언어의 배열(ARRAY)와 동일한 개념<br> - 동일 데이터형을 하나의 그룹으로 정의 PL/SQL 에서만 지원|
|NESTED TABLE  |- INDEX-BY TABLE 의 확장 유형 (최대 2G)<br> - TABLE 의 COLUMN : 지원(관계형 테이블의 컬럼으로 저장가능)<br> - PL/SQL 의 변수 : 지원|
|VARRAY        |- C 언어의 배열(ARRAY)와 동일한 개념(최대 2G)<br> - 동일 데이터형을 하나의 그룹으로 정의<br> - TABLE 의 COLUMN : 지원(관계형 테이블의 컬럼으로 저장가능한)<br> - PL/SQL 의 변수 : 지원|


#### [Table Type]
1. Dynamic Array
2. (Key, Value) 구조

메모리를 고갈시킬 수 있을까?

- 리눅스에서 TOP 등의 명령어 쓰면 메모리가 줄어드는 것을 실시간으로 볼 수 있음


## 4. DATA TYPE 과 참조연산자

참조 연산자를 사용하면 변수 선언 시, 특정테이블의 특정 컬럼 데이터타입과 데이터 length로 대체할 수 있다.

#### [참조 연산자의 종류]
1. `%TYPE` : 1개의 column을 참조
2. `%ROWTYPE` : 1개의 Row를 참조
    - TABLE, VIEW, CURSOR의 여러개의 컬럼을 참조하여 RECORD TYPE을 생성할 수 있다. 
    - 보통 간접적으로 많이 사용한다. 


#### [참조 연산자의 장점]
1. 편리성
2. 유연성
    - 변화에 유연하다. 
    - 컬럼의 데이터타입과 데이터 Length가 변경될 시, 참조 연산자를 쓰면 일일히 PL/SQL 변경하지 않아도 된다.



## 5. BLOCK 내의 SELECT

PL/SQL에서 SELECT를 사용했을 시, DBMS_OUTPUT 처럼 값을 받을 대상이 없기 때문에 에러가 발생한다.

그래서 PL/SQL에서 SELECT를 사용할때는 반드시 INTO를 사용해야 한다. 

SELECT와 관련된 주요한 EXCEPTION은 아래 2가지가 있다. 
- `NO_DATA_FOUND` : 조회하는 데이터가 0건인 경우 발생하는 EXCEPTION
- `TOO_MANY_ROWS` : 조회하는 데이터가 1건 이상일때, 해당 컬럼들에 맞는 COMPOSITE DATA TYPE에 대입하지 않는 경우 발생하는 EXCEPTION

왜 조회하는 데이터가 0건인 경우 경고 정도로 끝나지 않고 ERROR를 발생시킬까?
- 변수가 NULL일때 뒤에 흐름제어에서 오류가 발생할 수도 있기 때문이다. 

