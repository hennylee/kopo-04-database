# Ubuntu에서 Oracle 12c R2 설치하기


비공식적이지만, Ubuntu에서도 Oracle Database Server를 설치할 수 있으나, 설치가 상당히 까다롭다. 

Oracle Database Server는 현재 Unix 계열의 OS(Oracle Solaris, HP UX, IBM AIX)와 Linux 그리고 MS Windows를 위한 공식적인 설치 파일을 배포하고 있다. 

그러나, 여기서 Linux는 Oracle Linux을 지칭하는 것으로써 공식적으로 지원하는 Linux는 Oracle Linux 밖에 없다. 

Oracle Database Server는 Unix 환경에 최적화해서 설계가 되어 있기 때문에 MS Windows에 설치하는 것보다 Unix와 유사한 Linux에 설치하는 것이 
좀 더 Oracle Database Server의 기능을 제대로 사용해 볼 수 있다.



## 1. 가상머신에64bit Ubuntu Linux OS 구성

### 1.1 우분투 설치

Ubuntu IOS 파일을 통해 VMware에 우분투 서버를 생성한다. 

![image](https://user-images.githubusercontent.com/77392444/116190620-f0e4e400-a765-11eb-883e-e2515b903c8b.png)


### 1.2 우분투 서버 고정 IP 설정하기

- root 계정으로 전환하기 : `sudo passwd root` - `su`

- vmnetcfg에 설정된 VM웨어 네트워크 IP 정보들은 아래와 같다. 

```
Subnet IP=192.168.119.0
Gateway IP: 192.168.119.2
Starting IP addrss=192.168.119.128
Ending IP address=192.168.119.254
Broadcast address=192.168.119.255
Subnet mask=255.255.255.0
```

- 따라서 우분투 서버의 IP를 고정하기 위해선 위의 설정한 네트워크 IP 범위내에서만 DBMS 서버의 고정 IP를 설정해주면 된다. 

- 현재 IP를 확인보기 위해 `sudo apt-get install net-tools`를 통해 패키지를 설치하고 `ifconfig` 명령어를 실행하면 아래와 같이 나온다. 

```shell
haeni@ubuntu:/etc/netplan$ ifconfig
ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.119.128  netmask 255.255.255.0  broadcast 192.168.119.255
        inet6 fe80::61ec:7b0d:ec5a:397f  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:f5:15:8e  txqueuelen 1000  (Ethernet)
        RX packets 5226  bytes 7646891 (7.6 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2852  bytes 187313 (187.3 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 270  bytes 23626 (23.6 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 270  bytes 23626 (23.6 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```


- 현재 `192.168.119.128`로 설정된 IP를 `192.168.119.111`로 변경해줄 것이다.

- 우분투에서 IP를 설정하는 파일은 `/etc/netplan/01-network-manager-all.yaml` 내에 있다. `vi /etc/netplan/01-network-manager-all.yaml` 명령어로 내용을 수정한 뒤 저장해 준다. 

![image](https://user-images.githubusercontent.com/77392444/116213466-c6eceb00-a780-11eb-94fb-55dc264dca7d.png)

- 저장 후 netplan 적용을 위해 `sudo netplan apply` 명령어를 실행한다. 

- 그리고 나서 `ifconfig` 명령어로 ip주소를 확인해 보면 아래와 같이 바뀐 것을 알 수 있다.

```shell
haeni@ubuntu:/etc/netplan$ ifconfig
ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.119.111  netmask 255.255.255.0  broadcast 192.168.119.255
        inet6 fe80::20c:29ff:fef5:158e  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:f5:15:8e  txqueuelen 1000  (Ethernet)
        RX packets 5270  bytes 7651944 (7.6 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2946  bytes 197210 (197.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 401  bytes 34507 (34.5 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 401  bytes 34507 (34.5 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```
  
## 2. 64bit Oracle 12c R2(or 19c R2)다운받아서 Linux에 설치

### 2.1 Oracle 설치 파일 다운로드

- 다운로드 링크 : https://www.oracle.com/database/technologies/oracle-database-software-downloads.html

- [64bit Oracle 19c R2] zip 파일로 다운로드

![image](https://user-images.githubusercontent.com/77392444/116192762-3fe04880-a769-11eb-9ff5-5cbe927d470f.png)



### 2.2 오라클 데이터베이스 그룹/유저 추가

```shell
haeni@ubuntu:~$ sudo su
[sudo] password for haeni: 
root@ubuntu:/home/haeni# groupadd -g 502 oinstall
root@ubuntu:/home/haeni# groupadd -g 503 dba
root@ubuntu:/home/haeni# groupadd -g 504 oper
root@ubuntu:/home/haeni# groupadd -g 505 asmadmin
root@ubuntu:/home/haeni# useradd -u 502 -g oinstall -G dba,asmadmin,oper -s /bin/bash -m oracle
root@ubuntu:/home/haeni# passwd
New password: 
Retype new password: 
passwd: password updated successfully
```

![image](https://user-images.githubusercontent.com/77392444/116192974-99487780-a769-11eb-8a58-deabd0f4109d.png)



### 2.3 필수 패키지(package)설치

```shell
haeni@ubuntu:/$ sudo apt install -y alien libaio1 unixodbc bc unzip
```

1. alien : RPM 패키지를 Debian 패키지로 변환하는 툴

2. libaio1 : Linux 커널 AIOAsynchronous I/O 엑세스 라이브러리 

3. unixodbc : ODBC(Open Database Connectivity) 라이브러리

출처: https://dudaji.tistory.com/entry/펌-Ubuntu에-Oracle-XE-설치하기 [기네스와 조니워커]





### 2.4 사전 설정 작업

- 파라미터 : https://docs.oracle.com/database/121/LADBI/app_manual.htm#LADBI7866

### 2.5 리스너 설정


### 2.6 데이터베이스 생성


### 
