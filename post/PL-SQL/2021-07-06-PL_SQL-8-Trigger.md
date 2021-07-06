

## 무결성 제약조건을 구현하는 방법

```
1. Constraint
2. Trigger
-----------------------dbms
3. App Logic
-----------------------app
```

### Constraint  vs  Trigger

`Constraint`
  - 선언적 무결성 제약사항
  - 테이블 정의 시, 선언만 하면 됨

`Trigger`
  - PL/SQL로 코딩해야 함
  - 복잡한 비즈니스 로직 구현이 가능함



트리거란 이벤트가 생기면 자동으로 실행되는것이다.

SELECT는 제약 사항에 제한을 받지 않는다.



|    |INSERT|DELETE|UPDATE|
|----|:-----:|:---:|:----:|
|:NEW|O     |X     |O     |
|:OLD|X     |O     |O     |



EVENT LOGGING을 왜 필요로 할까?
- 이력 관리를 위해서이다. 
  - 이력관리(History Table) : 진행이력, 발생이력, 변경이력...

- 이력을 관리하는 것이란?
  - 데이터 생명주기를 기록으로 남기는 것이다.
  - 데이터는 SQL의 DML 연산을 통해 변화한다. 

