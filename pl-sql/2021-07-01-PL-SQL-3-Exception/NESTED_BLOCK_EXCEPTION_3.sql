BEGIN
    INSERT INTO DEPT VALUES(66, 'OUTER_BLK_PART', 'Main_Blk');
    
    <<NESTED_BLOCK_1>>
    BEGIN 
        INSERT INTO DEPT VALUES(76, 'LOCAL_PART_1', 'Nested_Blk1');
        --INSERT INTO DEPT VALUES(777, 'LOCAL_PART_1', 'Nested_Blk1');
        INSERT INTO DEPT VALUES(77, 'LOCAL_PART_1', 'Nested_Blk1');
        INSERT INTO DEPT VALUES(78, 'LOCAL_PART_1', 'Nested_Blk1');
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END NESTED_BLOCK_1;
    
    <<NESTED_BLOCK_2>>
    BEGIN 
        INSERT INTO DEPT VALUES(88, 'LOCAL_PART_2', 'Nested_Blk2');
        COMMIT;
    END NESTED_BLOCK_2;
    
    INSERT INTO DEPT VALUES(99, 'OUTER_BLK_PART', 'Main_Blk');
END;
/

SELECT * FROM DEPT;
/*
    DEPTNO DNAME          LOC          
---------- -------------- -------------
        99 OUTER_BLK_PART Main_Blk     
        66 OUTER_BLK_PART Main_Blk     
        76 LOCAL_PART_1   Nested_Blk1  
        77 LOCAL_PART_1   Nested_Blk1  
        78 LOCAL_PART_1   Nested_Blk1  
        88 LOCAL_PART_2   Nested_Blk2  
        10 ACCOUNTING     NEW YORK     
        20 RESEARCH       DALLAS       
        30 SALES          CHICAGO      
        40 OPERATIONS     BOSTON       

10개 행이 선택되었습니다. 
*/

DELETE FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
COMMIT;


BEGIN
    INSERT INTO DEPT VALUES(66, 'OUTER_BLK_PART', 'Main_Blk'); -- 커밋완료
    
    <<NESTED_BLOCK_1>>
    BEGIN 
        INSERT INTO DEPT VALUES(76, 'LOCAL_PART_1', 'Nested_Blk1'); -- 커밋완료
        INSERT INTO DEPT VALUES(777, 'LOCAL_PART_1', 'Nested_Blk1'); -- 런타임에러
        INSERT INTO DEPT VALUES(77, 'LOCAL_PART_1', 'Nested_Blk1');
        INSERT INTO DEPT VALUES(78, 'LOCAL_PART_1', 'Nested_Blk1');
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END NESTED_BLOCK_1;
    
    <<NESTED_BLOCK_2>>
    BEGIN 
        INSERT INTO DEPT VALUES(88, 'LOCAL_PART_2', 'Nested_Blk2'); -- 커밋완료
        COMMIT;
    END NESTED_BLOCK_2;
    
    INSERT INTO DEPT VALUES(99, 'OUTER_BLK_PART', 'Main_Blk'); -- 커밋 전 상태
END;
/

SELECT * FROM DEPT;
/*
    DEPTNO DNAME          LOC          
---------- -------------- -------------
        66 OUTER_BLK_PART Main_Blk     
        76 LOCAL_PART_1   Nested_Blk1  
        88 LOCAL_PART_2   Nested_Blk2  
        99 OUTER_BLK_PART Main_Blk     
        10 ACCOUNTING     NEW YORK     
        20 RESEARCH       DALLAS       
        30 SALES          CHICAGO      
        40 OPERATIONS     BOSTON       

8개 행이 선택되었습니다.  
*/

ROLLBACK;
SELECT * FROM DEPT;

/*
    DEPTNO DNAME          LOC          
---------- -------------- -------------
        66 OUTER_BLK_PART Main_Blk     
        76 LOCAL_PART_1   Nested_Blk1  
        88 LOCAL_PART_2   Nested_Blk2  
        10 ACCOUNTING     NEW YORK     
        20 RESEARCH       DALLAS       
        30 SALES          CHICAGO      
        40 OPERATIONS     BOSTON       

7개 행이 선택되었습니다. 
*/