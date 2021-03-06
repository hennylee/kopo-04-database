SELECT * FROM CUSTOMER;

DESC CUSTOMER;

-- [CUSTOMER]
-- 서울 지역으로 한정
-- 구 찾을 때 공백 전까지만 잘랐음
-- 구, 신용등급의 평균의 순위, ID만 추출
-- ID, CREDIT_LIMIT, SUBSTR(ADDRESS1, 4,4)


--AVG(NVL(CREDIT_LIMIT, 0)) AS CREDIT_LIMIT


SELECT AVG(NVL(CREDIT_LIMIT, 0)) AS CREDIT_LIMIT, GU
FROM (
    SELECT ID, CREDIT_LIMIT, SUBSTR(ADDRESS1, 4,INSTR(ADDRESS1, ' ')) AS GU
    FROM CUSTOMER
    WHERE ADDRESS1 LIKE '%서울%'
)
GROUP BY GU;


-- 신용등급의 평균까지 구함
SELECT TRUNC(AVG(NVL(CREDIT_LIMIT, 0))) AS CREDIT_LIMIT, SUBSTR(ADDRESS1, 4,INSTR(ADDRESS1, ' ')) AS GU
FROM CUSTOMER
WHERE ADDRESS1 LIKE '%서울%'
GROUP BY SUBSTR(ADDRESS1, 4,INSTR(ADDRESS1, ' '));


-- 신용한도 지역별 랭킹까지 구함
SELECT TRUNC(AVG(NVL(CREDIT_LIMIT, 0))) AS CREDIT_LIMIT, SUBSTR(ADDRESS1, 4,INSTR(ADDRESS1, ' ')) AS GU
, DENSE_RANK() OVER (ORDER BY TRUNC(AVG(NVL(CREDIT_LIMIT, 0))) DESC) DENSE_RANK
FROM CUSTOMER
WHERE ADDRESS1 LIKE '%서울%'
GROUP BY SUBSTR(ADDRESS1, 4,INSTR(ADDRESS1, ' '));




SELECT * FROM LEASE_EXPIRE;

-- [LEASE_EXPIRE]
-- 지역별 도래 건수
SELECT GU, SUM(COUNT) AS COUNT
FROM LEASE_EXPIRE
GROUP BY GU;

-- 지역별 도래건수 순위
SELECT GU, SUM(COUNT) AS COUNT, DENSE_RANK() OVER (ORDER BY SUM(COUNT) DESC) DENSE_RANK
FROM LEASE_EXPIRE
GROUP BY GU;



-- [JOIN] COUNT와 CREDIT_LIMIT의 상관관계
-- 등가 조인 
/*
SELECT L.GU, L.COUNT, C.CREDIT_LIMIT
FROM LEASE_EXPIRE L, CUSTOMER C
WHERE L.GU = C.GU;
*/

SELECT L.GU, L.COUNT, C.CREDIT_LIMIT
FROM (
    SELECT GU, SUM(COUNT) AS COUNT
    FROM LEASE_EXPIRE
    GROUP BY GU
) L, (
    SELECT TRUNC(AVG(NVL(CREDIT_LIMIT, 0))) AS CREDIT_LIMIT, SUBSTR(ADDRESS1, 4,INSTR(ADDRESS1, ' ')) AS GU
    FROM CUSTOMER
    WHERE ADDRESS1 LIKE '%서울%'
    GROUP BY SUBSTR(ADDRESS1, 4,INSTR(ADDRESS1, ' '))
) C
WHERE L.GU = C.GU;



-- [JOIN] COUNT 순위와 CREDIT_LIMIT 순위의 상관관계
-- OUTER JOIN : (+) 사용해서 JOIN조건을 만족하지 않는 경우의 데이터도 출력
SELECT L.GU, L.DENSE_RANK, C.DENSE_RANK
FROM (
    SELECT GU, SUM(COUNT) AS COUNT, DENSE_RANK() OVER (ORDER BY SUM(COUNT) DESC) DENSE_RANK
    FROM LEASE_EXPIRE
    GROUP BY GU
) L, (
    SELECT TRUNC(AVG(NVL(CREDIT_LIMIT, 0))) AS CREDIT_LIMIT, SUBSTR(ADDRESS1, 4,INSTR(ADDRESS1, ' ')) AS GU
    , DENSE_RANK() OVER (ORDER BY TRUNC(AVG(NVL(CREDIT_LIMIT, 0))) DESC) DENSE_RANK
    FROM CUSTOMER
    WHERE ADDRESS1 LIKE '%서울%'
    GROUP BY SUBSTR(ADDRESS1, 4,INSTR(ADDRESS1, ' '))
) C
WHERE L.GU(+) = C.GU
ORDER BY C.DENSE_RANK;



-- [JOIN] COUNT 순위와 CREDIT_LIMIT 순위의 상관관계
-- 등가 JOIN : 사용해서 JOIN조건을 만족하지 않는 경우의 데이터는 뺌
SELECT L.GU, L.DENSE_RANK, C.DENSE_RANK
FROM (
    SELECT GU, SUM(COUNT) AS COUNT, DENSE_RANK() OVER (ORDER BY SUM(COUNT) DESC) DENSE_RANK
    FROM LEASE_EXPIRE
    GROUP BY GU
) L, (
    SELECT TRUNC(AVG(NVL(CREDIT_LIMIT, 0))) AS CREDIT_LIMIT, SUBSTR(ADDRESS1, 4,INSTR(ADDRESS1, ' ')) AS GU
    , DENSE_RANK() OVER (ORDER BY TRUNC(AVG(NVL(CREDIT_LIMIT, 0))) DESC) DENSE_RANK
    FROM CUSTOMER
    WHERE ADDRESS1 LIKE '%서울%'
    GROUP BY SUBSTR(ADDRESS1, 4,INSTR(ADDRESS1, ' '))
) C
WHERE L.GU = C.GU
ORDER BY C.DENSE_RANK;




SELECT ID, CREDIT_LIMIT, SUBSTR(ADDRESS1, 4,INSTR(ADDRESS1, ' ')) AS GU
FROM CUSTOMER
WHERE ADDRESS1 LIKE '%서울%';

SELECT INSTR(ADDRESS1, ' ') FROM CUSTOMER;
SELECT SUBSTR(ADDRESS1, 4,4) FROM CUSTOMER;