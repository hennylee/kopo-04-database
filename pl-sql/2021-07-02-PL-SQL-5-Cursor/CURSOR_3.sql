-- 참조 연산자를 사용해서 변수를 정의하기
-- 만약 변수가 50개라면 무척 귀찮겠지? 일일히 다 해야할까? 정답은 CURSOR_3.SQL에서...
-- 커서를 참조해서 변수를 선언하면 된다~!

SET SERVEROUTPUT ON

DECLARE
    CURSOR CUR_EMP IS
        SELECT ENAME, JOB, SAL, COMM FROM EMP WHERE DEPTNO = 10;
    R_CUR_EMP CUR_EMP%ROWTYPE;
BEGIN
    OPEN CUR_EMP;
    LOOP 
        FETCH CUR_EMP INTO R_CUR_EMP;
        EXIT WHEN CUR_EMP%NOTFOUND;
        
        INSERT INTO BONUS(ENAME, JOB, SAL, COMM) 
            VALUES(R_CUR_EMP.ENAME, R_CUR_EMP.JOB, R_CUR_EMP.SAL, R_CUR_EMP.COMM);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('TOTAL '||TO_CHAR(CUR_EMP%ROWCOUNT)||'rows processed');
    -- TOTAL 3rows processed
    CLOSE CUR_EMP;
    COMMIT;
END;
/

