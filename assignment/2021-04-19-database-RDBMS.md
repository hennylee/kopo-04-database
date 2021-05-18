# RDBMS

## 정의 및 개념

- RDBMS(Relational DataBase Management System)

- RDBMS는 관계형 모델을 기반으로 하는 DBMS의 일종이다. 

- RDBMS는 **관계형** 데이터베이스를 생성, 수정, 관리하는 소프트웨어이다.

- RDBMS는 테이블이 서로 연관되어 상호관련성을 가질 수 있는 것이 특징이다. 

- RDBMS 시스템에서 모든 데이터는 row와 column의 이차원 테이블로 표현된다.

## RDBMS가 왜 획기적인가?

- DBMS는 아래 순으로 탄생했다.
  -  계층형 
  -  망형 
  -  관계형(So Hot!!) 
  -  객체지향형(망함)
  -  객체 관계형 

- 엄밀히 말하면 현재 Oracle은 '관계형 + 객체 관계형'이라고 볼 수 있다.

- 계층형DBMS는 Pointer로 연결되어 있다. 

- 관계형DBMS는 평소에는 독립적이다가 필요시에만 연산을 통해 관계를 맺는다.

## RDBMS의 R(관계)이란?

- R은 관계성(Relational)이란 뜻으로 DBMS의 종류를 의미한다. 

- 관계성은 데이터(Entity) 간의 관계를 의미한다. 

- RDBMS는 여러 개의 테이블 관계성을 통해 복잡한 요구를 실현할 수 있다. 

- 데이터의 중복의 최소화를 위해 테이블 간의 관계를 맺는다.
![image](https://user-images.githubusercontent.com/77392444/118587042-d0450280-b7d6-11eb-92bf-7e7a3e8e406e.png)
![image](https://user-images.githubusercontent.com/77392444/118587049-d33ff300-b7d6-11eb-9674-e23ab852c984.png)

- 데이터가 중복되면, 하나 수정 시 다른 하나는 수정되지 않아서 데이터에 큰 오류가 발생하게 된다. 
  - 근데 생각해보면 고객 번호가 중복되는디? 그럼 같은 문제 발생하는 것 아님?
  - 하나에는 PK, 다른 하나에는 FK로 설정해두면 동기화되나?
 

## Entity와 Table

- Entity : 논리적 개념 , 관리하고자 하는 데이터의 집합

- Table : 물리적 개념

- Entity와 Table은 무조건 1:1 대응이라고 할 순 없다.
