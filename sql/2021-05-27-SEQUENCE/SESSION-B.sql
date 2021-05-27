-- 세션 B.

-- 7. 
SELECT ORDER_SEQ.NEXTVAL FROM DUAL; -- NEXTVAL = 3

/*
    CACHE가 30으로 설정되어 있다.
    무슨 영향으로 3에서 32가 되었을까?
*/

-- 9.
SELECT ORDER_SEQ.NEXTVAL FROM DUAL; -- NEXTVAL = 32

-- 11.
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- CURRVAL = 32

-- 12.
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- CURRVAL = 32


/*
프로세스가 할당되고 메모리가 할당된다. 
빈번하게 신규 커넥션을 맺으면 서버가 성능저하가 된다. 
*/