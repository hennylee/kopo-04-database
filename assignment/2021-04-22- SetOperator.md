## 집합 연산자

- 수평적 결합을 수행하는 join과 달리, set은 수직적 결합을 수행한다. 

- 수직적 결합을 수행하기 때문에 데이터 타입과 컬럼의 수가 같아야 한다.


## UNION

- UNION : A + B - (A∩B)

- UNION은 SQL문장에서 먼저 조회되더라도 해당 컬럼을 정렬하여 출력한다.

- UNION의 경우 정렬해야 하기 때문에 속도가 느린 단점이 있다.

```SQL
SELECT SAL FROM EMP
UNION
SELECT COMM FROM EMP;
```

![image](https://user-images.githubusercontent.com/77392444/115799910-6e31f100-a414-11eb-8362-67589dcacf7c.png)


## UNION ALL

- UNION ALL : A + B

- UNION ALL은 정렬과 중복 데이터 제거를 하지 않는다. 

```SQL
SELECT SAL FROM EMP
UNION ALL
SELECT COMM FROM EMP;
```

![image](https://user-images.githubusercontent.com/77392444/115799939-7be77680-a414-11eb-8ead-20c694a32500.png)


## INTERSECT

- INTERSECT : (A∩B)

- 오라클은 정렬을 통해 교집합을 찾게되며 많은 데이터를 대상으로 할 경우 속도가 느려진다는 단점이 있다.

```SQL
SELECT DEPTNO FROM EMP
INTERSECT
SELECT DEPTNO FROM DEPT;
```

![image](https://user-images.githubusercontent.com/77392444/115800040-be10b800-a414-11eb-936f-43caea1d97f1.png)


## MINUS

- MINUS : A - (A∩B)

- 데이터량이 많은 경우 시간이 오래걸릴 수 있으며 두개의 컬럼의 갯수가 다르거나 데이터 형이 다르면 에러를 발생하므로 개수와 데이터형을 꼭 맞춰야한다.

```SQL
SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;
```


- 출처: https://message0412.tistory.com/entry/ORACLE-SQL-기법1 [캉군]
