-- < POLLUTION 데이터 >
-- 전체 데이터
SELECT * FROM POLLUTION;
SELECT COUNT(*) FROM POLLUTION;

-- 서울시 정보
SELECT COUNT(*) FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%';
SELECT * FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%';

-- 각 지역 컬럼에서 구 정보만 추출
SELECT SUBSTR(LOCATION_ADDR,7,2) AS ADDR1,  SUBSTR(ROAD_ADDR,7,2) AS ADDR2 FROM 
        (SELECT * FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%');

SELECT COUNT(*) FROM (
    SELECT SUBSTR(LOCATION_ADDR,7,2) AS ADDR1,  SUBSTR(ROAD_ADDR,7,2) AS ADDR2 FROM 
        (SELECT * FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%')
);

-- 서울의 구 별 갯수
SELECT COUNT(*), NVL(ADDR1, ADDR2) AS GU FROM (
    SELECT * FROM (
        SELECT SUBSTR(LOCATION_ADDR,7,3) AS ADDR1,  SUBSTR(ROAD_ADDR,7,3) AS ADDR2 FROM 
            (SELECT * FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%')
    )
) GROUP BY NVL(ADDR1, ADDR2);


-- 지역별 오염물질 배출 설치 사업장 수
-- 이상 값 존재 => 진시, 부시? 영등포구 / 영등포
SELECT COUNT(*), GU FROM(
    SELECT NVL(ADDR1, ADDR2) AS GU FROM (
        SELECT * FROM (
            SELECT LOCATION_ADDR, ROAD_ADDR, SUBSTR(LOCATION_ADDR,7,3) AS ADDR1, SUBSTR(ROAD_ADDR,7,3) AS ADDR2 FROM 
                (SELECT * FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%')
        )
    )
) GROUP BY GU ORDER BY COUNT(*) DESC;


-- 최종 : 오염물질 배출 설치 사업장이 가장 많은 구
SELECT GU FROM (
    SELECT COUNT(*), GU FROM(
        SELECT NVL(ADDR1, ADDR2) AS GU FROM (
            SELECT * FROM (
                SELECT LOCATION_ADDR, ROAD_ADDR, SUBSTR(LOCATION_ADDR,7,3) AS ADDR1, SUBSTR(ROAD_ADDR,7,3) AS ADDR2 FROM 
                    (SELECT * FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%')
            )
        )
    ) GROUP BY GU ORDER BY COUNT(*) DESC 
) WHERE ROWNUM = 1;





-- <CUSTOMER 데이터>
-- 전체 데이터
SELECT * FROM CUSTOMER;
DESC CUSTOMER;


-- 서울 추출
SELECT * FROM (SELECT * FROM CUSTOMER WHERE SUBSTR(ADDRESS1, 0,2) = '서울') SEOUL;

-- AGE, GU 만 추출
-- 이상치 : 구와 시가 혼재되어 나옴 
SELECT substr(ADDRESS1, 4,3) as GU, trunc((sysdate - BIRTH_DT) / 365) as AGE FROM (
    SELECT * FROM (SELECT * FROM CUSTOMER WHERE SUBSTR(ADDRESS1, 0,2) = '서울') SEOUL
);




-- 연령대별, GU만 추출
SELECT GU,
CASE
    WHEN AGE BETWEEN 10 AND 19 THEN '10대'
    WHEN AGE BETWEEN 20 AND 29 THEN '20대'
    WHEN AGE BETWEEN 30 AND 39 THEN '30대'
    WHEN AGE BETWEEN 40 AND 49 THEN '40대'
    WHEN AGE BETWEEN 50 AND 59 THEN '50대'
    WHEN AGE BETWEEN 60 AND 69 THEN '60대'
    WHEN AGE BETWEEN 70 AND 79 THEN '70대'
    ELSE '기타'
END AS AGE_RANGE
FROM (
    SELECT substr(ADDRESS1, 4,3) as GU, trunc((sysdate - BIRTH_DT) / 365) as AGE FROM  (
        SELECT * FROM (SELECT * FROM CUSTOMER WHERE SUBSTR(ADDRESS1, 0,2) = '서울') SEOUL
    )
);


-- 연령대별, GU별 고객 수 추출
SELECT GU, AGE_RANGE, COUNT(*) FROM (
    SELECT GU,
    CASE
        WHEN AGE BETWEEN 10 AND 19 THEN '10대'
        WHEN AGE BETWEEN 20 AND 29 THEN '20대'
        WHEN AGE BETWEEN 30 AND 39 THEN '30대'
        WHEN AGE BETWEEN 40 AND 49 THEN '40대'
        WHEN AGE BETWEEN 50 AND 59 THEN '50대'
        WHEN AGE BETWEEN 60 AND 69 THEN '60대'
        WHEN AGE BETWEEN 70 AND 79 THEN '70대'
        ELSE '기타'
    END AS AGE_RANGE
    FROM (
        SELECT substr(ADDRESS1, 4,3) as GU, trunc((sysdate - BIRTH_DT) / 365) as AGE FROM (
            SELECT * FROM (SELECT * FROM CUSTOMER WHERE SUBSTR(ADDRESS1, 0,2) = '서울') SEOUL
        )
    )
)
GROUP BY GU, AGE_RANGE
ORDER BY COUNT(*) DESC;



-- <JOIN>

-- TABLE 1
SELECT * FROM (
    SELECT GU, AGE_RANGE, COUNT(*) FROM (
        SELECT GU,
        CASE
            WHEN AGE BETWEEN 10 AND 19 THEN '10대'
            WHEN AGE BETWEEN 20 AND 29 THEN '20대'
            WHEN AGE BETWEEN 30 AND 39 THEN '30대'
            WHEN AGE BETWEEN 40 AND 49 THEN '40대'
            WHEN AGE BETWEEN 50 AND 59 THEN '50대'
            WHEN AGE BETWEEN 60 AND 69 THEN '60대'
            WHEN AGE BETWEEN 70 AND 79 THEN '70대'
            ELSE '기타'
        END AS AGE_RANGE
        FROM (
            SELECT substr(ADDRESS1, 4,3) as GU, trunc((sysdate - BIRTH_DT) / 365) as AGE FROM (
                SELECT * FROM (SELECT * FROM CUSTOMER WHERE SUBSTR(ADDRESS1, 0,2) = '서울') SEOUL
            )
        )
    )
    GROUP BY GU, AGE_RANGE
    ORDER BY COUNT(*) DESC
) C;

-- TABLE 2
SELECT * FROM (
    SELECT GU FROM (
        SELECT COUNT(*), GU FROM(
            SELECT NVL(ADDR1, ADDR2) AS GU FROM (
                SELECT * FROM (
                    SELECT LOCATION_ADDR, ROAD_ADDR, SUBSTR(LOCATION_ADDR,7,3) AS ADDR1, SUBSTR(ROAD_ADDR,7,3) AS ADDR2 FROM 
                        (SELECT * FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%')
                )
            )
        ) GROUP BY GU ORDER BY COUNT(*) DESC 
    ) WHERE ROWNUM = 1
) P;


-- 두 개 JOIN : 페기물이 가장 많은 지역의 => 고객 연령대별 수 구하기 
/*
SELECT * FROM () C
INNER JOIN () P ON
C.GU = P.GU;
*/
SELECT AGE_RANGE,COUNT FROM (SELECT GU, AGE_RANGE, COUNT(*) AS COUNT FROM (
        SELECT GU,
        CASE
            WHEN AGE BETWEEN 10 AND 19 THEN '10대'
            WHEN AGE BETWEEN 20 AND 29 THEN '20대'
            WHEN AGE BETWEEN 30 AND 39 THEN '30대'
            WHEN AGE BETWEEN 40 AND 49 THEN '40대'
            WHEN AGE BETWEEN 50 AND 59 THEN '50대'
            WHEN AGE BETWEEN 60 AND 69 THEN '60대'
            WHEN AGE BETWEEN 70 AND 79 THEN '70대'
            ELSE '기타'
        END AS AGE_RANGE
        FROM (
            SELECT substr(ADDRESS1, 4,3) as GU, trunc((sysdate - BIRTH_DT) / 365) as AGE FROM (
                SELECT * FROM (SELECT * FROM CUSTOMER WHERE SUBSTR(ADDRESS1, 0,2) = '서울') SEOUL
            )
        )
    )
    GROUP BY GU, AGE_RANGE
    ORDER BY COUNT(*) DESC) C
INNER JOIN (SELECT GU FROM (
        SELECT COUNT(*), GU FROM(
            SELECT NVL(ADDR1, ADDR2) AS GU FROM (
                SELECT * FROM (
                    SELECT LOCATION_ADDR, ROAD_ADDR, SUBSTR(LOCATION_ADDR,7,3) AS ADDR1, SUBSTR(ROAD_ADDR,7,3) AS ADDR2 FROM 
                        (SELECT * FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%')
                )
            )
        ) GROUP BY GU ORDER BY COUNT(*) DESC 
    ) WHERE ROWNUM = 1) P ON
C.GU = P.GU;


-- 두 개 JOIN : 페기물이 가장 많은 지역의 => 고객 연령대별가 가장 많은 분포 구하기 => 50대
SELECT AGE_RANGE FROM (SELECT GU, AGE_RANGE, COUNT(*) AS COUNT FROM (
        SELECT GU,
        CASE
            WHEN AGE BETWEEN 10 AND 19 THEN '10대'
            WHEN AGE BETWEEN 20 AND 29 THEN '20대'
            WHEN AGE BETWEEN 30 AND 39 THEN '30대'
            WHEN AGE BETWEEN 40 AND 49 THEN '40대'
            WHEN AGE BETWEEN 50 AND 59 THEN '50대'
            WHEN AGE BETWEEN 60 AND 69 THEN '60대'
            WHEN AGE BETWEEN 70 AND 79 THEN '70대'
            ELSE '기타'
        END AS AGE_RANGE
        FROM (
            SELECT substr(ADDRESS1, 4,3) as GU, trunc((sysdate - BIRTH_DT) / 365) as AGE FROM (
                SELECT * FROM (SELECT * FROM CUSTOMER WHERE SUBSTR(ADDRESS1, 0,2) = '서울') SEOUL
            )
        )
    )
    GROUP BY GU, AGE_RANGE
    ORDER BY COUNT(*) DESC) C
INNER JOIN (SELECT GU FROM (
        SELECT COUNT(*), GU FROM(
            SELECT NVL(ADDR1, ADDR2) AS GU FROM (
                SELECT * FROM (
                    SELECT LOCATION_ADDR, ROAD_ADDR, SUBSTR(LOCATION_ADDR,7,3) AS ADDR1, SUBSTR(ROAD_ADDR,7,3) AS ADDR2 FROM 
                        (SELECT * FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%')
                )
            )
        ) GROUP BY GU ORDER BY COUNT(*) DESC 
    ) WHERE ROWNUM = 1) P ON
C.GU = P.GU
WHERE ROWNUM = 1;



-- 타겟은 50대 + 구로구! => 50대 고객의 정보 출력
-- 필요한 고객 정보 : ID, NAME, MOBILE_NO, EMAIL, ADDRESS1,BIRTH_DT 


-- JOIN을 사용하지 않은 쿼리
SELECT * FROM (
    SELECT ID, NAME, MOBILE_NO, EMAIL, ADDRESS1,BIRTH_DT, GU,
    CASE
        WHEN AGE BETWEEN 10 AND 19 THEN '10대'
        WHEN AGE BETWEEN 20 AND 29 THEN '20대'
        WHEN AGE BETWEEN 30 AND 39 THEN '30대'
        WHEN AGE BETWEEN 40 AND 49 THEN '40대'
        WHEN AGE BETWEEN 50 AND 59 THEN '50대'
        WHEN AGE BETWEEN 60 AND 69 THEN '60대'
        WHEN AGE BETWEEN 70 AND 79 THEN '70대'
        ELSE '기타'
    END AS AGE_RANGE
    FROM (
        SELECT ID, NAME, MOBILE_NO, EMAIL, ADDRESS1,BIRTH_DT,substr(ADDRESS1, 4,3) as GU, trunc((sysdate - BIRTH_DT) / 365) as AGE FROM  (
            SELECT * FROM (SELECT * FROM CUSTOMER WHERE SUBSTR(ADDRESS1, 0,2) = '서울') SEOUL
        )
    )
)
WHERE AGE_RANGE = '50대' AND GU = '구로구';


-- JOIN을 사용한 쿼리
/*
SELECT * FROM (
    SELECT ID, NAME, MOBILE_NO, EMAIL, ADDRESS1,BIRTH_DT, GU,
    CASE
        WHEN AGE BETWEEN 10 AND 19 THEN '10대'
        WHEN AGE BETWEEN 20 AND 29 THEN '20대'
        WHEN AGE BETWEEN 30 AND 39 THEN '30대'
        WHEN AGE BETWEEN 40 AND 49 THEN '40대'
        WHEN AGE BETWEEN 50 AND 59 THEN '50대'
        WHEN AGE BETWEEN 60 AND 69 THEN '60대'
        WHEN AGE BETWEEN 70 AND 79 THEN '70대'
        ELSE '기타'
    END AS AGE_RANGE
    FROM (
        SELECT ID, NAME, MOBILE_NO, EMAIL, ADDRESS1,BIRTH_DT,substr(ADDRESS1, 4,3) as GU, trunc((sysdate - BIRTH_DT) / 365) as AGE FROM  (
            SELECT * FROM (SELECT * FROM CUSTOMER WHERE SUBSTR(ADDRESS1, 0,2) = '서울') SEOUL
        )
    )
)
WHERE AGE_RANGE = '(CUSTOMER와 POLLUTION JOIN)' AND GU = '(POLLUTION JOIN)';
*/


SELECT * FROM (
    SELECT ID, NAME, MOBILE_NO, EMAIL, ADDRESS1,BIRTH_DT, GU,
    CASE
        WHEN AGE BETWEEN 10 AND 19 THEN '10대'
        WHEN AGE BETWEEN 20 AND 29 THEN '20대'
        WHEN AGE BETWEEN 30 AND 39 THEN '30대'
        WHEN AGE BETWEEN 40 AND 49 THEN '40대'
        WHEN AGE BETWEEN 50 AND 59 THEN '50대'
        WHEN AGE BETWEEN 60 AND 69 THEN '60대'
        WHEN AGE BETWEEN 70 AND 79 THEN '70대'
        ELSE '기타'
    END AS AGE_RANGE
    FROM (
        SELECT ID, NAME, MOBILE_NO, EMAIL, ADDRESS1,BIRTH_DT,substr(ADDRESS1, 4,3) as GU, trunc((sysdate - BIRTH_DT) / 365) as AGE FROM  (
            SELECT * FROM (SELECT * FROM CUSTOMER WHERE SUBSTR(ADDRESS1, 0,2) = '서울') SEOUL
        )
    )
)
WHERE AGE_RANGE = (
SELECT AGE_RANGE FROM (SELECT GU, AGE_RANGE, COUNT(*) AS COUNT FROM (
        SELECT GU,
        CASE
            WHEN AGE BETWEEN 10 AND 19 THEN '10대'
            WHEN AGE BETWEEN 20 AND 29 THEN '20대'
            WHEN AGE BETWEEN 30 AND 39 THEN '30대'
            WHEN AGE BETWEEN 40 AND 49 THEN '40대'
            WHEN AGE BETWEEN 50 AND 59 THEN '50대'
            WHEN AGE BETWEEN 60 AND 69 THEN '60대'
            WHEN AGE BETWEEN 70 AND 79 THEN '70대'
            ELSE '기타'
        END AS AGE_RANGE
        FROM (
            SELECT substr(ADDRESS1, 4,3) as GU, trunc((sysdate - BIRTH_DT) / 365) as AGE FROM (
                SELECT * FROM (SELECT * FROM CUSTOMER WHERE SUBSTR(ADDRESS1, 0,2) = '서울') SEOUL
            )
        )
    )
    GROUP BY GU, AGE_RANGE
    ORDER BY COUNT(*) DESC) C
INNER JOIN (SELECT GU FROM (
        SELECT COUNT(*), GU FROM(
            SELECT NVL(ADDR1, ADDR2) AS GU FROM (
                SELECT * FROM (
                    SELECT LOCATION_ADDR, ROAD_ADDR, SUBSTR(LOCATION_ADDR,7,3) AS ADDR1, SUBSTR(ROAD_ADDR,7,3) AS ADDR2 FROM 
                        (SELECT * FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%')
                )
            )
        ) GROUP BY GU ORDER BY COUNT(*) DESC 
    ) WHERE ROWNUM = 1) P ON
C.GU = P.GU
WHERE ROWNUM = 1
) AND GU = (
    SELECT GU FROM (
        SELECT COUNT(*), GU FROM(
            SELECT NVL(ADDR1, ADDR2) AS GU FROM (
                SELECT * FROM (
                    SELECT LOCATION_ADDR, ROAD_ADDR, SUBSTR(LOCATION_ADDR,7,3) AS ADDR1, SUBSTR(ROAD_ADDR,7,3) AS ADDR2 FROM 
                        (SELECT * FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%')
                )
            )
        ) GROUP BY GU ORDER BY COUNT(*) DESC 
    ) WHERE ROWNUM = 1
);



-- SPOOL로 CSV 파일로 내보내기
-- 실패함 이유는 모르겠음
SET FEEDBACK OFF
SET HEAD ON
SPOOL C:\kopo-04-database\project-2\pollution_customer.CSV
SELECT /*csv*/ * FROM (
    SELECT ID, NAME, MOBILE_NO, EMAIL, ADDRESS1,BIRTH_DT, GU,
    CASE
        WHEN AGE BETWEEN 10 AND 19 THEN '10대'
        WHEN AGE BETWEEN 20 AND 29 THEN '20대'
        WHEN AGE BETWEEN 30 AND 39 THEN '30대'
        WHEN AGE BETWEEN 40 AND 49 THEN '40대'
        WHEN AGE BETWEEN 50 AND 59 THEN '50대'
        WHEN AGE BETWEEN 60 AND 69 THEN '60대'
        WHEN AGE BETWEEN 70 AND 79 THEN '70대'
        ELSE '기타'
    END AS AGE_RANGE
    FROM (
        SELECT ID, NAME, MOBILE_NO, EMAIL, ADDRESS1,BIRTH_DT,substr(ADDRESS1, 4,3) as GU, trunc((sysdate - BIRTH_DT) / 365) as AGE FROM  (
            SELECT * FROM (SELECT * FROM CUSTOMER WHERE SUBSTR(ADDRESS1, 0,2) = '서울') SEOUL
        )
    )
)
WHERE AGE_RANGE = (
SELECT AGE_RANGE FROM (SELECT GU, AGE_RANGE, COUNT(*) AS COUNT FROM (
        SELECT GU,
        CASE
            WHEN AGE BETWEEN 10 AND 19 THEN '10대'
            WHEN AGE BETWEEN 20 AND 29 THEN '20대'
            WHEN AGE BETWEEN 30 AND 39 THEN '30대'
            WHEN AGE BETWEEN 40 AND 49 THEN '40대'
            WHEN AGE BETWEEN 50 AND 59 THEN '50대'
            WHEN AGE BETWEEN 60 AND 69 THEN '60대'
            WHEN AGE BETWEEN 70 AND 79 THEN '70대'
            ELSE '기타'
        END AS AGE_RANGE
        FROM (
            SELECT substr(ADDRESS1, 4,3) as GU, trunc((sysdate - BIRTH_DT) / 365) as AGE FROM (
                SELECT * FROM (SELECT * FROM CUSTOMER WHERE SUBSTR(ADDRESS1, 0,2) = '서울') SEOUL
            )
        )
    )
    GROUP BY GU, AGE_RANGE
    ORDER BY COUNT(*) DESC) C
INNER JOIN (SELECT GU FROM (
        SELECT COUNT(*), GU FROM(
            SELECT NVL(ADDR1, ADDR2) AS GU FROM (
                SELECT * FROM (
                    SELECT LOCATION_ADDR, ROAD_ADDR, SUBSTR(LOCATION_ADDR,7,3) AS ADDR1, SUBSTR(ROAD_ADDR,7,3) AS ADDR2 FROM 
                        (SELECT * FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%')
                )
            )
        ) GROUP BY GU ORDER BY COUNT(*) DESC 
    ) WHERE ROWNUM = 1) P ON
C.GU = P.GU
WHERE ROWNUM = 1
) AND GU = (
    SELECT GU FROM (
        SELECT COUNT(*), GU FROM(
            SELECT NVL(ADDR1, ADDR2) AS GU FROM (
                SELECT * FROM (
                    SELECT LOCATION_ADDR, ROAD_ADDR, SUBSTR(LOCATION_ADDR,7,3) AS ADDR1, SUBSTR(ROAD_ADDR,7,3) AS ADDR2 FROM 
                        (SELECT * FROM POLLUTION WHERE LOCATION_ADDR LIKE '%서울특별시%' OR ROAD_ADDR LIKE '%서울특별시%')
                )
            )
        ) GROUP BY GU ORDER BY COUNT(*) DESC 
    ) WHERE ROWNUM = 1
);
SPOOL OFF;
EXIT;


