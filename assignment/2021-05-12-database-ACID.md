# 트랜젝션의 4가지 특성 ACID

## 1. 원자성(Automicity) 

- All tasks of a transaction are performed or none of them are. There are no partial transactions. For example, if a transaction starts updating 100 rows, but the system fails after 20 updates, then the database rolls back the changes to these 20 rows.

- 트랜잭션의 포함된 오퍼레이션(작업)들은 모두 수행되거나, 아니면 전혀 수행되지 않아야 한다.

## 2. 일관성(Consistency)

- The transaction takes the database from one consistent state to another consistent state. For example, in a banking transaction that debits a savings account and credits a checking account, a failure must not cause the database to credit only one account, which would lead to inconsistent data.

- consistent는 내부적 일관성을 의미한다.

- 트랜잭션이 성공적인 경우에는 일관성있는 상태에 있어야 한다. 만약 테이블의 글자 수를 설정해놨다면 그 설정을 따라야 한다는 뜻이다.

- 즉, 트랜잭션에 무결성에 위배된 쿼리문이 있어선 안된다는 뜻 아니엽?

## 3. 고립성(Isolation)

- The effect of a transaction is not visible to other transactions until the transaction is committed. For example, one user updating the hr.employees table does not see the uncommitted changes to employees made concurrently by another user. Thus, it appears to users as if transactions are executing serially.

- 각 트랜잭션은 다른 트랜잭션과 독립적으로 수행되는 것처럼 보여야 한다.

## 4. 지속성(Durability)

- Changes made by committed transactions are permanent. After a transaction completes, the database ensures through its recovery mechanisms that changes from the transaction are not lost.

- 성공적으로 수행된 트랜잭션의 결과는 지속성이 있어야 한다

출처: https://priceless.tistory.com/362 [Pasture]
