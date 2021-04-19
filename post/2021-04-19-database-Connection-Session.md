# Connection vs Session

- 세션과 프로세스 그리고 커넥션에는 CONNECTION->SESSION->PROCESS 의 관계가 있다고 볼 수도 있다. 

- 커넥션이 이루어짐으로서 세션이 성립되고 세션을 통해 프로세스가 사용되어짐으로서 이러한 관계가 있다고 말할 수 있다.

## Connection

- Connection은 user process 과 Oracle instance 간의 소통 경로이다. 

- Connection은 Client와 Server(오라클 인스턴스)의 물리적 연결이다.

- Connection 은 여러 종류 중 하나가 선택 되어질 수 있다.

- Options are

```
1. client --connected to-- dispatcher
2. client --connected to-- dedicated server
3. client --connected to-- Oracle Connection Manager(CMAN)
```

## Session

- Session은 사용자 프로세스를 통한 DBMS와 유저의 연결을 의미한다. 

- A session is a specific connection of a user to an Oracle instance through a user process. 

- 커넥션이 이루어져야 세션이 성립된다. 

- 세션은 인스턴스의 논리적 요소이다. 

## Process

- 프로세스는 세션에 의해 수행되는 명령어에 의해 사용된다. 

- 세션을 통해 프로세스가 사용된다.


## Instance vs Database

![image](https://user-images.githubusercontent.com/77392444/115215529-8ec12900-a13e-11eb-9689-5128dc403dcf.png)

- 출처 : https://srzero.tistory.com/entry/Oracle-%EC%9A%A9%EC%96%B4-Instance-VS-Database


## 총 정리

- 오라클 데이터베이스 구조 : 오라클 데이터베이스 시스템은 오라클 데이터베이스와 데이터베이스 Instance로 구성

- instance : instance가 시작될 때마다 SGA(System Global Area) 라는 공유 메모리 영역이 할당, 백그라운드 프로세스 시작.

- 데이터베이스 마운트: 데이터베이스 instance를 시작 후, 해당 instance를 특정 DB와 연결하는 과정.

- connection: user process와 오라클 DB instance 사이의 통신 경로.
- session: 데이터베이스 instance에 대한 현재 유저의 로그인 상태. 유저가 연결하는 시점에서 연결을 끊거나 DB application을 종료할 때까지 지속.


- 출처 : https://garimoo.github.io/database/2018/04/16/oracle_db_structure.html
