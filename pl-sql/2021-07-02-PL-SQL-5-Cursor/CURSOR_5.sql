-- 조건절에 상수 대신 동적 변수 할당하기

SET SERVEROUTPUT ON

SELECT * FROM BONUS;

DECLARE
    CURSOR CUR_EMP(P_DEPTNO IN NUMBER) IS
        SELECT ENAME, JOB, SAL, COMM FROM EMP WHERE DEPTNO = P_DEPTNO;
    V_DEPTNO DEPT.DEPTNO%TYPE;
BEGIN
    V_DEPTNO := 20;
    FOR R_CUR_EMP IN CUR_EMP(V_DEPTNO)
    LOOP 
        INSERT INTO BONUS(ENAME, JOB, SAL, COMM) 
            VALUES(R_CUR_EMP.ENAME, R_CUR_EMP.JOB, R_CUR_EMP.SAL, R_CUR_EMP.COMM);
    END LOOP;
    COMMIT;
END;
/

SELECT * FROM BONUS;