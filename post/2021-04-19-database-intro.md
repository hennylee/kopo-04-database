## 0419 과제

1. DB vs DBMS 정의, 사례, 차이점 
2. RDBMS 정의 및 개념, RDBMS의 R이란?

- 짤막하게 2~3줄 정도의 분량으로 정리하기 


## Client/Server와 Request/Response

![image](https://user-images.githubusercontent.com/77392444/115166724-986f7000-a0ef-11eb-95f9-6652609edb88.png)

- Client는 서비스 요청을 보내는 모든 H/W 컴퓨터 또는 S/W 프로그램이다.

- Server는 응답을 보내는 모든 H/W 컴퓨터 또는 S/W 프로그램이다.

- Web Server, WAS 서버, DB 서버의 관계를 살펴보면, WebServer(클라이언트) - WAS(서버)와 WAS(클라이언트)- DB(서버)로 이루어져 있다.

- 웹서버는 WAS에 Requsest를 보내고, WAS는 DB로 Request를 보내기 때문이다.

- 반대로 DB는 WAS로 Response를 보내고, WAS는 Web Server로 Response를 보낸다. 

![image](https://user-images.githubusercontent.com/77392444/115169651-98746d80-a0f9-11eb-961c-3c0a5711ed80.png)


## Personal Computer/ Server Computer

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



## Virtual Machine/Computing와 Host OS /Guest OS

- 가상화에 대한 용어를 이해할 필요가 있다.

-  Virtual Machine과 Docker의 공통점과 차이점은?


## 절차적(Procedural)/비절차적(Non-Procedural) 

- 절차적이란 것은 그동안 했던 프로그래밍 언어이다.

- Java, C언어, 코볼 등은 다 절차적 언어이다. 

- 처리 순서와 처리 방법을 명기하는 언어가 절차적 언어이다. 

- 비절차적 언어는 처리 순서와 방법을 명기하지 않는 언어이다. 


## SQL*PLUS , SQL Developer , PRO*C

- `*`는 뭘까?

- 예전에 오라클은 자사의 고유 Product에 `*`를 붙였다.

- PRO*C 란?
<img width="570" alt="image" src="https://user-images.githubusercontent.com/77392444/115169536-3f0c3e80-a0f9-11eb-9227-4c7858771d49.png">


## OSS(Open Source Software)

- Oracle의 최대 경쟁자는 타사 상용 SW가 아니라 Open Source DBMS라는 의견도 있다. 

- MySQL이 OSS DBMS 중에 가장 점유율이 크다.

- 국내에서는 카카오뱅크는 처음부터 MySQL을 가지고 은행 Core Banking을 시작했기 때문에 파격적이란 평을 들었다. 

- 예전보다 OSS가 안정화되면서 점차 시장 내 입지가 높아지고 있다. 


## RDBMS의 역사

- 1986년에 ANSI위원회와 ISO위원회가 관계형데이터베이스의 표준언어로 SQL(Structured Query Language)을 제정했다.

- 현재 사용되는 대부분의 데이터베이스는 관계형 데이터베이스모델을 기반으로 한다.

- ANSI(American National Standard Institute : 미국표준협회)

- ISO(International Organization for Standardization : 국제표준화기구)

- SQL을 표준으로 제정했다는 것은 SQL을 여러 DBMS에 적용할 수 있다는 것을 의미한다.


##
