# MView


## MView 생성 권한 부여

```SQL
GRANT QUERY REWRITE TO SCOTT;
GRANT CREATE MATERIALIZED VIEW TO SCOTT;
```


- 권한 제거

```sql
REVOKE QUERY REWRITE FROM SCOTT;
REVOKE CREATE MATERIALIZED VIEW FROM SCOTT;
```



## 비효율적인 쿼리 실행해보기

- 각 부서별 급여 1위 구하기

```SQL
SELECT A.ENAME,
      A.SAL,
      A.DNAME
  FROM (SELECT A.ENAME,
              B.DNAME,
              A.SAL,
              RANK() OVER (PARTITION BY A.DEPTNO
                ORDER BY A.SAL DESC) AS RANKING
          FROM EMP A,
              DEPT B
        WHERE A.DEPTNO = B.DEPTNO ) A
 WHERE A.RANKING = 1;
```

- 결과 : `COST = 7`

![image](https://user-images.githubusercontent.com/77392444/119910452-27469680-bf92-11eb-9742-ff11db2e780b.png)



## MView 생성하기

```SQL
CREATE MATERIALIZED VIEW TST_MView
    BUILD IMMEDIATE
    REFRESH
        COMPLETE
        ON DEMAND
ENABLE QUERY REWRITE AS
    SELECT
        a.ename,
        a.sal,
        a.dname
    FROM
        (
            SELECT
                a.ename,
                b.dname,
                a.sal,
                RANK() OVER(PARTITION BY
                    a.deptno
                    ORDER BY
                        a.sal
                    DESC
                ) AS ranking
            FROM
                emp a,
                dept b
            WHERE
                a.deptno = b.deptno
        ) a
    WHERE
        a.ranking = 1;
```

- MView 삭제

```sql
DROP MATERIALIZED VIEW TST_MView;
```


- MView 관련 파라미터

![image](https://user-images.githubusercontent.com/77392444/119911887-4266d580-bf95-11eb-8e7d-50455811f0a8.png)



## MView 실행해보기

```SQL
SELECT ENAME,SAL,DNAME FROM TST_MView;
```

- 결과 : `COST = 3`

![image](https://user-images.githubusercontent.com/77392444/119910996-6a553980-bf93-11eb-9607-7fd5a5f80ea4.png)


## 관리자 계정에서 이전 쿼리 실행해보기

```SQL
SELECT A.ENAME,
      A.SAL,
      A.DNAME
  FROM (SELECT A.ENAME,
              B.DNAME,
              A.SAL,
              RANK() OVER (PARTITION BY A.DEPTNO
                ORDER BY A.SAL DESC) AS RANKING
          FROM SCOTT.EMP A,
              SCOTT.DEPT B
        WHERE A.DEPTNO = B.DEPTNO ) A
 WHERE A.RANKING = 1;
 ```
 
- 결과 : `COST = 3`

![image](https://user-images.githubusercontent.com/77392444/119911130-a9838a80-bf93-11eb-9424-b1773a26b590.png)
