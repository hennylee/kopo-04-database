
## 로컬PC (로컬, 클라이언트)

- 로컬PC 접속 정보 (pw : happy)

![image](https://user-images.githubusercontent.com/77392444/121105251-b3807580-c83e-11eb-8923-8b8175d59efe.png)

- 권한 확인

```sql
SELECT USERNAME, PRIVILEGE, ADMIN_OPTION FROM USER_SYS_PRIVS;
```

- 권한 결과 : CREATE SESSION, CREATE DATABASE LINK 권한이 존재함

![image](https://user-images.githubusercontent.com/77392444/121107583-22f86400-c843-11eb-9048-f31379835b10.png)




## VMWarePC (원격, 서버)

- VMWarePC 접속 정보 (pw : tiger)

![image](https://user-images.githubusercontent.com/77392444/121105299-d1e67100-c83e-11eb-91c1-5bae13f0d8e6.png)

- 권한 확인

```sql
select * from user_sys_privs;
```

- 권한 결과 : CREATE SESSION, CREATE DATABASE LINK 권한이 존재하지 않음

![image](https://user-images.githubusercontent.com/77392444/121107650-40c5c900-c843-11eb-916e-1da45b038ae0.png)



## DB Link 권한 시나리오

#### 1. VMWarePC DBMS 에 접속하여 분산 트랜잭션을 실행하려고 한다. 

- 현재, 로컬 PC에 DB Link 권한이 있고, VMWarePC는 권한이 없는 상태에서 VMWarePC에 대한 DB Link를 생성할 수 있을까?

|                     |로컬 PC|VMWarePC|
|:--------------------|:-----:|:------:|
|CREATE SESSION       |    O  |  X     |
|CREATE DATABASE LINK |    O  |  X     |


- 로컬 PC에서 VMWarePC에 대한 DB Link는 생성 가능하다.

```SQL
CREATE DATABASE LINK scottLink CONNECT TO SCOTT IDENTIFIED BY TIGER USING
'(DESCRIPTION =
  (ADDRESS_LIST =
    (ADDRESS = 
      (PROTOCOL = TCP)
      (HOST = 192.168.119.119)
      (PORT = 1521)
    )
  )
  (CONNECT_DATA =
    (SERVICE_NAME = dink)
  }
)';
```


#### 2. 반대로, 로컬 PC 에 접속하여 분산 트랜잭션을 실행하려고 한다. 

- VMWarePC에서 DB Link 권한이 없는 로컬 PC에 대한 DB Link를 생성할 수 있을까?


|                     |로컬 PC|VMWarePC|
|:--------------------|:-----:|:------:|
|CREATE SESSION       |    O  |  X     |
|CREATE DATABASE LINK |    O  |  X     |


- VMWarePC에서 로컬 PC에 대한 DB Link는 권한 불충분으로 인해 생성 불가능하다.

```SQL
CREATE DATABASE LINK scottLink CONNECT TO HR IDENTIFIED BY HAPPY USING
'(DESCRIPTION =
  (ADDRESS_LIST =
    (ADDRESS = 
      (PROTOCOL = TCP)
      (HOST = 192.168.217.33)
      (PORT = 1522)
    )
  )
  (CONNECT_DATA =
    (SID = XE)
  }
)';
```

```
오류 보고 -
ORA-01031: 권한이 불충분합니다
01031. 00000 -  "insufficient privileges"
*Cause:    An attempt was made to perform a database operation without
           the necessary privileges.
*Action:   Ask your database administrator or designated security
           administrator to grant you the necessary privileges
```


#### 3. VMWarePC에서 SCOTT 계정에 DB Link 생성 권한을 부여한다면?

- DBA 계정에서 권한 부여

```sql
GRANT CREATE DATABASE LINK TO SCOTT;
```

- 로컬 PC HR 계정에 대한 DB Link 생성

```SQL
CREATE DATABASE LINK scottLink CONNECT TO HR IDENTIFIED BY HAPPY USING
'(DESCRIPTION =
  (ADDRESS_LIST =
    (ADDRESS = 
      (PROTOCOL = TCP)
      (HOST = 192.168.217.33)
      (PORT = 1522)
    )
  )
  (CONNECT_DATA =
    (SID = XE)
  }
)';
```

```
Database link HRLINK이(가) 생성되었습니다.
```
