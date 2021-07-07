

## 1. Dynamic SQL과 Static SQL

|버전   |개발시점|실행시점|
|-------|-------|-------|
|정적 SQL|SQL작성|SQL실행|
|동적 SQL|       |SQL작성 → SQL실행|


동적 SQL
- 실행 시점에 완성되는 것이 Dynamic SQL
- 오류 및 성능 예측이 어려움

정적 SQL
- 프로그램밍 컴파일 시 완성되는 것이 static SQL
- 성능 예측이 가능함
- 보안 측면에서 안정적임 (SQL Injection이 어려움)



로그인 예시 : 

```sql
-- 1. 정적 SQL
SELECT * FROM 회원 WHERE ID = 'XMAN' AND PWD='YMAN'

-- 2. 동적 SQL
SELECT * FROM 회원 WHERE ID = :V_ID AND PWD=:V_PWD
```

- `:V_ID` : 글로벌 변수 = 바인드 변수'

ORACLE 8i 부터 PL/SQL에서 EXECUTE IMMEDIATE 를 지원하면서 부터 동적 SQL을 쉽고 효율적으로 사용할수 있게 되었다.


