-- <<예외처리부가 에러를 못잡는 경우 Runtime Exception>>
/*
목적
1) WHEN NO_DATA_FOUND
*/


-- 1. Exception이 예외를 못잡는 경우 Runtime Error가 발생하면 이전에 삽입된 데이터는 자동 ROLLBACK 되는가? YES!
DELETE FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
COMMIT;


BEGIN
    INSERT INTO DEPT VALUES(66, 'OUTER_BLK_PART', 'Main_Blk'); -- 자동 ROLLBACK
    
    <<NESTED_BLOCK_1>>
    BEGIN 
        INSERT INTO DEPT VALUES(76, 'LOCAL_PART_1', 'Nested_Blk1'); -- 자동 ROLLBACK
        INSERT INTO DEPT VALUES(777, 'LOCAL_PART_1', 'Nested_Blk1'); -- 런타임에러
        INSERT INTO DEPT VALUES(77, 'LOCAL_PART_1', 'Nested_Blk1'); -- 실행 X
        INSERT INTO DEPT VALUES(78, 'LOCAL_PART_1', 'Nested_Blk1'); -- 실행 X
        COMMIT; -- 실행X
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            NULL;
    END NESTED_BLOCK_1;
   
    INSERT INTO DEPT VALUES(99, 'OUTER_BLK_PART', 'Main_Blk'); -- 자동 ROLLBACK
END;
/

SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
/*
선택된 행 없음
*/




-- 2. Exception이 예외를 못잡는 경우 Runtime Error가 발생하면 이후에 삽입된 데이터는 자동 ROLLBACK 되는가? YES!
DELETE FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
COMMIT;


BEGIN
    INSERT INTO DEPT VALUES(66, 'OUTER_BLK_PART', 'Main_Blk'); -- 자동 ROLLBACK
    
    <<NESTED_BLOCK_1>>
    BEGIN 
        INSERT INTO DEPT VALUES(76, 'LOCAL_PART_1', 'Nested_Blk1'); -- 자동 ROLLBACK
        INSERT INTO DEPT VALUES(777, 'LOCAL_PART_1', 'Nested_Blk1'); -- 런타임에러
        INSERT INTO DEPT VALUES(77, 'LOCAL_PART_1', 'Nested_Blk1'); -- 실행 X
        INSERT INTO DEPT VALUES(78, 'LOCAL_PART_1', 'Nested_Blk1'); -- 실행 X
        COMMIT; -- 실행X
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            NULL;
    END NESTED_BLOCK_1;
   
    INSERT INTO DEPT VALUES(99, 'OUTER_BLK_PART', 'Main_Blk'); -- 실행X
    COMMIT; -- 실행X
END;
/

SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
/*
선택된 행 없음
*/

ROLLBACK;
SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
/*
롤백 완료.
선택된 행 없음
*/







-- 3. Exception이 예외를 못잡는 경우 Runtime Error가 발생하면 다음블럭은 실행되는가? NO 실행안됨
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
        WHEN NO_DATA_FOUND THEN
            NULL;
    END NESTED_BLOCK_1;
    
    <<NESTED_BLOCK_2>>
    BEGIN 
        INSERT INTO DEPT VALUES(88, 'LOCAL_PART_2', 'Nested_Blk2'); -- 실행 X
        COMMIT;-- 실행 X
    END NESTED_BLOCK_2;
    
    INSERT INTO DEPT VALUES(99, 'OUTER_BLK_PART', 'Main_Blk'); -- 실행 X
END;
/

SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);
/*
선택된 행 없음
*/

ROLLBACK;
SELECT * FROM DEPT WHERE DEPTNO IN (66, 76, 77, 78, 88, 99);

/*
롤백 완료.
선택된 행 없음
*/

