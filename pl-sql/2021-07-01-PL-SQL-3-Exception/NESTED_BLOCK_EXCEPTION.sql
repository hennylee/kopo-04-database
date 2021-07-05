SET SERVEROUTPUT ON

INSERT INTO DEPT VALUES(66, 'OUTER_BLK_PART', 'Outlander'); -- 커밋전상태

DECLARE
    V_DNAME  VARCHAR2(14);
    V_DEPTNO NUMBER(200); -- NUMBER는 최대 38자리까지 가능 => 컴파일 에러 발생! => 뒷부분은 아예 실행되지 않음
    V_LOC VARCHAR2(13);
BEGIN
    -- 77 GLOBAL_PART    Nested_Blk2 
    V_DEPTNO := 77;
    V_DNAME := 'GLOBAL_PART';
    V_LOC := 'Main_Blk';
    
    <<NESTED_BLOCK_1>> -- 지역블록 Label
    DECLARE
        V_DNAME VARCHAR2(14);
        V_DEPTNO NUMBER(2);
    BEGIN 
        -- 88 LOCAL_PART_1   Nested_Blk1
        V_DEPTNO := 88;
        V_DNAME := 'LOCAL_PART_1';
        V_LOC := 'Nested_Blk1';
        INSERT INTO DEPT VALUES(V_DEPTNO, V_DNAME, V_LOC);
        COMMIT;
    END NESTED_BLOCK_1;
    
    <<NESTED_BLOCK_2>>
    DECLARE
        V_DNAME VARCHAR2(14);
        V_DEPTNO NUMBER(2);
    BEGIN 
        -- 99 LOCAL_PART_2   Nested_Blk2
        V_DEPTNO := 99;
        V_DNAME := 'LOCAL_PART_2';
        V_LOC := 'Nested_Blk2';
        INSERT INTO DEPT VALUES(V_DEPTNO, V_DNAME, V_LOC); -- Main Block의 변수를 사용하려면? Main Block 명을 선언 후 명시해줘야 함
        COMMIT;
    END NESTED_BLOCK_2;
    
    INSERT INTO DEPT VALUES(V_DEPTNO, V_DNAME, V_LOC);
END;
/

/*
오류 보고 -
ORA-06550: 줄 3, 열21:PLS-00216: NUMBER 정도 제약은 (1 .. 38)범위이어야 합니다
*/

SELECT * FROM DEPT;

/*
    DEPTNO DNAME          LOC          
---------- -------------- -------------
        66 OUTER_BLK_PART Outlander    
        10 ACCOUNTING     NEW YORK     
        20 RESEARCH       DALLAS       
        30 SALES          CHICAGO      
        40 OPERATIONS     BOSTON    
*/

ROLLBACK;
SELECT * FROM DEPT;

/*
롤백 완료.

    DEPTNO DNAME          LOC          
---------- -------------- -------------
        10 ACCOUNTING     NEW YORK     
        20 RESEARCH       DALLAS       
        30 SALES          CHICAGO      
        40 OPERATIONS     BOSTON    
*/

DELETE FROM DEPT WHERE DEPTNO IN (66, 77, 88, 99);
COMMIT;

/*
4개 행 이(가) 삭제되었습니다.

커밋 완료.
*/
    

