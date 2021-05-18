# 제약사항

## CONSTRAINT란

- 데이터의 무결성(INTEGRITY)을 보장하기 위해서 사용되는 제약사항을 의미한다. 

- 무결성이란? 데이터에 결점, 결함이 없게 하는 것이다. 쓰레기 데이터가 DB 내에 있지 못하게 보장해야 한다.

- 제약사항에 명시적인 이름을 주면, 에러메세지에서 식별성이 더욱 좋아진다. 

## CONSTRAINT의 종류

① 선언적 무결성 제약사항(Declarative Integrity Constraint)

② TRIGGER

③ APPLICATION LOGIC

![image](https://user-images.githubusercontent.com/77392444/118456495-47758a80-b734-11eb-8cc8-f4885faee1ae.png)

## 만약 CONSTRAINT가 공존한다면 비효율적인 것일까? 

![image](https://user-images.githubusercontent.com/77392444/118457288-93283400-b734-11eb-95c3-35ca0a2f1f53.png)

- 아니다. 데이터 무결성을 보장하기 위해서는 2중 안전 장치가 필요하기 때문에 효율적인 코딩이라고 볼 수 있다. 



## 선언적 무결성 제약사항 종류

① `PRIMARY KEY` : **대표성, 고유성, 존재성**
- NOT NULL
- 대표로 1개만 정의 가능하다
- Unique Index,  (P.K = U.K + N.N), 
- 데이터가 반드시 존재하면서 고유해야 한다. 

② `UNIQUE KEY` : 데이터의 **고유성**을 보장하는 것
- NULL 허용
- N개 정의가 가능하다
- Unique Index 자동 생성
- 데이터가 없어도 되지만, 데이터가 존재하는 한 고유해야 한다. 
- NULL이 여러개 인경우 어떻게 되나 ? 
- Index : 빨리 데이터를 찾아오기 위해 사용한다. (Quick Search)
- DBMS는 데이터가 중복되었는지 안되었는지 어떻게 빠른시간 내에 알아낼까? Index를 활용해서 알아낸다. 

③ `CHECK` : 값의 유효성 제약 , Boolean 연산 처리 
- 조건절
- true가 나오면 데이터를 처리하고 false가 나오면 데이터를 처리하지 않는다. 

④ `NOT NULL` : 데이터의 **존재성**을 보장하는 것
- 필수 입력 사항

⑤ `FOREIGN KEY` : 테이블간의 관계 정의, 기본키를 다른 테이블에 저장
- 연결고리, 내용에 의한 참조
- 테이블간(테이블내)의 참조 무결성(REFERNTIAL INTEGRITY)을 보장 
- F.K는 다른 테이블의 P.K나 U.K를 참조한다. 
- 참조 당하는 테이블 = Parent , 참조 하는 테이블 = Child로 이해하면 쉽다. (물론 예외도 존재한다)


## 선언적 무결성 제약사항 레벨

① TABLE LEVEL : 컬럼 조합으로 제약조건을 설정할 때 사용됨

② COLUMN LEVEL : 각 컬럼의 제약조건을 설정할 때 사용됨


## 선언적 무결성 제약사항 생성시기

① TABLE 생성시 생성

② TABLE 생성후 임의의 시점에 추가 : 꼼꼼히 설계하면 불필요하다.
