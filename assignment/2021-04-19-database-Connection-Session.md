# Connection vs Session

- 세션과 프로세스 그리고 커넥션에는 CONNECTION->SESSION->PROCESS 의 관계가 있다고 볼 수도 있다. 

- 커넥션이 이루어짐으로서 세션이 성립되고 세션을 통해 프로세스가 사용되어짐으로서 이러한 관계가 있다고 말할 수 있다.

## Connection

- Connection은 client와 server 간의 네트워크 적인 연결이다.

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

- 세션은 사전적으로 시간의 의미를 가지고 있다.

- 로그인한 기간 동안의 상태정보를 파일이나 메모리에 받아 저장한다.

- 세션은 서버 내에 만들어진다. 

- 세션은 로그아웃 될때 해제된다. 

- 세션을 날려버리는 이유는 리소스 낭비를 막기 위해서이다. 

- 서버는 클라이언트에게 서비스를 제공하기 위해 로그인에서 로그아웃할때까지 Client의 Status 정보를 가지고 있어야 한다.

- 그 정보를 메모리에 가지고 있는다. 

- Session은 사용자 프로세스를 통한 DBMS와 유저의 특정한 연결을 의미한다. 

- A session is a specific connection of a user to an Oracle instance through a user process. 

- 커넥션이 이루어져야 세션이 성립된다. 

- 세션은 인스턴스의 논리적 요소이다. 

## Process

- 프로세스는 세션에 의해 수행되는 명령어에 의해 사용된다. 

- 세션을 통해 프로세스가 사용된다.



## 3Tier(웹, WAS, DB) 관점에서의 Connection과 Session 비교

|     |Web Server|WAS Server| DB Server|
|-----|----------|----------|----------|
|Connection||||
|Session||||


## Connection Pool


## Instance vs Database

## ask TOM(The Oracle Mentor)의 답변

- A connection is a physical circuit between you and the database. 

- A connection might be one of many types -- most popular begin DEDICATED server and SHARED server. 

- Zero, one or more sessions may be established over a given connection to the database as show above with sqlplus. 

- A process will be used by a session to execute statements. 

- Sometimes there is a one to one relationship between CONNECTION->SESSION->PROCESS (eg: a normal dedicated server connection). 

- Sometimes there is a one to many from connection to sessions (eg: like autotrace, one connection, two sessions, one process). 

- A process does not have to be dedicated to a specific connection or session however, for example when using shared server (MTS), your SESSION will grab a process from a pool of processes in order to execute a statement. 

- When the call is over, that process is released back to the pool of processes.

- 출처 : https://asktom.oracle.com/pls/apex/f?p=100:11:0::::P11_QUESTION_ID:5671284058977


## 총 정리

- 오라클 데이터베이스 구조 : 오라클 데이터베이스 시스템은 오라클 데이터베이스와 데이터베이스 Instance로 구성

- instance : instance가 시작될 때마다 SGA(System Global Area) 라는 공유 메모리 영역이 할당, 백그라운드 프로세스 시작.

- 데이터베이스 마운트: 데이터베이스 instance를 시작 후, 해당 instance를 특정 DB와 연결하는 과정.

- connection: user process와 오라클 DB instance 사이의 통신 경로.

- session: 데이터베이스 instance에 대한 현재 유저의 로그인 상태. 유저가 연결하는 시점에서 연결을 끊거나 DB application을 종료할 때까지 지속.


- 출처 : https://garimoo.github.io/database/2018/04/16/oracle_db_structure.html
