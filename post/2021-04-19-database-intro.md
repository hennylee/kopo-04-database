

## 1. Client/Server와 Request/Response

![image](https://user-images.githubusercontent.com/77392444/115166724-986f7000-a0ef-11eb-95f9-6652609edb88.png)

- Client는 서비스 요청을 보내는 모든 H/W 컴퓨터 또는 S/W 프로그램이다.

- Server는 응답을 보내는 모든 H/W 컴퓨터 또는 S/W 프로그램이다.

- Web Server, WAS 서버, DB 서버의 관계를 살펴보면, WebServer(클라이언트) - WAS(서버)와 WAS(클라이언트)- DB(서버)로 이루어져 있다.

- 웹서버는 WAS에 Requsest를 보내고, WAS는 DB로 Request를 보내기 때문이다.

- 반대로 DB는 WAS로 Response를 보내고, WAS는 Web Server로 Response를 보낸다. 


## 2. Personal Computer/ Server Computer

- Server Computer는 뭐가 다른거지?

- 기업들은 왜 Server Computer를 가지고 있을까?

- 기업용 컴퓨터(Server)는 높은 사양의 CPU, Cache, 메모리, 디스크를 가지고 있다. 

- CPU가 높다 => 동시에 처리할 수 있는 병렬성이 높다.

- 디스크는 컴퓨터의 가장 느린 장치이다.

- 메모리가 많다는 것은 가장 느린 장치인 DISK를 덜 Access할 수 있다??

- 폰노이만의 컴퓨터 아키텍처

- 개인용 컴퓨터는 WorkStation이라고 볼 수 있다.

- 기업용 컴퓨터는 다수의 Client가 요청을 보내는 Server이다. 

- 수십, 수만개의 Request를 처리할 수 있는 컴퓨터가 바로 Server Computer이다.
![image](https://user-images.githubusercontent.com/77392444/115167784-b048f300-a0f3-11eb-979a-f725b3381a1f.png)



## 3. Virtual Machine/Computing와 Host OS /Guest OS

- 가상화에 대한 용어를 이해할 필요가 있다.

-  Virtual Machine과 Docker의 공통점과 차이점은?


## 4. 절차적(Procedural)/비절차적(Non-Procedural) 

- 절차적이란 것은 그동안 했던 프로그래밍 언어이다.

- Java, C언어, 코볼 등은 다 절차적 언어이다. 

- 처리 순서와 처리 방법을 명기하는 언어가 절차적 언어이다. 

- 비절차적 언어는 처리 순서와 방법을 명기하지 않는 언어이다. 


## 5. SQL*PLUS , SQL Developer , PRO*C

- `*`는 뭘까?

- 예전에 오라클은 자사의 고유 Product에 `*`를 붙였다.

- PRO*C 란?
<img width="570" alt="image" src="https://user-images.githubusercontent.com/77392444/115169536-3f0c3e80-a0f9-11eb-9227-4c7858771d49.png">


## 6. OSS(Open Source Software)

- Oracle의 최대 경쟁자는 타사 상용 SW가 아니라 Open Source DBMS라는 의견도 있다. 

- MySQL이 OSS DBMS 중에 가장 점유율이 크다.

- 국내에서는 카카오뱅크는 처음부터 MySQL을 가지고 은행 Core Banking을 시작했기 때문에 파격적이란 평을 들었다. 

- 예전보다 OSS가 안정화되면서 점차 시장 내 입지가 높아지고 있다. 


## 7. RDBMS의 역사

- 1986년에 ANSI위원회와 ISO위원회가 관계형데이터베이스의 표준언어로 SQL(Structured Query Language)을 제정했다.

- 현재 사용되는 대부분의 데이터베이스는 관계형 데이터베이스모델을 기반으로 한다.

- ANSI(American National Standard Institute : 미국표준협회)

- ISO(International Organization for Standardization : 국제표준화기구)

- SQL을 표준으로 제정했다는 것은 SQL을 여러 DBMS에 적용할 수 있다는 것을 의미한다.


## 8. RDBMS의 장점

1. 모델 단순성
2. 독립성과 유연성
3. 비절차적 SQL
4. 수학적 집합론


### 8.1 모델 단순성
- 관계형 데이터 베이스에서 모든 데이터는 Table로 이루어져 있다.

- Table은 row와 column으로 이루어진 이차원 형태로 구성되어 있다.

### 8.2 모델 독립성과 유연성

- ERD(Entity Relationship Diagram) : 객체 관계를 그림으로 표현한 도구라고 볼 수 있다. 

![image](https://user-images.githubusercontent.com/77392444/115170355-6c59ec00-a0fb-11eb-8b92-3dc39eefd314.png)


## 9. SQL 개요

1. SQL이란 관계형 DBMS에 접근하는 유일한 언어이다. 
2. English-Like 
3. ANSI/ISO SQL
4. 비절차형 언어이다. 

### 9.1 관계형 DBMS에 접근하는 유일한 언어

- DB란 data의 집합이다.

- 사람들은 DBMS에 있는 data에 접근하기 위해 SQL을 사용하는 것이라고 볼 수 있다. 

- SQL을 활용하는 사람들은 주로 개발자, DBA, Tuner(성능을 개선하는 사람), 모델러(DB를 분석/설계하는 사람)들이다.

### 9.2 English-Like 

- SQL은 의미와 문법적인 구조가 영어 문맥과 유사하다.

- SQL은 데이터 전문가가 아닌 현업의 일반인이 데이터를 쉽게 활용할 수 있게 하기 위해 만들어졌기 때문이다. 

- SQL 명령어는 대소문자를 구분하지 않는다. 

- 다만, 데이터는 대소문자를 구분한다. 

### 9.3 ANSI/ISO SQL

- 미국 내 DBMS 업체들이 우후죽순으로 생겨나면서 ANSI에서 SQL을 표준화하게 되었다. 

- 전 세계적으로 DBMS의 활용도가 높아지면서 ISO에서 전세계적으로 SQL을 표준화했다.

- 각 회사마다 표준을 따르되, 자체적인 SQL이 추가되었다.

- SQL on Hadoop : Hadoop에서 SQL을 써서 처리하게 요구에 따라 탄생한 HDFS에 저장된 데이터에 대한 SQL 질의 처리를 제공하는 시스템을 의미한다.

- 주기적으로 표준 제정을 통해 버전 Update가 되고 있다.

### 9.4 비절차형 언어

- 처리 절차가 없는 언어라는 의미이다. 


## 10. SQL 명령어의 분류

![image](https://user-images.githubusercontent.com/77392444/115172148-97ded580-a0ff-11eb-916f-ff0a2f36701c.png)

- 금융권에서는 전문을 날린다?라는 표현을 쓴다. 

- atm기계는 SQL을 활용하지 않고 전문을 활용하기 때문이다. 

- 데이터베이스에서 Transaction은 하나의 논리적인 작업 단위이다. 

- 데이터베이스 Object란? 테이블, 뷰 등을 의미한다.
