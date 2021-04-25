## 오라클 타입 형변환

- 명시적 형변환 : 사용자가 임의로 데이터 유형을 변경시키는 것이다. (to_date, to_char, to_number)

- 암시적 형변환 : 오라클 DBMS 내부적으로 형변환을 일으키는 것이다.

- 일반적인 비교에서는 다른 자료형의 비교일 경우엔 암시적 형변환이 일어나게 되고 여기엔 우선순위가 있다.
	- [숫자 > 문자] : 숫자 문자 비교시엔 숫자가 우선이므로 문자가 숫자로 변형됩니다. 
	- [날짜 > 문자] : 날짜 문자 비교시엔 날짜가 우선이므로 문자가 날짜로 변형됩니다.


## 문자와 날짜

- 일반적으로 날짜와 문자와의 비교에서는 날짜가 우선이다. 즉, 문자가 날짜로 변형되어서 비교가 된다. 

- IN 의 경우 문자가 날짜로 변경되다가 오류가 날 수 있다. 

- 하지만 LIKE 는 오로지 문자비교형 함수이기 때문에 오히려 반대로 날짜형이 문자형으로 바뀌어 비교된다. 

- 좌변을 가공하면 처음부터 끝까지 full table scan을 해야해서 가장 성능이 떨어진다. 
