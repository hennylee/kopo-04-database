# DataType

## 1. 문자

### 1.1 작은 유형 : VARCHAR2, CHAR

- 'VAR' 는 Variable Length의 약자이다. 가변길이 데이터 타입이란 뜻이다.

- 따라서 `CHAR`는 **고정 길이 문자 타입**이고, `VARCHAR2`는 **가변길이 문자 타입**이다.

- `CHAR` 는 최대 2000 Bytes까지 저장이 가능하다.

- `VARCHAR2`는 최대 4000 Bytes까지 저장이 가능하다. 영어라면 4000자, 한글이라면 2000자 혹은 1333자 혹은 1000자까지 저장가능한 것이다.

- 따라서, 
  - `CHAR(20)` : 무조건 20 Byte를 할당하겠다는 뜻이고, 
  - `VARCHAR(20)` : 최대 20 Byte를 할당하겠다는 뜻이다. 

- `VARCHAR2`는 `VARCHAR`의 두 번째 버전이란 뜻이다. 



### 1.2 긴 유형 : LONG, CLOB

- LONG : 최대 2G까지 저장이 가능하다. 지원하는 연산이 적어서 CLOB을 주로 사용한다.

- 'LOB'은 Large Object Binary의 약자이다. 'C'는 Char를 의미한다. 

- CLOB : 최대 4G의 저장공간 할당이 가능하다.

## 2. 숫자 : NUMBER

- `NUMBER`는 정수와 실수 모두 표현 가능하다. (다른 언어와의 차이점)

- `NUMBER`는 가변길이이다. 최대 38자의 숫자까지 허용한다.


## 3. 날짜 : DATE, TIMESTAMP

- `DATE`는 고정길이이다. (7 Byte)

- `TIMESTAMP`는 가변길이일까? 고정길이일까?

## 4. BINARY 

- BINARY는 영상, 압축된 문서 등의 데이터 타입이다. 

- BINARY 데이터를 저장한다면, 문자열 형식의 password 대신 지문, 얼굴, 생체 등의 정보가 저장될 수 있다. 

### 4.1 작은 유형 : RAW

### 4.2 긴 유형 : LONG ROW, BLOB

- 'LOB'은 Large Object Binary의 약자이다. 'B'는 Binary를 의미한다. 
