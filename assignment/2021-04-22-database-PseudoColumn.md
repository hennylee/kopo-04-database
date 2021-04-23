## Pseudo Column

- Pseudo Column : 테이블 컬럼처럼 행동하지만, 테이블에 실제로 저장되지 않고 오라클에서 내부적으로만 사용되는 컬럼이다.

- Pseudo Column의 특징

  - 조회만 가능한 컬럼이다.
  
  - 그래서 DML을 사용할 수 없다. 

  - argument가 필요없다.

  - pseudocolumns 은 각 ROW마다 다른 값을 반환한다. 

## pseudocolumns 의 종류

- Hierarchical Query Pseudocolumns

- Sequence Pseudocolumns

- Version Query Pseudocolumns

- COLUMN_VALUE Pseudocolumn

- OBJECT_ID Pseudocolumn

- OBJECT_VALUE Pseudocolumn

- ORA_ROWSCN Pseudocolumn

```SQL
-- 데이터 최종수정 시간
-- For each row, ORA_ROWSCN returns the conservative upper bound system change number (SCN) of the most recent change to the row.
SELECT ORA_ROWSCN FROM EMP;
```

- ROWID Pseudocolumn : Index를 할 때 중요하다. Order을 달리해도 변하지 않는 고유의 값이다.

```SQL
-- 행을 찾아가는 가장 빠른 방법   
SELECT ROWID FROM EMP;
```

- ROWNUM Pseudocolumn

- XMLDATA Pseudocolumn
