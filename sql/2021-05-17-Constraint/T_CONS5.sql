CREATE TABLE TST_부서(
    부서ID VARCHAR2(2) CONSTRAINT TST_DEPARTMENT_부서ID_PK PRIMARY KEY,
    부서명 VARCHAR2(10) -- 부서명
);

CREATE TABLE TST_EMPLOYEE(
    EMPID VARCHAR2(8), -- 사원 고유 ID
    부서ID VARCHAR2(2), -- 사원 근무 부서 ID
    CONSTRAINT TST_EMPLOYEE_부서_부서ID_FK FOREIGN KEY(부서ID)
    REFERENCES TST_부서(부서ID) -- TABLE LEVEL 제약사항
);