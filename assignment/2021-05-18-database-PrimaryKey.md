# 컬럼 조합으로 구성되는 PK를 가지는 테이블을 설계한 후 SQL Script를 작성 하십시오



## 테이블 설계

학생 정보를 등록하는 테이블을 설계한다.
- 입학년도, 전공, 반, 반 내 번호, 이름이 등록되어 있다. 

- [ 입학년도, 전공, 반, 반 내 번호 ] 의 조합으로 학번이 만들어지기 때문에 PK로 설정해야 한다. 

- 여러 개의 컬럼 조합으로 이루어지기 때문에 TABLE LEVEL CONSTRAINT 이다.

- 이름은 중복 가능하다.

- 입학년도, 전공, 반, 반 내 번호, 이름은 NULL이 허용되지 않는다.



## SQL Script 작성

#### 테이블 생성 및 복합컬럼 제약조건 설정

```SQL
DROP TABLE TST_PK;

CREATE TABLE TST_PK(
    GRADE NUMBER(9) NOT NULL CHECK (GRADE > 1998), -- 입학년도(학년)
    MAJOR VARCHAR2(3) NOT NULL CHECK (MAJOR IN ('001', '002', '003', '004')), -- 전공
    CLASS  VARCHAR2(3) NOT NULL, -- 반
    NUM VARCHAR2(3) NOT NULL, -- 반 내 번호    
    NAME VARCHAR2(20) NOT NULL ,
    CONSTRAINT TST_PK_PK PRIMARY KEY (GRADE, MAJOR, CLASS, NUM) -- TABLE LEVEL CONSTRAINT
);
```

#### 데이터 삽입

```SQL
INSERT INTO TST_PK VALUES(1997,'001','01','01', '이해니'); -- 오류
INSERT INTO TST_PK VALUES(2021,'001','01','01', '이해니');
SELECT * FROM TST_PK;
INSERT INTO TST_PK VALUES(2021,'001','001','001', '이해니');
INSERT INTO TST_PK VALUES(2021,'001','0001','0001', '이해니');
INSERT INTO TST_PK VALUES(2021,'001','0000001','0000001', '이해니'); -- 오류 발생
```

#### 테이블 및 학번 조회

```SQL
SELECT GRADE, MAJOR, CLASS, NUM,  GRADE||MAJOR||CLASS||NUM AS "학번" FROM TST_PK;
```

#### 데이터 딕셔너리로 인덱스 확인하기

```SQL
SELECT * FROM USER_INDEXES WHERE TABLE_NAME = 'TST_PK';
SELECT * FROM USER_IND_COLUMNS WHERE TABLE_NAME = 'TST_PK';
```

- 사용자의 인덱스 확인하는 데이터 딕셔너리 : USER_INDEXES , USER_IND_COLUMNS

- 복합컬럼으로 PK, UK를 정의하면, 인덱스 POSITION은 컬럼 정의 순서대로 만들어진다. 

![image](https://user-images.githubusercontent.com/77392444/118573459-93b8dd00-b7bd-11eb-8ee0-07051c6f5502.png)
![image](https://user-images.githubusercontent.com/77392444/118573477-9ddadb80-b7bd-11eb-8253-0e9cdf0566ef.png)

