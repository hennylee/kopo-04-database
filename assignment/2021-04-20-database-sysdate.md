
## SYSDATE 공식문서

- SYSDATE는 DB가 있는 시스템의 현재 날짜와 시간을 반환한다.

- 반환되는 데이터의 데이터형은 DATE이고, 그 format은 `NLS_DATE_FORMAT` initialization parameter의 값에 따라 달라진다. 

- `NLS_DATE_FORMAT`이 뭘까? 세션의 인자들을 정의한 `nls_session_parameters`테이블을 조회해보면 다음과 같다.

![image](https://user-images.githubusercontent.com/77392444/115357801-f8e9d480-a1f7-11eb-803d-95bf4b0e1927.png)

- 즉, `NLS_DATE_FORMAT`은 `RR/MM/DD`로 정의되어 있기 때문에 최초에 SYSDATE값을 조회하면 date에 대한 정보만 나오는 것이다. 

- SYSDATE는 arguments가 필요하지 않다. 

- SYSDATE는 로컬 DB 운영 시스템의 시간을 반환한다.

- CHECK 제한 조건에서는 사용할 수 없다.

- 출처 : https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions172.htm


## SYSDATE를 조회하면 왜 날짜 정보만 나올까?

- 공식 문서에 따르면 반환되는 데이터의 데이터형은 DATE이고, 그 format은 `NLS_DATE_FORMAT` initialization parameter의 값에 따라 달라진다. 

- 그렇다면 `NLS_DATE_FORMAT`이 뭘까? 세션의 인자들을 정의한 `nls_session_parameters`테이블을 조회해보면 다음과 같다.

![image](https://user-images.githubusercontent.com/77392444/115357801-f8e9d480-a1f7-11eb-803d-95bf4b0e1927.png)

- `NLS_DATE_FORMAT`은 `RR/MM/DD`로 정의되어 있기 때문에 최초에 SYSDATE값을 조회하면 date에 대한 정보만 나오는 것이다. 

- 즉, `NLS_DATE_FORMAT`은 현재 시스템의 기본 날짜 입력 형태를 지정하는 파라미터라고 볼 수 있다. 

- 그렇다면 DATE의 시간 정보까지 출력하려면 어떻게 할까?

```sql
-- 시간 정보까지 출력하는 방법
SELECT TO_CHAR(SYSDATE, 'MM-DD-YYYY HH24:MI:SS') "NOW" FROM DUAL;
```

- 위와 같이 TO_CHAR로 format 형식을 변환해주면 된다. 


## 초 이하 단위까지 출력하려면?

- 오라클에서 DATE형은 초 이하 단위까지 처리할 수 없다. 

- 만약 초 이하 단위(fractional seconds)까지 처리하고 싶다면 TIMESTAMP형을 사용해야 한다. 

- 시스템의 DATE를 조회하려면 `SYSDATE`를 사용하는 것과 같이, 시스템의 TIMESTAMP를 조회하려면 `SYSTIMESTAMP`를 사용하면 된다. 

- 또 `SYSTIMESTAMP`의 format을 변환하려면 TO_CHAR 함수를 활용하면 된다. 

- 초 이하 단위는 `FF`이며, FF뒤에 숫자를 붙여 소수점 자리수를 제한할 수 있다. 

```SQL
-- 오라클에서 초단위 이하의 밀리세컨드 처리를 위해선 TIMESTAMP형을 사용해야 한다.
-- 9i에서 추가된것 같다.
SELECT TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.FF') "NOW" FROM DUAL;
```


## 현재 시간, 분, 초, 1/100초 까지 표현하는 SQL 작성하기

```SQL
-- 초단위를 formating하려면 FF 뒤에 소수점 자리를 표현하면 된다. 
SELECT TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.FF2') "NOW" FROM DUAL;
```



## 현재 시간, 분, 초, 1/1000초 까지 표현하는 SQL 작성하기

```SQL
-- 초단위를 formating하려면 FF 뒤에 소수점 자리를 표현하면 된다. 
SELECT TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.FF3') "NOW" FROM DUAL;
```
