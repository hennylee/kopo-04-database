
## 1. 설치 메뉴얼 찾기

- 구글에서 `Oracle-Base Oracle Install in Linx 8` 검색

![image](https://user-images.githubusercontent.com/77392444/117553860-e04e3b00-b08e-11eb-8df7-c7e764c07877.png)

- 접속 : https://oracle-base.com/articles/19c/oracle-db-19c-installation-on-oracle-linux-8

![image](https://user-images.githubusercontent.com/77392444/117560511-5e2f3800-b0c9-11eb-8bd3-3219f5688750.png)

- Host File 부분부터 보면서 맞춰서 환경 설정 하기
![image](https://user-images.githubusercontent.com/77392444/117553939-679bae80-b08f-11eb-898c-36bafe9d0f57.png)


## 2. Host File 설정

- `vi /etc/hosts` : 본인의 ip 번호 작성 후 저장

![image](https://user-images.githubusercontent.com/77392444/117560497-4788e100-b0c9-11eb-881f-104f8843e037.png)

- `vi /etc/hostname` : 호스트 네임 수정

![image](https://user-images.githubusercontent.com/77392444/117554934-bcdabe80-b095-11eb-9235-30cbd349edef.png)

## 3. 오라클 dbms 설치에 필요한 패키지 설치

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


## 4. Oracle 계정 설정 

- Oracle이 속할 그룹 추가하기 

```shell
groupadd -g 54321 oinstall
groupadd -g 54322 dba
groupadd -g 54323 oper 
```

- 앞서 만든 그룹에 Oracle 유저 추가하기  : `useradd -u 54321 -g oinstall -G dba,oper oracle`

- 폴더로 확인해보면 oracle 이라는 계정의 설정을 변경하는 것이다. 
- 추후에 oracle 폴더에는 Oracle DBMS 파일이 위치하게 된다. 

![image](https://user-images.githubusercontent.com/77392444/117555965-eba96280-b09e-11eb-9886-1dc3da5c6039.png)

- Oralce 패스워드 설정하기 : `passwd oracle`


## 5. 추가 설정

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


- scripts 파일 만들기 : `mkdir /home/oracle/scripts`
- 파일을 만들때, GUI 환경에서 말고 터미널 환경에서 위의 명령어로 파일을 만들어야 오류가 없다. 

![image](https://user-images.githubusercontent.com/77392444/117555990-332fee80-b09f-11eb-9b85-915b1da3e31b.png)



- setEnv.sh 파일 만들기 
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

- /home/oracle/.bash_profile 파일 뒤에 setEnv.sh 내용 넣기 

```shell
echo ". /home/oracle/scripts/setEnv.sh" >> /home/oracle/.bash_profile
```


-  startup/shutdown service 로부터 호출되는 "start_all.sh" 과 "stop_all.sh" 스크립트 만들기 

```shell
cat > /home/oracle/scripts/start_all.sh <<EOF
```

```shell
export ORAENV_ASK=NO
. oraenv
export ORAENV_ASK=YES

dbstart \$ORACLE_HOME
EOF
```

```shell
cat > /home/oracle/scripts/stop_all.sh <<EOF
export ORAENV_ASK=NO
. oraenv
export ORAENV_ASK=YES

dbshut \$ORACLE_HOME
EOF
```

```shell
chown -R oracle:oinstall /home/oracle/scripts
chmod u+x /home/oracle/scripts/*.sh
```

- 만든 스크립트 파일들의 소유와 권한 설정/변경하기

```shell
chown -R oracle:oinstall /home/oracle/scripts
chmod u+x /home/oracle/scripts/*.sh
```

- 참고 : 만든 스크립트 파일들

![image](https://user-images.githubusercontent.com/77392444/117556004-64a8ba00-b09f-11eb-92e8-dd976e060fd6.png)


## 6. Oracle Database (zip) 파일 다운로드

- 인터넷에서 `Oracle Database 19c (19.3) for Linux x86-64 (zip)`을 다운받는다. 

- 다운 받을 파일명 : `LINUX.X64_193000_db_home.zip`

- 링크 : https://www.oracle.com/kr/database/technologies/oracle19c-linux-downloads.html

- 다운 받은 zip 파일은 $ORACLE_HOME인 oracle 폴더에 위치하도록 한다. 

![image](https://user-images.githubusercontent.com/77392444/117558898-e27abe80-b0bb-11eb-91ec-cbaaa3357bfc.png)

- 터미널에서 oracle 계정으로 접속하기  : `su oracle`

![image](https://user-images.githubusercontent.com/77392444/117556076-00d2c100-b0a0-11eb-868e-acbff8ee00a3.png)


- $ORACLE_HOME 환경변수 설정하기 : `echo $ORACLE_HOME`

![image](https://user-images.githubusercontent.com/77392444/117556138-9e2df500-b0a0-11eb-9953-ee036a094106.png)


- 오라클 zip 파일 압출 풀기

```shell
cd $ORACLE_HOME
unzip -oq /path/to/software/LINUX.X64_193000_db_home.zip
```




## 7. Oracle Database GUI 환경에서 설치

- gui 프로그램이 참조할 DISPLY 환경 변수 설정 : `DISPLAY=<본인의 machine-name>:0.0; export DISPLAY`

```shell
xhost +ol8-19
DISPLAY=:0.0;
export DISPLAY
```

- 만약 xhost 오류가 발생하면  아래 과정을 실행한다. 

```
1) Log on to XWindows as root
2) Open a terminal
3) enter 'xhost +'
4) enter 'su - oracle'
5) enter 'export DISPLAY=:0.0'
6) runInstaller (or use whatever installer is required)
```

- 설치 오류를 피하기 위한 Fake Oracle Linux 7 환경변수 설정

```shell
export CV_ASSUME_DISTID=OEL7.6
```

- Oracle DBMS GUI환경에서 설치하기

```shell
cd /home/oracle/
./runInstaller 
```

![image](https://user-images.githubusercontent.com/77392444/117559704-8a938600-b0c2-11eb-953d-733188d85e01.png)



- 선택

![image](https://user-images.githubusercontent.com/77392444/117559758-02fa4700-b0c3-11eb-9d3a-a2b832f631f1.png)

![image](https://user-images.githubusercontent.com/77392444/117559762-10afcc80-b0c3-11eb-81d0-a66cb6f85127.png)

![image](https://user-images.githubusercontent.com/77392444/117559775-1e655200-b0c3-11eb-9508-39b0758e50d0.png)

![image](https://user-images.githubusercontent.com/77392444/117559783-2e7d3180-b0c3-11eb-9932-a39f0d26193e.png)

![image](https://user-images.githubusercontent.com/77392444/117559789-3ccb4d80-b0c3-11eb-8820-a9745b36347d.png)

![image](https://user-images.githubusercontent.com/77392444/117559793-494fa600-b0c3-11eb-8e82-2c006ac458d6.png)

![image](https://user-images.githubusercontent.com/77392444/117559804-5a98b280-b0c3-11eb-9dd4-e0edd4bb050a.png)

![image](https://user-images.githubusercontent.com/77392444/117559816-6be1bf00-b0c3-11eb-995a-aa919908ba04.png)

![image](https://user-images.githubusercontent.com/77392444/117559822-7ac87180-b0c3-11eb-913d-215ae1a7f196.png)

![image](https://user-images.githubusercontent.com/77392444/117559837-93d12280-b0c3-11eb-8f90-d478193ab40d.png)

![image](https://user-images.githubusercontent.com/77392444/117559841-a21f3e80-b0c3-11eb-91f3-905ddeef2da9.png)

![image](https://user-images.githubusercontent.com/77392444/117559851-bbc08600-b0c3-11eb-9c37-92b303329898.png)

![image](https://user-images.githubusercontent.com/77392444/117559857-d561cd80-b0c3-11eb-893c-1c8a1bafb7dd.png)

![image](https://user-images.githubusercontent.com/77392444/117559864-e0b4f900-b0c3-11eb-8146-9e951d85b0f3.png)

![image](https://user-images.githubusercontent.com/77392444/117559909-32f61a00-b0c4-11eb-816e-4b19c3e0c941.png)

![image](https://user-images.githubusercontent.com/77392444/117559914-3c7f8200-b0c4-11eb-82c6-797020eb887b.png)

![image](https://user-images.githubusercontent.com/77392444/117559915-443f2680-b0c4-11eb-8ae5-e885c100380c.png)

![image](https://user-images.githubusercontent.com/77392444/117559918-50c37f00-b0c4-11eb-8f4e-d15644aa65b6.png)

- 이 창이 뜨면 터미널에서 새 윈도우창을 연 뒤, 아래 폴더로 이동해서 스크립트 파일을 실행해야 한다. 

- 이 과정을 생략하려면, script 실행을 root 한다는 부분에 체크했어야 한다. 

![image](https://user-images.githubusercontent.com/77392444/117559946-75b7f200-b0c4-11eb-937a-07db812729d7.png)

- 새 윈도우창을 연 뒤, 각 스크립트가 위치한 폴더로 이동해서 스크립트 파일 실행하기

![image](https://user-images.githubusercontent.com/77392444/117560126-06db9880-b0c6-11eb-8f52-9ccf61cdc161.png)

- 그런 다음 GUI 세션에서 이전 화면으로 돌아가서 확인을 클릭하여 설치를 계속할 수 있다.

![image](https://user-images.githubusercontent.com/77392444/117560143-28d51b00-b0c6-11eb-8ed7-67a3b032b8a6.png)


- 설치 완료되면 close

![image](https://user-images.githubusercontent.com/77392444/117560357-1c51c200-b0c8-11eb-925b-e3b1ac528c4d.png)
