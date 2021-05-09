
-- 출생년도별 고객 수
SELECT to_char(BIRTH_DT,'yyyy'), COUNT(*)  FROM CUSTOMER GROUP BY to_char(BIRTH_DT,'yyyy') 
ORDER BY to_char(BIRTH_DT,'yyyy');


SELECT trunc(sysdate - birth_dt) FROM CUSTOMER;

desc CUSTOMER;

-- 나이별 고객 수
-- 출생년도별 고객 수
SELECT (2021 - to_char(BIRTH_DT,'yyyy')), COUNT(*)  FROM CUSTOMER GROUP BY (2021 - to_char(BIRTH_DT,'yyyy')) ORDER BY (2021 - to_char(BIRTH_DT,'yyyy'));

desc 

CASE (2021 - to_char(BIRTH_DT,'YYYY')) 
    WHEN BETWEEN 0 AND 19 THEN '10대 이하'
    WHEN BETWEEN 20 AND 29 THEN '20대'
    WHEN BETWEEN 30 AND 39 THEN '30대'
    WHEN BETWEEN 40 AND 49 THEN '40대'
    WHEN BETWEEN 50 AND 59 THEN '50대'
    WHEN BETWEEN 60 AND 69 THEN '60대'
    WHEN BETWEEN 70 AND 79 THEN '70대'
    WHEN BETWEEN 80 AND 89 THEN '80대'
    WHEN BETWEEN 90 AND 100 THEN '90대'
    ELSE '기타'
    END as customer_age
    
    
-- 성별, 출생년도별 고객 수
SELECT to_char(BIRTH_DT,'yyyy'),GENDER, COUNT(*)  FROM CUSTOMER GROUP BY GENDER, to_char(BIRTH_DT,'yyyy') ORDER BY to_char(BIRTH_DT,'yyyy');

SELECT ID FROM CUSTOMER;

SELECT COUNT(*) FROM CUSTOMER;
SELECT * FROM CUSTOMER;



select age, city, count(*) as count 
from (select substr(address1, 1,2) as city, 
             floor((to_char(sysdate, 'YYYY') - to_char(birth_dt, 'YYYY')) / 10) * 10 as age
      from customer) temp
group by city, age
order by age, city;



SELECT city, age, gender, count(*) as count 
FROM (SELECT substr(address1, 1,2) as city, gender,
             trunc((sysdate - birth_dt) / 365) as age
      FROM customer)
GROUP BY city, age, gender
ORDER BY age, city, gender;



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
ORDER BY age, city, gender;



      SELECT substr(address1, 1,2) as city, gender,
             trunc((sysdate - birth_dt) / 365) as age,
             CASE
                WHEN trunc((sysdate - birth_dt) / 365) BETWEEN 10 AND 19 THEN '10대'
                WHEN trunc((sysdate - birth_dt) / 365) BETWEEN 20 AND 29 THEN '20대'
                WHEN trunc((sysdate - birth_dt) / 365) BETWEEN 30 AND 39 THEN '30대'
                WHEN trunc((sysdate - birth_dt) / 365) BETWEEN 40 AND 49 THEN '40대'
                WHEN trunc((sysdate - birth_dt) / 365) BETWEEN 50 AND 59 THEN '50대'
                WHEN trunc((sysdate - birth_dt) / 365) BETWEEN 60 AND 69 THEN '60대'
                WHEN trunc((sysdate - birth_dt) / 365) BETWEEN 70 AND 79 THEN '70대'
                ELSE '기타'
            END as age_range
      FROM customer;