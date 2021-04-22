# Oracle TAB 의 용도

- `SELECT * FROM TAB;` 은 DB 내의 계정이 사용할 수 있는 테이블 목록을 조회할 때 사용한다.

- `TAB`에 현재 계정에서 사용할 수 있는 TABLE에 대한 정보가 저장되어 있다.

- `devDinkDBMS`에서의 결과

![image](https://user-images.githubusercontent.com/77392444/115204301-4bad8880-a133-11eb-860c-2a4aba46bfbf.png)



- `mgrDinkDBMS`에서의 결과

![image](https://user-images.githubusercontent.com/77392444/115204374-5ff18580-a133-11eb-91b9-90b04128aabc.png)


- 관리자인지 아닌지에 따라 조회할 수 있는 테이블이 다르기 때문에 아래와 같이 다르게 조회해야 한다.

```sql
-- (관리자일 경우)
SELECT * FROM ALL_TABLES; 

-- (관리자 아닐 경우)
SELECT * FROM USER_TABLES; 
SELECT * FROM TAB; 
```

- 출처: https://javaoop.tistory.com/65 [개쿠]
