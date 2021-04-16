## 실습 환경 개요

![image](https://user-images.githubusercontent.com/77392444/114974736-eac94a80-9ebd-11eb-94d2-178fee815f3e.png)

1. Vmware : H/W의 역할 

2. Centos : O/S의 역할
2-1. Putty : O/S에 접근

3. Oracle : Applcation의 역할
3-1. SQLDEV : Applcation와 호환

```
- 1주차에는 Host PC(Client)와 Guest pc(DB 서버)가 모두 동일한 컴퓨터에 있는 환경에서 실습을 진행한다. (아래 환경 설정)
- 2주차부터는 DB 서버를 서버실에 있는 컴퓨터로 바꿔서 실습을 진행한다. 
- 4주차부터는 우분투 위에 스스로 DB 서버를 Migration을 해서 실습을 진행한다. 
```


## 가상화 솔루션 네트워크 환경 구성

- `vmnetcfg.exe`를 VMware Player 폴더에 복사 - 붙여넣기

- VMware Configuration에서 IP 주소 `192.168.119.119` 를 고정시켜두기
  - 공인 IP는 중복되면 안되지만, 사설 IP는 같은 네트워크끼리만 아니면 중복되어도 상관 없다. 
  - Gateway IP : `192.168.119.2`
  - Subnet IP : `192.168.80.0`
  - Subnet Mask : `255.255.255.0`

- VMware에서 설정한 가상 컴퓨터 열기

![image](https://user-images.githubusercontent.com/77392444/114983881-181cf500-9ecc-11eb-8c64-a171a2fc8ee2.png)

![image](https://user-images.githubusercontent.com/77392444/114983631-d2f8c300-9ecb-11eb-9a7f-ec4720cab210.png)

![image](https://user-images.githubusercontent.com/77392444/114983663-dc822b00-9ecb-11eb-96d3-5ca4d3781ea7.png)

- 로그인 : `root/root00` , `oracle/dba00`

## putty
- Putty는 ClientServer이다.

- Client가 Server에 접근하려면? 서버가 구동되어 있어야 한다. (현재 접속할 서버는 VMware에서의 CentOS가상 컴퓨터이다.)

- 로그인 : `192.168.119.119/DinkServer`

![image](https://user-images.githubusercontent.com/77392444/114984411-a98c6700-9ecc-11eb-8c45-9aaf5ba6e847.png)

- Client에서 Server에 접속이 안되면? `ping IP주소`

![image](https://user-images.githubusercontent.com/77392444/114983235-50700380-9ecb-11eb-9c0b-c07877a204b5.png)

## SQLDeveloper

- 개발자 계정 연결

![image](https://user-images.githubusercontent.com/77392444/114984632-e5bfc780-9ecc-11eb-8996-a1886f93b27c.png)

- DBA 계정 연결

![image](https://user-images.githubusercontent.com/77392444/114984678-f1ab8980-9ecc-11eb-970b-bc840a61a6e8.png)



## 과제 

- DB, DBMS, RDBMS
- Connection vs Session
- Layer, Tier
- OSI 7 Layer : Response, Request로 DB를 받아옴

![image](https://user-images.githubusercontent.com/77392444/114974914-45fb3d00-9ebe-11eb-933f-e2a857c393b2.png)
