[학습목차] 
5-1. 커서(Cursor)의 용어 및 개념
5-2. 커서(Cursor)의 종류
5-3. 명시적 커서(Explicit Cursor)
5-4. 커서 속성(Cursor Attribute)
5-5. 명시적 커서의 4 가지 유형


## 1. 커서(Cursor)의 용어 및 개념
## 2. 커서(Cursor)의 종류
1. 암시적 커서

2. 명시적 커서
- 커서를 정의하는 것
- 커서를 (1) Define , (2) Open , (3) Fetch , (4) Close 한다.


## 3. 명시적 커서(Explicit Cursor)

#### [EXPLICIT CURSOR의 처리 과정]

```
1. DECLARE
2. OPEN : Bind & 커서에 정의했던 SELECT문을 Execute(ResultSet이 만들어짐)
3. FETCH
4. CLOLSE
```

커서는 select로 정의한다. 



open
- 변수를 bind하고, 커서에서 정의한 select 문장을 실행(Execute)한다. 
- select 문장을 실행(Execute)되면서 ResultSet이 DBMS 메모리 내에 생성됨


fetch
- fetch는 1 row 단위로 수행한다.
- 만약 1000만건의 데이터라면 fetch를 1000만번 수행하는 걸까?
  - 아니다. Bulk Binding 기법을 통해 한번에 fetch를 처리한다. 
  - Bulk Binding 과 유사하게 Array Processing, Bulk Collect 이라는 용어를 사용하기도 한다. 
- fetch into : 커서에 있는 값을 변수에 옮겨준다.

- 커서에 인덱스가 있는 것은 아니고 loop 안에서 순차적으로 커서가 옮겨지는 것이다. 
- 커서는 첫 행을 가리키고 있다가 fetch를 하면 다움 행으로 넘어간다. 



close
- 커서를 종료한다는 뜻은 내부적으로 ResultSet을 없앤다는 뜻이다. 
- 즉 메모리 자원을 반납한다는 뜻이다. 



JDBC에서 처리하는 것의 차이는?
- PL/SQL이 anonymous 블럭이면, 클라이언트에 존재하고 dbms에 보내지고 dbms 내부에서 실행됨
- 무거운 데이터 이동이 없어지게 된다.
- 만약에 PL/SQL 쓰지 않고 JDBC에서 처리하게 되면 무거운 데이터가 이동하게 된다. 


## 4. 커서 속성(Cursor Attribute)

|커서속성자 |IMPLICIT CURSOR |EXPLICIT CURSOR|
|-----------|---------------|----------------|
|**%ROWCOUNT** |SQL문에의해 영향받은 ROW 총 갯수 FETCH된 누적 갯수 |
|**%FOUND** |- SQL문에의해 영향받은ROW 존재유무<br> - TRUE or FALSE 리턴<br> - 현재 FETCH된 ROW존재유무<br> - TRUE or FALSE 리턴|
|%NOTFOUND|FOUND의 반대값 FOUND의 반대값|
|%ISOPEN| 항상FALSE이다 CURSOR의 Open 상태 확인|


## 5. 명시적 커서의 4 가지 유형
