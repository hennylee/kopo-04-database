## RDBMS의 인터페이스

## Interactive SQL
- 대화식 sql

- 보통 SQL Developer같은 툴에서 Interactive SQL을 사용해 기능, 성능 검증을 마친 뒤 Embeded SQL로 사용한다. 

## Embeded SQL
- 내포된 sql

- 절자적 언어 코드(C, JAVA, 코볼 등) 에서 SQL 언어가 포함된 것이다. 

- Embeded SQL을 포함하고 있는 언어를 'Host Language', 그 변수를 'Host 변수'라고 한다.

- EXEC SQL로 시작하고 세미콜론으로 종료한다.

- SQL * Plus 예시

```SQL
EXEC SQL SELECT ename, sal 
    INTO : EMPLOYEE_NAME, : EMPLOYEE_SALARY 
    FROM emp 
    WHERE empno = : EMP_NUMBER; 
```

- 예시  : https://docs.oracle.com/cd/A57673_01/DOC/api/doc/PAD18/ch2.htm

- SQL이 호스트 언어의 완전한 표현력을 갖고 있지 않기 때문에 모든 질의를 SQL로 표현할 수는 없다.

- SQL은 호스트 언어과 갖고 있는 IF, WHILE, 입출력 등과 같은 동작, 사용자와의 상호 작용, 질의 결과를 GUI로 보내는 등의 기능을 갖고 있지 않다.

- 그래서 C,C++,코볼 자바 등의 고급 프로그래밍 언어내에 SQL문을 삽입하여, 
데이터베이스를 접근하는 부분을 SQL이 맡고 SQL에 없는 기능은 호스트 언어로 작성하는 것이 필요하다.

- 이때 데이터구조가 불일치하는 문제(impedance mismatch problem)발생한다.

- 호스트 언어는 단일 변수/레코드 위주의 처리(튜플 위주의 방식)를 지원하는 반면에 
SQL은 데이터 레코드들의 처리(집합 위주의 방식)를 지원하기 때문이다.

- 이를 해결하기 위해 커서(cursor)가 사용된다.
