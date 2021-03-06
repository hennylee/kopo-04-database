# ODBC를 이용해서 excel과 Oracle 연동 & 시각화하기

## ODBC란?

- ODBC란 Open DataBase Connectivity의 약자이다.

- 즉 ODBC란 어떤 응용프로그램을 사용하는지에 관계없이, 데이터베이스를 자유롭게 사용하기 위하여 만든 응용프로그램의 표준방법을 말한다.

- ODBC란 마이크로소프트 사에 의해 만들어진 데이터베이스에 접근하기 위한 소프트웨어의 표준 규격으로, 프로그램 내에 ODBC 문장을 사용하면 MS-Access, dBase, DB2, Excel, Text 등의 여러종류의 데이터베이스에 접근할 수 있다.

- 각 데이터베이스의 차이는 ODBC 드라이버에 의해서 흡수되기 때문에 유저는 ODBC에 정해진 순서에 따라서 프로그램을 쓰면 접속처의 데이터베이스가 어떠한 데이터베이스 관리 시스템에 관리되고 있는지 의식할 필요 없이 접근할 수 있다는 것이 특징이다.

- ODBC가 SQL 요청을 받아서 그것을 개개의 데이터베이스 시스템들이 이해할 수 있도록 변환하기 때문이다.

- 이를 위해서는 ODBC 소프트웨어 외에, 액세스 할 각 데이터베이스마다 별도의 모듈이나 드라이버가 필요하다.


![image](https://user-images.githubusercontent.com/77392444/115997688-0ac7df00-a61f-11eb-92f0-27ed72c56f15.png)


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


## Excel에서 Oracle DB에 저장된 데이터 활용하기

- EXCEL에서 ODBC 데이터 불러오기

![image](https://user-images.githubusercontent.com/77392444/115861291-98fc6380-a46d-11eb-8fd8-d16a9e38754d.png)

- 연결한 DNS 선택하고, SQL문 작성하기

![image](https://user-images.githubusercontent.com/77392444/115861546-dfea5900-a46d-11eb-97d4-a8bab858d933.png)

```sql
SELECT city, gender, 
CASE
    WHEN age BETWEEN 10 AND 19 THEN '10대'
    WHEN age BETWEEN 20 AND 29 THEN '20대'
    WHEN age BETWEEN 30 AND 39 THEN '30대'
    WHEN age BETWEEN 40 AND 49 THEN '40대'
    WHEN age BETWEEN 50 AND 59 THEN '50대'
    WHEN age BETWEEN 60 AND 69 THEN '60대'
    WHEN age BETWEEN 70 AND 79 THEN '70대'
    ELSE '기타'
END as age_range, count(*) as count 
FROM (SELECT substr(address1, 1,2) as city, gender,
             trunc((sysdate - birth_dt) / 365) as age
      FROM customer)
GROUP BY city, age, gender
ORDER BY age, city, gender
```

- 데이터 로드 혹은 데이터 변환 하기

![image](https://user-images.githubusercontent.com/77392444/115861409-b7faf580-a46d-11eb-9b7d-cb812e6604ed.png)


- 데이터 로드 완료

![image](https://user-images.githubusercontent.com/77392444/115861706-145e1500-a46e-11eb-8dad-fc9ee5110b3b.png)


## 데이터 시각화 하기

- 로드된 데이터에 적절한 시각화 방법 결정하기

![image](https://user-images.githubusercontent.com/77392444/117035577-6e4cbd80-ad3f-11eb-8f0d-07d07d820ed3.png)


- 피벗차트 만들기 (표 전체 선택 - 삽입 - 피벗테이블)

![image](https://user-images.githubusercontent.com/77392444/117035743-a3591000-ad3f-11eb-9264-67ee95b4cf04.png)


- 피벗 차트 필드 설정하기

![image](https://user-images.githubusercontent.com/77392444/117036004-efa45000-ad3f-11eb-9092-e963c38a7a57.png)
