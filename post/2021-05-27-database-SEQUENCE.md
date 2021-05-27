# SEQUENCE

## SEQUENCE
- SEQUENCE란? : 일련번호 생성기이다.  

- 일련번호란? : 의미가 없지만 고유성을 식별할 수 있는 번호이다.

- 일련번호의 예시 : 접수번호, 배송번호, 등록번호


## 일련번호 자동 생성 방식

#### 1) MAX(SEQ) + 1 방식
- 테이블 일련번호의 최대값을 찾아서 1을 더하는 방법이다.

- 중복 위험성이 있다. (DUP Error)

  - 여러명에게 동시에 새로운 접수 번호를 줄 때, 순간적으로 중복이 발생할 수 있다.

- 속도가 느리다. 

  - 데이터가 늘어날수록, 전체 데이터를 읽어야 MAX값을 얻을 수 있기 때문에 성능 부분에서 좋지 않다. 


#### 2) 채번 TABLE 방식

- 가장 최근 일련번호를 새로운 TABLE에 저장해 두는 방식이다. 

- 트랜잭션의 크기가 늘어나는 불필요한 연산이 늘어난다. 

#### 3) SEQUENCE (권장)

- 자동으로 일련번호를 생성해주는 기능이다.

## SEQUENCE 생성 방법

```SQL
CREATE SEQUENCE 스키마(소유주).테이블명_SEQ
  INCREMENT BY  증가단위
  START WITH    시작번호
  MAXVALUE      최대값
  MINVALUE      최소값
  NOCYCLE       최대값에 도달하면, 에러 발생시키고 끝낸다.
  [CYCLE        최대값에 도달하면, 다시 MINVALUE로 돌아가라]
  CACHE         미리 생성해서 메모리에 올려둘 일련번호 갯수 (갯수가 끝나면, 다시 해당 갯수만큼 시퀀스를 만든다)
```

 - SEQUENCE 생성 옵션

|옵션명        |설명   |
|:------------:|:-----|
|INCREMENT BY  |증가단위|
|START WITH    |시작번호|
|MAXVALUE      |최대값|
|MINVALUE      |최소값|
|NOCYCLE       |최대값에 도달하면, 에러 발생시키고 끝낸다.|
|CYCLE         |최대값에 도달하면, 다시 MINVALUE로 돌아가라|
|CACHE         |미리 생성해서 메모리에 올려둘 일련번호 갯수 (갯수가 끝나면, 다시 해당 갯수만큼 시퀀스를 만든다)|



## SEQUENCE의 특징

- NEXTVAL : 새로운 일련번호를 만들어낸다.

- CURRVAL : 아무리 많이 호출해도 같은 값을 출력한다. 

- SEQUENCE는 ROLLBACK이 불가하다.

- INSERT(시퀀스 포함)을 ROLLBACK하면 INSERT는 ROLLBACK되지만, SEQUENCE는 ROLLBACK되지 않는다.

- 때문에, 시퀀스 값은 연속적일 수 없다. 

- SEQUENCE는 SELECT 형과 함께 쓰지 않는다. 단지, SEQUENCE의 동작 방식을 알고 싶을 때만 사용한다. 

- SEQUENCE는 INSERT와 함께 쓰인다. 

- SEQUENCE는 테이블과 독립적으로 생성되고 사용된다. (MySQL의 시퀀스는 테이블 종속적)


- SEQUENCE의 START값을 10에서 다시 시작하는 방법은?


## SQL 실습

-- 6 ~ 13. 두 개의 세션에서 시퀀스 실습해보기

-- 2번과 관련해서 에러나는 이유는 무엇일까?

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
SELECT FOR UPDATE;


-- [요구]

-- a. SEQUENCE의 START값을 10에서 다시 시작하는 방법은?


-- c. 0000001, 0000002와 같은 문자로 SEQUENCE를 만들어 보기

