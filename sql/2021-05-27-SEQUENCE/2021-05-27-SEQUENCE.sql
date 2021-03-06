-- 05/27 : SEQUENCE

-- 1~5. SEQUENCE의 작동방식 알아보기

-- 1. 시퀀스 생성하기
CREATE SEQUENCE SCOTT.ORDER_SEQ
INCREMENT BY 1
START WITH 1
MAXVALUE 999999999999
MINVALUE 1
NOCYCLE
CACHE 30;

-- 2. 시퀀스를 만들자마자 CURRAVAL를 조회하면, 어떤 값이 나오는가?
-- 아무 값도 나오지 않는다.
/*
ORA-08002: 시퀀스 ORDER_SEQ.CURRVAL은 이 세션에서는 정의 되어 있지 않습니다
08002. 00000 -  "sequence %s.CURRVAL is not yet defined in this session"
*Cause:    sequence CURRVAL has been selected before sequence NEXTVAL
*Action:   select NEXTVAL from the sequence before selecting CURRVAL
*/
SELECT ORDER_SEQ.CURRVAL FROM DUAL;

-- 2번에서 세션 관련 에러나는 이유는 무엇일까?

/*
NEXTVAL을 먼저 호출하고 CURRVAL을 하면 에러가 안난다. 
*/


-- 3. 시퀀스는 롤백가능한가?
-- 가능하지 않다.
SELECT ORDER_SEQ.NEXTVAL FROM DUAL; -- 1
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- 1
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- 1
ROLLBACK;
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- 1


--------------------------------------------------------------------------------

-- 6~13. 두 개의 세션에서 시퀀스 실습해보기

-- 하나의 시퀀스를 여러 세션에서 공유한다. 

/*
SESSION-A.sql
SESSION-B.sql
*/

-- ORDER_TBL.SQL
@ORDER_TBL.sql

-------------------------------------------------------------------------

/*
- EMP 테이블의 EMPNO 컬럼에 P.K 혹은 U.K 제약사항이 걸려있지 않다면,  P.K 제약사항 추가하기
  - F.K는 다른 테이블의 U.K 또는 P.K를 참조하는 것이다. 
  - EMPNO에 P.K가 걸려있지 않다면, F.K 설정 시 참조가 불가능하기 때문이다.
- */
DESC EMP;

-- 테이블 제약조건 조회하기
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'EMP';
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'ORDERS';

-- 테이블 인덱스 조회하기
/*
유일키 관련 제약조건은 PK, UK 입니다.
이 유일키 제약조건은 중복값을 체크하기 위해서 인덱스를 필요로 합니다.
*/
SELECT * FROM ALL_INDEXES WHERE TABLE_NAME = 'EMP';

-- PK 제약조건 추가하기
ALTER TABLE EMP ADD PRIMARY KEY (EMPNO);
ALTER TABLE EMP ADD CONSTRAINT EMP_EMPNO_PK PRIMARY KEY (EMPNO);

-- PK 제약조건 삭제하기
ALTER TABLE EMP DROP PRIMARY KEY;

-- FK 제약조건 추가하기
ALTER TABLE ORDERS ADD CONSTRAINT ORDER_SALES_ID_FK FOREIGN KEY(SALES_ID) REFERENCES EMP(EMP_EMPNO_PK);
-- [ON DELETE 옵션(NO ACTION/CASCADE/SET NULL/SET DEFAULT)] 
-- [ON UPDATE 옵션(NO ACTION/CASCADE/SET NULL/SET DEFAULT)]

-- FK 제약조건 삭제하기
ALTER TABLE ORDERS DROP CONSTRAINT ORDER_SALES_ID_FK;

-- UNIQUE 제약조건 추가하기
ALTER TABLE EMP ADD UNIQUE (EMPNO);
ALTER TABLE EMP ADD CONSTRAINT EMPNO UNIQUE (EMPNO);

-- UNIQUE 제약조건 삭제하기
ALTER TABLE ORDERS DROP CONSTRAINT EMP_EMPNO_UK;

-------------------------------------------------------------------------

-- 1. 
INSERT INTO ORDERS(ORDER_ID, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, SALES_ID) 
VALUES(ORDER_SEQ.NEXTVAL, 'direct', 166, 1, 7499);

SELECT ORDER_ID FROM ORDERS; -- 2
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- 2

-- 2. 
INSERT INTO SCOTT.ORDERS(ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, SALES_ID)
VALUES(SCOTT.ORDER_SEQ.NEXTVAL, SYSDATE, 'online', 200, 3, 7521);

SELECT ORDER_ID FROM ORDERS; -- 2, 3
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- 3

-- 3. 테이블 입력사항 저장
COMMIT; 

SELECT ORDER_ID FROM ORDERS; -- 2, 3
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- 3

-- 4.
INSERT INTO ORDERS(ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, SALES_ID)
VALUES(ORDER_SEQ.NEXTVAL, SYSDATE, 'online', 135, 2, 7844);

SELECT ORDER_ID FROM ORDERS; -- 2, 3, 4
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- 4


-------------------------------------------------------------------------------------

-- 5~6. INSERT가 ROLLBACK되면, 시퀀스값도 감소하는가?
-- INSERT문을 ROLLBACK하면 SEQUENCE도 ROLLBACK될까?
ROLLBACK;

-- 퀀스값은 ROLLBACK되지 않고 INCREMENT값만큼 증가한다.

SELECT ORDER_ID FROM ORDERS; -- 2, 3
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- 4


-------------------------------------------------------------------------------------

-- 7. 시퀀스값은 연속적인가?
INSERT INTO ORDERS(ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, SALES_ID)
VALUES(ORDER_SEQ.NEXTVAL, SYSDATE, 'direct', 135, 4, 7844);

-- SEQUENCE 값은 연속적이지 않다. 
SELECT ORDER_ID FROM ORDERS; -- 2, 3, 5
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- 5


-------------------------------------------------------------------------------------

-- 8. MAX+1 방식의 문제점은 ?

INSERT INTO SCOTT.ORDERS(ORDER_ID, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, SALES_ID)
VALUES((SELECT MAX(ORDER_ID)+1 FROM SCOTT.ORDERS), 'direct', 335, 1, 7654);

-- 시퀀스를 사용하다가 MAX+1값을 사용하면 SEQUENCE값이 꼬인다. ORDER_ID는 증가했는데, SEQUENCE는 증가하지 않아서 문제임
SELECT ORDER_ID FROM ORDERS; -- 2, 3, 5, 6
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- 5

-- 이외에도 MAX+1은 값이 중복되거나, 성능이 저하될 수 있다.
-- VALUES절에 SELECT가 사용된 스칼라 서브쿼리에서 INSERT할때마다 MAX연산이 쓰이면 성능에 유리하지 않다.

-------------------------------------------------------------------------------------

@ORDER_ID_TBL.sql

DESC ORDER_ID;

-- 1. 일련번호만 저장하는 테이블 만들고, INSERT할때마다 UPDATE하기 (PL/SQL : 블록 구조화된 언어)

/*
DECLARE
  선언부
BEGIN
  실행부
END;
*/

-- Low Level Lock
-- SELECT ... FOR UPDATE;

DECLARE
    V_ORDER_SEQ NUMBER(12);
BEGIN
    SELECT ORDER_SEQ INTO V_ORDER_SEQ
    FROM ORDER_ID
    FOR UPDATE;
    
    INSERT INTO ORDERS(ORDER_ID, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, SALES_ID)
    VALUES(V_ORDER_SEQ, 'direct', 3320, 2, 7902);
    
    UPDATE ORDER_ID SET ORDER_SEQ = ORDER_SEQ + 1;
    COMMIT;
END;

/*
오류 보고 -
ORA-02291: 무결성 제약조건(SCOTT.ORDER_SALES_ID_FK)이 위배되었습니다- 부모 키가 없습니다
ORA-06512:  8행
02291. 00000 - "integrity constraint (%s.%s) violated - parent key not found"
*Cause:    A foreign key value has no matching primary key value.
*Action:   Delete the foreign key or add a matching primary key.
*/

-- 부모키인 7677가 없어서 오류가 발생한 것이니, 이 사원을 추가하거나, 사원 번호를 있는 사원번호로 바꾸면 된다.



--------------------------------------------------------------------------------
-- [요구]

-- a. SEQUENCE의 START값을 10에서 다시 시작하는 방법은?

-- 1) 권한이 있는 경우 : 시퀀스를 DROP 하고 다시 CREATE 하면 된다. 
-- 2) 권한이 없는 경우 : NEXTVAL값을 초기화 해준다. 


-- 1)

DROP SEQUENCE ORDER_SEQ;

-- 2)

-- 시퀀스의 현재 값을 확인
SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'ORDER_SEQ'; -- LAST_NUMBER = 121

-- 시퀀스의 증가 값을 
ALTER SEQUENCE ORDER_SEQ INCREMENT BY -111;

SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- 95
SELECT ORDER_SEQ.NEXTVAL FROM DUAL; -- 95

SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'ORDER_SEQ'; -- -16

SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- 95

ALTER SEQUENCE ORDER_SEQ INCREMENT BY 1;

-- c. 0000001, 0000002와 같은 문자로 SEQUENCE를 만들어 보기

SELECT LPAD(ORDER_SEQ.CURRVAL,8,0) FROM ORDER_ID;
SELECT TRIM(TO_CHAR(ORDER_SEQ.CURRVAL,'00000000')) FROM ORDER_ID;
SELECT TO_CHAR(ORDER_SEQ.CURRVAL,'FM00000000') FROM ORDER_ID;




