BEGIN
    P_EMPLOYEE.GV_ROWS := 100;
    P_EMPLOYEE.V_ROWS := 100;
END;
/
/*
오류 보고 -
ORA-06550: 줄 3, 열16:PLS-00302: 'V_ROWS' 구성 요소가 정의되어야 합니다
*/

DESC P_EMPLOYEE

/*
PROCEDURE DELETE_EMP
인수 이름                                                                                                                            유형                                                                                                                                                                입/출력      기본값?   
-------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------- --------- -------
P_EMPNO                                                                                                                          NUMBER(4)                                                                                                                                                         IN               


PROCEDURE INSERT_EMP
인수 이름                                                                                                                            유형                                                                                                                                                                입/출력      기본값?   
-------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------- --------- -------
P_EMPNO                                                                                                                          NUMBER                                                                                                                                                            IN               
P_ENAME                                                                                                                          VARCHAR2                                                                                                                                                          IN               
P_JOB                                                                                                                            VARCHAR2                                                                                                                                                          IN               
P_SAL                                                                                                                            NUMBER                                                                                                                                                            IN               
P_DEPTNO                                                                                                                         NUMBER                                                                                                                                                            IN               

FUNCTION SEARCH_MNG RETURNS VARCHAR2
인수 이름                                                                                                                            유형                                                                                                                                                                입/출력      기본값?   
-------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------- --------- -------
P_EMPNO                                                                                                                          NUMBER(4)                                                                                                                                                         IN               
*/



BEGIN
    P_EMPLOYEE.INSERT_EMP(1113, 'PACKAGE', 'CIO', 9999, 10);
    P_EMPLOYEE.INSERT_EMP(1114, 'PACKAGE2', 'CTO', 9999, 20);
    P_EMPLOYEE.DELETE_EMP(1114);
    DBMS_OUTPUT.PUT_LINE('DELETE ROWS => ' || P_EMPLOYEE.GV_ROWS);
END;
/
/*
DELETE ROWS => 2
*/
select * from emp;
/*
     EMPNO ENAME      JOB              MGR HIREDATE                           SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------------------------- ---------- ---------- ----------
      1111 PACKAGE    CIO                                                    9999                    10
      2025 JJANG      PRESIDENT                                              8888                    10
        10 KIM        SALESMAN                                               5555                    10
      1113 PACKAGE    CIO                                                    9999                    10
      ....
*/


DECLARE
    V_ENAME EMP.ENAME%TYPE;
BEGIN
    V_ENAME := P_EMPLOYEE.SEARCH_MNG(1114);
    DBMS_OUTPUT.PUT_LINE('MANAGER NAME =>' || V_ENAME);
END;
/
/*
MANAGER NAME =>NO_DATE
*/
