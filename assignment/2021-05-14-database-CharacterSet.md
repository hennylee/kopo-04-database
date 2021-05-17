# 테이블명과 컬럼명을 한글로 생성할수 있는가?


## 테이블명과 컬럼명을 한글로 생성해보기


### 테이블 생성 및 데이터 삽입

```sql
CREATE TABLE 테스트_한국어 (
    NUM NUMBER(38),
    한국어 VARCHAR2(10)
);

INSERT INTO 테스트_한국어 VALUES(1, '한글');
```

### 확인

```sql
DESC 테스트_한국어;
SELECT * FROM 테스트_한국어;
```

- 확인해보면 성공적으로 수행된 것을 알 수 가 있다. 





## 왜 한글로 설정이 가능할까?


### 현재 언어 설정 확인하기

```sql
select * from nls_database_parameters where parameter = 'NLS_CHARACTERSET'; -- AL32UTF8
select * from nls_database_parameters where parameter = 'NLS_NCHAR_CHARACTERSET'; -- AL16UTF16
```

### 언어 종류

- KO16KSC5601
  - 완성형 한글
  - 일반적으로 많이 사용되며 2350자의 한글, 4888자의 한자, 히라카나, 카타카나, 영문 및 각종 기호를 포함하고 있음.  (한글바이트: 2byte)

- KO16MSWIN949
  - 조합형 한글
  - 완성형을 포함하여 11172자의 한글을 표현함 (한글바이트: 2byte)

- AL32UTF8 
  - Unicode의 CES 중 하나
  - 11172자의 한글을 지원 (한글바이트: 3byte)


