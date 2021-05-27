-- 05/27 : SEQUENCE

-- 1~5. SEQUENCE의 작동방식 알아보기

-- 1.
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

*/



-- 3. 시퀀스는 롤백가능한가?
-- 가능하지 않다.
SELECT ORDER_SEQ.NEXTVAL FROM DUAL;
SELECT ORDER_SEQ.CURRVAL FROM DUAL;
SELECT ORDER_SEQ.CURRVAL FROM DUAL;
ROLLBACK;
SELECT ORDER_SEQ.CURRVAL FROM DUAL;

-- 6~13. 두 개의 세션에서 시퀀스 실습해보기

/*
SESSION-A.sql
SESSION-B.sql
*/

-- ORDER_TBL.SQL
@ORDER_TBL.sql


/*
- EMP 테이블의 EMPNO 컬럼에 P.K 혹은 U.K 제약사항이 걸려있지 않다면,  P.K 제약사항 추가하기
  - F.K는 다른 테이블의 U.K 또는 P.K를 참조하는 것이다. 
  - EMPNO에 P.K가 걸려있지 않다면, F.K 설정 시 참조가 불가능하기 때문이다.
- */

-- INSERT문을 ROLLBACK하면 SEQUENCE도 ROLLBACK될까?

-- 시퀀스값은 연속적인가?

-- 8. 

-- VALUES절에 SELECT가 사용된 스칼라 서브쿼리에서 INSERT할때마다 MAX연산이 쓰이면 성능에 유리할까?
-- MAX+1은 값이 중복되거나, 성능이 저하될 수 있다.


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


-- [요구]

-- a. SEQUENCE의 START값을 10에서 다시 시작하는 방법은?


-- c. 0000001, 0000002와 같은 문자로 SEQUENCE를 만들어 보기

