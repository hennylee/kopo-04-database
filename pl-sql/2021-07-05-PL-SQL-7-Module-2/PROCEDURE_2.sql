-- 예외처리부 있는 PROCEDURE 생성해보기

REM ---------------------------------------------
REM PROCEDURE 생성 : CHANGE_SALARY + EXCEPTION
REM ---------------------------------------------

CREATE OR REPLACE PROCEDURE CHANGE_SALARY(A_EMPNO IN NUMBER, A_SALARY NUMBER DEFAULT 2000)
AS
BEGIN
    UPDATE EMP
    SET SAL = A_SALARY
    WHERE EMPNO = A_EMPNO;
    
    COMMIT;
EXCEPTION
    WHEN VALUE_ERROR THEN -- 산술,변환,절삭 크기 제약에 에러가 생겼을 때 발생되는 예외.
        DBMS_OUTPUT.PUT_LINE('VALUE_ERROR => ' || SQLERRM);
        NULL;
    WHEN NO_DATA_FOUND THEN -- PL/SQL Select문이 한 건도 리턴하지 못하는 경우 발생하는 예외
        DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND => ' || SQLERRM);
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('OTHERS => ' || SQLERRM);
        ROLLBACK;        
END CHANGE_SALARY;
/



REM ---------------------------------------------
REM PROCEDURE 테스트 1
REM ---------------------------------------------

EXECUTE CHANGE_SALARY(A_EMPNO => 7369, A_SALARY => 1234667);
SELECT EMPNO, SAL FROM EMP WHERE EMPNO = 7369;
/*
OTHERS => ORA-01438: 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.


     EMPNO        SAL
---------- ----------
      7369       7000
*/
