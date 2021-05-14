SELECT * FROM LEASE_EXPIRE;

-- 지역별 총 만기도래 총합 구하기 
SELECT GU, SUM(COUNT) FROM LEASE_EXPIRE GROUP BY GU ORDER BY SUM(COUNT) DESC;

-- 가장 많은 지역 구하기 : 송파구
SELECT * FROM (
    SELECT GU, SUM(COUNT) FROM LEASE_EXPIRE GROUP BY GU ORDER BY SUM(COUNT) DESC
) WHERE ROWNUM = 1;


-- CUSTOMER 중에 송파구 고객 추출
SELECT * FROM CUSTOMER WHERE ADDRESS1 LIKE '%송파구%';


-- 나이
SELECT BIRTH_DT FROM CUSTOMER;
SELECT BIRTH_DT, (SYSDATE-BIRTH_DT) FROM CUSTOMER;

-- 나이 구하는 방법
/*
1. (현재 년도 - 생일 년도) + 1
2. 내림(나이 / 10) => 연령대 추출가능 
*/
SELECT MONTHS_BETWEEN(TO_CHAR(SYSDATE,'YY/MM/DD'), TO_DATE('800724')) FROM DUAL;
SELECT (MONTHS_BETWEEN(TO_CHAR(SYSDATE,'YY/MM/DD'), TO_DATE('800724'))/12) FROM DUAL;
SELECT TRUNC(MONTHS_BETWEEN(TO_CHAR(SYSDATE,'YY/MM/DD'), TO_DATE('800724'))/12,0)+1 FROM DUAL;
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, '800724')/12,0)+1 FROM DUAL;




-- [주제 : 송파구 + CREDIT 한도 높은 10% 추출해서 마케팅하기]
-- 신용한도 등급 고객 내 상대적 순위가 상위 몇 퍼센트(%)인지 구하기

-- 기초작업
SELECT * FROM CUSTOMER;
SELECT COUNT(*) FROM CUSTOMER; -- 총 고객 수 : 5714754

SELECT CREDIT_LIMIT FROM CUSTOMER ORDER BY CREDIT_LIMIT DESC; -- CREDIT 최저 = 1, CREDIT 최고 = 5000

SELECT CREDIT_LIMIT, RANK() OVER (ORDER BY credit_limit desc) RANK FROM CUSTOMER;

-- 각 랭크 별 속한 인원 수
SELECT COUNT(RANK), RANK FROM (
    SELECT CREDIT_LIMIT, RANK() OVER (ORDER BY credit_limit desc) RANK FROM CUSTOMER
) GROUP BY RANK
ORDER BY RANK;

-- 총 순위의 갯수 : 5000개
SELECT C.*, RANK() OVER (ORDER BY CREDIT_LIMIT ASC) RANK FROM CUSTOMER C;
SELECT C.*, RANK() OVER (ORDER BY CREDIT_LIMIT DESC) RANK FROM CUSTOMER C;

SELECT C.*, RANK() OVER (ORDER BY CREDIT_LIMIT DESC) RANK FROM CUSTOMER C ORDER BY RANK DESC;

SELECT C.*, DENSE_RANK() OVER (ORDER BY CREDIT_LIMIT DESC) RANK FROM CUSTOMER C ORDER BY RANK DESC;

-- 최종 : 랭크의 마지막 번호 구하기
SELECT RANK FROM (
SELECT C.*, DENSE_RANK() OVER (ORDER BY CREDIT_LIMIT DESC) RANK FROM CUSTOMER C ORDER BY RANK DESC
) WHERE ROWNUM = 1;

-- 시행착오 
SELECT COUNT(*) FROM (
    SELECT COUNT(RANK), RANK FROM (
        SELECT CREDIT_LIMIT, RANK() OVER (ORDER BY credit_limit desc) RANK FROM CUSTOMER
    ) GROUP BY RANK
    ORDER BY RANK
);

-- 랭크하나가 차지하는 퍼센트 
-- SELECT TRUNC(총 순위 갯수(=랭크의 마지막 번호) / 총 인원수 ) * 100 FROM DUAL;

-- 방법 1
SELECT 
TRUNC(
    ( 
        (
            SELECT COUNT(*) FROM (
                SELECT COUNT(RANK), RANK FROM (
                    SELECT CREDIT_LIMIT, RANK() OVER (ORDER BY credit_limit desc) RANK FROM CUSTOMER
                ) GROUP BY RANK
                ORDER BY RANK
            )
        )
    / (SELECT COUNT(*) FROM CUSTOMER) 
    ) * 100, 2
) as PERCENT
FROM DUAL;


-- 방법2
SELECT 
TRUNC(
    ( 
        (SELECT RANK FROM (
            SELECT DENSE_RANK() OVER (ORDER BY CREDIT_LIMIT DESC) RANK FROM CUSTOMER C ORDER BY RANK DESC
        ) WHERE ROWNUM = 1)
    / (SELECT COUNT(*) FROM CUSTOMER) 
    ) * 100, 2
) as PERCENT
FROM DUAL;

-- 상위 10%는? 랭킹 몇까지? 125까지
-- SELECT TRUNC( 10 / (한개의 등급)) FROM DUAL;

-- 방법1
SELECT 
TRUNC(10 / 
    (
        SELECT 
        TRUNC(
            ( 
                (SELECT COUNT(*) FROM (
                    SELECT COUNT(RANK), RANK FROM (
                        SELECT CREDIT_LIMIT, RANK() OVER (ORDER BY credit_limit desc) RANK FROM CUSTOMER
                    ) GROUP BY RANK
                    ORDER BY RANK)
                ) 
            / (SELECT COUNT(*) FROM CUSTOMER) 
            ) * 100, 2
        ) as PERCENT
        FROM DUAL
    )
) AS TOP10
FROM DUAL;

-- 방법 2
SELECT 
TRUNC(10 / 
    (
        SELECT 
            TRUNC(
                ( 
                    (
                        SELECT COUNT(*) FROM (
                            SELECT COUNT(RANK), RANK FROM (
                                SELECT CREDIT_LIMIT, RANK() OVER (ORDER BY credit_limit desc) RANK FROM CUSTOMER
                            ) GROUP BY RANK
                            ORDER BY RANK
                        )
                    )
                / (SELECT COUNT(*) FROM CUSTOMER) 
                ) * 100, 2
            ) as PERCENT
        FROM DUAL
    )
) AS TOP10 FROM DUAL;



-- 신용 등급 순위와 전체 데이터 
SELECT C.*, RANK() OVER (ORDER BY credit_limit desc) RANK FROM CUSTOMER C;

SELECT C.*, RANK() OVER (ORDER BY credit_limit desc) RANK 
FROM CUSTOMER C
ORDER BY RANK DESC;


-- 신용 등급 상위 10% 고객들의 전체 데이터

-- 왜 이렇게 나오지....RANK함수로 구해서 그럼...DENSE RANK로 구하면 됨
SELECT * FROM (
    SELECT C.*, RANK() OVER (ORDER BY credit_limit desc) RANK 
    FROM CUSTOMER C
)
WHERE RANK <= (
    SELECT 
    TRUNC(10 / 
        (
            SELECT 
            TRUNC(
                ( 
                    (SELECT COUNT(*) FROM (
                        SELECT COUNT(RANK), RANK FROM (
                            SELECT CREDIT_LIMIT, RANK() OVER (ORDER BY credit_limit desc) RANK FROM CUSTOMER
                        ) GROUP BY RANK
                        ORDER BY RANK)
                    ) 
                / (SELECT COUNT(*) FROM CUSTOMER) 
                ) * 100, 2
            ) as PERCENT
            FROM DUAL
        )
    )FROM DUAL
)
ORDER BY RANK DESC;


-- 방법 1 : 13.244초
-- DENSE RANK로 구하기
SELECT * FROM (
    SELECT C.*, DENSE_RANK() OVER (ORDER BY credit_limit desc) RANK 
    FROM CUSTOMER C
)
WHERE RANK <= (
    SELECT 
    TRUNC(10 / 
        (
            SELECT 
            TRUNC(
                ( 
                    (SELECT COUNT(*) FROM (
                        SELECT COUNT(RANK), RANK FROM (
                            SELECT CREDIT_LIMIT, RANK() OVER (ORDER BY credit_limit desc) RANK FROM CUSTOMER
                        ) GROUP BY RANK
                        ORDER BY RANK)
                    ) 
                / (SELECT COUNT(*) FROM CUSTOMER) 
                ) * 100, 2
            ) as PERCENT
            FROM DUAL
        )
    )FROM DUAL
)
ORDER BY RANK DESC;


-- 최종!!!!!!
-- 방법 2 : 11.799초
SELECT * FROM (
    SELECT C.*, DENSE_RANK() OVER (ORDER BY credit_limit desc) RANK 
    FROM CUSTOMER C
)
WHERE RANK <= (
    SELECT 
    TRUNC(10 / 
        (
            SELECT 
                TRUNC(
                    ( 
                        (
                            SELECT COUNT(*) FROM (
                                SELECT COUNT(RANK), RANK FROM (
                                    SELECT CREDIT_LIMIT, RANK() OVER (ORDER BY credit_limit desc) RANK FROM CUSTOMER
                                ) GROUP BY RANK
                                ORDER BY RANK
                            )
                        )
                    / (SELECT COUNT(*) FROM CUSTOMER) 
                    ) * 100, 2
                ) as PERCENT
            FROM DUAL
        )
    ) AS TOP10 FROM DUAL
)
ORDER BY RANK DESC;





-- 최종 : [JOIN을 활용해서 송파구 + CREDIT 한도 높은 10% 추출해서 마케팅하기
/*
SELECT * FROM CUSTOMER C, LEASE_EXPIRE L
WHERE C.GU = L.GU AND C.RANK <= 10%;

SELECT * FROM CUSTOMER C, LEASE_EXPIRE L
WHERE C.GU = L.GU AND C.CREDIT_RANK <= 10;
*/

-- 오류 !!!!! ORA-00904: "C"."RANK": 부적합한 식별자
SELECT * FROM CUSTOMER C, LEASE_EXPIRE L
WHERE C.GU = (
    SELECT * FROM (
        SELECT GU, SUM(COUNT) FROM LEASE_EXPIRE GROUP BY GU ORDER BY SUM(COUNT) DESC
    ) WHERE ROWNUM = 1
)
AND C.RANK <= 125;


-- 보완
/*
1. CUSTOMER 테이블에서 신용등급 상위 몇 %인지 구하는 컬럼 추가하기
2. CUSTOMER 테이블에서 지역구 구하는 컬럼 추가하기





