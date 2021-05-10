-- <05/10> 서브쿼리

-- 그림 잘 이해하기
-- 3. 



-- 서브쿼리가 여러개의 컬럼을 리턴할 때 확인하기
-- 4.


-- [스칼라 서브쿼리]

-- SELECT LIST 자리에 서브쿼리가 올 때 
-- Corealted SubQuery : 메인쿼리가 실행된 후에야 서브쿼리를 사용할 수 있을 때!
-- 5. 


-- [인라인 뷰]
-- 테이블은 정형화된 데이터 구조인데, 인라인뷰 서브쿼리를 사용하면 동적 테이블 구조를 생성해내서 활용할 수 있어서 편리하다.
-- 이때 활용한 동적 테이블 구조는 메모리 상에서만 실행되고 쿼리가 끝나면 사라진다. 
-- 정적 데이터 구조는 디스크 상에서 저장되어 사용된다는 차이가 있다. 


-- [DML]
-- SELECT가 서브쿼리 + INSERT가 메인 쿼리이다. 

-- DML 내의 SELECT 문에는 DECODE, WHERE IN 등을 모두 사용할 수 있다.