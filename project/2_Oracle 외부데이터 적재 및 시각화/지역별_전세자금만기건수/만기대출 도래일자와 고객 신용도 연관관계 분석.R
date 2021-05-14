# 만기대출 도래일자와 고객 신용도 연관관계 분석

library(DBI)
library(rJava)
library(RJDBC)
library(RODBC)
library(ggplot2)

db<-odbcConnect("dns", uid="scott", pwd="tiger")



query<-"SELECT C.REGDATE, C.COUNT, S.COUNT, S.PRICE
FROM (
    SELECT COUNT(ID) COUNT, SUBSTR(REGDATE,0,5) AS REGDATE FROM CORONA GROUP BY SUBSTR(REGDATE,0,5) ORDER BY REGDATE
) C, (
    SELECT SUM(COUNT) AS COUNT, SUM(PRICE_B) AS PRICE, SUBSTR(REGDATE,0,5) AS REGDATE FROM STUDENT_LOAN GROUP BY SUBSTR(REGDATE,0,5) ORDER BY REGDATE
) S
WHERE C.REGDATE = S.REGDATE"

result <- sqlQuery(db,query)

result

pairs(result[2:3])

ggplot(result, aes(x=COUNT, y=COUNT.1))+geom_point()


cor.test(result$COUNT, result$COUNT.1)


q <- ggplot(data=result, aes(x=COUNT, y=COUNT.1)) 
q +  geom_bar(stat="identity")

