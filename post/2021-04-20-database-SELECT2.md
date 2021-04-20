# SELECT (2)

## DUAL


### 1-2. Dual

### 3. sysdate

### 4. to_char (type conversion 함수), 자리수마다 콤마찍기


## NULL
- 사전적 의미 : 데이터가 존재하지 않는, 값이 정의되지 않은

- 현재 데이터를 입력하지 못한 경우이다. 

- Unavailable, Unassigned, Unknown, Inapplicable

- NULL, 0, 공백문자는 모두 다르다. 

- NULL의 특징
  - 연산 불가 : 결과가 무조건 NULL로 나온다.
  - 비교 불가
  - 적용 불가

- NULL과 함수와의 관계
  - Single Row 함수이다.
  - Group Row 함수이다.
  - Null 무시함수이다.

- SQL*PLUS 에서의 결과 : NULL이 보이지 않음

![image](https://user-images.githubusercontent.com/77392444/115348905-2cbffc80-a1ee-11eb-937d-6f3d46d2e481.png)

- SQL Developer에서의 결과 : NULL값을 표시해줌

![image](https://user-images.githubusercontent.com/77392444/115348958-3c3f4580-a1ee-11eb-89cd-bc94d48201a5.png)

### 5-7. NULL 연산불가

- 결과가 NULL이 된다. 


### 8-14. NULL 비교불가

- 비교 연산자로 비교할 수 없기 때문에 특별한 연산자를 만들었다.

- 13-14. NULL을 비교하는 특별한 연산자는 `is null`,  `is not null` 뿐이다.

### 1-2. NULL 적용불가

- `length(COMM)` : 암시적 데이터타입 형변환이 발생한다. COMM이 문자로 바뀌게 된다. 좋은 방식은 아니다. 
