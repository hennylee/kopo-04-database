-- 데이터 초기화
DELETE FROM DEPT WHERE DEPTNO IN (88, 99, 77);
COMMIT;

<<MAIN_BLK>>
DECLARE
    V_DNAME VARCHAR2(14);
    V_DEPTNO NUMBER(2);
    V_LOC VARCHAR2(13);
BEGIN
    V_DEPTNO := 77;
    V_DNAME := 'GLOBAL_PART';
    V_LOC := 'Main_Blk';
    
    <<LOCAL_BLOCK_1>>
    DECLARE
        V_DNAME VARCHAR2(14);
        V_DEPTNO NUMBER(2);
    BEGIN  
        V_DEPTNO := 88;
        V_DNAME := 'LOCAL_PART_1';
        V_LOC := 'Nested_Blk1';
        -- 88, GLOBAL_PART, Nested_Blk1
        INSERT INTO DEPT VALUES(V_DEPTNO, MAIN_BLK.V_DNAME, V_LOC);
    END LOCAL_BLOCK_1;
    
    <<LOCAL_BLOCK_2>>
    DECLARE
        V_DNAME VARCHAR2(14);
        V_DEPTNO NUMBER(2);
    BEGIN
        V_DEPTNO := 99;
        V_DNAME := 'LOCAL_PART_2';
        V_LOC := 'Nested_Blk2';
        -- 99, LOCAL_PART_2, Nested_Blk2
        INSERT INTO DEPT VALUES(V_DEPTNO, V_DNAME, V_LOC);
    END LOCAL_BLOCK_2;
    -- 77,  'GLOBAL_PART', Main_Blk가 아니고 Nested_Blk2가 나오네?;
    -- V_LOC를 지역변수로 선언하지 않고, 값을 지역BLOCK 내에서 바꾸면 전역변수 값이 변한다.
    INSERT INTO DEPT VALUES(V_DEPTNO, V_DNAME, V_LOC);
END MAIN_BLK;
/

SELECT * FROM DEPT;
ROLLBACK;

SELECT * FROM DEPT;
