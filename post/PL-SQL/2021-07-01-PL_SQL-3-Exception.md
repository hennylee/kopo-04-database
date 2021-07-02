

## 1. Nested Block

Nested는    사전적    의미로    중첩된   포개진    이라는    의미를   가지고    있으며. Nested Block은   중첩된   Block 으로        Block 안에    또   다른    Block이   내포된    구조이다.


Nested Block을   사용하는   주요   이유는 
①   예외처리           ②   모듈화 이다.

Label   : `<< label_name >>`
Label은   (a)   GOTO 분기하는   영역 
(b)   SOURCE 가독성    (주용도) 2가지   용도로   사용된다.



## 2. Nested Block과 Transaction

트랜젝션 시작 : 첫 번째 트랜잭션 sql 문장이 실행될때 (다른 dbms는 begin transaction 선언)
트랜젝션 종료 : commit이나 rollback이 실행될때

![image](https://user-images.githubusercontent.com/77392444/124263404-2b0ba100-db6e-11eb-8a98-8d0e74dab308.png)


그래서 트랜잭션의 시작과 끝은 Block의 시작 및 종료와 전혀 관련이 없다.



## 3. Exception


에러는 발생하는 시점에 따라 2가지 유형으로 구분된다.
- 컴파일 시점 에러 (Compile Time Error)
- 실행시점 에러 (Run Time Error) 

PL/SQL Block은 크게 2단계로 처리된다고 볼 수 있다. 

```
(1) 컴파일 => (2) 실행
```

### 3.1 컴파일 시점 에러 (Compile Time Error)

- 컴파일 에러가 발생하면, 뒷부분은 아예 실행조차 되지 않는다. 

- 컴파일 에러가 발생하기 전 데이터는 명시적(수동) ROLLBACK이 필요하다...?



### 3.2 실행시점 에러 (Run Time Error)

Block 내에서 예외처리구문을 못 찾으면?

- Block 밖으로 예외를 던진다.

Main Block까지 던저도 예외처리 구문이 없다면, 더이상 예외를 처리할 구문이 없기 때문에 커밋되지 않은 데이터는 자동 `ROLLBACK` 된다.
- Statement Level ROLLBACK이 된 것이다.


#### [Statement Level ROLLBACK / Transaction Level ROLLBACK]

Statement Level ROLLBACK : 암시적(자동)

- 2개까지 UPDATE 완료했는데, 3번째에서 오류가 나면 그 전의 것들이 자동으로 ROLLBACK되는 것이다. 
- 트랜젝션 내에서 2개까지 UPDATE 완료했는데, 3번째에서 오류가 났을때 그 전/후의 것들이 자동으로 ROLLBACK되는 것이다.  (예외처리 안했을 시)

Transaction Level ROLLBACK : 명시적(수동)

- 트랜젝션 내에서 2개까지 UPDATE 완료했는데, 3번째에서 오류가 났을때 그 전의 것들을 ROLLBACK시키려면 수동으로 해야한다. (예외처리 했을 시)



### 3.3 Exception 정의

|종류                     |세부           |설명                 |예시                                                         |
|------------------------|---------------|--------------------|-------------------------------------------------------------|
|ORACLE Defined Exception|PREDEFINED<br>NON-PREDEFINED      |Name이 정의된 Exception|NO_DATA_FOUND, TOO_MANY_ROWS, TIMEOUT_ON_RESOURCE <br>Name이 없는 Exception|ORA-00001 :무결성 제약 조건(SCOTT.DEPT_DEPTNO_PK)에 위배됩니다          |
|USER Defined Exception  |               |비즈니스룰에 따라 정의된 Exception|SAL < 0 , E_MINUS_SAL                                        |

PREDEFINED 와 NON-PREDEFINED의 차이는?
- 이름유무의 차이이다. 
- 이름이 없는 NON-PREDEFINED는 에러명 대신 `Error Code`와 `Error Msg`만 정의되어 있다. 

USER Defined Exception는 PL/SQL에 코드를 깔끔하게 만들고, 개발자의 반복된 코딩을 줄여준다.


### 3.4 Exception 발생 및 처리

#### [Exception 블록의 역할]
1. Error가 블록 밖으로 나가지 않도록 잡아준다.
2. 트랜젝션 일관성 보장을 위해 ROLLBACK 등의 조치
3. 에러 로그 기록


#### [Exception 처리과정]
① Exception이 발생 -> 해당 Statement를 Rollback처리
② 다음 Statement를 처리하지 않고 해당 Block내의 예외처리부로 제어를 이동

#### [질문] Exception을 처리한다는 의미를 설명 하십시요? 
 
① Block내에서 발생한 Exception이 외부로 전파되지 않도록 잡기만(Catch) 하는 행위 (O)
② Exception을 잡아서(Catch) 오류의 원인을 처리한후 재작업을 하거나 오류를 기록하는 행위 (X)


#### [Exception 구문]


```sql
EXCEPTION
 
WHEN exception1 [OR exception 2 ....] THEN 
  statement1;
  statement2;
[ WHEN exception3 [OR exception 4.. ] THEN 
  statement1;
  statement2;
]
[ WHEN OTHERS THEN 
  statement1;
  statement2;
]
```
