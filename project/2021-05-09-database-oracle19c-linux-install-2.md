
- 구글에서 `Oracle-Base Oracle Install in Linx 8` 검색
- 접속 : https://oracle-base.com/articles/19c/oracle-db-19c-installation-on-oracle-linux-8

![image](https://user-images.githubusercontent.com/77392444/117553860-e04e3b00-b08e-11eb-8df7-c7e764c07877.png)

- Host File 부분부터 보면서 맞춰서 환경 설정 하기
![image](https://user-images.githubusercontent.com/77392444/117553939-679bae80-b08f-11eb-898c-36bafe9d0f57.png)


## Host File

- `vi /etc/hosts` : 본인의 ip 번호 작성 후 저장

![image](https://user-images.githubusercontent.com/77392444/117554887-76855f80-b095-11eb-9c05-4843e53cab90.png)

- `vi /etc/hostname` : 호스트 네임 수정

![image](https://user-images.githubusercontent.com/77392444/117554934-bcdabe80-b095-11eb-9235-30cbd349edef.png)

## 자동 설정

- `dnf install -y https://yum.oracle.com/repo/OracleLinux/OL8/baseos/latest/x86_64/getPackage/oracle-database-preinstall-19c-1.0-1.el8.x86_64.rpm`
- 자동 설정 패키지들을 설치한다. 

![image](https://user-images.githubusercontent.com/77392444/117554971-18a54780-b096-11eb-9529-aed497ad70d1.png)


- `yum update -y` : full 업데이트를 원한다면 실행하기

![image](https://user-images.githubusercontent.com/77392444/117555013-7c2f7500-b096-11eb-859e-e99ef2e27960.png)

- 아래 명령어를 그대로 복사 붙여넣기해서 필요한 패키지들을 모두 설치한다. 

```shell
dnf install -y bc    
dnf install -y binutils
#dnf install -y compat-libcap1
dnf install -y compat-libstdc++-33
#dnf install -y dtrace-modules
#dnf install -y dtrace-modules-headers
#dnf install -y dtrace-modules-provider-headers
#dnf install -y dtrace-utils
dnf install -y elfutils-libelf
dnf install -y elfutils-libelf-devel
dnf install -y fontconfig-devel
dnf install -y glibc
dnf install -y glibc-devel
dnf install -y ksh
dnf install -y libaio
dnf install -y libaio-devel
#dnf install -y libdtrace-ctf-devel
dnf install -y libXrender
dnf install -y libXrender-devel
dnf install -y libX11
dnf install -y libXau
dnf install -y libXi
dnf install -y libXtst
dnf install -y libgcc
dnf install -y librdmacm-devel
dnf install -y libstdc++
dnf install -y libstdc++-devel
dnf install -y libxcb
dnf install -y make
dnf install -y net-tools # Clusterware
dnf install -y nfs-utils # ACFS
dnf install -y python # ACFS
dnf install -y python-configshell # ACFS
dnf install -y python-rtslib # ACFS
dnf install -y python-six # ACFS
dnf install -y targetcli # ACFS
dnf install -y smartmontools
dnf install -y sysstat
dnf install -y unixODBC
dnf install -y libnsl
dnf install -y libnsl.i686
dnf install -y libnsl2
dnf install -y libnsl2.i686
```


![image](https://user-images.githubusercontent.com/77392444/117555427-1218cf00-b09a-11eb-841c-f047215e0e4b.png)



- Oracle이 속할 그룹 추가하기 

```shell
groupadd -g 54321 oinstall
groupadd -g 54322 dba
groupadd -g 54323 oper 
```

- 앞서 만든 그룹에 Oracle 유저 추가하기  : `useradd -u 54321 -g oinstall -G dba,oper oracle`

- Oralce 패스워드 설정하기 : `passwd oracle`


- SELinux Permissive 로 변경하기 : `SELinux=permissive`
  - SELinux 는 어느 프로세스가 파일, 디렉토리, 포트에 액세스 할 수 있는지 결정하는 보안 규칙의 집합이다.
  - SELinux Permissive는 제한하고 있는 콘텐츠에 대한 액세스를 일시적으로 허용한다. 

![image](https://user-images.githubusercontent.com/77392444/117555251-9cf8ca00-b098-11eb-901d-dfa3783abfd6.png)

- `setenforce Permissive` : Permissive 변경 적용하기

- 방화벽 재가동하기

```shell
systemctl stop firewalld
systemctl disable firewalld
```

- 오라클 DBMS가 설치될 파일 만들고 권한 설정하기 

```shell
mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1
mkdir -p /u02/oradata
chown -R oracle:oinstall /u01 /u02
chmod -R 775 /u01 /u02
```

- `vi /etc/hosts` 에서 machine-name 확인하기

![image](https://user-images.githubusercontent.com/77392444/117555457-4c826c00-b09a-11eb-8392-c726a2859a8b.png)


- `xhost +<본인이 설정한 machine-name>` 
- xhost는 그래픽 화면(X윈도)의 처리를 담당한다.
- xhost + IP의 의미는 "IP"에서 들어오는 연결을 허용한다는 뜻이다. (차단은 xhost - 를 사용)
- 이 작업은 어디까지나 화면으로 연결해주는 길을 설정해준 것 뿐이지, 아직 실제로 출력해주는 화면 프로그램을 설치하지 않은 상태이다.

![image](https://user-images.githubusercontent.com/77392444/117555483-8c495380-b09a-11eb-8546-99c06f600d63.png)


- `mkdir /home/oracle/scripts`

- 환경 설정 변수들을 저장하기 
- 환경 설정 파일을 setEnv.sh 라고 한다. 

```shell
cat > /home/oracle/scripts/setEnv.sh <<EOF
```

```shell
export TMP=/tmp
export TMPDIR=\$TMP

export ORACLE_HOSTNAME=ol8-19.localdomain
export ORACLE_UNQNAME=cdb1
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/u01/app/oraInventory
export ORACLE_SID=cdb1
export PDB_NAME=pdb1
export DATA_DIR=/u02/oradata

export PATH=/usr/sbin:/usr/local/bin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$PATH

export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
EOF
```

![image](https://user-images.githubusercontent.com/77392444/117555578-5a84bc80-b09b-11eb-8a0d-0802e2d2640f.png)

