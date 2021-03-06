-- 코로나 확진자 수
SELECT * FROM CORONA;

-- 년월 추출 : SUBSTR(REGDATE,0,5)
SELECT SUBSTR(REGDATE,0,5) FROM CORONA;
SELECT SUBSTR(REGDATE,0,5) AS REGDATE, COUNT(ID) COUNT FROM CORONA GROUP BY SUBSTR(REGDATE,0,5) ORDER BY REGDATE;


-- 마스크 가격
SELECT * FROM MASK_PRICE;
SELECT TRUNC(AVG(NVL(PRICE, 0))) AS PRICE, SUBSTR(REGDATE,0,5) AS REGDATE FROM MASK_PRICE GROUP BY SUBSTR(REGDATE,0,5) ORDER BY REGDATE;


-- 학자금 대출
SELECT * FROM STUDENT_LOAN;
SELECT SUM(COUNT) AS COUNT, SUM(PRICE_B) AS PRICE, SUBSTR(REGDATE,0,5) AS REGDATE FROM STUDENT_LOAN GROUP BY SUBSTR(REGDATE,0,5) ORDER BY REGDATE;

-- 가계대출
-- 세로축을 더할때는 SUM을 사용하지만, 가로축을 더할때는 + 를 사용한다. 
SELECT * FROM HOUSE_LOAN;
SELECT REPLACE(SUBSTR(기간,3),'.','/') AS REGDATE, (예금취급기관 + 예금은행 + 주택담보대출 + 비은행예금취급기관 + 주택담보대출2 + 상호저축은행 + 신용협동조합 + 상호금융 + 새마을금고 + 기타) AS TOTAL_LOAN FROM HOUSE_LOAN ORDER BY 기간;





-- JOIN
SELECT C.REGDATE, C.COUNT, H.TOTAL_LOAN
FROM (
    SELECT COUNT(ID) COUNT, SUBSTR(REGDATE,0,5) AS REGDATE FROM CORONA GROUP BY SUBSTR(REGDATE,0,5) ORDER BY REGDATE
) C, (
    SELECT REPLACE(SUBSTR(기간,3),'.','/') AS REGDATE, (예금취급기관 + 예금은행 + 주택담보대출 + 비은행예금취급기관 + 주택담보대출2 + 상호저축은행 + 신용협동조합 + 상호금융 + 새마을금고 + 기타) AS TOTAL_LOAN FROM HOUSE_LOAN ORDER BY 기간
) H
WHERE C.REGDATE = H.REGDATE;