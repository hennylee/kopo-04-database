-- 이해니_SQL실기_20210531.SQL

-- 1. 가장 동명이인이 많은 이름 top-10
SELECT * FROM (
    SELECT 
    NAME AS "이름",
    COUNT(NAME) AS "동명이인 수",
    DENSE_RANK() OVER (ORDER BY COUNT(NAME) DESC) "순위"
    FROM CUSTOMER
    GROUP BY NAME
)
WHERE "순위" <= 10;


-- 2. 가장 많이 구매한 고객 100명
SELECT C.NAME, (C.ADDRESS1 || C.ADDRESS2) AS "주소" , O."구매횟수"
FROM (
    SELECT 
        CUSTOMER_ID, 
        SUM(ORDER_TOTAL) AS "총 주문금액", 
        COUNT(ID) AS "구매횟수",
        DENSE_RANK() OVER(ORDER BY SUM(ORDER_TOTAL) DESC) AS RANK
    FROM ORDERS
    WHERE
        EXTRACT(YEAR FROM ORDER_DT) = 2018
    AND 
        STATUS = 10
    GROUP BY (CUSTOMER_ID)
    ORDER BY SUM(ORDER_TOTAL) DESC
) O, CUSTOMER C
WHERE 
    O.CUSTOMER_ID = C.ID
AND O.RANK <= 100
;



-- 총금액이 가장 많은 고객순으로 나열하기
SELECT 
        CUSTOMER_ID, 
        SUM(ORDER_TOTAL) AS "총 주문금액", 
        COUNT(ID) AS "구매횟수",
        DENSE_RANK() OVER(ORDER BY SUM(ORDER_TOTAL) DESC) AS RANK
    FROM ORDERS
    WHERE
        EXTRACT(YEAR FROM ORDER_DT) = 2018
    AND 
        STATUS = 10
    GROUP BY (CUSTOMER_ID)
    ORDER BY SUM(ORDER_TOTAL) DESC;




-- 3. 가장 많이 주문된 제품 10개

-- 고친 답
SELECT * FROM (
    SELECT MAX(I.PRODUCT_ID) "제품번호", 
    MAX(P.NAME) "제품명", 
    SUM(I.QUANTITY) "총판매수량", 
    RANK() OVER(ORDER BY SUM(I.QUANTITY) DESC) AS RANK, 
    TRUNC( SUM(I.QUANTITY) / COUNT(I.PRODUCT_ID) ) "평균판매수량(1회 주문시)"
    FROM ORDER_ITEMS I, ORDERS O, PRODUCT P
    WHERE 
        I.ORDER_ID = O.ID
    AND 
        EXTRACT(YEAR FROM ORDER_DT) = 2019
    AND 
        I.PRODUCT_ID = P.ID
    AND 
        O.STATUS = 10
    GROUP BY I.PRODUCT_ID
)
WHERE RANK <= 10;


-- 틀린 답
SELECT "제품번호", P.NAME "제품명", "총판매수량","평균판매수량(1회 주문시)" FROM (
    SELECT 
        PRODUCT_ID "제품번호" ,
        SUM(NVL(QUANTITY,0)) "총판매수량", 
        TRUNC( SUM(NVL(QUANTITY,0)) / COUNT(ORDER_ID) ) "평균판매수량(1회 주문시)", 
        DENSE_RANK() OVER(ORDER BY SUM(QUANTITY) DESC) AS RANK
    FROM (
        SELECT * 
        FROM ORDERS, ORDER_ITEMS
        WHERE 
            ORDERS.ID = ORDER_ITEMS.ORDER_ID
        AND
                EXTRACT(YEAR FROM ORDER_DT) = 2018
        AND 
                STATUS = 10
    )
    GROUP BY PRODUCT_ID
), PRODUCT P
WHERE RANK <= 10;





-- 5.
SELECT MAX(E.DEPTNO) "부서번호", MAX(E.EMPNO) "사원번호", MAX(E.ENAME) "사원이름", COUNT(C."고객 번호") "고객수"
FROM (
    SELECT C.ACCOUNT_MGR , C.NAME, (C.ADDRESS1 || C.ADDRESS2) AS "주소" , O."구매횟수", O.CUSTOMER_ID "고객 번호"
    FROM (
        SELECT 
            CUSTOMER_ID, 
            SUM(ORDER_TOTAL) AS "총 주문금액", 
            COUNT(ID) AS "구매횟수",
            DENSE_RANK() OVER(ORDER BY SUM(ORDER_TOTAL) DESC) AS RANK
        FROM ORDERS
        WHERE
            EXTRACT(YEAR FROM ORDER_DT) = 2020
        AND 
            STATUS = 10
        GROUP BY (CUSTOMER_ID)
        ORDER BY SUM(ORDER_TOTAL) DESC
    ) O, CUSTOMER C
    WHERE 
        O.CUSTOMER_ID = C.ID
    AND O.RANK <= 100
) C, EMP E
WHERE C.ACCOUNT_MGR = E.EMPNO
GROUP BY C.ACCOUNT_MGR
ORDER BY COUNT(C."고객 번호") DESC
;