-- 법정 영업일 리팩토링

-- 꿀팁 : Ctrl + F7 , [마우스 우클릭 - 형식]

-- 리팩토링 전
SELECT
    DECODE(
        TO_CHAR(last_day(SYSDATE),'D'),
        7,
        last_day(SYSDATE) - 1,
        1,
        last_day(SYSDATE) - 2,
        last_day(SYSDATE)
    ) AS "법정 영업일"
FROM
    dual;
    
    
-- 리팩토링 후
SELECT
    CASE TO_CHAR(last_day(SYSDATE), 'D')
        WHEN '7' THEN last_day(SYSDATE) - 1
        WHEN '1' THEN last_day(SYSDATE) - 2
        ELSE last_day(SYSDATE)
    END
    AS "법정 영업일"
FROM
    dual;

-- 가독성 리팩토링 후 : 서브쿼리 재사용
SELECT
    CASE TO_CHAR(l_day, 'DAY', 'NLS_DATE_LANGUAGE = KOREAN')
        WHEN '토요일' THEN l_day - 1
        WHEN '일요일' THEN l_day - 2
        ELSE l_day
    END
    AS "법정 영업일"
FROM
    (SELECT last_day(SYSDATE) AS l_day FROM DUAL);
    
-- 가독성 리팩토링 후 : 서브쿼리 없이 재사용
SELECT
    CASE TO_CHAR(l_day, 'DAY', 'NLS_DATE_LANGUAGE = KOREAN')
        WHEN '토요일' THEN l_day - 1
        WHEN '일요일' THEN l_day - 2
        ELSE l_day
    END
    AS "법정 영업일"
FROM
    (SELECT last_day(SYSDATE) AS l_day FROM DUAL);