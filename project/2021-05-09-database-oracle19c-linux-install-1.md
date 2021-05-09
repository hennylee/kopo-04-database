# Vmware에 Oracle Linux 8설치하기

## 1. Oracle Linux 8 다운로드

- https://edelivery.oracle.com/ 에서 Oracle Linux8 검색


![image](https://user-images.githubusercontent.com/77392444/117553757-4be3d880-b08e-11eb-8d79-8db270aa59e7.png)


- 아래 항목 다운로드 

![image](https://user-images.githubusercontent.com/77392444/117553734-2525a200-b08e-11eb-934c-f79b346db5d8.png)
 

![image](https://user-images.githubusercontent.com/77392444/117553716-1343ff00-b08e-11eb-9eb7-e4924e0bdcf5.png)

- 다운로드된 ex 파일 실행

![image](https://user-images.githubusercontent.com/77392444/117552030-028e8b80-b084-11eb-93ac-5abcafedaca2.png)



## 2. VMware 에 Oracle Linux 8 설치

![image](https://user-images.githubusercontent.com/77392444/117552061-4386a000-b084-11eb-952a-c8baa5dbeee9.png)


- 다운받은 Oracle Linux 파일 불러오기

![image](https://user-images.githubusercontent.com/77392444/117552071-513c2580-b084-11eb-9fa5-14085e99b8fe.png)

- 아래 vmware가 만들어질 파일의 저장 공간은 60GB정도로 넉넉한게 좋다.

![image](https://user-images.githubusercontent.com/77392444/117552134-a24c1980-b084-11eb-8c00-921da85cce4c.png)


- 60GB 로 바꾸기

![image](https://user-images.githubusercontent.com/77392444/117552198-eb03d280-b084-11eb-86ff-3424601f4ad1.png)


- Customize 클릭

![image](https://user-images.githubusercontent.com/77392444/117552229-0c64be80-b085-11eb-88cf-887799c91175.png)


- Memory 8GB로 설정

![image](https://user-images.githubusercontent.com/77392444/117552252-27373300-b085-11eb-878a-d6cb8f01d3b2.png)

- 프로세스 4개 설정

![image](https://user-images.githubusercontent.com/77392444/117552311-78472700-b085-11eb-9385-6579e4e61417.png)


## 3. Oracle Linux 8 설치

- 만들어진 Oracle Linux 실행

![image](https://user-images.githubusercontent.com/77392444/117552323-93b23200-b085-11eb-9caa-2d00d45bf4a6.png)

- English 선택 

![image](https://user-images.githubusercontent.com/77392444/117552466-716ce400-b086-11eb-9865-c4e8d099dfba.png)

- IP 고정

![image](https://user-images.githubusercontent.com/77392444/117552608-754d3600-b087-11eb-9d0e-b69208b3db61.png)

- refresh 클릭

![image](https://user-images.githubusercontent.com/77392444/117552666-c52bfd00-b087-11eb-87a7-78938cad624a.png)


- 구글에서 yum oracle server 검색

![image](https://user-images.githubusercontent.com/77392444/117552687-f1477e00-b087-11eb-9080-bd010743fd95.png)


- https://yum.oracle.com/index.html 접속

- Home 에서 [Browse the Repositories - Oracle Linux 8 - x86_64] 선택

![image](https://user-images.githubusercontent.com/77392444/117552794-906c7580-b088-11eb-9d56-9b172c089d4b.png)



- 이 페이지의 index.html을 제외한 앞의 URL 카피 : https://yum.oracle.com/repo/OracleLinux/OL8/baseos/latest/x86_64


![image](https://user-images.githubusercontent.com/77392444/117552815-ab3eea00-b088-11eb-9750-07e9d9184db0.png)


- Installation Source에 붙여넣고 Done, 다운로드 다 될때까지 대기하기

![image](https://user-images.githubusercontent.com/77392444/117552876-02dd5580-b089-11eb-9696-799ad7010c87.png)

- Software Selection : Custom Operation System 선택 후, [Smart Card Support] 제외 하고 전부 선택

![image](https://user-images.githubusercontent.com/77392444/117553652-bfd1b100-b08d-11eb-8b2a-01dc4007317d.png)


- Begin to Install 클릭 후, 두 개 계정 PW 설정

![image](https://user-images.githubusercontent.com/77392444/117553041-176e1d80-b08a-11eb-841b-8f3f8b041f67.png)


![image](https://user-images.githubusercontent.com/77392444/117553016-f86f8b80-b089-11eb-811c-a7a424a856c5.png)



- 설치 완료 되면 Reboot

![image](https://user-images.githubusercontent.com/77392444/117553195-ff4ace00-b08a-11eb-9c20-7e23972946b8.png)


- 부팅하다가 두 개 선택하는 거 나오면 위의 Oracle Linux 선택(엔터)

![image](https://user-images.githubusercontent.com/77392444/117553402-6ae16b00-b08c-11eb-978d-34aab298341d.png)


- yum 설치 가능한 그룹 리스트 확인하기 : root 계정 접속 - `dnf group list`

![image](https://user-images.githubusercontent.com/77392444/117553228-30c39980-b08b-11eb-8659-9ad1d96a699f.png)


-  Server with GUI 설치하기 : `dnf groupinstall Server with GUI` 입력 - 중간에 Y 클릭
    - 이를 통해 xWindow패키지 등과 같은 GUI 패키지들을 설치해야 오라클 DBMS를 GUI환경에서 설치할 수 있다. 

![image](https://user-images.githubusercontent.com/77392444/117553329-de36ad00-b08b-11eb-960b-ac08e1a49562.png)


- 설치 완료되면 `startx` 입력

![image](https://user-images.githubusercontent.com/77392444/117553283-9b74d500-b08b-11eb-8be3-23232b2b7ff6.png)

- [Activities - terminal] 실행

![image](https://user-images.githubusercontent.com/77392444/117553678-e1329d00-b08d-11eb-99aa-a6bdf72ed2f3.png)
