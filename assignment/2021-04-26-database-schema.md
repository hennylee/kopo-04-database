## 오라클 스키마란?

- 스키마란 임의의 사용자가 생성한 모든 데이터베이스 객체들의 집합이다.

- 스키마는 데이터베이스 USER에 의해 소유되며 스키마 이름은 그 사용자의 이름과 같다.

- 스키마 객체는 USER에 의해 만들어지는 논리적 구조이다.

- 스키마 객체에는 테이블, 인덱스, 뷰, 클러스터 등이 있다.

- There is no relationship between a tablespace and a schema. Objects in the same schema can use storage in different tablespaces, and a tablespace can contain data from different schemas.

- 스키마 관련 기사  : [국민은행, 메인프레임 다운사이징 또 물건너가나](http://webcache.googleusercontent.com/search?q=cache:0Cwii2IPq4UJ:www.bikorea.net/news/articleView.html%3Fidxno%3D30246+&cd=1&hl=ko&ct=clnk&gl=kr)


## scott.emp

- scott 이라는 사용자가 다른 계정의 사용자에게 emp 테이블의 권한을 줬을 때, 권한을 받은 사용자가 scott계정의 emp테이블을 사용할 때 `scott.emp`라고 작성한다.

### system 계정에서의 emp 테이블

- 계정 확인 : `SELECT USER FROM DUAL;`

- 계정 소유 테이블 확인 : `SELECT * FROM TAB;` / `SELECT * FROM USER_TABLES;`

- 소유하지 않은 테이블 조회 : `SELECT * FROM EMP;`

![image](https://user-images.githubusercontent.com/77392444/116014245-51452a00-a66f-11eb-9778-5112dea81252.png)

- 다른 스키마의 테이블 조회 : `SELECT * FROM SCOTT.EMP;`

![image](https://user-images.githubusercontent.com/77392444/116014255-602bdc80-a66f-11eb-89f7-1e9593b32348.png)
