SET SERVEROUTPUT ON

DECLARE
    TYPE T_EMP_LIST IS TABLE OF VARCHAR2(20)
        INDEX BY BINARY_INTEGER;
    TBL_EMP_LIST T_EMP_LIST;
    
    V_EMP VARCHAR2(20);
    V_INDEX NUMBER(10);
BEGIN
    TBL_EMP_LIST(1) := 'SCOTT';
    TBL_EMP_LIST(1000) := 'MILLER';
    TBL_EMP_LIST(-2134) := 'ALLEN';
    TBL_EMP_LIST(0) := 'XMAN';
    
    V_EMP := TBL_EMP_LIST(1000); -- 테이블에서 데이터 조회
    
    DBMS_OUTPUT.PUT_LINE('********************TABLE 요소 조회************************');
    DBMS_OUTPUT.PUT_LINE('DATA OF KEY 0 IS ' || TBL_EMP_LIST(0));
    DBMS_OUTPUT.PUT_LINE('DATA OF KEY 1 IS ' || TBL_EMP_LIST(1));
    DBMS_OUTPUT.PUT_LINE('DATA OF KEY 1000 IS ' || TBL_EMP_LIST(1000));
    DBMS_OUTPUT.PUT_LINE('DATA OF KEY -2134 IS ' || TBL_EMP_LIST(-2134));
    
    DBMS_OUTPUT.PUT_LINE('********************IF문**************************');
    IF NOT TBL_EMP_LIST.EXISTS(888) THEN
        DBMS_OUTPUT.PUT_LINE('DATA OF KEY 888 IS NOT EXIST');
    END IF;
    
    V_INDEX := TBL_EMP_LIST.FIRST; -- PRIOR, FIRST, LAST
    
    DBMS_OUTPUT.PUT_LINE('**********************LOOP문************************');
    LOOP
        DBMS_OUTPUT.PUT_LINE('LOOP( '||TO_CHAR(V_INDEX)||' ) : '||TBL_EMP_LIST(V_INDEX));
        V_INDEX := TBL_EMP_LIST.NEXT(V_INDEX);
        EXIT WHEN V_INDEX IS NULL;
    END LOOP;
    
    -- NO_DATA_FOUND : RUNTIME ERROR 발생!!!
    DBMS_OUTPUT.PUT_LINE('*******************존재하지 않는 데이터*****************');
    DBMS_OUTPUT.PUT_LINE('DATA OF KEY 999 IS '||TBL_EMP_LIST(999));
    DBMS_OUTPUT.PUT_LINE('DATA OF KEY 0 IS '||TBL_EMP_LIST(0));
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('*********************예외구문************************');
        DBMS_OUTPUT.PUT_LINE('ERROR CODE => '|| TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('ERROR MSG => '|| TO_CHAR(SQLERRM));
END;
/
    