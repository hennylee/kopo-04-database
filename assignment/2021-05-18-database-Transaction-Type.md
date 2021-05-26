# Transaction Type

## Transaction 각 유형(OLTP / DSS(= Batch = OLAP) / DTP)의 정의, 특징, 사례를 찾으시오

- 은행의 업무 현황과 연관지어 자료를 정리하시오.

```
OLTP : 현재 업무의 효율적인 처리에만 관심이 있음
OLAP : 의사결정에 도움이 되는 데이터 분석에만 관심이 있음.
```

### OLTP

#### 정의

```
OLTP란 주 컴퓨터와 통신 회선으로 접속되어 있는 복수의 사용자 단말에서 발생한 트랜잭션을 주 컴퓨터에서 처리하여 그 결과를 즉석에서 사용자 단말 측으로 되돌려 보내 주는 처리 형태를 말한다.
```

- OLTP 란 Oline Transaction Process(온라인 트랜잭션 처리)의 약자이다.

- OLTP란 여러과정(또는 연산)이 하나의 단위 프로세스로 실행되도록 하는 프로세스라고 할 수 있다.

- 즉, OLTP란 네트워크 상의 온라인 사용자들의 Database 에 대한 일괄 트랜잭션 처리를 의미한다. 

- 그래서 흔히 '트랜잭션(Transaction) 처리' 를 OLTP로 통용하기도 한다. 트랜잭션이라 부르는 용어의 의미 자체가 OLTP 의 의미를 포함하고 있다고 볼 수도 있다. 

- 출처: https://jins-dev.tistory.com/entry/간략하게-정리해보는-OLTP-OLAP-의-개념 [Jins' Dev Inside]

- 출처: https://splee75.tistory.com/75 [Study Log]

#### 특징

https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fuof8R%2FbtqF64ICf4J%2Ff9ofsbFZlITAhB2SZeYRM1%2Fimg.png

- 트랜잭션의 주 특징이 그루핑된 연산의 실패시 Rollback 이 지원된다는 점인 것처럼, OLTP도 트랜잭션과 동일한 ACID 특징을 가진다.

- OLTP는 정보를 트랜잭션 단위로 수집하고, 분류 / 저장 / 유지보수 / 갱신 / 검색하는 기능을 수행한다.

- 기업에서 모든 트랜잭션 및 레코드를 저장하는 데 사용하는 데이터베이스를 OLTP(온라인 트랜잭션 처리) 데이터베이스라고 한다. 

- 일반적으로 이러한 데이터베이스의 레코드는 한 번에 하나씩 입력되고, 종종 이러한 데이터베이스는 조직에 귀중한 정보를 풍부하게 포함한다.

- 주로 OLTP(온라인 트랜잭션 처리) 데이터베이스를 DW(Data Warehouse)라 한다.

	- DW란? OLTP 시스템으로부터 필요한 데이터를 추출, 수정, 요약해서 의사결정을 지원할 수 있는 데이터베이스를 만든 것이다.

	- DW에 접근해 데이터를 분석하고 의사결정에 활용하는 방법이 OLAP라고 볼 수 있다.

- OLTP에 사용되는 데이터베이스는 분석용으로 적합하지 않다. OLTP 데이터베이스에서 답변을 검색할 때는 시간과 노력이 많이 든다. 
	- 테이블 및 열 이름을 포함하는 데이터베이스의 디자인을 사용자가 이해하기 어려울 수 있기 때문이다.
    - 사용자는 쿼리할 테이블, 해당 테이블이 조인되는 방법, 올바른 결과를 얻기 위해 적용해야 하는 기타 비즈니스 논리를 알고 있어야 한다. 
    - 또한 시작하기 위해 SQL과 같은 쿼리 언어를 알고 있어야 한다.
    
#### 사례

https://t1.daumcdn.net/cfile/tistory/165489334E2049652F

- OLTP 방식은 주로 하루에도 대량으로 처리되는 업무상의 트랜잭션을 처리하고 저장할 필요가 있는 경우에 사용한다. 

- OLTP는 흔히 '기간계'라고 부르며, 일반적으로 회사에서 기본적으로 사용하고 있는 ERP와 같은 시스템의 처리 방식이 OLTP이다.

	- 기간계 시스템이란? 은행의 계정계, 관공서의 주민등록원장과 같이 전체 시스템의 메인 데이터가 있는 시스템을 의미한다. 

- 항공사의 예약시스템, 은행의 창구업무시스템 등이 대표적인 OLTP 사례에 해당된다.

출처: https://itpassion.tistory.com/entry/현재-OLTPOnLine-Transaction-Processing란 [세상을 바꾸는 IT]

출처: https://jins-dev.tistory.com/entry/간략하게-정리해보는-OLTP-OLAP-의-개념 [Jins' Dev Inside]

#### 은행 사례

**운영계** 
- OLTP를 수행하는 시스템 및 부서를 운영계라고 한다. 

- 운영계는 주로 실시간 & 즉시처리하는 시스템이며, 안정성과 정확성을 위주로 개발한다.

- 운영을 담당하는 금융권 영업점에서 실시간으로 고객의 거래를 처리하기 위해 트랜잭션 단위로 발생하는 업무가 바로 OLTP 예시이다.

**계정계**

- 계정계란 고객의 거래를 처리하는 시스템이다.

- 은행의 전통적인 핵심 업무는 통장이 중심이 된다. 이 통장을 계좌, 계정이라고 한다. 그래서 계정을 관리하는 시스템이 모여있는 것을 계정계라고 부르며, 은행의 DW역할을 담당한다.

- 이 계정계 Dw의 정보를 트랜잭션 단위로 수집하고, 분류 / 저장 / 유지보수 / 갱신 / 검색하는 기능을 수행하는 것이 OLTP이다.

- 주로 고객의 통장 정보(계좌번호, 입출금, 이체, 펀드, 주식 등)와 관련된 업무가 계정계 OLTP의 사례이다. 

- 구체적으로 은행의 'ATM 현금 인출' 처리 과정을 OLTP의 사례로 들 수 있다.

```
<현금인출 OLTP>
과정 1 : 철수가 은행 ATM에서 계좌번호와 비밀번호를 입력 후, 현금 인출을 선택한다.
과정 2 : 철수의 계좌에서 50,000원을 감소시킨다. (계정계)
과정 3 : 현금을 인출해 준다.
과정 4 : 명세표를 출력해준다.
```

출처: https://propie.tistory.com/entry/기간계-정보계-운영계 [보안블로그]




### DSS = OLAP

#### 정의

https://docs.microsoft.com/ko-kr/azure/architecture/data-guide/images/olap-data-pipeline.png

- OLAP(온라인 분석 처리)는 대규모 비즈니스 데이터베이스를 구성하고 복잡한 분석을 지원하는 기술이다. 

- OLAP는 트랜잭션 시스템에 부정적인 영향을 주지 않고 복잡한 분석 쿼리를 수행하는 데 사용할 수 있다.

- DSS (Decision Support System)는 의사결정 지원 시스템이다.

- DSS란 단순히 정보를 수집, 저장, 분배하기 위한 시스템을 넘어서 사용자들이 기업의 의사결정을 쉽게 내릴 수 있도록 사업 자료를 분석해주는 역할을 하는 컴퓨터 응용 프로그램이다.

#### 특징
- OLAP은 방대한 양의 데이터에 대해 집계 계산을 적용하는 데 특히 유용합니다. 

- OLAP 시스템은 분석 및 비즈니스 인텔리전스 등, 과도한 읽기 시나리오에 대해 최적화되어 있습니다. 

- OLAP는 다차원 데이터를 2차원으로 볼 수 있는 조각(예: 피벗 테이블)으로 분할하거나 데이터를 특정 값을 기준으로 필터링할 수 있도록 합니다. 

- OLAP 시스템은 고효율적 방식으로 데이터에서 이러한 비즈니스 인텔리전스 정보를 추출하는 데 도움이 되도록 디자인되었습니다. OLAP 데이터베이스가 과도한 읽기, 낮은 쓰기 워크로드에 최적화되어 있기 때문입니다.

#### 사례
- 조직의 데이터가 대형 데이터베이스에 저장되어 있습니다. 비즈니스 사용자 및 고객이 자체 보고서를 만들고 분석을 수행하는 데 이 데이터를 사용할 수 있게 하려고 합니다. 

- BI 프로그램들 (Azure 머신러닝, Power BI 등)

#### 은행 사례

정보계
1. OLAP : Online Analysis Processing
2. 분석을 위한 목적. 경영자가 의사결정을 할 수 있게 도와주는 시스템. 
3. DM(Data Mart)나 DW(Data warehouse)등의 도구를 통해 사용된다

출처: https://propie.tistory.com/entry/기간계-정보계-운영계 [보안블로그]



### Batch

#### 정의

Batch는 작업을 몰아두었다가 한번에 처리하는 시스템이다.

#### 특징


#### 사례

쇼핑몰로 예를 들면 하루가 지난 뒤에 전체 매장의 재고를 체크하고 현재의 상품에 대해 가격과 재고 등을 맞추는 작업을주기적으로 수행하는 작업을 말한다! 간단히 말해 데이터를 실시간이 아닌 전체적으로 맞추는 작업을 하거나 주기적으로 발생하는 것들에 대한 처리를 하는 것!

#### 은행 사례

은행을 예로 들면, 매일 있는 은행 점검 시간에 하루가 지난 뒤에 전체 지점 및 온라인 뱅킹의 거래액을 체크하고 현재의 계정계와 비교하여 시재를 맞추는 작업을 주기적으로 수행하는 것을 말한다.

출처: https://acet.pe.kr/623 [Story Of ace-T]


### DTP

#### 정의
- 분산 트랜잭션(Distributed Transaction)

- 하나의 데이터베이스 인스턴스 내에서 한 트랜잭션으로 묶인 SQL 문장이 모두 커밋되거나 롤백되듯이 네트워크로 연결된 여러 개의 데이터베이스 인스턴스가 참여하는 트랜잭션에서도 각각 다른 데이터베이스 인스턴스에서 수행한 SQL 문장이 모두 동시에 커밋되거나 롤백될 수 있는 방법이 필요하다.

- 이렇게 여러 개의 노드 또는 다른 종류의 데이터베이스가 참여하는 하나의 트랜잭션을 분산 트랜잭션이라고 한다. Tibero에서는 분산 트랜잭션을 처리하기 위해 XA와 데이터베이스 링크(DBLink)를 통해 지원한다.



https://technet.tmaxsoft.com/upload/download/online/tibero/pver-20131217-000019/tibero_admin/ch_07.html

#### 특징

#### 사례

#### 은행 사례

### 정규화와 반정규화

- 정규화 : 온라인 거래 시스템 같은 OLTP(OnLine Transaction Processing) 데이터베이스는 CRUD(Create, Read, Update, Delete) 가 많이 일어나 정규화가 적절합니다.

- 반정규화 : 분석 리포트 같은 OLAP(OnLine Analytical Processing) 데이터베이스는 분석과 리포팅을 위해 사용되기 때문에 연산의 속도를 위해 반정규화를 사용하는 게 좋습니다.

  - 반정규화 : 정규화된 시스템을 성능 향상 및 개발과 운영의 단순화를 위해 역으로 정규화를 수행하는 것을 말합니다. 일반적으로 join을 많이 사용해야 할 경우, 대량의 범위를 자주 처리하는 경우 등 조회에 대한 처리가 중요하다고 판단될 때 부분적으로 반정규화를 합니다.

## Java : SQL Statement, Prepared Statement, Callable Statement

```
Transaction Type과 연계해서 정의, 장단점, 개발 시 차이점, 코딩 실습
```

- statement : 일반적인 sql쿼리를 실행

- preparedStatement : 동적 또는 매개변수가 필요한 sql쿼리를 실행
	- OLAP

- callableStatement : 저장된 프로시져를 실행
	- OLTP, Batch
    
https://daesuni.github.io/Java-statement-vs-preparedStatement-vs-callableStatement/