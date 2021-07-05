SET SERVEROUTPUT ON

REM ---------------------------------------------
REM EXCEPTION 발생을 기록하는 LOG 테이블
REM ---------------------------------------------

CREATE TABLE EXCEPTION_LOG
(
    LOG_DATE VARCHAR2(8) DEFAULT TO_CHAR(SYSDATE, 'YYYYMMDD'),
    LOG_TIME VARCHAR2(6) DEFAULT TO_CHAR(SYSDATE, 'HH24MISS'),
    PROGRAM_NAME VARCHAR2(100),
    ERROR_MESSAGE VARCHAR2(250),
    DESCRIPTION VARCHAR2(250)
);

CREATE OR REPLACE PROCEDURE CHANGE_SALARY(A_EMPNO IN NUMBER , A_SALARY NUMBER DEFAULT 2000)
AS
    V_ERROR_MESSAGE EXCEPTION_LOG.ERROR_MESSAGE%TYPE;
BEGIN
    UPDATE EMP SET SAL = A_SALARY WHERE EMPNO = A_EMPNO;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        --DBMS_OUTPUT.PUT_LINE('OTHERS => : '||SQLERRM);
        ROLLBACK;
        
        BEGIN
            V_ERROR_MESSAGE := SQLERRM;
            INSERT INTO EXCEPTION_LOG(PROGRAM_NAME, ERROR_MESSAGE, DESCRIPTION)
                VALUES('CHANGE_SALARY', V_ERROR_MESSAGE,
                    'VALUES : [1] =>' ||A_EMPNO||' [2] =>'||A_SALARY);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;
END CHANGE_SALARY;
/

REM ---------------------------------------------
REM PROCEDURE 테스트
REM ---------------------------------------------

EXECUTE CHANGE_SALARY(A_EMPNO => 7369, A_SALARY => 124578);
SELECT * FROM EXCEPTION_LOG;
/*
LOG_DATE LOG_TI PROGRAM_NAME                                                                                         ERROR_MESSAGE                                                                                                                                                                                                                                              DESCRIPTION                                                                                                                                                                                                                                               
-------- ------ ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
20210705 152030 CHANGE_SALARY              
*/
