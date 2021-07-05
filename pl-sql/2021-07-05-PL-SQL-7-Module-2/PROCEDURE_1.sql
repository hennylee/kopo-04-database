-- 예외처리부 없는 PROCEDURE 생성 후, 2가지 방법으로 실행해보기

REM ---------------------------------------------
REM PROCEDURE 생성 : CHANGE_SALARY
REM ---------------------------------------------

CREATE OR REPLACE PROCEDURE CHANGE_SALARY(A_EMPNO IN NUMBER, A_SALARY NUMBER DEFAULT 2000)
AS
BEGIN
    UPDATE EMP
    SET SAL = A_SALARY
    WHERE EMPNO = A_EMPNO;
    
    COMMIT;
END CHANGE_SALARY;
/

DESC CHANGE_SALARY;

/*
PROCEDURE CHANGE_SALARY
인수 이름    유형     In/Out 기본값?    
-------- ------ ------ ------- 
A_EMPNO  NUMBER IN             
A_SALARY NUMBER IN     DEFAULT 
*/


REM ---------------------------------------------
REM PROCEDURE 테스트 1
REM ---------------------------------------------

VARIABLE P_EMPNO NUMBER
VARIABLE P_SALARY NUMBER

BEGIN 
    :P_EMPNO := 7369;
    :P_SALARY := 7000;
    
    CHANGE_SALARY(:P_EMPNO, :P_SALARY);
END;
/

SELECT EMPNO, SAL FROM EMP WHERE EMPNO = 7369;
/*
     EMPNO        SAL
---------- ----------
      7369       7000

*/

REM ---------------------------------------------
REM PROCEDURE 테스트 2
REM ---------------------------------------------
EXECUTE CHANGE_LOG(:P_EMPNO);
SELECT EMPNO, SAL FROM EMP WHERE EMPNO = 7369;

/*
     EMPNO        SAL
---------- ----------
      7369       7000

*/
