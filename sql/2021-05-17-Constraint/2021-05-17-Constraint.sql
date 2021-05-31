-- <05/17 ~ 05/18> Constraint


---------------------------------------------------------------------------------
-- [ NOT NULL (필수입력사항 ]
@t_cons.sql
/*
    DROP TABLE SCOTT.CUSTOMER; 

    CREATE TABLE SCOTT.TST_CUSTOMER(
        ID VARCHAR2(8) NOT NULL,
        PWD VARCHAR2(8) CONSTRAINT TST_CUSTOMER_PWD_NN NOT NULL,
        NAME VARCHAR2(20),-- 이름
        SEX CHAR(1),-- 성별
        AGE NUMBER(3) -- 나이
    )TABLESPACE USERS
        -- PCTFREE,PCTUSED : 블럭 단위의 공간활용 파라미터
        -- PCTFREE : 프리로 남겨둘 %(퍼센테이지)
        -- INITRANS : 이니셜 트랜젝션
        -- MAXTRANS : 맥시멈 트랜젝션
    PCTFREE 5 PCTUSED 60 INITRANS 2 MAXTRANS 20
        -- STORAGE : 양을 할당하라,처음에는 100K,그 다음에 더 필요하면 100K를 할당해라,
    STORAGE(INITIAL 100K NEXT 100K MINEXTENTS 3 MAXEXTENTS 10 PCTINCREASE 0);

*/

SELECT
    *
FROM
    tst_customer;

/*
ⓐ Block 공간 활용 Parameter PCTFREE ,PCTUSED,INITRANS,MAXTRANS에 대해 설명 하십시요
 
ⓑ TABLESPACE 정의 및 용도 와 STORAGE에 대해 설명 하십시요
*/

-- 1.

DESC tst_customer;
/*
ID   NOT NULL VARCHAR2(8)  
PWD  NOT NULL VARCHAR2(8)  
NAME          VARCHAR2(20) 
SEX           CHAR(1)      
AGE           NUMBER(3)    
*/


---------------------------------------------------------------------------------
-- 2. (ID,PWD,NAME,SEX,AGE),('xman','ok','kang','M',21)인 회원 입력

INSERT INTO tst_customer (
    id,
    pwd,
    name,
    sex,
    age
) VALUES (
    'xman',
    'ok',
    'kang',
    'M',
    21
);


-- 3. (ID,PWD,NAME,SEX,AGE)('XMAN','no','kim','T',-20);

INSERT INTO tst_customer (
    id,
    pwd,
    name,
    sex,
    age
) VALUES (
    'XMAN',
    'no',
    'kim',
    'T',
    -20
);

-- 4.
-- implicit null insert

/*
오류 보고 -
ORA-01400: NULL을 ("SCOTT"."TST_CUSTOMER"."PWD") 안에 삽입할 수 없습니다
*/

INSERT INTO tst_customer ( id,name,age ) VALUES ( 'zman','son',99 );

-- 5.
-- explicit null insert

/*
오류 보고 -
ORA-01400: NULL을 ("SCOTT"."TST_CUSTOMER"."PWD") 안에 삽입할 수 없습니다.
*/

INSERT INTO tst_customer (
    id,
    pwd,
    name,
    age
) VALUES (
    'rman',
    NULL,
    'jjang',
    24
);

-- 6.
/*
오류 보고 -
ORA-01400: NULL을 ("SCOTT"."TST_CUSTOMER"."ID") 안에 삽입할 수 없습니다
*/
INSERT INTO tst_customer (
    id,
    pwd,
    name,
    age
) VALUES (
    '',
    'pwd',
    'jjang',
    24
);


---------------------------------------------------------------------------------
-- UPDATE

-- 7. 
COMMIT; -- INSERT 저장
SELECT * FROM TST_CUSTOMER; -- UPDATE 전 조회

UPDATE TST_CUSTOMER SET AGE=-1, NAME = NULL;

SELECT * FROM TST_CUSTOMER; -- UPDATE 후 조회

ROLLBACK;

SELECT * FROM TST_CUSTOMER;


-- 8.
/*
오류 보고 -
ORA-01407: NULL로 ("SCOTT"."TST_CUSTOMER"."PWD")을 업데이트할 수 없습니다
*/
UPDATE TST_CUSTOMER SET PWD = NULL WHERE ID = 'XMAN'; -- ID가 XMAN인 ROW만 수정

-- 9. 
/*
오류 보고 -
ORA-01407: NULL로 ("SCOTT"."TST_CUSTOMER"."PWD")을 업데이트할 수 없습니다
*/
UPDATE TST_CUSTOMER SET PWD = NULL; -- UPDATE시 WHERE절이 없는경우? 전체수정

-- 10. 
SELECT * FROM TST_CUSTOMER;

---------------------------------------------------------------------------------
-- DATA DICTIONARY에서 CONSTRAINT 정보 조회

-- 11. 
SELECT TABLE_NAME,CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TST_CUSTOMER';

-- 12. 
SELECT TABLE_NAME,CONSTRAINT_NAME,POSITION,COLUMN_NAME
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'TST_CUSTOMER'
ORDER BY CONSTRAINT_NAME,POSITION;

-- [요구] ⓐ DATA DICTIONARY에 대해서 설명하고 DBA_ , ALL_ , USER_ 에 대해서 설명 하십시요




---------------------------------------------------------------------------------
-- [ CHECK: BOOLEAN CHECK ]
@T_CONS2.sql
/*
DROP TABLE SCOTT.TST_CUSTOMER2;

CREATE TABLE TST_CUSTOMER2(
    ID VARCHAR2(8) NOT NULL,
    PWD VARCHAR2(8) CONSTRAINT TST_CUSTOMER2_PWD_NN NOT NULL,
    NAME VARCHAR2(20), 
    SEX CHAR(1) CONSTRAINT TST_CUSTOMER2_SEX_CK CHECK(SEX IN ('M', 'F')), 
    AGE NUMBER(3) CHECK (AGE > 0 AND AGE < 100)
);
*/

SELECT * FROM TST_CUSTOMER2;

-- ⑬ 
INSERT INTO TST_CUSTOMER2(ID,PWD,NAME,SEX, AGE) VALUES('xman','ok','kang', 'M',21);

-- ⑭ 
INSERT INTO TST_CUSTOMER2(ID,PWD,NAME,SEX,AGE) VALUES('xman','ok', 'jjang','M',20); -- ID 중복 가능(NN이라서)

-- ① 
/*
오류 보고 -
ORA-02290: 체크 제약조건(SCOTT.SYS_C0012461)이 위배되었습니다
*/
INSERT INTO TST_CUSTOMER2(ID,PWD,NAME,SEX,AGE) VALUES('XMAN','no','kim', 'M',-20); -- ID 중복?,나이?

-- ② 
-- CHECK에 NULL값이 들어가는가? 
INSERT INTO TST_CUSTOMER2(ID,PWD,NAME,AGE) 
VALUES('asura','ok', 'joo',99); -- 성별?CONSTRAINT TST_CUSTOMER2_SEX_CK CHECK(SEX IN ('M', 'F'))

SELECT * FROM TST_CUSTOMER2; -- CHECK에 NULL로 들어감! NOT NULL 도 꼭 함께 써줘야 함

-- ③ 
/*
오류 보고 -
ORA-02290: 체크 제약조건(SCOTT.TST_CUSTOMER2_SEX_CK)이 위배되었습니다
*/

INSERT INTO TST_CUSTOMER2(ID,PWD,NAME,SEX,AGE) VALUES('harisu','ok', 'susu','T',33); -- 성별?

-- ④ 
/*
오류 보고 -
ORA-02290: 체크 제약조건(SCOTT.SYS_C0012461)이 위배되었습니다
*/
INSERT INTO TST_CUSTOMER2(ID,PWD,NAME,SEX,AGE) VALUES('shinsun','ok', '도사', 'M',999); -- 나이범위?

-- ⑤ 
UPDATE TST_CUSTOMER2 SET AGE = AGE + 1;

SELECT * FROM TST_CUSTOMER2; -- 99살이 있어서 나이 체크 오류 발생








---------------------------------------------------------------------------------
-- [ UNIQUE: 컬럼 또는 컬럼조합의 고유한 값을 보장 ]

@T_CONS3.sql

/*
DROP TABLE TST_CUSTOMER3;

CREATE TABLE TST_CUSTOMER3(
    ID VARCHAR2(8) NOT NULL CONSTRAINT TST_CUSTOMER3_ID_UK UNIQUE,
    PWD VARCHAR2(8) NOT NULL,
    NAME VARCHAR2(20), 
    SEX CHAR(1) DEFAULT 'M' CONSTRAINT TST_CUSTOMER3_SEX_CK CHECK(SEX IN ('M', 'F')), 
    -- SEX CHAR(1) DEFAULT 'M' CONSTRAINT TST_CUSTOMER2_SEX_CK CHECK(SEX IN ('M', 'F')), 
    MOBILE VARCHAR2(14) UNIQUE, -- 핸드폰 번호
    AGE NUMBER(3) DEFAULT 18
);
*/

-- // 동일한 이름을 가진 제약사항이 생성될수 있는가? NO~!

SELECT * FROM tst_customer3;

---------------------------------------------------------------------------------
-- INSERT

-- ⑥ 
INSERT INTO tst_customer3(ID,PWD,NAME,MOBILE, AGE) VALUES('xman','ok','kang', '011-3333',21); -- 성별? NULL

-- ⑦ 
/*
오류 보고 -
ORA-00001: 무결성 제약 조건(SCOTT.SYS_C0012466)에 위배됩니다
*/
INSERT INTO tst_customer3(ID,PWD,NAME, MOBILE,AGE) VALUES('yman','yes','lee', '011-3333',28); --핸폰?

-- ⑧ 
-- 데이터는 대소문자 구분
INSERT INTO tst_customer3(ID,PWD,NAME, MOBILE,AGE) VALUES('XMAN','yes','kim','011-3334',33); --ID중복

-- ⑨ 
/*
오류 보고 -
ORA-00001: 무결성 제약 조건(SCOTT.TST_CUSTOMER3_ID_UK)에 위배됩니다
*/
INSERT INTO tst_customer3(ID,PWD,NAME, MOBILE,AGE) VALUES('xman','yes','lee', '011-3335',-21);--ID중복

-- ⑩ 
INSERT INTO tst_customer3(ID,PWD,NAME, MOBILE) VALUES('무명인','yes',NULL, NULL); -- NULL?

-- // 테이블 생성후 제약사항 신규 추가
-- ⑪ 
ALTER TABLE tst_customer3 ADD CONSTRAINT CUSTOMER_NAME_SEX_UK UNIQUE(NAME,SEX); --조합,2개

-- ⑫ 
ALTER TABLE tst_customer3 MODIFY(NAME NOT NULL);
 
-- NOT NULL

-- ⑬ 
INSERT INTO tst_customer3(ID,PWD,NAME, SEX)  
VALUES('rman','yes','ksh', 'M');

-- ⑭ 
INSERT INTO tst_customer3(ID,PWD,NAME, SEX ) VALUES('Rman','yes','ksh', 'F'); -- 이름 중복 허용?

-- ⑮ 
INSERT INTO tst_customer3(ID,PWD,NAME, SEX) VALUES('RmaN','yes','ksh', 'M');
 
-- 조합의 중복 ??
SELECT * FROM tst_customer3;

-- // CONSTRAINT(제약사항) 확인
-- ① 
SELECT INDEX_NAME,INDEX_TYPE,UNIQUENESS FROM USER_INDEXES
WHERE TABLE_NAME = 'tst_customer3';
-- // INDEX 생성 여부 확인
-- ② 
SELECT INDEX_NAME,COLUMN_POSITION,COLUMN_NAME FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'tst_customer3' 
ORDER BY INDEX_NAME,COLUMN_POSITION;

-- [요구~캔] 
-- ⓐ INDEX에 대해서 설명하고 UNIQUE 제약사항이 걸린 컬럼에 UNIQUE INDEX 가 생성되는 이유를 설명 하십시요 






SELECT
    *
FROM
    user_triggers;


SELECT
    index_name,
    index_type,
    uniqueness
FROM
    user_indexes
WHERE
    table_name = 'CUSTOMER3';

SELECT
    index_name,
    index_type,
    uniqueness
FROM
    user_indexes
WHERE
    table_name = 'TST_CUSTOMER3';

SELECT
    index_name,
    column_position,
    column_name
FROM
    user_ind_columns
WHERE
    table_name = 'TST_CUSTOMER3'
ORDER BY index_name,column_position;












SELECT
    *
FROM
    tst_customer4;

SELECT
    index_name,
    index_type,
    uniqueness
FROM
    user_indexes
WHERE
    table_name = 'TST_CUSTOMER4';

SELECT
    index_name,
    column_position,
    column_name
FROM
    user_ind_columns
WHERE
    table_name = 'TST_CUSTOMER4'
ORDER BY index_name,column_position;



---------------------------------------------------------------------------------
-- [ FOREIGN KEY : 테이블간(테이블내)의 참조 무결성(REFERNTIAL INTEGRITY)을 보장 ]

@t_cons5.sql
/*
CREATE TABLE TST_부서(
    부서ID VARCHAR2(2) CONSTRAINT TST_DEPARTMENT_부서ID_PK PRIMARY KEY,
    부서명 VARCHAR2(10) -- 부서명
);

CREATE TABLE TST_EMPLOYEE(
    EMPID VARCHAR2(8),-- 사원 고유 ID
    부서ID VARCHAR2(2),-- 사원 근무 부서 ID
    CONSTRAINT TST_EMPLOYEE_부서_부서ID_FK FOREIGN KEY(부서ID)
    REFERENCES TST_부서(부서ID) -- TABLE LEVEL 제약사항
);
*/



-- 1. 부서 테이블에 10번 부서가 존재하지 않을 때,직원 테이블에 10번 부서 데이터를 추가할 수 있는가?
-- ORA-02291: 무결성 제약조건(SCOTT.TST_EMPLOYEE_부서_부서ID_FK)이 위배되었습니다- 부모 키가 없습니다
-- 10번 부서에 직원을 추가하려면,추가하기 전에 PK에 해당 값인 10번 부서가 있는지 확인한다. 

INSERT INTO tst_employee VALUES ( 'XMAN','10' );

-- 2. 부서 테이블에 10번 부서(관리실)를 추가하시오

INSERT INTO tst_부서 ( 부서id,부서명 ) VALUES ( '10','관리실' );
-- 3. 부서 테이블에 20번 부서(전산실)를 추가하시오

INSERT INTO tst_부서 ( 부서id,부서명 ) VALUES ( '20','전산실' );

SELECT
    *
FROM
    tst_부서;

SELECT
    *
FROM
    tst_employee;

-- 4. 부서가 10인 직원을 추가하시오

INSERT INTO tst_employee VALUES ( 'XMAN','10' );

-- 5. 부서가 XX인 직원을 추가하시오
-- ORA-02291: 무결성 제약조건(SCOTT.TST_EMPLOYEE_부서_부서ID_FK)이 위배되었습니다- 부모 키가 없습니다

INSERT INTO tst_employee VALUES ( 'XMAN','XX' );

/*
- 참조하는 주체(자식) 데이터를 DML할 때 부모 데이터를 확인하나? 부모 테이블을 DML할 때에도 자식 테이블에 관계를 끼치는가?
    - 부모 테이블 : 
    - 자식 테이블 : 
*/

-- 6. 부모 테이블 DEL : 에러
-- ORA-02292: 무결성 제약조건(SCOTT.TST_EMPLOYEE_부서_부서ID_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다

DELETE FROM tst_부서 WHERE
    부서id = '10';

-- 6-2. 자식 테이블 DEL : ???

/*
- 참조하는 주체(자식) 데이터를 DDL할 때 부모 데이터를 확인하나? 부모 테이블을 DDL할 때에도 자식 테이블에 관계를 끼치는가?
    - 부모 테이블 : 
    - 자식 테이블 : 
*/

-- 7. 부모 테이블을 DROP : 에러
-- ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다

DROP TABLE tst_부서;

-- 8. 자식테이블을 DROP : 정상 삭제
-- Table TST_EMPLOYEE이(가) 삭제되었습니다

DROP TABLE tst_employee;

-- 부모 TABLE을 DROP 시키는 방법은?
-- CASCADE 조건을 뒤에 붙인다. 
-- CASCADE로 DROP 하면 자식은 살아있고,부모는 DROP된다.

DROP TABLE tst_부서 CASCADE CONSTRAINTS;

---------------------------------------------------------------------------------

-- FK 관계가 걸려있었을 때,제약조건은도 삭제되는가? 인덱스는? 

@t_cons5.sql

/*
CREATE TABLE TST_부서(
    부서ID VARCHAR2(2) CONSTRAINT TST_DEPARTMENT_부서ID_PK PRIMARY KEY,
    부서명 VARCHAR2(10) -- 부서명
);

CREATE TABLE TST_EMPLOYEE(
    EMPID VARCHAR2(8),-- 사원 고유 ID
    부서ID VARCHAR2(2),-- 사원 근무 부서 ID
    CONSTRAINT TST_EMPLOYEE_부서_부서ID_FK FOREIGN KEY(부서ID)
    REFERENCES TST_부서(부서ID) -- TABLE LEVEL 제약사항
);
*/

DROP TABLE tst_부서 CASCADE CONSTRAINTS;

-- 제약조건도 전부 삭제된다. 

SELECT
    *
FROM
    user_indexes;

SELECT
    *
FROM
    user_ind_columns; 


---------------------------------------------------------------------------------

@t_cons5_2.sql
/*
CREATE TABLE TST_DEPARTMENT(
    DEPTNO VARCHAR2(2) CONSTRAINT TST_DEPARTMENT_DEPTNO_PK PRIMARY KEY,
    DNAME VARCHAR2(10) CONSTRAINT TST_DEPARTMENT_DNAME_NN NOT NULL
);

CREATE TABLE TST_EMPLOYEE(
    사번 VARCHAR2(8) PRIMARY KEY,
    이름 VARCHAR2(10),
    DEPTNO VARCHAR2(2) NOT NULL,
    CONSTRAINT TST_EMPLOYEE_DEPARTMENT_DEPTNO_FK FOREIGN KEY(DEPTNO) -- TABLE LEVEL 제약사항
    REFERENCES TST_DEPARTMENT(DEPTNO) 
);
*/
-- 1.

SELECT
    table_name,
    constraint_name,
    constraint_type
FROM
    dba_constraints
WHERE
    table_name IN (
        'TST_DEPARTMENT','TST_EMPLOYEE'
    );

-- 2. 사번 : 'XMAN',이름 : 'TUNER',DEPTNO : '10'인 사원을 추가하시오
-- ORA-02291: 무결성 제약조건(SCOTT.TST_EMPLOYEE_DEPARTMENT_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다

INSERT INTO tst_employee ( 사번,이름,deptno ) VALUES ( 'XMAN','TUNER','10' );

-- 3. 부서정보 10(관리팀),20(전산팀),30(영업팀)을 입력하시오

INSERT INTO tst_department VALUES ( 10,'관리팀' );

INSERT INTO tst_department VALUES ( 20,'전산팀' );

INSERT INTO tst_department VALUES ( 30,'영업팀' );

-- 4. 10번,20번,30번 DEPARTMENT에 근무하는 사원을 추가하시오

INSERT INTO tst_employee VALUES ( 'XMAN','TUNER','10' );

INSERT INTO tst_employee VALUES ( 'YMAN','DBA','20' );

INSERT INTO tst_employee VALUES ( 'ZMAN','DEVELOPER','30' );

SELECT
    *
FROM
    tst_department;

SELECT
    *
FROM
    tst_employee;

-- 5. 40번 부서에 근무하는 사원을 추가하시오
-- 부서 TABLE에 40번 부서가 없다. 
-- ORA-02291: 무결성 제약조건(SCOTT.TST_EMPLOYEE_DEPARTMENT_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다

INSERT INTO tst_employee VALUES ( 'KMAN','DEVELOPER','40' );

/*
- FK로 참조되고 있는 부모테이블의 레코드를 삭제할 수 있는가?
    - 자식 레코드가 있는 경우 : 삭제 불가
    - 자식 레코드가 없는 경우 : 삭제 가능
*/
-- 6. 근무자가 없는 40번 부서를 만든 후 삭제해보기
-- 삭제 되는가? YES

INSERT INTO tst_department VALUES ( 40,'기획팀' );

DELETE FROM tst_department WHERE
    deptno = 40;

-- 7. 근무자가 있는 30번 부서를 삭제해보기
-- 삭제 되는가? NO
-- ORA-02292: 무결성 제약조건(SCOTT.TST_EMPLOYEE_DEPARTMENT_DEPTNO_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다

DELETE FROM tst_department WHERE
    deptno = 30;

-- 8. 근무자가 있는 30번 DEPARTMENT 폐지 방법은?
-- 30번 부서 직원의 부서를 10번으로 바꾼 뒤,30번 부서를 삭제한다. 

UPDATE tst_employee
    SET
        deptno = 10
WHERE
    deptno = 30;

DELETE FROM tst_department WHERE
    deptno = 30;

SELECT
    *
FROM
    tst_employee;

SELECT
    *
FROM
    tst_department;


---------------------------------------------------------------------------------

/*
- EMP 테이블의 EMPNO 컬럼에 P.K 혹은 U.K 제약사항이 걸려있지 않다면,P.K 제약사항 추가하기
  - F.K는 다른 테이블의 U.K 또는 P.K를 참조하는 것이다. 
  - EMPNO에 P.K가 걸려있지 않다면,F.K 설정 시 참조가 불가능하기 때문이다.
- */

DESC emp;

-- 테이블 제약조건 조회하기

SELECT
    *
FROM
    all_constraints
WHERE
    table_name = 'EMP';

SELECT
    *
FROM
    all_constraints
WHERE
    table_name = 'ORDERS';

-- 테이블 인덱스 조회하기
/*
유일키 관련 제약조건은 PK,UK 입니다.
이 유일키 제약조건은 중복값을 체크하기 위해서 인덱스를 필요로 합니다.
*/

SELECT
    *
FROM
    all_indexes
WHERE
    table_name = 'EMP';

-- PK 제약조건 추가하기

ALTER TABLE emp ADD PRIMARY KEY ( empno );

ALTER TABLE emp ADD CONSTRAINT emp_empno_pk PRIMARY KEY ( empno );

-- PK 제약조건 삭제하기

ALTER TABLE emp DROP PRIMARY KEY;

-- FK 제약조건 추가하기

ALTER TABLE orders
    ADD CONSTRAINT order_sales_id_fk FOREIGN KEY ( sales_id )
        REFERENCES emp ( emp_empno_pk );
-- [ON DELETE 옵션(NO ACTION/CASCADE/SET NULL/SET DEFAULT)] 
-- [ON UPDATE 옵션(NO ACTION/CASCADE/SET NULL/SET DEFAULT)]

-- FK 제약조건 삭제하기

ALTER TABLE orders DROP CONSTRAINT order_sales_id_fk;

-- UNIQUE 제약조건 추가하기

ALTER TABLE emp ADD UNIQUE ( empno );

ALTER TABLE emp ADD CONSTRAINT empno UNIQUE ( empno );

-- UNIQUE 제약조건 삭제하기

ALTER TABLE orders DROP CONSTRAINT emp_empno_uk;