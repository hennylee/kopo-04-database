-- RECORD 안에 RECORD를 정의할 수 있는가? YES!

SET SERVEROUTPUT ON

DECLARE
    TYPE T_ADDRESS IS RECORD(
        ADDR1 VARCHAR2(60),
        ADDR2 VARCHAR2(60),
        ZIP VARCHAR2(7),
        PHONE VARCHAR2(14)
    );
    TYPE T_EMP_RECORD IS RECORD(
        EMPNO NUMBER(4),
        ENAME VARCHAR2(10),
        JOB VARCHAR2(9),
        ADDRESS T_ADDRESS,
        HIREDATE DATE
    );
REC_EMP T_EMP_RECORD;
BEGIN
    REC_EMP.EMPNO := 1234;
    REC_EMP.ENAME := 'XMAN';
    REC_EMP.JOB := 'DBA';
    REC_EMP.ADDRESS.ADDR1 := '강남구 역삼동';
    REC_EMP.ADDRESS.ZIP := '150-035';
    REC_EMP.HIREDATE := SYSDATE - 365;
    
    DBMS_OUTPUT.PUT_LINE('****************************************');
    DBMS_OUTPUT.PUT_LINE('사번 : '||REC_EMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('이름 : '||REC_EMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('직업 : '||REC_EMP.JOB);
    DBMS_OUTPUT.PUT_LINE('주소 : '||REC_EMP.ADDRESS.ADDR1);
    DBMS_OUTPUT.PUT_LINE('우편번호 : '||REC_EMP.ADDRESS.ZIP);
    DBMS_OUTPUT.PUT_LINE('입사일 : '||REC_EMP.HIREDATE);
    DBMS_OUTPUT.PUT_LINE('****************************************');
END;
/