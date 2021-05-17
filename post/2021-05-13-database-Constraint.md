# 제약사항

## CONSTRAINT란

- 데이터의 무결성(INTEGRITY)을 보장하기 위해서 사용되는 제약사항을 의미한다. 

- 무결성이란? 데이터에 결점, 결함이 없게 하는 것이다. 쓰레기 데이터가 DB 내에 있지 못하게 보장해야 한다.


## CONSTRAINT의 종류

① 선언적 무결성 제약사항(Declarative Integrity Constraint)
- '선언적'의 의미란?

② TRIGGER

③ APPLICATION LOGIC


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


## 선언적 무결성 제약사항 레벨

① TABLE LEVEL

② COLUMN LEVEL


## 선언적 무결성 제약사항 생성시기

① TABLE 생성시 생성

② TABLE 생성후 임의의 시점에 추가 : 꼼꼼히 설계하면 불필요하다.
