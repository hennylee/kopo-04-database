
## 로컬PC (로컬, 클라이언트)

- 로컬PC 접속 정보 (pw : happy)

![image](https://user-images.githubusercontent.com/77392444/121105251-b3807580-c83e-11eb-8923-8b8175d59efe.png)

- 권한 확인

```sql
SELECT DISTINCT PRIVILEGE AS "Database Link Privileges"
FROM ROLE_SYS_PRIVS
WHERE PRIVILEGE IN ( 'CREATE SESSION','CREATE DATABASE LINK','CREATE PUBLIC DATABASE LINK');
```

- 권한 결과 : 권한이 존재하지 않음

![image](https://user-images.githubusercontent.com/77392444/121105523-3c97ac80-c83f-11eb-9e59-28bae5ff5a6b.png)



## 서버실 (원격, 서버)

- 서버실 접속 정보 (pw : tiger)

![image](https://user-images.githubusercontent.com/77392444/121105299-d1e67100-c83e-11eb-91c1-5bae13f0d8e6.png)

- 권한 확인

```sql
SELECT DISTINCT PRIVILEGE AS "Database Link Privileges"
FROM ROLE_SYS_PRIVS
WHERE PRIVILEGE IN ( 'CREATE SESSION','CREATE DATABASE LINK','CREATE PUBLIC DATABASE LINK');
```

- 권한 결과 : 권한이 존재하지 않음

![image](https://user-images.githubusercontent.com/77392444/121105502-3275ae00-c83f-11eb-94c1-66d3d6532c2f.png)



## 상황 시나리오

- 서버실 DBMS 에 접속하여 분산 트랜잭션을 실행하려고 한다. 

- 현재, 로컬 PC에 DB Link 권한이 없는 상태에서 DB Link를 생성할 수 있을까?
