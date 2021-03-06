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