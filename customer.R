library(DBI)
library(rJava)
library(RJDBC)

drv<-JDBC("oracle.jdbc.driver.OracleDriver",
          "C:/Program Files/Java/jdk1.8.0_241/ojdbc8.jar")

conn<-dbConnect(drv, "jdbc:oracle:thin:@//192.168.119.119:1521/dink","scott","tiger")

Sys.setenv("JAVA_HOME"='C:\\Program Files\\Java\\jdk1.8.0_241')



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


head(result)





install.packages("ggmap")
install.packages("ggplot2")
install.packages("raster")
install.packages("rgeos")
install.packages("maptools")
install.packages("rgdal")

library(ggmap)

install.packages("ggplot2")
library(ggplot2)
library(raster)
library(rgeos)
library(maptools)


install.packages("ggplot2")
install.packages("RColorBrewer")
install.packages("ggpubr")
install.packages("ggsci")

library("RColorBrewer")
library("ggpubr")

ggplot(data=mtcars, aes(x=disp, y=mpg)) + geom_point(aes(size=hp, color=wt))


ggplot(data=result, aes(x=reorder(CITY,result$CITY), y=AGE)) + geom_bar(stat='identity')
p <- ggplot(data=result, aes(x=reorder(CITY, result$CITY), y=COUNT)) + geom_bar(stat='identity') + coord_flip()
p + labs(x='지역', y='고객수', title='지역별 고객 수')
p + geom_text(aes(label=COUNT), size=3, hjust=1.25, color='#FFFFFF')


# 최종
library(DBI)
library(rJava)
library(RJDBC)

drv<-JDBC("oracle.jdbc.driver.OracleDriver",
          "C:/Program Files/Java/jdk1.8.0_241/ojdbc8.jar")

conn<-dbConnect(drv, "jdbc:oracle:thin:@//192.168.119.119:1521/dink","scott","tiger")



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


library(ggplot2)

q <- ggplot(data=result, aes(x=CITY, y=COUNT, fill=AGE_RANGE)) 
q +  geom_bar(stat="identity")


