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
