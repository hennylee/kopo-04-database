

# 1. Java : SQL Statement, Prepared Statement, Callable Statement란?

```
Transaction Type과 연계해서 정의, 장단점, 개발 시 차이점, 코딩 실습
```

- statement : 일반적인 sql쿼리를 실행

- preparedStatement : 동적 또는 매개변수가 필요한 sql쿼리를 실행

- callableStatement : 저장된 프로시져를 실행
	- 트랜잭션은 자바로 구현할수도 있고, 프로시저로 구현할 수도 있다.
    
## 1.1 Statement

```java
String sql = "SELECT name, phone, address FROM classTable";
Statement s = conn.credateStatement();
ResultSet rs = s.executeQuerey(sql);
```

statement는 일반적인 sql 쿼리를 실행하는데 사용된다. 매개변수를 전달할 수도 없고 실행할 때마다 컴파일을 하게된다. 따라서 성능적인 면에서 안좋을 수 밖에 없고, 유연하지 못하다. 그래서 대부분의 statement 구문은 DDL문(create, alter, drop …)에서 주로 사용된다.

statement는 string형태로 sql을 작성하기 때문에 sql 작성이 다른 인터페이스보다 편하고 직관적인 장점이 있다.

## 1.2 Prepared-Statement

```java
String sql = "UPDATE classTable SET name = ?, phone = ?, address = ?";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, "마동석");
ps.setString(2, "010-1234-5678");
ps.setString(3, "서울시");
ResultSet rs = ps.executeQuerey();
```

prepared는 사전적 의미로 ‘준비된’ 이란 뜻이다. 이름에서 알 수 있듯이 준비된 statement이며 여기서 준비 = 컴파일을 말한다. preparedStatement는 statement를 확장한다.

미리 컴파일이 되어 준비하고 있기 때문에 statement에 비해 성능상으로 우위에 있다. 매개변수 전달이 필요한 sql 작성이나, for loop 등으로 여러번 sql을 실행하는 경우에 주로 사용한다.



## 1.3 Callable Statement

```java
int classNumber = 1;

CallableStatement cs = conn.prepareCall("{ call procGetStudents(?, ?, ?) }");
cs.setString(1, classNumber);
cs.registerOutputParameter(2, Types.VARCHAR);
cs.registerOutputParameter(3, Types.VARCHAR);
cs.execute();
ResultSet rs = cs.getResultSet();
```

CallableStatement는 미리 작성해둔 프로시저를 실행하는데 사용한다. CallableStatement는 PreparedStatement를 확장한다.

CallableStatement를 사용할때는 ? 매개변수 자리에 프로시져에서 사용하는 매개변수와, 가져올 값에 대한 셋팅을 동시에 해준다. 프로시져 실행에 필요한 매개변수는 setString, setInt 등으로 해주고, 프로시져 응답으로 받을 값들에 대한 데이터 타입을 registerOutputParameter으로 모두 지정해주어야 한다.

CallableStatement 역시 미리 컴파일되어 DB에 저장되어 있기 때문에 성능상으로 이점이 있다.




# 2. 각 Statement의 속도 차이


Statement, PreparedStatement, CallableStatement 의 속도에 대한 의견은 다음과 같다.

  - Statement : 단일일때 빠르다.
  - PreparedStatement, CallableStatement : 연속적으로 써야 빠르다. 
    - 처음 생성할때 여러가지 준비된 작업을 하기에 연속적으로 쓰지않는경우 Statement보다 느리다.
    - 약 60 번정도 연속적으로 써야 Statement 보다 빠르다.

- 이견

```
 몇 년전부터 요즘은 단일로 쓰더라도 Statement와 PreparedStatement, CallableStatement사이의 속도차이가 나지 않기 때문에 
인젝션을 하나하나 막을 생각이 없다면 연속적으로 부르지 않을 경우에도 PreparedStatement, CallableStatement를 쓰라고 권고한다.

그래서 현재에는 더 빠른 속도로 매번 다른 구문을 실행하기위해 PreparedStatement, CallableStatement 대신 Statement를 쓸 필요가 없어졌다.

다만 PreparedStatement, CallableStatement로 속도적 이득을 보기위해선 파라미터값만 다른 구문을 연속적으로 실행해야한다.

예를 들어 h게시판 메인부분을 스테틱 CallableStatement로 만들어 매번 재사용하는 것 처럼 사용하면 속도적 이득이 있지만,
매번 불러 사용하게될경우 Statement 보다 빠르지 않다는것은 10년전과 동일합니다.

매번 SQL 인젝션을 처리해주는것이 부담스러운 사람은 무조건 PreparedStatement, CallableStatement을 사용해주시는 것이 좋다.

인젝션 처리가 부담스럽지 않은 사람들도 PreparedStatement, CallableStatement를 쓰는것이 Statement를 쓰는것과 별반 차이가 없다.
```

진짜일까? test를 해보자.




## 2-1. 실험
