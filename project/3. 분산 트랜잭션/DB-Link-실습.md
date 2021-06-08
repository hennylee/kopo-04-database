
## 로컬PC (로컬, 클라이언트)

- 로컬PC 접속 정보 (pw : happy)

![image](https://user-images.githubusercontent.com/77392444/121105251-b3807580-c83e-11eb-8923-8b8175d59efe.png)

- 권한 확인

```sql
SELECT USERNAME, PRIVILEGE, ADMIN_OPTION FROM USER_SYS_PRIVS;
```

- 권한 결과 : CREATE SESSION, CREATE DATABASE LINK 권한이 존재함

![image](https://user-images.githubusercontent.com/77392444/121107583-22f86400-c843-11eb-9048-f31379835b10.png)




## VMWarePC (원격, 서버)

- VMWarePC 접속 정보 (pw : tiger)

![image](https://user-images.githubusercontent.com/77392444/121105299-d1e67100-c83e-11eb-91c1-5bae13f0d8e6.png)

- 권한 확인

```sql
select * from user_sys_privs;
```

- 권한 결과 : CREATE SESSION, CREATE DATABASE LINK 권한이 존재하지 않음

![image](https://user-images.githubusercontent.com/77392444/121107650-40c5c900-c843-11eb-916e-1da45b038ae0.png)



## DB Link 권한별 생성 시나리오

#### 1. VMWarePC DBMS 에 접속하여 분산 트랜잭션을 실행하려고 한다. 

- 현재, 로컬 PC에 DB Link 권한이 있고, VMWarePC는 권한이 없는 상태에서 VMWarePC에 대한 DB Link를 생성할 수 있을까?

|                     |로컬 PC|VMWarePC|
|:--------------------|:-----:|:------:|
|CREATE SESSION       |    O  |  X     |
|CREATE DATABASE LINK |    O  |  X     |


- 로컬 PC에서 VMWarePC에 대한 DB Link는 생성 가능하다.

```SQL
CREATE DATABASE LINK scottLink CONNECT TO SCOTT IDENTIFIED BY TIGER USING
'(DESCRIPTION =
  (ADDRESS_LIST =
    (ADDRESS = 
      (PROTOCOL = TCP)
      (HOST = 192.168.119.119)
      (PORT = 1521)
    )
  )
  (CONNECT_DATA =
    (SERVICE_NAME = dink)
  }
)';
```

```
Database link SCOTTLINK이(가) 생성되었습니다.
```

#### 2. 반대로, 로컬 PC 에 접속하여 분산 트랜잭션을 실행하려고 한다. 

- VMWarePC에서 DB Link 권한이 없는 로컬 PC에 대한 DB Link를 생성할 수 있을까?


|                     |로컬 PC|VMWarePC|
|:--------------------|:-----:|:------:|
|CREATE SESSION       |    O  |  X     |
|CREATE DATABASE LINK |    O  |  X     |


- VMWarePC에서 로컬 PC에 대한 DB Link는 권한 불충분으로 인해 생성 불가능하다.

```SQL
CREATE DATABASE LINK hrLink CONNECT TO HR IDENTIFIED BY HAPPY USING
'(DESCRIPTION =
  (ADDRESS_LIST =
    (ADDRESS = 
      (PROTOCOL = TCP)
      (HOST = 192.168.217.33)
      (PORT = 1522)
    )
  )
  (CONNECT_DATA =
    (SID = XE)
  )
)';
```

```
오류 보고 -
ORA-01031: 권한이 불충분합니다
01031. 00000 -  "insufficient privileges"
*Cause:    An attempt was made to perform a database operation without
           the necessary privileges.
*Action:   Ask your database administrator or designated security
           administrator to grant you the necessary privileges
```


#### 3. VMWarePC에서 SCOTT 계정에 DB Link 생성 권한을 부여한다면?

- DBA 계정에서 권한 부여

```sql
GRANT CREATE DATABASE LINK TO SCOTT;
```

|                     |로컬 PC|VMWarePC|
|:--------------------|:-----:|:------:|
|CREATE SESSION       |    O  |  O     |
|CREATE DATABASE LINK |    O  |  O     |

- 로컬 PC HR 계정에 대한 DB Link 생성

```SQL
CREATE DATABASE LINK hrLink CONNECT TO HR IDENTIFIED BY HAPPY USING
'(DESCRIPTION =
  (ADDRESS_LIST =
    (ADDRESS = 
      (PROTOCOL = TCP)
      (HOST = 192.168.217.33)
      (PORT = 1522)
    )
  )
  (CONNECT_DATA =
    (SID = XE)
  )
)';
```

```
Database link HRLINK이(가) 생성되었습니다.
```




## 분산 트랜잭션 실습

- 로컬 PC의 HR 계정 : 하나은행 계좌 테이블, 회원 테이블이 존재함

- VMWare PC의 SCOTT 계정 : 중앙은행 전체 계좌 거래 내역 테이블이 존재함

- 서버실 PC의 da2102 계정 : 신한은행 계좌 테이블, 회원 테이블이 존재함

- 상황 시나리오 : 하나은행에서 'haeni' 고객이 신한은행 'spring'고객에게 1000원을 계좌이체 하려고 한다. 

  - 이때, 하나은행 'haeni' 고객이 신한은행 'spring' 고객에게 1000원을 이체 했다는 내역을 로그 테이블에 남겨야 한다. 
  - 그리고, 중앙은행 전체 계좌 테이블에서 'haeni' 고객의 계좌 잔액에서 1000원을 감소시키고, 'spring' 고객의 계좌 잔액에는 1000원을 증가시켜야 한다. 
  - 마지막으로 신한은행 테이블에서 'spring' 고객의 잔액 1000ㅝㄴ 증가



### 테이블 생성


- 하나은행 테이블 생성

![image](https://user-images.githubusercontent.com/77392444/121120526-aec8bb00-c858-11eb-963a-766a64e0419a.png)


```sql
/*
하나_회원정보
MEMBER_ID 주민번호 핸드폰번호
*/
CREATE TABLE HN_MEMBER(
    ID VARCHAR2(14)CONSTRAINT HN_MEM_ID_PK PRIMARY KEY,
    PW VARCHAR2(30) NOT NULL,
    RESIDENT_NUMBER VARCHAR2(14) NOT NULL,
    NAME VARCHAR2(30) NOT NULL,
    AGE NUMBER(4) NOT NULL CONSTRAINT HN_MEM_AGE_CK CHECK(AGE > 0 AND AGE < 1000),
    SEX CHAR(1) DEFAULT 'M' CONSTRAINT HN_MEM_SEX_CK CHECK(SEX IN('M', 'F')),
    JOIN_DATE DATE DEFAULT SYSDATE
);


/*
하나_계좌정보
계좌번호 MEMBER_ID 잔액 별칭 개설일
*/
CREATE TABLE HN_ACCOUNT(
    ACCOUNT_NUMBER VARCHAR2(30) CONSTRAINT HN_ACNT_NUM_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(14) NOT NULL,
    ACCOUNT_PW NUMBER(4) NOT NULL, -- 음수 나오면 안됨, 무조건 4자리 숫자
    BALANCE NUMBER(38) NOT NULL,
    ALIAS VARCHAR2(30),
    OPEN_USED CHAR(1) DEFAULT 'N' CONSTRAINT HN_ACNT_OPEN_CK CHECK(OPEN_USED IN('Y', 'N')),
    LIMIT_AMOUNT NUMBER(20) CONSTRAINT HN_ACNT_LIMIT_CK CHECK (LIMIT_AMOUNT > 0),
    OPENING_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT HN_ACNT_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES HN_MEMBER(ID)
);


/*
데이터 삽입
*/
INSERT INTO HN_MEMBER(ID, PW, RESIDENT_NUMBER, NAME, AGE, SEX) 
VALUES('haeni', 'a12345', '931202-2222222', '이해니', 29, 'F');

INSERT INTO HN_MEMBER(ID, PW, RESIDENT_NUMBER, NAME, AGE, SEX) 
VALUES('jungmin', 'a12345', '900930-1222222', '김정민', 32, 'M');


INSERT INTO HN_ACCOUNT(ACCOUNT_NUMBER, MEMBER_ID, ACCOUNT_PW, BALANCE, ALIAS, OPEN_USED)
VALUES('11-000000001-111', 'haeni',1234,1000, '급여계좌', 'Y');

INSERT INTO HN_ACCOUNT(ACCOUNT_NUMBER, MEMBER_ID, ACCOUNT_PW, BALANCE, ALIAS, OPEN_USED)
VALUES('11-000000002-111', 'jungmin',1234 ,1000, '여행경비', 'Y');

COMMIT;
```

- 통합_거래내역 테이블 생성

![image](https://user-images.githubusercontent.com/77392444/121120568-cacc5c80-c858-11eb-8b9b-82603012497c.png)


```sql
/*
통합_거래내역
주민번호 계좌주명 계좌번호 잔액 은행코드 대상계좌번호 대상은행코드 대상계좌잔액 거래코드 거래액 거래일자
*/

CREATE TABLE KFTC_BANKING_LOG(
    SEQ NUMBER(30) CONSTRAINT H_BANKING_LOG_SEQ_PK PRIMARY KEY,
    OWNER_NAME VARCHAR2(30) NOT NULL,
    OWNER_CODE NUMBER(3) NOT NULL,
    OWNER_ACCOUNT VARCHAR2(30) NOT NULL,
    TARGET_CODE NUMBER(3) NOT NULL,
    TARGET_ACCOUNT VARCHAR2(30) NOT NULL,
    TARGET_NAME VARCHAR2(30) NOT NULL,
    LOG_DATE DATE DEFAULT SYSDATE,
    AMOUNT NUMBER(38) NOT NULL,
    TYPE_CODE NUMBER(3) NOT NULL
);


/*
통합_거래코드
코드 거래구분
*/
CREATE TABLE BANKING_TYPE(
    CODE NUMBER(3) CONSTRAINT BANKING_TYPE_CODE_PK PRIMARY KEY,
    NAME VARCHAR2(30) NOT NULL CONSTRAINT BANKING_TYPE_NAME_UK UNIQUE
);

/*
통합_은행코드
코드 은행명
*/
CREATE TABLE BANK (
    CODE NUMBER(3) CONSTRAINT BANK_CODE_PK PRIMARY KEY, -- 은행코드
    NAME VARCHAR2(30) NOT NULL CONSTRAINT BANK_NAME_UK UNIQUE -- 은행명
);

/*
데이터 삽입
*/
INSERT INTO BANKING_TYPE VALUES('1', '입금');

INSERT INTO BANKING_TYPE VALUES('2', '출금');

INSERT INTO BANKING_TYPE VALUES('3', '계좌이체(입금)');

INSERT INTO BANKING_TYPE VALUES('4', '계좌이체(출금)');

INSERT INTO BANK VALUES('1', '하나');

INSERT INTO BANK VALUES('2', '신한');
 
INSERT INTO BANK VALUES('3', '국민');

INSERT INTO BANK VALUES('4', '우리');

INSERT INTO BANK VALUES('5', '기업');

COMMIT;
```


- 분산 트랜잭션 실행

```sql
DECLARE
    p_amount NUMBER(38);
    p_owner_name VARCHAR2(30);
    p_owner_code number(3);
    p_owner_account varchar2(30);
    
    p_owner_balance number(30);
    
    p_target_name varchar2(30);
    p_target_code number(3);
    p_target_account varchar2(30);
    
    
    p_target_balance number(30);
BEGIN 
    p_amount :=&p_amount;
    p_owner_name :=&p_owner_name;
    p_owner_code :=&p_owner_code;
    p_owner_account :=&p_owner_account;
    p_target_name :=&p_target_name;
    p_target_code :=&p_target_code;
    p_target_account :=&p_target_account;   
    select balance into p_owner_balance from HN_ACCOUNT where ACCOUNT_NUMBER=p_owner_account;
    select balance into p_target_balance from HN_ACCOUNT where ACCOUNT_NUMBER=p_target_account;
    IF p_owner_balance > p_amount then
        -- 보낼 사람 계좌 잔액 감소
        update HN_ACCOUNT set balance = p_owner_balance - p_amount where ACCOUNT_NUMBER=p_owner_account;
        -- 받는 사람 계좌 잔액 증가
        update HN_ACCOUNT set balance = p_target_balance + p_amount where ACCOUNT_NUMBER=p_target_account;
        -- 보낸 사람 계좌 거래 기록
        INSERT INTO KFTC_BANKING_LOG@scott
            (SEQ, owner_name, OWNER_CODE, OWNER_ACCOUNT, target_name, TARGET_CODE, TARGET_ACCOUNT, AMOUNT, TYPE_CODE)
        VALUES(
            (SELECT nvl(MAX(SEQ)+1,1) FROM KFTC_BANKING_LOG@scott), p_owner_name,
            p_owner_code, p_owner_account, p_target_name, p_target_code,  p_target_account , p_amount * (-1), 4
        );
        -- 받은 사람 계좌 거래 기록
        INSERT INTO KFTC_BANKING_LOG@scott
            (SEQ, owner_name, OWNER_CODE, OWNER_ACCOUNT, target_name, TARGET_CODE, TARGET_ACCOUNT, AMOUNT, TYPE_CODE)
        VALUES(
            (SELECT nvl(MAX(SEQ)+1,1) FROM KFTC_BANKING_LOG@scott), 
            p_target_name, p_target_code,  p_target_account , 
            p_owner_name, p_owner_code, p_owner_account, p_amount , 4
        );
        commit;
        DBMS_OUTPUT.PUT_LINE('이체 완료');
    ELSE
        DBMS_OUTPUT.PUT_LINE('잔액부족으로 인한 이체 취소');
        rollback;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('오류발생 롤백 완료');
END;
```


- 하나은행 계좌 테이블 변화

![image](https://user-images.githubusercontent.com/77392444/121141527-06295400-c876-11eb-970d-36f90cea12aa.png)

![image](https://user-images.githubusercontent.com/77392444/121141613-235e2280-c876-11eb-9da2-f938ed803b09.png)


- 통합 거래 테이블 변화

![image](https://user-images.githubusercontent.com/77392444/121143360-f01c9300-c877-11eb-9bd1-16d26dcff70b.png)

![image](https://user-images.githubusercontent.com/77392444/121143290-dbd89600-c877-11eb-9862-18c578798e9d.png)


- 기타 : 오류나는 프로시저

```sql
SET SERVEROUTPUT ON 
CREATE OR REPLACE PROCEDURE HN_TRANSFER(
    P_OWNER_ID HN_MEMBER.ID%TYPE, -- 본인 ID
    P_ACCOUNT_PW HN_ACCOUNT.ACCOUNT_PW%TYPE, -- 본인 계좌 PW
    P_OWNER_ACCOUNT HN_ACCOUNT.ACCOUNT_NUMBER%TYPE, -- 본인 은행 계좌
    P_OWNER_CODE KFTC_BANKING_LOG.OWNER_CODE@SCOTT%TYPE, -- 본인 은행 코드
    P_TARGET_NAME KFTC_BANKING_LOG.TARGET_NAME@SCOTT%TYPE, -- 대상 계좌주
    P_TARGET_ACCOUNT HN_ACCOUNT.ACCOUNT_PW%TYPE, -- 대상 은행 계좌
    P_TARGET_CODE KFTC_BANKING_LOG.OWNER_CODE@SCOTT%TYPE, -- 대상 은행 코드
    P_AMOUNT KFTC_BANKING_LOG.AMOUNT@SCOTT%TYPE -- 거래액
)
IS
        VN_OWNER_NAME VARCHAR2(30) ; -- 본인 이름
BEGIN
    -- 하나은행 보내는 사람 계좌주명, 주민번호 추출
    SELECT M.NAME INTO VN_OWNER_NAME FROM HN_ACCOUNT A , HN_MEMBER M 
    WHERE A.MEMBER_ID = M.ID
    AND ACCOUNT_NUMBER = P_OWNER_ACCOUNT AND A.MEMBER_ID = P_OWNER_ID; 
    DBMS_OUTPUT.PUT_LINE(VN_OWNER_NAME);
    -- 보내는 사람 계좌에서 잔액 감소
    IF ((SELECT ACCOUNT_PW FROM HN_ACCOUNT WHERE ACCOUNT_NUMBER = P_OWNER_ACCOUNT AND MEMBER_ID =P_OWNER_ID) != P_ACCOUNT_PW) THEN ROLLBACK;
    ELSE IF (
        ((SELECT BALANCE FROM HN_ACCOUNT WHERE ACCOUNT_NUMBER = P_OWNER_ACCOUNT AND MEMBER_ID =P_OWNER_ID) 
        - P_AMOUNT) < 0
    ) THEN ROLLBACK;
    ELSE
    UPDATE HN_ACCOUNT SET BALANCE = 
            (SELECT BALANCE FROM HN_ACCOUNT WHERE ACCOUNT_NUMBER = P_OWNER_ACCOUNT AND MEMBER_ID =P_OWNER_ID) - P_AMOUNT
    WHERE ACCOUNT_NUMBER = P_OWNER_ACCOUNT AND MEMBER_ID = P_OWNER_ID;
    END IF;
    -- 보내는 내역 거래 로그에 기록
    INSERT INTO KFTC_BANKING_LOG@scott
        (SEQ, OWNER_NAME, OWNER_CODE, OWNER_ACCOUNT, TARGET_CODE, TARGET_ACCOUNT, TARGET_NAME , AMOUNT, TYPE_CODE)
    VALUES(
        (SELECT nvl(MAX(SEQ)+1,1) FROM KFTC_BANKING_LOG@scott), 
        VN_OWNER_NAME, 
        P_OWNER_CODE, P_OWNER_ACCOUNT, P_OWNER_CODE,  P_TARGET_ACCOUNT , P_TARGET_NAME , P_AMOUNT * (-1), 4);
    -- 받는 내역 거래 로그에 기록
    INSERT INTO KFTC_BANKING_LOG@scott
        (SEQ, OWNER_NAME, OWNER_CODE, OWNER_ACCOUNT, TARGET_CODE, TARGET_ACCOUNT, TARGET_NAME , AMOUNT, TYPE_CODE)
    VALUES(
        (SELECT nvl(MAX(SEQ)+1,1) FROM KFTC_BANKING_LOG@scott), 
        (SELECT M.NAME FROM HN_ACCOUNT A , HN_MEMBER M WHERE A.MEMBER_ID = M.ID AND ACCOUNT_NUMBER = P_OWNER_ACCOUNT), 
        P_TARGET_CODE, P_TARGET_ACCOUNT,P_OWNER_CODE , P_OWNER_ACCOUNT , VN_OWNER_NAME , P_AMOUNT, 3);     
    -- 받는 사람 계좌에서 증가
    UPDATE HN_ACCOUNT SET BALANCE = 
            (SELECT BALANCE FROM HN_ACCOUNT WHERE ACCOUNT_NUMBER = P_TARGET_ACCOUNT) + P_AMOUNT
    WHERE ACCOUNT_NUMBER = P_TARGET_ACCOUNT;
    END IF;
    COMMIT;
END;
```
