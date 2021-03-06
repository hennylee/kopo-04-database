
## SYSDATE 공식문서

- SYSDATE는 DB가 있는 시스템의 현재 날짜와 시간을 반환한다.

- 반환되는 데이터의 데이터형은 DATE이고, 그 format은 `NLS_DATE_FORMAT` initialization parameter의 값에 따라 달라진다. 

- SYSDATE는 arguments가 필요하지 않다. 

- SYSDATE는 로컬 DB 운영 시스템의 시간을 반환한다.

- CHECK 제한 조건에서는 사용할 수 없다.

- 출처 : https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions172.htm


## SYSDATE를 조회하면 왜 날짜 정보만 나올까?

- 공식 문서에 따르면 반환되는 데이터의 데이터형은 DATE이고, DATE의 format은 `NLS_DATE_FORMAT` initialization parameter의 값에 따라 달라진다는 것을 알 수 있다.

- 그렇다면 `NLS_DATE_FORMAT`이 뭘까? NLS란 National Language Support이다.

- 또 세션의 인자들을 정의한 `nls_session_parameters`테이블을 조회해보면 `NLS_DATE_FORMAT`은 다음과 같이 저장되어 있다.

![image](https://user-images.githubusercontent.com/77392444/115357801-f8e9d480-a1f7-11eb-803d-95bf4b0e1927.png)

- 즉, `NLS_DATE_FORMAT`은 현재 시스템의 기본 날짜 입력 형태를 지정하는 파라미터라고 볼 수 있다. 

- 따라서 DATE의 기본 포맷인 `NLS_DATE_FORMAT`은 기본 디폴트값이 `RR/MM/DD`로 정의되어 있기 때문에 최초에 SYSDATE값을 조회하면 시간에 대한 정보 없이 날짜에 대한 정보만 나오는 것이다. 

- 그렇다면 DATE의 시간 정보까지 출력하려면 어떻게 할까?

```sql
-- 1. 출력 포맷을 바꾸는 방법
SELECT TO_CHAR(SYSDATE, 'MM-DD-YYYY HH24:MI:SS') "NOW" FROM DUAL;


-- 2. 세션에 저장된 기본 포맷을 바꾸는 방법
ALTER SESSION SET nls_date_format = 'YYYY-MM-DD HH24:MI:SS';
```

- 위와 같이 TO_CHAR로 format 형식을 변환해주거나, 세션의 기본 포맷값을 된다. 


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

## SYSDATE, DATE, SYSTIMESTAMP, TIMSTAMP

- DATE : 년, 월, 일, 시, 분, 초까지의 정보만 가지고 있다. 

- DATETIME : 

- TIMESTAMP : 

- SYSDATE : 

- SYSTIMESTAMP : 


## YY/RR 차이는?

- Y2k compatibility의 차이이다.

- YY : 입력년도를 오라클 서버의 현재 날짜와 동시간대로 계산한다. 21을 쓰면 2021년으로, 55를 쓰면 2055년으로 인식한다.

- RR : 입력년도가 50 ~ 99 일 경우 전 세기로 계산한다. 21을 쓰면 20201년으로, 55를 쓰면 1955년으로 인식한다.



## 아래 YY 조회 결과가 출력되지 않는 이유는?

```sql
SELECT ENAME,HIREDATE,SAL FROM EMP
WHERE HIREDATE between to_date('81/02/20','yy/mm/dd') and to_date('82/12/09','yy/mm/dd');
```

![image](https://user-images.githubusercontent.com/77392444/116014385-f19b4e80-a66f-11eb-83ce-7a9d95efe73c.png)

-  HIREDATE의 입력년도를 확인해보면, 1900년대임을 알 수 있다.

```sql
-- 년도 확인하는 방법들
SELECT ENAME,HIREDATE,to_CHAR(HIREDATE,'YYYY'),SAL FROM EMP;
SELECT ENAME,HIREDATE,to_CHAR(HIREDATE,'YEAR'),SAL FROM EMP;
SELECT ENAME,HIREDATE,to_CHAR(HIREDATE,'YYYY-MM-DD'),SAL FROM EMP;
SELECT ENAME,HIREDATE,to_CHAR(HIREDATE,'RRRR-MM-DD'),SAL FROM EMP;
```

![image](https://user-images.githubusercontent.com/77392444/116015044-e8f84780-a672-11eb-8279-bd6d996cbb78.png)


- 이때, YY로 형변환을 하게 되면 현재 년도의 세기와 같은 2081년과 2082년으로 변환된다.

```sql
SELECT ENAME,HIREDATE,SAL FROM EMP
WHERE HIREDATE between to_date('81/02/20','yy/mm/dd') and to_date('82/12/09','yy/mm/dd');
```

- 반면, RR로 형변환을 하게 되면 이전 세기의 년도인 1981년과 1982년으로 변환된다. 

```sql
SELECT ENAME,HIREDATE,SAL FROM EMP
WHERE HIREDATE between to_date('81/02/20','rr/mm/dd') and to_date('82/12/09','rr/mm/dd');
```

- 그래서 RR로 형변환했을 때에만 WHERE 조건이 참이되는 ROW가 존재하게 되는 것이다.
