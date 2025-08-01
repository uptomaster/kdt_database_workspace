-- 첫번째 테이블 생성(TBL_SCHOOL)
CREATE TABLE TBL_SCHOOL(
   SCHOOL_NUMBER NUMBER,
   SCHOOL_NAME VARCHAR2(100)
);

-- 두번째 테이블 생성(TBL_STUDENT)
CREATE TABLE TBL_STUDENT(
   STUDENT_NUMBER NUMBER,
   STUDENT_NAME VARCHAR2(100),
   STUDENT_AGE NUMBER,
   SCHOOL_NUMBER NUMBER
);

-- 1번 : 제약조건

SELECT * FROM tbl_student
SELECT * FROM TBL_SCHOOL

INSERT INTO TBL_SCHOOL
--VALUES(1, '코리아고등학교');
--VALUES(2, '코리아it고등학교');
--VALUES(3, '한국고등학교');
--VALUES(5, NULL);

INSERT INTO TBL_STUDENT
--VALUES(1, '짱구', 100, 100, 100, 'A');
VALUES(1, '민수', 17, 1);

-- 데이터 삭제




-- 제약조건 추가
ALTER TABLE TBL_STUDENT 
ADD CONSTRAINT UQ_STUDENT_NUMBER UNIQUE (STUDENT_NUMBER);

SELECT * FROM TBL_STUDENT;
ALTER INSERT INTO TBL_STUDENT
VALUES(7, NULL, NULL, NULL)




-- 데이터 삭제
DELETE FROM TBL_STUDENT
WHERE SCHOOL_NUMBER IS NULL;

DELETE FROM TBL_SCHOOL
WHERE SCHOOL_NAME IS NULL;

-- 데이터 조회
SELECT * FROM TBL_SCHOOL;
SELECT * FROM TBL_STUDENT;

DELETE FROM TBL_STUDENT 
WHERE STUDENT_NAME = '철수';

-- 상위테이블 TBL_SCHOOL의 값을 삭제 할 때는
-- 참조하고 있는 테이블에서 사용중인지 확인 후 삭제가 가능하다.
-- 1) 자식(하위) 테이블에서 해당 컬럼의 값을 NULL로 수정 후 상위 테이블 삭제하거나,
UPDATE TBL_STUDENT
SET SCHOOL_NUMBER = NULL
WHERE SCHOOL_NUMBER = 2;

-- 2) 자식 테이블에서 해당 행을 삭제 후 상위 테이블 삭제 
DELETE FROM TBL_SCHOOL
WHERE SCHOOL_NUMBER = 2;
SELECT * FROM TBL_STUDENT;



