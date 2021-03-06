# SubQuery

## 1. 메인 쿼리와 서브 쿼리

- Query : 1. SQL 또는 2. SELECT를 의미한다. 

- Main Query : SELECT , DML , CREATE문

- Sub Query : SELECT 만 올 수 있다. 

- 실행순서 : Sub Query 가 먼저 실행된 후에 Main Query가 실행된다. 

## 2. Subquery를 사용하는 이유는?

- 서브쿼리를 사용하지 않으면 여러 문장의 쿼리를 날려서 복수의 Result Set을 받아야 해서 비효율적이기 때문이다.

- 만일 여러 번, Result Set을 주고 받을 때 데이터 량이 많다면 클라이언트, 네트워크, 서버 모두 부하가 걸릴 수 있다.

- 이때, 서브쿼리를 사용하면 하나의 쿼리만 전송하면 되기 때문에 Result Set을 한 번만 받게 되어 이러한 에러를 해결할 수 있다.
 
- 서브쿼리의 Result Set은 DBMS 내부에서 처리되고 클라이언트에는 Result Set을 한 번만 전송하면 되기 때문이다. 

- ![그림 추가하기]()

- ![그림 추가하기]() 

## 3. Subquery의 분류

### Return Style에 따른 분류

- Single Row SubQuery : 리턴되는 데이터가 1건 이하인 서브쿼리, 단일행 비교 연산자( = , > , < , <= ... )와 함께 사용된다. 

- Multiple Row SubQuery : 리턴되는 데이터가 1건 이상인 서브쿼리, 리스트 연산자(IN , ANY , ALL , SOME , EXIST)

- Single Column SubQuery : 리턴되는 데이터가 1개의 컬럼인 서브쿼리

- Multiple Column SubQuery : 리턴되는 데이터가 1개 이상의 컬럼인 서브쿼리


### 동작하는 방식에 따른 분류

- Un-Correlated Subquery : 서브쿼리가 메인쿼리의 컬럼을 참고하지 않는다.

  - [Creating an Uncorrelated Subquery 관련 문서](https://docs.oracle.com/cd/E57185_01/SQRST/apds118.html)

- Correlated Subquery : 서브쿼리가 메인쿼리의 컬럼을 참조한다. 메인쿼리가 먼저 실행되고 서브쿼리에서 필터링하는 목적으로 사용된다. 

- ![그림 추가하기]()


## 4. In-Line View 

- FROM 절에 사용된 서브쿼리를 인라인뷰라고 한다. 

- SQL이 시작되는 시점에 동적으로 생성되는 View의 역할을 한다고 해서 Dynamic View라고도 한다. 

- 일반적으로 Subquery의 컬럼을 Mainquery에서 사용할수 없지만, Inline View에서 Subquery의 컬럼을 Mainquery 에서 사용이 가능하다.

## 5. 1:M / M:1

## 6. Top-N , Bottom-M


## 7. Scalar Subquery

- 내부적으로 캐싱(caching) 기법이 적용된다.

- cache : 자주 쓰는 것을 짱박아 두는 것이다. 


