-- 4번 : DDL 테이블 생성 후 관계 연결

-- 자동차 테이블 생성 tbl_car
-- 자동차 번호 car_number number
-- 자동차 이름 car_name varchar2(1000)
-- 자동차 브랜드 car_brand varchar2(1000)
-- 출시 날짜 car_release_date date
-- 색상 car_color varchar2(1000)
-- 가격 car_price number

CREATE TABLE TBL_CAR(
	CAR_NUMBER NUMBER,
	CAR_NAME VARCHAR2(1000),
	CAR_BRAND VARCHAR2(1000),
	CAR_RELEASE_DATE DATE,
	CAR_COLOR VARCHAR2(1000),
	CAR_PRICE NUMBER
);

SELECT * FROM TBL_CAR;

-- TBL_CAR 테이블은 6개의 컬럼을 가지고 있다
-- PK ? 중복X, NULLX => CAR_NUMBER

ALTER TABLE TBL_CAR ADD CONSTRAINT PK_CAR PRIMARY KEY(CAR_NUMBER);
/*ALTER TABLE TBL_CAR : TBL_CAR 테이블을 수정하겠다
 * ADD : 추가한다
 * CONSTRAINT	제약조건
 * PK_CAR	이름으로
 * PRIMARY KEY(CAR_NUMBER) PK 제약조건을 (CAR_NUMBER) 컬럼에
 * 
 * PK_CAR 이름으로 PK제약조건을 CAR_NUMBER 컬럼에 추가하여 테이블을 수정하겠다
 * 
 * */

SELECT * FROM TBL_CAR;

-- DML
INSERT INTO TBL_CAR(CAR_NUMBER, CAR_BRAND)
--VALUES(1, 'KIA');
--VALUES(2, 'BWM'); -- PK 제약조건 설정된 컬럼은 중복값을 허용하지 않는다
VALUES(3, 'BWM');

INSERT INTO TBL_CAR
--VALUES(NULL, NULL, NULL, NULL, NULL, NULL); -- PK 제약조건 설정된 컬럼믕 NULL을 허용하지 않는다

-- 학교 테이블과 학생 테이블 생성
-- 학교테이블
-- 학교번호 (PK)
-- 학교명

-- 학생테이블
-- 학생번호 (PK)
-- 학생이름
-- 학생나이
-- 학교명

CREATE TABLE TBL_SCHOOL(
--	SCHOOL_NUMBER NUMBER CONSTRAINT PK_SCHOOL PRIMARY KEY, 가능하나 아래쪽에 작성한다
	SCHOOL_NUMBER NUMBER,
	SCHOOL_NAME VARCHAR2(100),
	CONSTRAINT PK_SCHOOL PRIMARY KEY(SCHOOL_NUMBER)
);

SELECT * FROM TBL_SCHOOL;
DROP TABLE TBL_STUDENT ;
DROP TABLE TBL_SCHOOL ;

CREATE TABLE TBL_STUDENT(
	STUDENT_NUMBER NUMBER,
	STUDENT_NAME VARCHAR2(100),
	STUDENT_AGE NUMBER,
	SCHOOL_NUMBER NUMBER, --PK와 FK의 타입 일치해야 함.
	CONSTRAINT PK_STUDENT PRIMARY KEY(STUDENT_NUMBER),
	CONSTRAINT FK_STUDENT FOREIGN KEY(SCHOOL_NUMBER) REFERENCES TBL_SCHOOL(SCHOOL_NUMBER)
);

SELECT * FROM TBL_STUDENT;
INSERT INTO TBL_SCHOOL
VALUES(1, '코리아중학교');

INSERT INTO TBL_STUDENT
VALUES(1, '짱구', 15, '코리아중학교');






