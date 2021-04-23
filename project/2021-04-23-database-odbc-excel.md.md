# Oracle Database의 데이터 Excel에 연동하기

## ODBC 다운로드

- 다운로드 : https://www.oracle.com/kr/database/technologies/instant-client/winx64-64-downloads.html

- Basic Package와 ODBC Package를 다운로드(64bit or 32bit) 후, 압축 풀어서 원하는 위치에 모아둔다. 

![image](https://user-images.githubusercontent.com/77392444/115849491-e2de4d00-a45f-11eb-9f9d-271951c58a14.png)


## tnsnames 설정

- `tnsnames.or` 로 텍스트 파일을 만들고 아래 내용을 작성하여 저장한다.
  - `(HOST=192.168.119.119)` : 연결하고자 하는 Oracle DBMS의 IP
  - `(PORT=1521))` : 연결하고자 하는 Oracle DBMS의 Port번호
  - `(SERVICE_NAME=DINK)` : 연결하고자 하는 Oracle DBMS의 서비스 네임

```
ORCL=
(DESCRIPTION=
 (ADDRESS_LIST=
  (ADDRESS=(PROTOCOL=TCP)(HOST=192.168.119.119)(PORT=1521))
 )
 (CONNECT_DATA=
 (SERVICE_NAME=DINK)
 )
)
```


## 환경변수 설정


- 아래 두 가지 시스템 환경변수를 설정한다.

![image](https://user-images.githubusercontent.com/77392444/115849360-c5a97e80-a45f-11eb-8039-7f3f445d04f3.png)


![image](https://user-images.githubusercontent.com/77392444/115849400-cfcb7d00-a45f-11eb-8e9e-0b192ddb96ae.png)


## ODBC 연결

- ODBC 데이터 원본 관리자(64비트 or 32bit) : [시스템 DSN] 선택 - [추가] 클릭

![image](https://user-images.githubusercontent.com/77392444/115850023-7152ce80-a460-11eb-8566-51b6a777bbfa.png)

- 앞서 설치한 instantclient 선택

![image](https://user-images.githubusercontent.com/77392444/115850101-8b8cac80-a460-11eb-8434-a9a52a461104.png)


- Data Source Name 은 아무거나 입력하고, TNS Service Name은 앞서 `tnsnames.or`파일 에서 설정한 이름 ORCL을 입력한다.

![image](https://user-images.githubusercontent.com/77392444/115850200-a2cb9a00-a460-11eb-9cf8-81886d413b50.png)

- Test Connection을 클릭한 후, 계정명과 비밀번호를 입력한다. (이때 Oracle DBMS 서버가 반드시 가동중이어야 한다)




