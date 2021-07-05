SET SERVEROUTPUT ON

REM ---------------------------------------------
REM EXCEPTION 발생을 기록하는 WRITE_LOG PROCEDURE 생성
REM ---------------------------------------------

CREATE OR REPLACE PROCEDURE WRITE_LOG(A_PROGRAM_NAME IN VARCHAR2 , A_ERROR_MESSAGE VARCHAR2, A_DESCRIPTION IN VARCHAR2)
AS
BEGIN
    INSERT INTO EXCEPTION_LOG(PROGRAM_NAME, ERROR_MESSAGE, DESCRIPTION)
        VALUES(A_PROGRAM_NAME, A_ERROR_MESSAGE, A_DESCRIPTION);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
       NULL;
END;
/

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
        WRITE_LOG('CHANGE_SALARY', SQLERRM, 'VALUES : [1] => '||A_EMPNO ||'[2] => ' || A_SALARY);
END CHANGE_SALARY;
/

REM ---------------------------------------------
REM PROCEDURE 테스트
REM ---------------------------------------------

EXECUTE CHANGE_SALARY(A_EMPNO => 7369, A_SALARY => 987495872895);
SELECT * FROM EXCEPTION_LOG;
/*
LOG_DATE LOG_TI PROGRAM_NAME                                                                                         ERROR_MESSAGE                                                                                                                                                                                                                                              DESCRIPTION                                                                                                                                                                                                                                               
-------- ------ ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
20210705 152030 CHANGE_SALARY                                                                                        ORA-01438: 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.                                                                                                                                                                                         VALUES : [1] =>7369 [2] =>124578                                                                                                                                                                                                                          
20210705 162437 CHANGE_SALARY                                                                                        ORA-01438: 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.                                                                                                                                                                                         VALUES : [1]7369[2] => 987495872895                                                                                                                                                                                                                       

*/
