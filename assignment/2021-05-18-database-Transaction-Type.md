# Transaction Type

## Transaction 각 유형(OLTP / DSS(= Batch = OLAP) / DTP)의 정의, 특징, 사례를 찾으시오

- 은행의 업무 현황과 연관지어 자료를 정리하시오.


### OLTP

### DSS = Batch = OLAP

### DTP


### 정규화와 반정규화

- 정규화 : 온라인 거래 시스템 같은 OLTP(OnLine Transaction Processing) 데이터베이스는 CRUD(Create, Read, Update, Delete) 가 많이 일어나 정규화가 적절합니다.

- 반정규화 : 분석 리포트 같은 OLAP(OnLine Analytical Processing) 데이터베이스는 분석과 리포팅을 위해 사용되기 때문에 연산의 속도를 위해 반정규화를 사용하는 게 좋습니다.

  - 반정규화 : 정규화된 시스템을 성능 향상 및 개발과 운영의 단순화를 위해 역으로 정규화를 수행하는 것을 말합니다. 일반적으로 join을 많이 사용해야 할 경우, 대량의 범위를 자주 처리하는 경우 등 조회에 대한 처리가 중요하다고 판단될 때 부분적으로 반정규화를 합니다.

## Java : SQL Statement, Prepared Statement, Callable Statement

- Transaction Type과 연계해서 정의, 장단점, 개발 시 차이점, 코딩 실습
