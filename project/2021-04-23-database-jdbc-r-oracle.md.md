# JDBC를 이용해서 R과 Oracle 연동하기


## 설치

1. 먼저 R을 설치한다. 
2. 그 다음으로 R을 쉽게 사용할 수 있게 해주는 Rstudio를 설치한다.
3. Oracle과 R을 연동시키기 위해 ojdbc8.jar파일을 설치한다 (ODBC도 사용 가능)

## R 패키지 설치

- R studio를 실행한다.

- 아래 명령어를 순서대로 입력한다. 

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
