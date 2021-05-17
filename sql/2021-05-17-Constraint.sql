-- <05/13> 일일과제

-- 2. 테이블명과 컬럼명을 한글로 생성할수 있는지를 확인할수 있는 SQL예제를 작성하십시요

CREATE TABLE 테스트_한국어 (
    NUM NUMBER(38),
    한국어 VARCHAR2(10)
);

DESC 테스트_한국어;

INSERT INTO 테스트_한국어 VALUES(1, '한글');

SELECT * FROM 테스트_한국어;



/*
 * KO16KSC5601
   완성형 한글- 일반적으로 많이 사용되며 2350자의 한글, 4888자의 한자, 히라카나, 카타카나, 영문 및 각종 기호를 포함하고 있음.  (한글바이트: 2byte)

 * KO16MSWIN949
   조합형 한글- 완성형을 포함하여 11172자의 한글을 표현함 (한글바이트: 2byte)

 * AL32UTF8 
   Unicode의 CES 중 하나- 11172자의 한글을 지원 (한글바이트: 3byte)
*/
select * from nls_database_parameters where parameter = 'NLS_CHARACTERSET'; -- AL32UTF8
select * from nls_database_parameters where parameter = 'NLS_NCHAR_CHARACTERSET'; -- AL16UTF16

ROLLBACK;

SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE NOT SAL > (2000+200) / 2;


SET AUTOTRACE ON
SELECT * FROM EMP;

SET AUTOTRACE ON
SELECT * FROM DEPT;

SET AUTOTRACE ON
SELECT * FROM CUSTOMER WHERE NAME = '전지현' AND ID = '03621915';
ROLLBACK;

select * FROM (
select * from emp where job = 'SALESMAN') a , (
select * from dept where loc = 'CHICAGO') b 
where a.deptno = b.deptno;


SELECT * FROM EMP a, DEPT b WHERE a.deptno = b.deptno AND a.job = 'SALESMAN' AND b.loc = 'CHICAGO';
