-- 세션 A.

/* 시퀀스 2에서부터 시작! */

-- 6. 
SELECT ORDER_SEQ.NEXTVAL FROM DUAL; -- NEXTVAL = 2

/*
cache 옵션을 사용하면 속도를 증가시키기 위해 sequence 번호를 한 번에 여러 개씩 메모리에 올려놓고 작업을 한다. 

이것을 사용하면 매번 sequence 번호를 생성하는 것보다 빠르기 때문이다. 

이러한 경우에 DB를 중지시키거나 전원이 off 되는 경우에 메모리에 있던 번호가 삭제되기 때문에 이러한 증상이 발생된다. 

즉 cache 옵션이 20개씩 시퀀스 번호를 생성하도록 설정되어 있다면 한번에 1부터 20까지 시퀀스 번호를 생성한다. 

이 상태에서 DB를 중지하고 재시작 시키면 
메모리에 있던 20번까지의 시퀀스가 삭제되고 
21번부터 40번까지 메모리에 시퀀스 번호가 저장되기 때문에 
이런 경우에 1, 21, 41로 시퀀스 번호가 증가될 수 있다.
*/

-- 8. 
SELECT ORDER_SEQ.NEXTVAL FROM DUAL; -- NEXTVAL = 31

-- 10. 
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- CURRVAL = 32

-- 13.
SELECT ORDER_SEQ.CURRVAL FROM DUAL; -- CURRVAL = 32