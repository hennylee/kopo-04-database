-- 패키지 P_EMPLOYEE의 Header 선언

CREATE OR REPLACE PACKAGE P_EMPLOYEE
AS
    -- 사원 퇴사 처리
    PROCEDURE DELETE_EMP(P_EMPNO EMP.EMPNO%TYPE);
    
    -- 신규 입사사원 등록
    PROCEDURE INSERT_EMP(P_EMPNO NUMBER, P_ENAME VARCHAR2, P_JOB VARCHAR2, P_SAL NUMBER, P_DEPTNO NUMBER);
    
    -- 해당 사원의 MANAGER의 이름을 RETURN하는 함수
    FUNCTION SEARCH_MNG(P_EMPNO EMP.EMPNO%TYPE) RETURN VARCHAR2;
    
    GV_ROWS NUMBER(6); -- PUBLIC 변수
END P_EMPLOYEE;
/