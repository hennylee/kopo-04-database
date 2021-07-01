SELECT COUNT(*) FROM DEPT;

/*
  COUNT(*)
----------
         4
*/         

INSERT INTO DEPT VALUES(66, 'OUTER_BLK_PART', 'Outlander');

/*
1 행 이(가) 삽입되었습니다.
*/

DECLARE
    V_DNAME  VARCHAR2(14);
    V_DEPTNO NUMBER(2);
    V_LOC VARCHAR2(13);
BEGIN
    -- 77 GLOBAL_PART    Nested_Blk2 
    V_DEPTNO := 77;
    V_DNAME := 'GLOBAL_PART';
    V_LOC := 'Main_Blk';
    
    <<LOCAL_BLOCK_1>> -- 지역블록 Label
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
    END LOCAL_BLOCK_1;
    
    <<LOCAL_BLOCK_2>>
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
    END LOCAL_BLOCK_2;
    
    INSERT INTO DEPT VALUES(V_DEPTNO, V_DNAME, V_LOC);
END;
/

/*
PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

SELECT * FROM DEPT;

/*
    DEPTNO DNAME          LOC          
---------- -------------- -------------
        77 GLOBAL_PART    Nested_Blk2  
        66 OUTER_BLK_PART Outlander    
        88 LOCAL_PART_1   Nested_Blk1  
        99 LOCAL_PART_2   Nested_Blk2  
        10 ACCOUNTING     NEW YORK     
        20 RESEARCH       DALLAS       
        30 SALES          CHICAGO      
        40 OPERATIONS     BOSTON       

8개 행이 선택되었습니다. 
*/

DELETE FROM DEPT WHERE DEPTNO IN (66, 77, 88, 99);
COMMIT;

/*
4개 행 이(가) 삭제되었습니다.

커밋 완료.
*/
    

