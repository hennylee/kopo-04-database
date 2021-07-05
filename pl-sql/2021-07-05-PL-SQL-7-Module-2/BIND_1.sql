REM ---------------------------------------------
REM 변수선언 : 바인드변수 = 호스트변수 = 글로벌 변수
REM ---------------------------------------------

VARIABLE H_SALARY NUMBER 
VARIABLE H_TAX NUMBER

DECLARE
    C_TAX_RATE NUMBER(2,3);
BEGIN
    C_TAX_RATE := 0.05;
    :H_SALARY := 1000;
    
    :H_TAX := ROUND(:H_SALARY * C_TAX_RATE, 2);
END;
/

REM ---------------------------------------------
REM 변수출력 : 바인드변수 = 호스트변수 = 글로벌 변수
REM ---------------------------------------------

PRINT H_SALARY
PRINT H_TAX


/*

PL/SQL 프로시저가 성공적으로 완료되었습니다.


  H_SALARY
----------
      1000


     H_TAX
----------
        50

*/

VARIABLE;
/*
variable H_SALARY
datatype NUMBER

variable H_TAX
datatype NUMBER
*/


PRINT;
/*
  H_SALARY
----------
      1000

     H_TAX
----------
        50
*/