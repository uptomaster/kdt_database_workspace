--1번 : 정규화

-- 학생 정보 테이블
/*
 * 학번(Stu_id)   이름(stu_name) 전공(stu_major) 	과목코드(stu_course_code) 과목명(stu_course_name)
 * 001         	홍길동         컴공           	 	cs101             	 데이터베이스
 * 001         	홍길동         컴공            		cs202             	 알고리즘
 * 002         	김철수         경영학           	bus202             	 경영이론
 * 
 * */
-- 다대다 관계에서는 중간테이블이 반드시 필요하다. => 테이블끼리는 1대1 또는 1대N관계여야만 함.

-- 학생 정보 테이블 생성
CREATE TABLE TBL_STU(
	STU_ID NUMBER,
	STU_NAME VARCHAR2(100),
	STU_MAJOR VARCHAR2(100),
	STU_COURSE_CODE VARCHAR2(100),
	STU_COURSE_NAME VARCHAR2(100)
);

-- 테이블 조회
SELECT * FROM TBL_STU;

-- PK 제약조건 추가
ALTER TABLE TBL_STU 
ADD CONSTRAINT PK_STU PRIMARY KEY(STU_ID);

-- 데이터 삽입
INSERT INTO TBL_STU 
VALUES(001, '홍길동', '컴퓨터 공학', 'CS101', '데이터베이스');
--VALUE(001, '홍길동', '컴퓨터 공학', 'CS101', '데이터베이스');

INSERT INTO TBL_STU
VALUES(002, '김철수', '경영학', 'BUS202', '경영이론');

-- 데이터 삽입 후 반드시 테이블 조회
SELECT * FROM TBL_STU;

-- 특정 학번의 학생 정보 조회(학번 2)
SELECT * FROM TBL_STU
WHERE STU_ID = 2;

-- 특정 과목명에 해당하는 학생 정보조회(과목명 데이터베이스)
SELECT * FROM TBL_STU
WHERE STU_COURSE_NAME = '데이터베이스';

-- 학번 2인 학생의 전공을 데이터사이언스로 변경
UPDATE TBL_STU
SET STU_MAJOR = '데이터사이언스'
WHERE STU_ID = 2;

UPDATE TBL_STU
SET STU_MAJOR = '컴퓨터공학과'
WHERE STU_ID = 1;

-- 변경된 결과만 확인
SELECT * FROM TBL_STU;

-- 컬럼 추가 STU_ADDRESS VARCHAR2(100)
ALTER TABLE TBL_STU 
ADD STU_ADDRESS VARCHAR2(100);

-- 결과 확인
SELECT * FROM TBL_STU;

-- 1번 학생의 주소를 서울시 강남구 역삼동, 12345로 입력
-- 컬럼값 수정
UPDATE TBL_STU
SET STU_ADDRESS = '서울시 강남구 역삼동, 12345'
WHERE STU_ID = 1;

SELECT * FROM TBL_STU;

INSERT INTO TBL_STU 
VALUES(3, '홍길동', '컴퓨터공학과', 'CS202', '알고리즘', '서울시 강남구 역삼동, 12345');

SELECT * FROM TBL_STU;

-- 1차정규화 : 원자값, 반복제거
-- 원자값이 잘못된 부분은 주소.

-- 학생 정보 테이블 : 학번(PK), 이름, 전공, 주소
CREATE TABLE TBL_STU_1NF(
	STU_ID NUMBER,
	STU_NAME VARCHAR2(100),
	STU_MAJOR VARCHAR2(100),
	STU_ADDRESS VARCHAR2(100)
);

SELECT * FROM TBL_STU_1NF;

-- 과목 테이블 : 과목번호(PK), 과목코드, 과목명

CREATE TABLE TBL_SUBJECT_1NF(
	SUBJECT_ID NUMBER,
	SUBJECT_CODE VARCHAR2(100),
	SUBJECT_NAME VARCHAR2(100)
);

DROP TABLE TBL_STU_1NF;

SELECT * FROM TBL_SUBJECT_1NF;

SELECT * FROM TBL_STU;

INSERT INTO TBL_STU_1NF
VALUES(1, '홍길동', '컴퓨터공학과', '서울시 강남구 역삼동, 1234');

INSERT INTO TBL_STU_1NF
VALUES(2, '김철수', '데이터사이언스학과', '서울시 송파구 잠실동, 2345');

SELECT * FROM TBL_STU_1NF;

INSERT INTO TBL_SUBJECT_1NF
VALUES(1, 'CS101', '데이터베이스');

INSERT INTO TBL_SUBJECT_1NF
VALUES(2, 'BUS202', '경영이론');

INSERT INTO TBL_SUBJECT_1NF
VALUES(3, 'CS202', '알고리즘');

SELECT * FROM TBL_SUBJECT_1NF;

-- 각 테이블에 PK, FK 설정

-- STU
ALTER TABLE TBL_STU_1NF 
ADD CONSTRAINT PK_ID PRIMARY KEY(STU_ID); 

-- SUBJECT
ALTER TABLE TBL_SUBJECT_1NF 
ADD CONSTRAINT PK_SUB_ID PRIMARY KEY(SUBJECT_ID); 

-- 1차 정규화 (중복제거만)완료, 원자값 문제 여전히 있음.
-- 학생테이블 : 학번(PK), 이름, 전공, 주소
-- 과목테이블 : 과목번호(PK), 과목코드, 과목명

SELECT * FROM TBL_STU_1NF;
SELECT * FROM TBL_SUBJECT_1NF;

-- 1차 정규화 - 원자값으로 만들기.
DROP TABLE TBL_STU_1NF;

CREATE TABLE TBL_STU_1NF(
	STU_ID NUMBER,
	STU_NAME VARCHAR2(100),
	STU_MAJOR VARCHAR2(100),
	STU_ADDRESS_CODE NUMBER,
	STU_ADDRESS VARCHAR2(100),
	CONSTRAINT PK_STU_1NF PRIMARY KEY(STU_ID)
);

SELECT * FROM TBL_STU_1NF;

INSERT INTO TBL_STU_1NF
VALUES(1, '홍길동', '컴퓨터공학과', 1234, '서울시 강남구 역삼동');

INSERT INTO TBL_STU_1NF
VALUES(2, '김철수', '데이터사이언스학과', 2345, '서울시 송파구 잠실동');

SELECT * FROM TBL_STU_1NF;
SELECT * FROM TBL_SUBJECT_1NF;

-- 학생테이블과 과목테이블을 분리했음. 이제 관계가 형성되었고, FK를 생각해야함.
-- 학생테이블 기준 : 한 명의 학생은 여러 과목을 수강할 수 있다.
-- 과목테이블 기준 : 하나의 과목은 여러 학생이 들을 수 있다.
-- 따라서 두 테이블은 다대다 관계이다. (N:M) -> 중간 테이블이 필요하다.
SELECT * FROM TBL_STU

-- 수강테이블  TBL_ENROLL_2NF
-- 학번(FK)과 과목번호(FK)를 조합키로 사용해서 기본키로 이용한다. => 부분 종속성 제거1
CREATE TABLE TBL_ENROLL_2NF(
   STU_ID NUMBER,
   SUBJECT_ID NUMBER,
   CONSTRAINT PK_ENROLL PRIMARY KEY(STU_ID, SUBJECT_ID),
   CONSTRAINT FK_ENROLL_STU FOREIGN KEY(STU_ID) REFERENCES TBL_STU_1NF(STU_ID),
   CONSTRAINT FK_ENROLL_SUBJECT FOREIGN KEY(SUBJECT_ID) REFERENCES TBL_SUBJECT_1NF(SUBJECT_ID)
);

SELECT * FROM TBL_ENROLL_2NF;

INSERT INTO TBL_ENROLL_2NF
VALUES(1,1);

INSERT INTO TBL_ENROLL_2NF
VALUES(1,2);

INSERT INTO TBL_ENROLL_2NF
VALUES(2,1);

INSERT INTO TBL_ENROLL_2NF
VALUES(2,2);

SELECT * FROM TBL_ENROLL_2NF;

-- 2차 정규화(부분종속제거)
-- 조합키를 가진 테이블에서 일부키에만 종속되는 컬럼이 있을 경우 분리.
-- 현재는 이미 중간테이블로 분리했기 때문에 2차 정규화까지 완료된 상태이다.
-- TBL_ENROLL_2NF는 복합키만 있고, 다른 종속되는 컬럼이 존재하지 않음.
-- TBL_STU_1NF와 TBL_SUBJECT_1NF는 단일 PK기준으로 종속 문제 없음.
----------------------------------------------------------

--3차 정규화(이행종속제거)
--PK가 아닌 다른 컬럼에 종속되는 컬럼이 존재시 제거해야 한다.

SELECT * FROM TBL_STU_1NF;
SELECT * FROM TBL_SUBJECT_1NF;
SELECT * FROM TBL_ENROLL_2NF;

-- 하나의 컬럼으로만 PK를 설정할 수 없을 때 복합키를 사용한다.
-- 학생정보테이블과 주소테이블로 분리.
CREATE TABLE TBL_ADDRESS_3NF(
	ADDRESS_CODE NUMBER,
	ADDRESS_ADDR VARCHAR2(100),
	CONSTRAINT PK_ADDRESS PRIMARY KEY(ADDRESS_CODE)
);

CREATE TABLE TBL_STU_3NF(
	STU_ID NUMBER,
	STU_NAME VARCHAR2(100),
	STU_MAJOR VARCHAR2(100),
	STU_ADDRESS_CODE NUMBER,
	STU_ADDRESS_2 VARCHAR2(100),
	--PK
	CONSTRAINT PK_STU_3NF PRIMARY KEY(STU_ID),
	CONSTRAINT FK_STU_ADDRESS FOREIGN KEY(STU_ADDRESS_CODE) REFERENCES TBL_ADDRESS_3NF(ADDRESS_CODE)
);

SELECT * FROM TBL_STU_3NF; 

-- 최종 전체 구조 정리

-- 1. 주소테이블 TBL_ADDRESS_3NF
-- ADDRESS_CODE(PK), ADDRESS_ADDR(일반주소 시, 구, 동)

-- 2. 학생테이블 TBL_STU_3NF
-- STU_ID(PK), STU_NAME, STU_MAJOR, STU_ADDRESS_CODE(우편번호, FK), STU_ADDRESS2(상세주소)

-- 3. 과목테이블 TBL_SUBJECT
-- SUBJCET_ID(PK), SUBJECT_CODE, SUBJECT_NAME => PK는 조합키로도 고려가능함. SUBJECT_CODE 에만 PK도 고려가능

-- 4. 수강테이블(중간테이블) TBL_ENROLL_2NF
-- STU_ID(FK), SUBJECT_ID(FK) => 조합키 PK로 사용.


DROP TABLE TBL_ENROLL_2NF;
DROP TABLE TBL_STU_1NF;
DROP TABLE TBL_ADDRESS_3NF;
DROP TABLE TBL_SUBJECT_1NF;
DROP TABLE TBL_STU_3NF;





