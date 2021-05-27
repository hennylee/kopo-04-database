# 트랜젝션의 4가지 특성 ACID

## 1. 원자성(Automicity) 

- All tasks of a transaction are performed or none of them are. There are no partial transactions. For example, if a transaction starts updating 100 rows, but the system fails after 20 updates, then the database rolls back the changes to these 20 rows.

- 트랜잭션의 포함된 오퍼레이션(연산, 작업)들은 모두 수행되거나, 아니면 전혀 수행되지 않아야 한다.

## 2. 일관성(Consistency)

- The transaction takes the database from one consistent state to another consistent state. For example, in a banking transaction that debits a savings account and credits a checking account, a failure must not cause the database to credit only one account, which would lead to inconsistent data.

- consistent는 내부적 일관성을 의미한다.

- 트랜잭션이 실행되기 전의 데이터베이스 내용이 잘못 되어 있지 않다면, 트랜잭션 실행 이후에도 데이터베이스의 내용에 잘못이 있으면 안된다. 

- 즉, 트랜잭션이 성공적인 경우에는 일관성있는 상태에 있어야 한다. 만약 테이블의 글자 수를 설정해놨다면 트랜잭션 후에도 데이터가 그 설정을 따라야 한다는 뜻이다.



## 3. 고립성, 격리성 (Isolation)

- The effect of a transaction is not visible to other transactions until the transaction is committed. For example, one user updating the hr.employees table does not see the uncommitted changes to employees made concurrently by another user. Thus, it appears to users as if transactions are executing serially.

- 각 트랜잭션은 다른 트랜잭션과 독립적으로 수행되는 것처럼 보여야 한다.

- 트랜잭션이 실행되는 도중에 다른 트랜잭션의 영향을 받아 잘못된 결과를 만들어서는 안된다. 

### 3.1 낮은 단계의 격리성 수준에서 발생할 수 있는 현상들입니다.

1. Dirty Read : 다른 트랜잭션에 의해 수정되었지만 아직 커밋되지 않은데이터를 읽는 것을 의미합니다.

2. Non-Repeatable Read : 한 트랜잭션 내에서 같은 쿼리를 두 번 수행했는데, 그 사이에 다른 트랜잭션이 값을 수정,삭제하여 두 쿼리의 결과가 다르게 나타나는 현상입니다.



3. Phantom Read : 한 트랜잭션 내에서 같은 쿼리를 두 번 수행했는데, 그 사이에 다른 트랜잭션이 값을 추가하여 첫 번째 쿼리에서 없던 유령(Phantom) 레코드가 두 번째 쿼리에서 나타나는 현상입니다.



### 3.2 트랜잭션의 격리성 수준

1. Read Uncommitted : 트랜잭션에서 처리 중인 아직 커밋되지 않은 데이터를 다른 트랜잭션이 읽는 것을 허용하는 것 입니다.

2. Read Committed : 트랜잭션이 커밋되어 확정된 데이터만 다른 트랜잭션이 읽도록 허용함으로써, Dirty Read를 방지해줌. 하지만, 커밋된 데이터만 읽더라도  Non-Repeatable Read와 Phantom Read현상을 막지 못합니다.



3. Repeatable Read : 트랜잭션 내에서 쿼리를 두 번 이상 수행할 때, 첫 번째 쿼리에 있던 레코드가 사라지거나 값이 바뀌는 현상을 방지해 줍니다. 하지만, Phantom Read 현상을 막지 못합니다.



4. Serializable Read : 트랜잭션 내에서 쿼리를 두 번 이상 수행할 때, 첫 번째 쿼리에 있던 레코드가 사라지거나, 값이 바뀌지 않음은 물론, 세로운 레코드가 나타나지도 않습니다.



## 4. 지속성(Durability)

- Changes made by committed transactions are permanent. After a transaction completes, the database ensures through its recovery mechanisms that changes from the transaction are not lost.

- 성공적으로 수행된 트랜잭션의 결과는 지속성이 있어야 한다

- 트랜잭션이 성공적으로 수행되면 그 트랜잭션이 갱신한 데이터베이스의 내용은 영구적으로 저장된다. 

출처: https://priceless.tistory.com/362 [Pasture]
