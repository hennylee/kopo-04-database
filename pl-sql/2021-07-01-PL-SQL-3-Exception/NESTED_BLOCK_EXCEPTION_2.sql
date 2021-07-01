-- 1. 런타임 에러가 발생하지 않는다면?
BEGIN
    INSERT INTO DEPT VALUES(66, 'OUTER_BLK_PART', 'Main_Blk');
    
    <<NESTED_BLOCK_1>>
    BEGIN 
        INSERT INTO DEPT VALUES(76, 'LOCAL_PART_1', 'Nested_Blk1');
        --INSERT INTO DEPT VALUES(777, 'LOCAL_PART_1', 'Nested_Blk1');
        INSERT INTO DEPT VALUES(77, 'LOCAL_PART_1', 'Nested_Blk1');
        INSERT INTO DEPT VALUES(78, 'LOCAL_PART_1', 'Nested_Blk1');
        COMMIT;
    END NESTED_BLOCK_1;
    
    <<NESTED_BLOCK_2>>
    BEGIN 
        INSERT INTO DEPT VALUES(88, 'LOCAL_PART_2', 'Nested_Blk2');
        COMMIT;
    END NESTED_BLOCK_2;
    
    INSERT INTO DEPT VALUES(99, 'OUTER_BLK_PART', 'Main_Blk');
END;
/

/*
PL/SQL 프로시저가 성공적으로 완료되었습니다
*/

SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);

/*
    DEPTNO DNAME          LOC          
---------- -------------- -------------
        66 OUTER_BLK_PART Main_Blk     
        76 LOCAL_PART_1   Nested_Blk1  
        77 LOCAL_PART_1   Nested_Blk1  
        78 LOCAL_PART_1   Nested_Blk1  
        88 LOCAL_PART_2   Nested_Blk2  
        99 OUTER_BLK_PART Main_Blk     

6개 행이 선택되었습니다. 
*/

DELETE FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
COMMIT;




-- 2. 런타임 에러 전에 COMMIT이 완료된 데이터가 있다면?
BEGIN
    INSERT INTO DEPT VALUES(66, 'OUTER_BLK_PART', 'Main_Blk'); -- 삽입완료
    
    <<NESTED_BLOCK_1>>
    BEGIN 
        INSERT INTO DEPT VALUES(76, 'LOCAL_PART_1', 'Nested_Blk1'); -- 삽입완료
        COMMIT;
        INSERT INTO DEPT VALUES(77, 'LOCAL_PART_1', 'Nested_Blk1'); -- 삽입실패
        INSERT INTO DEPT VALUES(777, 'LOCAL_PART_1', 'Nested_Blk1'); -- 런타임에러
        INSERT INTO DEPT VALUES(78, 'LOCAL_PART_1', 'Nested_Blk1');
        COMMIT;
    END NESTED_BLOCK_1;
    
    <<NESTED_BLOCK_2>>
    BEGIN 
        INSERT INTO DEPT VALUES(88, 'LOCAL_PART_2', 'Nested_Blk2');
        COMMIT;
    END NESTED_BLOCK_2;
    
    INSERT INTO DEPT VALUES(99, 'OUTER_BLK_PART', 'Main_Blk');
END;
/

/*
오류 보고 -
ORA-01438: 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
ORA-06512:  9행
*/

SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);

/*
    DEPTNO DNAME          LOC          
---------- -------------- -------------
        66 OUTER_BLK_PART Main_Blk     
        76 LOCAL_PART_1   Nested_Blk1  
*/

DELETE FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
COMMIT;




-- 3. 런타임 에러 전에 COMMIT되지 않은 데이터가 있다면?
BEGIN
    INSERT INTO DEPT VALUES(66, 'OUTER_BLK_PART', 'Main_Blk'); -- 삽입실패
    
    <<NESTED_BLOCK_1>>
    BEGIN 
        INSERT INTO DEPT VALUES(76, 'LOCAL_PART_1', 'Nested_Blk1'); -- 삽입실패
        INSERT INTO DEPT VALUES(77, 'LOCAL_PART_1', 'Nested_Blk1'); -- 삽입실패
        INSERT INTO DEPT VALUES(777, 'LOCAL_PART_1', 'Nested_Blk1'); -- 런타임에러
        INSERT INTO DEPT VALUES(78, 'LOCAL_PART_1', 'Nested_Blk1');
        COMMIT;
    END NESTED_BLOCK_1;
    
    <<NESTED_BLOCK_2>>
    BEGIN 
        INSERT INTO DEPT VALUES(88, 'LOCAL_PART_2', 'Nested_Blk2');
        COMMIT;
    END NESTED_BLOCK_2;
    
    INSERT INTO DEPT VALUES(99, 'OUTER_BLK_PART', 'Main_Blk');
END;
/

/*
오류 보고 -
ORA-01438: 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
ORA-06512:  8행
*/

SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);

/*
선택된 행 없음
*/

