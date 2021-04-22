
# SQL Syntax Diagram

## 읽는 방향
- 왼쪽에서부터 오른쪽으로 화살표를 따라 읽는다. 

## 모양 의미
- 명령어, 키워드 : 직사각형 내에 대문자로 쓴다.

- Parameters(Variable) : 타원형 안에 소문자로 쓴다.

- Punctuation, operators, delimiters, and terminators : 원 안에 쓴다.

## 필수 키워드와 Parameter

- 단일 필수 키워드와 인자는 main path에 나타낸다.

- 수평적 직선이 main path이다. 

- 만약 다수의 키워드가 main path를 교차하며 수직적 리스트로 나타낼 때는 그 중에 하나가 필수적으로 필요하다는 뜻이다. 

![image](https://user-images.githubusercontent.com/77392444/115207069-3554fc00-a136-11eb-8d5f-67c1e44baedc.png)


## 선택 키워드와 Parameter

- 만약 main path 위에 구부러진 화살표로 연결된 리스트가 나타난다면 그 요소는 필수적인 것이 아닌 옵션이라는 뜻이다. 

![image](https://user-images.githubusercontent.com/77392444/115207208-56b5e800-a136-11eb-8d2a-36982c9daf01.png)

```SQL
DEALLOCATE UNUSED;
DEALLOCATE UNUSED KEEP 1000;
DEALLOCATE UNUSED KEEP 10G;
DEALLOCATE UNUSED 8T; 
```

## Loop

- Loop는 사용자가 원하는 만큼 반복해서 사용할 수 있다는 것을 의미한다. 

![image](https://user-images.githubusercontent.com/77392444/115207489-9d0b4700-a136-11eb-895c-8683bfbfdfab.png)


## Multipart Diagrams

- 여러개의 다이어그램을 Join할 때는 끝과 끝을 화살표로 연결한다. 


## 문제1

![image](https://user-images.githubusercontent.com/77392444/115209971-17d56180-a139-11eb-8c2c-beebb2ad7edf.png)


```sql
SELECT ~ ;
SELECT FOR UPDATE ~ ;
```

- subquery : The substitution value must be a SELECT statement that will be used in another SQL statement.

- FOR UPDATE 문
  - 9i부터 사용 가능

  - SELECT 문으로 사용자가 임의로 lock를 걸 수 있는 명령어이다.


## 문제2

![image](https://user-images.githubusercontent.com/77392444/115210019-215ec980-a139-11eb-96f7-c7fb21efc7af.png)

- query_block, subquery, (subquery) 셋 중 하나를 필수적으로 사용하고 뒤에 order by 절을 옵션적으로 붙일 수 있다. 

- subquery는 뒤에는 [UNION(합집합), INTERSECT(교집합), MINUS(차집합) 중 하나를 쓰고 subquery]를 뒤에 또 원하는 만큼 붙일 수 있다. 

- UNION(합집합) 뒤에는 ALL을 선택적으로 붙일 수 있다. 


## 문제 3

![image](https://user-images.githubusercontent.com/77392444/115210505-a0ec9880-a139-11eb-9011-a46f7e08190d.png)


## 문제 4

![image](https://user-images.githubusercontent.com/77392444/115214509-8c120400-a13d-11eb-9092-826cd42492ae.png)

- WITH 뒤에 반복적으로 문장이 ,로 연결되어서 나올 수 있다. 

## 참고

- https://docs.oracle.com/database/121/SQLRF/ap_syntx001.htm
- https://docs.oracle.com/cd/B19188_01/doc/B15917/sqsyntax.htm

