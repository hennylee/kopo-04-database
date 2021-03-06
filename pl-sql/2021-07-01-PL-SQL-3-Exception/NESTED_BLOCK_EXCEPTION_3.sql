-- <<예외처리부가 있는 경우 Runtime Exception>>
/*
목적
1) WHEN OTHERS
*/

-- 1. Runtime Error가 발생하면 이전에 삽입된 데이터는 자동 commit 되는가? 안됨
DELETE FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
COMMIT;


BEGIN
    INSERT INTO DEPT VALUES(66, 'OUTER_BLK_PART', 'Main_Blk'); -- 커밋미완료
    
    <<NESTED_BLOCK_1>>
    BEGIN 
        INSERT INTO DEPT VALUES(76, 'LOCAL_PART_1', 'Nested_Blk1'); -- 커밋미완료
        INSERT INTO DEPT VALUES(777, 'LOCAL_PART_1', 'Nested_Blk1'); -- 런타임에러
        INSERT INTO DEPT VALUES(77, 'LOCAL_PART_1', 'Nested_Blk1'); -- 실행 X
        INSERT INTO DEPT VALUES(78, 'LOCAL_PART_1', 'Nested_Blk1'); -- 실행 X
        COMMIT; -- 실행X
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END NESTED_BLOCK_1;
   
    INSERT INTO DEPT VALUES(99, 'OUTER_BLK_PART', 'Main_Blk'); -- 커밋미완료
END;
/

SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
/*
    DEPTNO DNAME          LOC          
---------- -------------- -------------
        66 OUTER_BLK_PART Main_Blk     
        76 LOCAL_PART_1   Nested_Blk1  
        99 OUTER_BLK_PART Main_Blk     
*/

ROLLBACK;
SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
/*
롤백 완료.
선택된 행 없음
*/




-- 2. Runtime Error가 발생하면 이전에 삽입된 데이터는 자동 ROLLBACK 되는가? NO! 수동 ROLLBACK시켜줘야 함
DELETE FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
COMMIT;


BEGIN
    INSERT INTO DEPT VALUES(66, 'OUTER_BLK_PART', 'Main_Blk'); -- 커밋미완료
    
    <<NESTED_BLOCK_1>>
    BEGIN 
        INSERT INTO DEPT VALUES(76, 'LOCAL_PART_1', 'Nested_Blk1'); -- 커밋미완료
        INSERT INTO DEPT VALUES(777, 'LOCAL_PART_1', 'Nested_Blk1'); -- 런타임에러
        INSERT INTO DEPT VALUES(77, 'LOCAL_PART_1', 'Nested_Blk1'); -- 실행 X
        INSERT INTO DEPT VALUES(78, 'LOCAL_PART_1', 'Nested_Blk1'); -- 실행 X
        COMMIT; -- 실행X
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END NESTED_BLOCK_1;
   
    INSERT INTO DEPT VALUES(99, 'OUTER_BLK_PART', 'Main_Blk'); -- 커밋미완료
END;
/

SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
/*
    DEPTNO DNAME          LOC          
---------- -------------- -------------
        66 OUTER_BLK_PART Main_Blk     
        76 LOCAL_PART_1   Nested_Blk1  
        99 OUTER_BLK_PART Main_Blk     
*/

ROLLBACK;
SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
/*
롤백 완료.
선택된 행 없음
*/







-- 3. Runtime Error가 발생하면 이 다음 블록의 COMMIT이 적용 되는가? YES!
DELETE FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
COMMIT;


BEGIN
    INSERT INTO DEPT VALUES(66, 'OUTER_BLK_PART', 'Main_Blk'); -- 커밋완료 
    
    <<NESTED_BLOCK_1>>
    BEGIN 
        INSERT INTO DEPT VALUES(76, 'LOCAL_PART_1', 'Nested_Blk1'); -- 커밋완료 
        INSERT INTO DEPT VALUES(777, 'LOCAL_PART_1', 'Nested_Blk1'); -- 런타임에러
        INSERT INTO DEPT VALUES(77, 'LOCAL_PART_1', 'Nested_Blk1'); -- 실행 X
        INSERT INTO DEPT VALUES(78, 'LOCAL_PART_1', 'Nested_Blk1'); -- 실행 X
        COMMIT; -- 실행X
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END NESTED_BLOCK_1;
    
    <<NESTED_BLOCK_2>>
    BEGIN 
        INSERT INTO DEPT VALUES(88, 'LOCAL_PART_2', 'Nested_Blk2'); -- 커밋완료
        COMMIT;-- 실행
    END NESTED_BLOCK_2;
    
    INSERT INTO DEPT VALUES(99, 'OUTER_BLK_PART', 'Main_Blk'); -- 커밋미완료
END;
/

SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
/*
    DEPTNO DNAME          LOC          
---------- -------------- -------------
        66 OUTER_BLK_PART Main_Blk     
        76 LOCAL_PART_1   Nested_Blk1  
        88 LOCAL_PART_2   Nested_Blk2  
        99 OUTER_BLK_PART Main_Blk    
*/

ROLLBACK;
SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);

/*
롤백 완료.

    DEPTNO DNAME          LOC          
---------- -------------- -------------
        66 OUTER_BLK_PART Main_Blk     
        76 LOCAL_PART_1   Nested_Blk1  
        88 LOCAL_PART_2   Nested_Blk2  
*/

