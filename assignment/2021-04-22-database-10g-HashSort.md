#  Oracle 9i와 Oracle 10g에서 distinct와 Group by 결과가 차이나는 이유는?

## Distinct

- Distinct : 중복된 데이터를 걸러내고 보여준다.

- 어떻게 중복된 데이터를 걸러줄까?
  - 9i : Sort(unique) 알고리즘 방식
  - 10g : Hash(unique) 알고리즘 방식, 단 Order by 절을 시행할 경우 Sort(unique)


## Group by

- Group by : 컬럼 값을 그룹짓고(중복을 제거하고) 이에 대해 건수나 값의 합을 계산할 때 사용한다.

- 어떻게 그룹을 지을까(중복을 제거하고)?
  - 9i : Sort group by
  - 10g : Hash group by, 정렬 유무에 따라 Hash group by 사용


## Sort 방식

- 이진검색 오름차순으로 정렬된 리스트에서 특정한값으니 위치를 찾는 알고리즘

- 데이터를 쭉 정렬하면서 읽어들이면서 중복 데이터를 찾아낸다. 

## Hash 정렬이란

- Hash 알고리즘이란?
  - 임의로 만든 HASH함수를 통해서 KEY들이 일정 규칙을 가진 hashes로 변형된다.

- Hash의 용도란?
  - 무결성
  - Direct Access Method : 데이터에 접근하는 가장 빠른 방법은 hash이고, 그 다음 빠른 방법은 rowid이다.
  - 암호화 : 해시함수로 변환되기 때문에 입력값을 알아내기 힘들어 보안에 용이하다.


- Hash의 특징은?
  - 고정길이 : hash 함수의 Input(Key)은 가변길이, Output(Value)은 고정길이를 갖는다. 
  - 충돌회피 : Chaining
  - 단방향


– 충분한 Memory일 경우 (즉 In-Memory Sort)일 경우 효과적
– Sort operation이 기존 방식에 비해 최대 5~10%까지 빠를 수 있다.

– 반면 높은 cardinality (Row들의 Distinct가 많은 경우)일 경우 HASH방식이 효과적이다.
– Faster CPU일 경우 더욱 효과적
– 적은 Column을 Select 했을 경우 Sort operation이 효과적이다. (Hash는 Memory부족에 의해 Disk로 내려가면 꽝)

- “GROUP BY”를 사용한 App가 “ORDER BY”를 기술하지 않더라도 Ordering된 결과를 Display하던
App들이 10g R2로 오면서 이 기능이 깨지게 되었음.
즉 반드시 Ordering이 필요하면 “GROUP BY”와 함께 “ORDER BY”를 기술해야 함.
(참고. 이는 Oracle의 Bug은 아니며 App의 잘못임)


## Oracle 10g에서 hash 정렬이 필요해진 이유는?

- 데이터량이 적으면 memory에서 sort를 할 수 있지만, 데이터 양이 늘어나면? disk 공간을 빌려 저장하게 된다.

- 하지만 disk는 컴퓨터 메모리중에 가장 느린 장치이다.

- 그래서 효율적인 서버 프로그램들은 disk I/O가 느리기 때문에 자주 사용하지 않거나 한번에 I/O를 처리하려고 한다. 

- Oracle 10g의 업그레이드 목적
  - 그리드 컴퓨팅
  - 병렬 처리
  - 대용량 데이터 처리


https://m.blog.naver.com/PostView.nhn?blogId=thurunet5&logNo=220155900914&proxyReferer=https:%2F%2Fwww.google.com%2F
