# JDBC를 이용해서 R과 Oracle 연동하기



## JDBC란?

- JDBC란 Java DataBase Connectivity

- 데이터베이스에 연결 및 작업을 하기 위한 자바 표준 인터페이스이다.

- 자바언어에서 데이터베이스 표준 인터페이스를 정의하고, 각 데이터베이스 회사들은 JDBC 인터페이스를 제공받아 자신들의 데이터베이스에 맞게 구현한후 드라이버를 제공한다. 

- 개발자가 JDBC API를 사용할 경우 DBMS에 알맞은 JDBC드라이버만 있으면 어떤 데이터베이스라도 사용할 수 있게 된다.

- JDBC 드라이버는 각 밴드사에서 jar파일로 제공된다.


![image](https://user-images.githubusercontent.com/77392444/115996778-a8211400-a61b-11eb-8b23-e8474ca30b2b.png)



## 설치과정

1. (자바, 오라클이 설치되어 있다는 가정 하에) R을 설치한다. 
2. 그 다음으로 R을 쉽게 사용할 수 있게 해주는 Rstudio를 설치한다.
3. Oracle과 R을 연동시키기 위해 JDBC(ojdbc8.jar)을 다운로드한다.
4. R에서 JDBC 드라이버를 로딩한다.
5. R에서 데이터베이스 Connection 연결한다.
6. 쿼리 문장 실행한다.

## R 패키지 설치

- R studio를 실행한다.

- 아래 명령어를 순서대로 입력한다. 
  - rJava, DBI, RJDBC 패키지는 의존성이 있으므로 순서대로 설치해야 한다. (순서가 바뀌면 에러 발생)

-  rJava 패키지 설치 : `install.packages("rJava")`
  - rJava : R에서 Java로 이어주는 간단한 인터페이스

- DBI 패키지 설치 : install.packages("DBI")

- RJDBC 패키지 설치  :install.packages("RJDBC")

- 자바 환경변수 설정 : `Sys.setenv("JAVA_HOME"='C:\\Program Files\\Java\\jdk1.8.0_241')`

- 환경변수 확인하는 방법

![image](https://user-images.githubusercontent.com/77392444/115855307-115f2680-a466-11eb-95c4-908f8bf082fc.png)


## 연동 후 쿼리 전송

- DBI 실행 : `library(DBI)`

- rJava 실행 : library(rJava)

- RJDBC 실행 : library(RJDBC)


- 드라이버 설정 : 

```r
drv<-JDBC("oracle.jdbc.driver.OracleDriver", "C:/Program Files/Java/jdk1.8.0_241/ojdbc8.jar")
```

- OracleDB와 연결 :

```r
conn<-dbConnect(drv, "jdbc:oracle:thin:@//192.168.119.119:1521/dink","scott","tiger")
```


- 쿼리 변수에 저장 : `query<-"SELECT * FROM EMP"`

- 쿼리 실행 : `dbGetQuery(conn,query)`

![image](https://user-images.githubusercontent.com/77392444/115861094-563a8b80-a46d-11eb-8156-05986b2acc1f.png)
