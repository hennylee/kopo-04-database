BEGIN
    CREATE TABLE BY_DYNAMIC(X DATA);
END;
/

DECLARE 
    V_SQL VARCHAR2(2000);
BEGIN
    -- -----------------------------------------------------
    -- PL/SQL BLOCK 내에서 DDL, DCL 등의 계열은 동적으로만 가능함
    -- -----------------------------------------------------
    
    -- 1) 삭제
    BEGIN
        V_SQL := 'DROP TABLE BY_DYNAMIC';
        EXECUTE IMMEDIATE V_SQL;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('DYNAMIC SQL DROP =>' || SUBSTR(SQLERRM, 1, 50));
    END;
    
    -- 2) 생성
    BEGIN
        EXECUTE IMMEDIATE 'CREATE TABLE BY_DYNAMIC(X DATE)';
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('DYNAMIC SQL CREATE => ' || SUBSTR(SQLERRM, 1, 50));
    END;
END;
/

DESC BY_DYNAMIC