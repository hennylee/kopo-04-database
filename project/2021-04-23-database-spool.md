

# SPOOL로 SQL Script File 생성하기

## 1. SPOOL 이란?


- spool은 명령들을 일괄로 처리해 주는 명령어로써 spool 명령에 파일명을 파라미터로 지정하면 spool에서 실행된 모든 명령 들이 파일(txt, csv , etc) 로 저장된다. 


- SPOOL/SPOOL OFF : 출력의 파일 저장을 실행/중지하며 저장 실행시에 출력 파일명을 "SPOOL 파일명"의 형식으로 지정한다.

  - 파일로 저장 : `spool 파일경로\파일명`

  - SPOOL 종료  : `spool off`

 


## 2. SPOOL 파일 형식 지정

```SQL
SELECT /*csv*/ * FROM scott.emp;
SELECT /*xml*/ * FROM scott.emp;
SELECT /*html*/ * FROM scott.emp;
SELECT /*delimited*/ * FROM scott.emp;
SELECT /*insert*/ * FROM scott.emp;
SELECT /*loader*/ * FROM scott.emp;
SELECT /*fixed*/ * FROM scott.emp;
SELECT /*text*/ * FROM scott.emp;
```

## 3. SPOOl 명령어

SET HEADING (ON|OFF)      : 칼럼에 대한 HEADING를 표시함, 기본 값은 ON

SET FEEDBACK (ON|OFF)     : 선택된 행이 몇행인지를 표시함, 기본값은 6행 이상인 경우에 ON
 
SET LINESIZE (N )         : 한 라인당 표시되는 문자의 수, 기본값은 80 

set pagesize 0    :    기본값은 14이며 공백을 없애기 위해 0으로 세팅, pagesize가 0이어도 컬럼명이 출력되지 않는다. 50000 (max)
 
SET PAGES (N )            : 한 페이지당 표시되는 라인수, 기본값은 24 

SET TIMING (ON|OFF)       : 명령문을 실행하는데 소요된 시간

SET TIME (ON|OFF)         : 현재 시간 표시

SET PAUSE (ON|OFF)        : 한 페이지씩 보기

SET UNDERLINE "="         :  SELECT 문을 실행할때 헤더의  언더라인 모양을 지정

SET UNDERLINE (ON|OFF)    : 언더라인 표시 유무

SET ECHO (ON|OFF)   :  명령이 표시되지 않게 off한다.

REMARK : 보통 "REM 문자"의 형식으로 REM 다음에 나오는 문자는 주석으로 처리된다.

/* */ : REM과 같이 주석을 사용할 때 쓰이며 "/* 주석 */"의 형식을 갖는다.

- : SQL문 안에 주석을 지정할 때 사용한다.

SET HEADSEP : HEADSEP은 HEAD SEPARATOR의 약자로, "SET HEADSEP |"일 경우, |이 두 문자를 두 라인에 걸쳐 나누어 출력되도록 하는 명령어이다.

TTITLE : 각 리포트의 위첨자를 설정한다.

BTITLE : 각 리포트의 아래첨자를 설정한다.

COLUMN : 컬럼의 목록명과 포맷을 설정한다.

BREAK ON : 각 행의 섹션을 나누고, 합을 구할 컬럼 사이를 나누는 명령어이다.

COMPUTE SUM : BREAK 명령으로 나누어진 컬럼의 데이터 행의 부분 합을 계산하는 명령어이다.

SAVE : 실행한 SQL문을 파일로 저장한다.

HOST : 호스트 OS로 명령을 보내며, 호스트와 오라클 사이의 INTERFACE를 제공한다. HOST 명령어 대신 !를 이용할 수 있다.

START : 파일에 저장한 SQL문 또는 PL/SQL문을 실행한다. START 명령어 대신 @을 이용할 수 있다.

EDIT : SQL 명령 창을 잠시 나가 메모장이나 VI 에디터와 같은 설정된 에디터 창을 실행한다.

DEFINE_EDITOR : EDIT 명령어로 실행시킬 에디터를 설정한다.

SAVE 파일명    : SQL 버퍼에 있는 현재의 내용을 파일로 저장한다.

GET 파일명      : 현재 디렉토리에 저장된 파일의 내용을 버퍼로 불러낸다.

START 파일명     : 이전에 저장한 명령 파일을 실행한다.

@파일명          : 이전에 저장한 명령 파일을 실행한다.( START와 동일 )

EDIT                : 편집기를 실행시켜 버퍼내용을 AFIDET.BUF로 불리는 파일에 저장한다.

EDIT 파일명      : 저장된 파일의 내용을 편집하기 위해 편집기를 실행한다.

EXIT                : SQL*PLUS를 중단한다.

HOST               : UNIX 형태에서 작업할수 있고, EXIT 를 치면 다시 돌아온다.

SPOOL 파일명    : RETRIEVE DATA를 파일명.LST로 저장한다.

SPOOL OFF          : SPOOL 을 끝낸다.

SPOOL OUT         : RETRIEVE DATA를 SYSTEM PRINTER로 출력하라.


A(PPEND)    : TEXT LINE의 끝에 TEXT를 추가함 

C(HANGE)/OLD/NEW  : OLD를 NEW로 바꿈 

DEL N     : N LINE을 지움 

I(NPUT)    : TEXT 다음 LINE에 TEXT를 추가함 

L(IST)     : 전체 문장을 보여줌 

N TEXT     : N LINE전체를 TEXT로 바꿈 

R(UN)     : BUFFER에 있는 문장을 실행함(/ 와 같음) 

EDIT     : BUFFER에 있는 문장을 파일로 부름(AFIEDT.BUF) 

SAVE A    : BUFFER에 있는 내용을 A.SQL 파일로 저장 

GET A     : 파일 A에 있는 내용을 BUFFER로 부름 

START A  : 파일 A를 실행함 

!      : UNIX SHELL로 나들이 

!VI A.SQL    : 파일 A.SQL을 VI편집기로 부름 

- 출처 : https://rios.tistory.com/entry/Oracle-Sqlplus-spool-%EB%AA%85%EB%A0%B9%EC%96%B4-%EC%A0%95%EB%A6%AC


## 4. SPOOL 실습해보기 


```
<목표>
- SQL Script File 생성해서 부서별년봉리스트(부서번호,년봉,이름,직무,입사일) CSV File 생성하기

<조건>
- Spool 활용

- 컬럼Header 생성

- 엑셀파일에서생성한~.csv file 불러오기
```

- 4.1 SPOOL 스크립트 파일 작성하기
  - 스크립트 파일 작성하기

![image](https://user-images.githubusercontent.com/77392444/115860735-e62c0580-a46c-11eb-9d67-837d8d39b2a7.png)

  - `spool.sql` 파일로 저장하기

- 4.2 SPOOL 스크립트 파일 실행하기

![image](https://user-images.githubusercontent.com/77392444/115860880-170c3a80-a46d-11eb-8a69-a050702577e1.png)

