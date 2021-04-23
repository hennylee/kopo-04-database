# Oracle 계정 비밀번호 변경하는 방법

## SQL Developer에서 변경하는 방법
- 권한 있는 계정으로 접속

- `ALTER USER scott IDENTIFIED BY tiger;`


## SQL PLUS에서 변경하는 방법

```sql
sqlplus /nolog
conn sys as sysdba
/* 패스워드 아무거나 */
ALTER USER scott IDENTIFIED BY tiger
```
