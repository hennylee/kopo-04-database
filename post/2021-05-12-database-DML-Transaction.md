

## DML

- Data Manipulation Language

- INSERT

- DELETE

- UPDATE

- MERGE(9i 이후 추가됨) : ( INSERT 연산 + UPDATE 연산 )이 합쳐진 것이다.

### INSERT

```SQL
-- 형식
INSERT INTO 테이블명(컬럼명, ...) VALUES(값, ...);
```


### DELETE

```SQL
-- 형식
DELETE FROM [ 컬럼명 ] WHERE ~
```


- 레코드를 삭제하기


### UPDATE

```SQL
-- 형식
UPDATE 테이블명 SET [ 수정할 컬럼명 = 수정할 값 ] WHERE ~
```

### MERGE(9i 이후 추가됨) 



## Transaction

- 트랜젝션이란 작업의 논리적 단위이다. (Logical Unit of Work)

- DBMS 내부에서는 논리적인 작업들은 SQL의 묶음이다. 

### 트랜젝션의 시작과 종료

- 시작 : 첫 번째 변경 가능한 SQL 실행시 트랜젝션이 시작된다.

- 종료 : 명시적 종료와 암시적 종료가 있다.

  - 명시적 종료 : COMMIT, ROLLBACK
  - 암시적 종료
    - DDL(데이터 정의어 : CREATE, DROP, ALTER, TRUNCATE) 명령어 실행 시
    - 비정상 종료 시

### 종료 트랜젝션

- COMMIT : 트랜젝션에서 DB에 변경된 사항을 영구히 반영하는 것 => Disk 에 저장하는 것이다. (임시저장 => 메모리에만 저장되는 것, 메모리는 휘발성이다.)

- ROLLBACK : 트랜젝션 이전 사태로 되돌리는 것, 입력/수정/삭제를 취소하고 LOCK을 해제

- SAVEPOINT : 저장점, 현재 시점부터 SAVAPOINT까지 트랜젝션의 일부만 ROLLBACK, 복잡한 대규모 TRANSACTION 에러가 발생했을 때



### 읽기 일관성

- 트랜젝션 중, 즉 **변경 중**인 불안정한 데이터 는 '나'의 세션에서만 볼 수 있다. 

- 다른 세션에서는 **변경 전**의 안정적인 데이터만 볼 수 있게 되는 것이다. 

![image](https://user-images.githubusercontent.com/77392444/117945053-e7a06d80-b348-11eb-8fe9-8b0399faf075.png)

- 트랜젝션이 이루어지면 DBMS는 변경전 데이터(Before Image)를 어딘가에 저장해 두고, 데이터를 변경해서 변경 후 데이터(After Image)를 만들어낸다. 

