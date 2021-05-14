

#  DEFAULT 에 TO_CHAR(SYSDATE,'YY/MM/DD')를 사용할수 있는지 확인 하는 SQL을 작성하십시오


## 1. DEFAULT로 TO_CHAR(SYSDATE,'YY/MM/DD')를 갖는 테이블 생성

```SQL
CREATE TABLE TST_DATE(
    NUM NUMBER(38),
    CHAR_DATE DATE DEFAULT TO_CHAR(SYSDATE, 'YY/MM/DD')
);

SELECT * FROM TST_DATE; -- 테이블 조회
```

![image](https://user-images.githubusercontent.com/77392444/118202512-175c8c00-b495-11eb-8a18-7eeb94c2e01b.png)


## 2. NUM이 1이고, CHAR_DATE에 DEFAULT가 들어가는 ROW 삽입

```SQL
INSERT INTO TST_DATE(NUM) VALUES(1);

SELECT * FROM TST_DATE; -- 테이블 조회
```

![image](https://user-images.githubusercontent.com/77392444/118202542-23e0e480-b495-11eb-9ba9-0cc9623220c9.png)


## 3. CHAR_DATE 열 DATE로 형변환

```SQL
SELECT NUM, CHAR_DATE, TO_DATE(CHAR_DATE, 'YY/MM/DD HH:MI:SS') FROM TST_DATE;
```

![image](https://user-images.githubusercontent.com/77392444/118202559-2e02e300-b495-11eb-9576-5b22e973d46d.png)



## 4. 실습 완료되었으면 테이블 삭제

```SQL
DROP TABLE TST_DATE;
```
