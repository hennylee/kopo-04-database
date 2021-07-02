## 1. PL/SQL 개요

PL/SQL은 비절차적 언어인 SQL에 절차적(PL) 기능을 추가한 것이다. 


```
비절차적(What) vs 절차적(How)
```

#### [절차적 언어란?]
- 처리하는 절차(방법과 순서)가 정해진 언어이다.
- SQL에는 어떻게 처리해야 하는지 방법을 명기한 적이 없기 때문에 비절차적 언어이다.

현재는 PL/SQL의 개발 생산성, 효율성의 장점으로 인해 시장점유율을 높은 DBMS 대부분 PL 기능을 추가했다. 

#### [PL/SQL Bolck 구조]

```sql
DECLARE
 선언부(optional)
BEGIN
  실행부
EXCEPTION
  예외처리부(optional)
END;
```

- 예외처리부는 optional이지만, 반드시 코딩하는 습관을 들여야 한다.

- 또 `END;`에 `;` (세미콜론, 문장종결자)을 작성하지 않으면 오류가 발생한다. 




## 2. PL/SQL 주요 특징

#### [PL(절차적 기능) 주요 특징]
- 변수, 상수 선언
- 제어구문(for, while)
- 예외처리
- 모듈화(function, package)




### 2.1 변수 선언

#### [형식]

- PL/SQL에서는 `:=` 이 대입 연산자이다. 

```
:= : 대입 연산자
=  : 비교 연산자
```

- 변수 선언과 초기화가 동시에 이루어질 수 있다. `V_EMPNO NUMBER(4) := 8888`

- 변수 선언 후, 초기화를 해주지 않으면 `null`값으로 초기화된다. (null 오류 발생 가능성 높으므로 주의해야 함)

- 테이블 컬럼 정의할때와 같이, 변수 정의할때도 `변수명 데이터타입(데이터길이)` 형식을 취한다. 


#### [CURSOR]

- Multiple(다중) Row를 처리하기 위한 수단이다. 

- CURSOR 뒤에는 SELECT 문만 나올 수 있다. 



### 2.2 제어 구조

- 제어는 프로그램의 처리(실행) 흐름을 제어하는 조건문/반복문/GOTO 문이다.

- PL/SQL에서는 `=` 이 비교 연산자이다. 

```
:= : 대입 연산자
=  : 비교 연산자
```

- IN과 같은 연산자를 PL/SQL에서도 쓸 수 있다. 

- PL/SQL에서 Package란 자바의 Class 개념이다. 



### 2-3. 예외처리

예외처리 구문이 있는 언어의 장점은? 
- 예외처리 부분과 실행 부분을 분리할 수 있기 때문에 코드가 깔끔해진다. 
- 물론 예외처리 구문이 없는 언어(C언어)에서도 예외처리를 할 수 있지만, 실행부와 예외처리부가 분리되지 않기 때문에 코드가 복잡하다.

안정적이고 오작동하지 않는 개발이 예외처리의 목적이다.

`Runtime Error`(실행시 에러) 와 `Complie Error` 중에서 예외처리부에서는 `Runtime Error`를 처리한다.



### 2-4. 모듈화

보통 일반적인 프로그램 개발시 모듈단위로 나누어 개발하거나 독립모듈을 만들어 라이브러리화 시켜서 재사용한다.

PL/SQL에서는 BLOCK 구조화된 언어로 BLOCK 단위를 통해 모듈화한다.

BLOCK 안에 BLOCK을 사용하는 것을 중첩 BLOCK(Nested Block)이라고 한다.

PL/SQL 블럭은 connection 연결통로를 타고 DBMS Server로 넘어간다. 

단일 SQL 문장을 넘기는 것과 PL/SQL 블럭을 넘기는 것, 무엇이 더 빠를까?

- PL/SQL이다.

- 네트워크 패킷 넘기는 건수가 줄어들어서 PL/SQL이 더 빠를까? 아니다. 그 효율은 아주작은 효율만 가져다줄 뿐이다...

- 그럼 왜 PL/SQL이 더 빠를까 그 이유를 생각해보아야 한다. 

- 그 이유는 바로, `무거운 데이터`가 클라이언트로 이동해서 클라이언트에서 가공처리되는 것이 아니라, 
`가벼운 데이터 처리로직`만 클라이언트로 이동하고 무거운 데이터는 서버 안에서 처리되기 때문이다.  

- 하둡, 맵리듀스 등도 이와 같은 원리로 대용량 데이터 처리를 빠르게 하는 것이다. 


왜 프로시저 패키지를 만들까?

- 재사용하기 위함이다. 



## 3. PL/SQL의 장점

```
1. 이식성
2. 통합성
3. 성능
```


### 3.1 이식성

이식성은 개발 생산성 및 유지보수/기능개선 비용을 줄여주는 특징이 있다. 

만일 ORACLE DBMS가 지원하는 모든 플랫폼간에 PL/SQL로 작성된 것은 그대로 호환이 가능하다.

자바의 'Write Once Run Anywhere'과 동일한 개념이다. 


### 3.2 통합성

통합성은 개발 생산성과 효율성을 주는 특징이 있다.

PL/SQL을 사용한다면, DATA에 저장되어 있는 DBMS 서버 내에서 데이터를 처리할 수 있기 때문에 개발 생산성과 효율성을 주는 것이다. 

즉, 클라이언트단에서 데이터를 처리하지 않아도 되기 때문에 효율성이 증대될 수 있다.



### 3.3 성능

위에서 했던 얘기와 같다.

단일 SQL 문장을 넘기는 것과 PL/SQL 블럭을 넘기는 것, 무엇이 더 빠를까?

- PL/SQL이다.

- 네트워크 패킷 넘기는 건수가 줄어들어서 PL/SQL이 더 빠를까? 아니다. 그 효율은 아주작은 효율만 가져다줄 뿐이다...

- 그럼 왜 PL/SQL이 더 빠를까 그 이유를 생각해보아야 한다. 

- 그 이유는 바로, `무거운 데이터`가 클라이언트로 이동해서 클라이언트에서 가공처리되는 것이 아니라, 
`가벼운 데이터 처리로직`만 클라이언트로 이동하고 무거운 데이터는 서버 안에서 처리되기 때문이다.  

- 하둡, 맵리듀스 등도 이와 같은 원리로 대용량 데이터 처리를 빠르게 하는 것이다. 


## 4. 실행구조 및 PL/SQL 엔진 


### 4.1. Block의 종류

```
1. ANONYMOUS BLOCK : 클라이언트 프로그램 또는 SQL Script 내에 저장된 블록
2. NAMED BLOCK(=STORED BLOCK) : DBMS 서버에 저장된 블록
```

#### [NAMED BLOCK]

Function / Procedure / Packege / Trigger 등이 `NAMED BLOCK`이다.

NAMED BLOCK은 재사용, 공유가 목적이다.

NAMED BLOCK도 View 처럼 데이터 처리 로직이 DBMS 서버 내의 데이터 딕셔너리에 저장된다. 

클라이언트 내에 블럭의 소스가 존재할 필요가 없다. 

![image](https://user-images.githubusercontent.com/77392444/124054453-fe1b9900-da5c-11eb-8757-8d66f79190fb.png)


#### [ANONYMOUS BLOCK]


ProC에서는 ANONYMOUS BLOCK을 사용한다. 

![image](https://user-images.githubusercontent.com/77392444/124054442-f6f48b00-da5c-11eb-9133-3ab026fd2f26.png)



### 4.2 PL/SQL 엔진

![image](https://user-images.githubusercontent.com/77392444/124054717-839f4900-da5d-11eb-80ce-4bfdf6ba4bbd.png)

PL/SQL 엔진에서는 PL/SQL BLOCK을 분석하여,
- PL/SQL  기능은 절차적 처리기(Procedural Statement Executor)에게 보내어 실행하고 
- SQL  기능은 SQL 처리기(SQL  Statement Executor)에게 보내어 실행합니다.

![image](https://user-images.githubusercontent.com/77392444/124055284-923a3000-da5e-11eb-8d30-cbf13ed94a2f.png)


#### [Context Switch (문맥 교환)]

- O/S 입장에서 말하자면 동시에 요청이 들어왔을때, 여러개를 왔다갔다 하면서 처리하는 것이다.
- 다른 요청을 처리하기 위해 작업을 중단할때 데이터는 레지스터에 담아두고 다른 일을 처리한다. (Time Slicing)

- Statement를 사용할때는, 클라이언트와 서버 사이에 자바와 SQL 사이에 문맥교환이 이루어진다. 

- Prepared Statement를 사용한다면, DBMS 서버 내에서 PL과 SQL 사이에 문맥 교환이 이루어진다. 


### 5. 디버깅 Tool

DBMS_OUTPUT은 ORACLE 社에서 디버깅 Tool 용도로 제공하는 PACKAGE이다.
- ORACLE  社에서 디버깅 Tool용도로 제공하는 PACKAGE 
- PL/SQL BLOCK이 실행되는 동안에는 메모리상에 출력결과를 저장해두었다가 PL/SQL BLOCK의 실행이 종료된후 메모리의 결과를 SQL*PLUS의 화면상에 출력한다.

DBMS_OUTPUT에 대한 오해는 실행    시점에    실시간으로    결과를    출력한다고 생각하는    경우가    많지만   PL/SQL  실행이    종료된후    해당    내용을    화면에    일괄적 으로    출력한다.

- SQL*PLUS의        환경변수    인   `SET SERVEROUTPUT ON` 을    설정해야    출력   결과가    나타난다. 
