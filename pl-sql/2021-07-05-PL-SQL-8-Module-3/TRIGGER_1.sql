CREATE OR REPLACE TRIGGER TRG_CHANGE_SAL
BEFORE UPDATE OF SAL ON EMP
FOR EACH ROW
BEGIN
    IF(:NEW.SAL > 9000) THEN
        :NEW.SAL := 9000;
    END IF;
END;
/
/*
Trigger TRG_CHANGE_SAL이(가) 컴파일되었습니다.
*/


UPDATE EMP SET SAL = 9500 WHERE EMPNO IN (7839, 7844);
SELECT * FROM EMP WHERE EMPNO IN (7839, 7844);
/*
2개 행 이(가) 업데이트되었습니다.

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7839 KING       PRESIDENT            81/11/17       9000                    10
      7844 TURNER     SALESMAN        7698 81/09/08       9000          0         30
*/


ROLLBACK;
SELECT EMPNO, SAL FROM EMP WHERE EMPNO IN (7839, 7844);
/*
롤백 완료.

     EMPNO        SAL
---------- ----------
      7839       5000
      7844       1500
*/