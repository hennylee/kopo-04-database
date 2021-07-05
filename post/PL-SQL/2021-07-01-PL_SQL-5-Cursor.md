

## 1. 커서(Cursor)의 용어 및 개념

사용자(User)가 SQL을 전송하면 Oracle DBMS는 해당 SQL을 실행하기 위한 메모리 공간이 필요 하다.
 
예를 들면,
 
- SQL을 실행하여 리턴되는 Rows
- 공유 메모리 영역(Shared Pool)에 저장되어 있는 Parsed Query에 대한 포인터

등을 저장하기 위해서 메모리 공간(Context Area)이 필요하다.


정의상으로는 `Context Area` 나 `Cursor`라는 용어가 동일한 의미로 사용되지만 
일반적으로 `Context Area`는 할당된 영역을, `Cursor`는 해당 영역을가리키는 포인터나 해당 영역을 제어하기 위한 핸들러(Handler)의 의미로 사용된다.
<참고 > Shared Pool, Parsed Query에 대한 내용은 SQL Tuning 과정이나
 
 
Oracle Admin 과정에서 별도의 학습을 해야 하며 내용이 어렵다면 마치
컴퓨터의 커서가 현재의 위치를 가리키는 역할을 하듯이 SQL,PL/SQL 관점에서도
SQL 실행을 위해서 할당된 메모리 영역의 위치를 가리킨다(즉 Pointer 역할) 라는
정도로만 기억을 하시기 바랍니다.
<참고> 개개의 서버 프로세스(Server Process)가 독립적으로 사용하는
PGA(Program Global Area) 라는 메모리 영역내에 SQL 처리를 위한 메모리 영역
(Context Area)이 생성 됩니다.

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
|**%ROWCOUNT** |SQL문에의해 영향받은 ROW 총 갯수| FETCH된 누적 갯수 |
|**%FOUND** |- SQL문에의해 영향받은ROW 존재유무<br> - TRUE or FALSE 리턴<br> |- 현재 FETCH된 ROW존재유무<br> - TRUE or FALSE 리턴|
|%NOTFOUND|FOUND의 반대값| FOUND의 반대값|
|%ISOPEN| 항상FALSE이다| CURSOR의 Open 상태 확인|


## 5. 명시적 커서의 4 가지 유형


파라미터 유형

![image](https://user-images.githubusercontent.com/77392444/124404114-6d063400-dd74-11eb-882b-70935ef2fa32.png)


![image](https://user-images.githubusercontent.com/77392444/124404134-8d35f300-dd74-11eb-9da5-b0cb5d1da49f.png)

### CURSOR FOR UPDATE
SELECT는 보통 LOCK을 걸지 않는다. 값을 보기만하니까...
하지만 SELECT FOR UPDATE는 데이터를 수정하기 위해 보는거니까 아무도 수정하지 못하게 ROW LEVEL LOCK을 건다. 

이처럼 CURSOR FOR UPDATE는 SELECT FOR UPDATE를 CURSOR에서 사용하는 것이다. 

다른 누군가가 LOCK을 먼저 걸었으면 나는 WAIT를 하게 된다. 

```SQL
CONN SYS AS SYSDBA
GRANT EXECUTE ON DBMS_LOCK TO SCOTT;
```

- DBMS_LOCK : Oracle이 제공해주는 Package


