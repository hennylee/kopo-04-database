SET SERVEROUTPUT ON 

-- NOT TRUE, NOT FALSE... ???
DECLARE
    V_NUM1 NUMBER(4,2);
    V_NUM2 NUMBER(4,2) := 30;
BEGIN
    IF NOT (V_NUM1 > 1 AND V_NUM2 < 31) THEN
        DBMS_OUTPUT.PUT_LINE('(V_NUM > 1 AND V_NUM2 < 31) IS TRUE');
    ELSIF NOT (V_NUM1 > 1 AND V_NUM2 < 31) THEN
        DBMS_OUTPUT.PUT_LINE('(V_NUM1 > 1 AND V_NUM2 < 31) IS FALSE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('NOT TRUE, NOT FALSE... ???');
    END IF;
END;

-- (V_NUM > 1 AND V_NUM2 < 31) IS TRUE
DECLARE
    V_NUM1 NUMBER(4,2);
    V_NUM2 NUMBER(4,2) := 30;
BEGIN
    --FALSE
    IF(NVL(V_NUM1 > 1, TRUE) AND V_NUM2 < 31) THEN
        DBMS_OUTPUT.PUT_LINE('(V_NUM > 1 AND V_NUM2 < 31) IS TRUE');
    -- FALSE
    ELSIF NOT (V_NUM1 > 1 AND V_NUM2 < 31) THEN
        DBMS_OUTPUT.PUT_LINE('(V_NUM1 > 1 AND V_NUM2 < 31) IS FALSE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('NOT TRUE, NOT FALSE... ???');
    END IF;
END;

SELECT 'X' FROM DUAL WHERE NULL > 1;
SELECT 'X' FROM DUAL WHERE NOT (NULL > 1);

SELECT 'X' FROM DUAL WHERE 2 > 1;
SELECT 'X' FROM DUAL WHERE NOT(2 > 1);

SELECT 'X' FROM DUAL WHERE 2 < 1;
SELECT 'X' FROM DUAL WHERE NOT(2 < 1);

