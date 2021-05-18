# 컬럼 조합으로 구성되는 PK를 가지는 테이블을 설계(자신만의)한후 SQL Script를 작성 하십시오



## 테이블 설계

- 학생 정보를 등록하는 테이블
    - 입학년도, 전공, 반, 반 내 번호, 이름이 등록되어 있다. 
    - (입학년도, 전공, 반, 반 내 번호) 의 조합으로 학번이 만들어지기 때문에 PK로 설정해야 한다. 
    - 이름은 중복 가능하다.
    - 입학년도, 전공, 반, 반 내 번호, 이름은 NULL이 허용되지 않는다.



## SQL Script 작성


```SQL
CREATE TABLE TST_PK(
    GRADE NUMBER(9) NOT NULL , -- 입학년도(학년)
    MAJOR NUMBER(9) NOT NULL , -- 전공
    CLASS NUMBER(9) NOT NULL , -- 반
    NUM NUMBER(38) NOT NULL , -- 반 내 번호    
    NAME VARCHAR2(20) NOT NULL ,
    CONSTRAINT TST_PK_PK PRIMARY KEY (GRADE, MAJOR, CLASS, NUM)
);

DROP TABLE TST_PK;
```

```SQL
INSERT INTO TST_PK VALUES(2021,01,01,01, '이해니');
INSERT INTO TST_PK VALUES(2021,01,01,01, '이해니'); -- 오류
INSERT INTO TST_PK VALUES(2021,01,01,02, '이해니');
```

```SQL
SELECT GRADE, MAJOR, CLASS, NUM,  GRADE||MAJOR||CLASS||NUM AS "학번" FROM TST_PK;
```
