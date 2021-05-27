# View

## View의 정의

- 제약사항을 선언하는 방법

![image](https://user-images.githubusercontent.com/77392444/119779567-c96b6d80-bf03-11eb-8764-18c8873388f5.png)

- View는 데이터 딕셔너리에 저장된 

- 질의를 재작성하여 수행하며, 데이터를 가지고 있지 않지만 테이블의 역할을 동일하게 수행하기 때문에 가상 테이블로 불리기도 한다. 

- View의 동작 방식 : Query Rewrite => 사용자가 날린 쿼리를 옵티마이저가 몰래 더 효율적인 것으로 바꾸는 것과 비슷하다. 

- MERGE를 Query Rewrite라고 한다. 

- 쿼리란?
  - SQL 문장 전체 혹은 SELECT

- 인라인뷰
  - FROM 절에 (SELECT ~) 가 온 것 

## View Merge

CTAS : CREATE TABLE AS (SELECT ~);

CVAS : CREATE VIEW AS (SELECT ~);


VIEW는 FROM 절에 올 수 있다. 

