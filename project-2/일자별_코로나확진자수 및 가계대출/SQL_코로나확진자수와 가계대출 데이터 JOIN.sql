SELECT * FROM CORONA;
SELECT * FROM HOUSE_LOAN;

-- 월별 코로나 확진자 수 구하기 : COUNT() 활용
SELECT REGDATE, COUNT(ID) FROM CORONA GROUP BY REGDATE ORDER BY REGDATE;
-- 현재는 일자별로 그룹핑됨
-- 필요한 것은 년/월별로 총확진자 수가 필요하므로 REGDATE를 년/월만 나오도록 변경할 것이다. 

SELECT SUBSTR(REGDATE,0,5) FROM CORONA;
-- SUBSTR 사용하기

-- 월별 확진자 수 구하기 
SELECT SUBSTR(REGDATE,0,5) AS REGDATE, COUNT(ID) FROM CORONA GROUP BY SUBSTR(REGDATE,0,5)
ORDER BY REGDATE;


SELECT * FROM HOUSE_LOAN;

-- 월별 가계대출 총합 구하기
-- 현재 기관별로 가계 대출 총합이 나눠져 있으니 이를 다 합쳐준 컬럼을 먼저 생성할 것이다. 
SELECT (예금취급기관+예금은행+주택담보대출+비은행예금취급기관
+주택담보대출2+상호저축은행+신용협동조합+상호금융+새마을금고+기타 ) AS TOTAL_LOAN 
FROM HOUSE_LOAN;

-- 이제 필요한 데이터를 추출한다. 
-- 기간과 대출 총합이 필요함
SELECT REPLACE(SUBSTR(기간, 3), '.','/') AS REGDATE, (예금취급기관+예금은행+주택담보대출+비은행예금취급기관
+주택담보대출2+상호저축은행+신용협동조합+상호금융+새마을금고+기타 ) AS TOTAL_LOAN 
FROM HOUSE_LOAN;

-- 기간을 JOIN할 데이터야 맞춰줘야 등가 조인이 가능하다.
SELECT SUBSTR(기간, 3) FROM HOUSE_LOAN;

-- .을 /으로 바꿔주기 위해 REPLACE()를 활용한다.
SELECT REPLACE(SUBSTR(기간, 3), '.','/') FROM HOUSE_LOAN;

DESC HOUSE_LOAN;
--예금취급기관+예금은행+주택담보대출+비은행예금취급기관+주택담보대출2+상호저축은행+신용협동조합+상호금융+새마을금고+기타 NUMBER(30,1)  

-- 이제 처리 완료한 두 테이블을 JOIN해서 월별 가계대출 총액과 코로나 확진자수를 결합한 테이블을 생성할 것이다. 
SELECT C.REGDATE, C.COUNT, H.TOTAL_LOAN
FROM (
    SELECT SUBSTR(REGDATE,0,5) AS REGDATE, COUNT(ID) AS COUNT FROM CORONA GROUP BY SUBSTR(REGDATE,0,5)
    ORDER BY REGDATE
) C, (
    SELECT REPLACE(SUBSTR(기간, 3), '.','/') AS REGDATE, (예금취급기관+예금은행+주택담보대출+비은행예금취급기관
    +주택담보대출2+상호저축은행+신용협동조합+상호금융+새마을금고+기타 ) AS TOTAL_LOAN 
    FROM HOUSE_LOAN
) H
WHERE C.REGDATE = H.REGDATE
ORDER BY REGDATE;




