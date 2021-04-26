# 아스키 코드와 유니코드

## ASCII 코드

- ASCII는 American Standard Code for Information Interchange의 약자로써, ANSI(미국표준협회)에서 만든 표준 코드 체계이다.

- ASCII는 미국 표준이기 때문에 알파벳 외의 아시아 문자는 표현할 수 없다는 한계를 가진다. 



## 유니코드

- 유니코드는 전세계 모든 언어를 단일 코드 체계로 표현하는 것이다. 

- 한글이 2바이트인 경우와 3바이트인 경우의 차이는?

	- 2바이트 : EUC-KR, CPA49 , 연동/호환의 문제가 있음

	- 3바이트 : UTF-8, UTF-16
    
    
- 한글도 조합형, 완성형, 확장형, 확장완성형이 있다.

	- 조합형 : 모음/자음을 따로 저장해서 조합하여 쓰는 경우
    
    - 완성형 : 모음+자음을 합친 글자 전부를 저장해서 쓰는 경우

- 가변길이 유니코드

- 고정길이 유니코드

- 아래 예시 확인하기

```sql
SELECT substrb('대한민국',2,11) FROM DUAL;
SELECT replace(substrb('대한민국',2,11),' ','*') FROM DUAL;
SELECT '공백' FROM DUAL WHERE substrb('대한민국',2,2) is null;
SELECT '공백' FROM DUAL WHERE substrb('대한민국',2,2) is not null;
```

### UTF-8

- 최대 6바이트를 이용할 수 있는 가변적 문자 인코딩이다. (다른 인코딩과의 호환을 위해 4바이트까지만 사용한다) 

- UTF-8의 1바이트 영역(첫 번째 바이트 영역)에 ASCII 코드를 포함하고 있다. 
