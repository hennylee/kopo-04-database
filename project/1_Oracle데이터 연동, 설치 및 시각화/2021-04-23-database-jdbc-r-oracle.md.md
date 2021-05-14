# JDBC를 이용해서 R과 Oracle 연동 & 시각화하기



## JDBC란?

- JDBC란 Java DataBase Connectivity의 약자이다.

- 데이터베이스에 연결 및 작업을 하기 위한 자바 표준 인터페이스이다.

- 자바언어에서 데이터베이스 표준 인터페이스를 정의하고, 각 데이터베이스 회사들은 JDBC 인터페이스를 제공받아 자신들의 데이터베이스에 맞게 구현한후 드라이버를 제공한다. 

- 개발자가 JDBC API를 사용할 경우 DBMS에 알맞은 JDBC드라이버만 있으면 어떤 데이터베이스라도 사용할 수 있게 된다.

- JDBC 드라이버는 각 밴드사에서 jar파일로 제공된다.

- 쿼리를 실행하면 JDBC는 결과 값을 담은 ResultSet을 반환하게 된다.


![image](https://user-images.githubusercontent.com/77392444/115996778-a8211400-a61b-11eb-8b23-e8474ca30b2b.png)



## 연동 과정

1. (자바, 오라클이 설치되어 있다는 가정 하에) R과 R을 쉽게 사용할 수 있게 해주는 Rstudio를 설치한다.

2. Oracle과 R을 연동시키기 위해 JDBC(ojdbc8.jar)을 다운로드한다.

3. R에서 JDBC 드라이버를 로딩한다.

4. R에서 데이터베이스 Connection 연결한다.

5. 쿼리 문장을 실행해 ResultSet에 담긴 결과를 받는다.


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

- rJava 실행 : `library(rJava)`

- RJDBC 실행 : `library(RJDBC)`


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


## 데이터 시각화하기

- 오라클 데이터 JDBC로 연결하기

```r
library(DBI)
library(rJava)
library(RJDBC)

drv<-JDBC("oracle.jdbc.driver.OracleDriver",
          "C:/Program Files/Java/jdk1.8.0_241/ojdbc8.jar")

conn<-dbConnect(drv, "jdbc:oracle:thin:@//192.168.119.119:1521/dink","scott","tiger")
```

- 쿼리 실행해서 데이터 불러오기 (result 변수로 받기)

```r
query<-"SELECT city, 
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
FROM (SELECT substr(address1, 1,2) as city,
             trunc((sysdate - birth_dt) / 365) as age
      FROM customer)
GROUP BY city, age
ORDER BY age, city"

result <- dbGetQuery(conn,query)
```


- ggplot 활용해서 데이터 시각화하기

```r
install.packages("ggplot2")
library(ggplot2)

q <- ggplot(data=result, aes(x=CITY, y=COUNT, fill=AGE_RANGE)) 
q +  geom_bar(stat="identity")
```


- 결과

![image](https://user-images.githubusercontent.com/77392444/117036690-abfe1600-ad40-11eb-9166-9506fb43058e.png)


