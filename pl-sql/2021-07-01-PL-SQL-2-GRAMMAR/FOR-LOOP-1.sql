SET SERVEROUTPUT ON

DECLARE
    LOOP_INDEX NUMBER(4) := 1;
    MAX_LOOP_INDEX NUMBER(4) := 30;
BEGIN
    FOR LOOP_INDEX IN 1..30 -- 1부터 출력됨
    --FOR LOOP_INDEX IN 30..1 -- 출력 안됨
    --FOR LOOP_INDEX IN REVERSE 1..30 -- 30부터 출력
    --FOR LOOP_INDEX IN REVERSE 30..1 -- 출력안됨
    LOOP
        DBMS_OUTPUT.PUT_LINE('LOOP COUNT' || TO_CHAR(LOOP_INDEX));
    END LOOP;
END;
/