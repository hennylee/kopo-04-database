


## 메인 쿼리와 서브 쿼리
- Query란? 
  - 1. SQL 또는 2. SELECT를 의미한다. 
- Main Query : SELECT , DML , CREATE
- Sub Query : SELECT 만 올 수 있다. 

- 실행순서 : Sub Query 가 먼저 실행된 후에 Main Query가 실행된다. 

## 서브쿼리를 사용하는 이유는?

- 서브쿼리를 사용하지 않으면 여러 문장의 쿼리를 날려서 복수의 Result Set을 받아야 해서 비효율적이다. 

- 만일 데이터 량이 많다면 클라이언트, 네트워크, 서버 모두에 부하가 걸릴 수 있다.

- 이때, 서브쿼리를 사용하면 하나의 쿼리만 전송하면 되기 때문에 Result Set을 한 번만 받게 되어 효율적이다. 
 
- 서브쿼리의 Result Set은 DBMS 내부에서 처리되기 때문이다. 

## Correlated Subquery
