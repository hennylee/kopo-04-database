-- 1. 테이블 생성

-- ---------------
-- 퇴사자 명단 TABLE
-- ---------------
CREATE TABLE RETIRED_EMP(
    EMPNO NUMBER(4) NOT NULL,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    RETIRED_DATE DATE
);
-- ---------------
-- 노조 명단 TABLE
-- ---------------
CREATE TABLE LABOR_UNION(
    EMPNO NUMBER(4) NOT NULL,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    ENROLL_DATE DATE
);



-- 2. 트리거 생성
CREATE OR REPLACE TRIGGER TRG_EMP_CHANGE
BEFORE INSERT OR DELETE OR UPDATE OF SAL ON EMP
FOR EACH ROW
DECLARE 
BEGIN
    -- 1) INSERTING 
    IF INSERTING AND :NEW.JOB IN ('CLEARK', 'SALESMAN') THEN
        INSERT INTO LABOR_UNION(EMPNO, ENAME, JOB, ENROLL_DATE) VALUES(:NEW.EMPNO, :NEW.ENAME, :NEW.JOB, SYSDATE);
    -- 2) DELETING
    ELSIF DELETING THEN
        BEGIN
            INSERT INTO RETIRED_EMP(EMPNO, ENAME, JOB, RETIRED_DATE)
                VALUES(:OLD.EMPNO, :OLD.ENAME, :OLD.JOB, SYSDATE);
            
            DELETE FROM LABOR_UNION WHERE EMPNO = :OLD.EMPNO;
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;
    -- 3) UPDATING
    ELSIF UPDATING THEN
        IF :NEW.SAL < 0 THEN
            :NEW.SAL := :OLD.SAL;
        END IF;
    END IF;
END;
/

SHOW ERROR;



-- 3. 트리거 실행해보기
BEGIN 
    P_EMPLOYEE.DELETE_EMP(7369);
    P_EMPLOYEE.INSERT_EMP(2025, 'JJANG', 'PRESIDENT', 8888, 10);
    P_EMPLOYEE.INSERT_EMP(10, 'KIM', 'SALESMAN', 5555, 10);
END;
/


SELECT * FROM EMP WHERE EMPNO IN (7369, 2025, 10);
/*
     EMPNO ENAME      JOB              MGR HIREDATE                           SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------------------------- ---------- ---------- ----------
        10 KIM        SALESMAN                                               5555                    10
      2025 JJANG      PRESIDENT                                              8888                    10
*/

SELECT * FROM RETIRED_EMP WHERE EMPNO IN (7369, 2025, 10);
/*
     EMPNO ENAME      JOB       RETIRED_
---------- ---------- --------- --------
      7369 SMITH      CLERK     21/07/06
*/

SELECT * FROM LABOR_UNION WHERE EMPNO IN (7369, 2025, 10);

/*
     EMPNO ENAME      JOB       ENROLL_D
---------- ---------- --------- --------
        10 KIM        SALESMAN  21/07/06
*/