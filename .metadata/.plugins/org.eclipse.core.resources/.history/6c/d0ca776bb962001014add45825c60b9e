-- 실습

-- 1. 
-- 학생 정보 테이블(정규화되지 않은 일반 테이블)
/*
 * 학번(Stu_id)   이름(stu_name) 전공(stu_major) 과목코드(stu_course_code) 과목명(stu_course_name)
 * 001         홍길동         컴공            cs101               데이터베이스
 * 001         홍길동         컴공            cs202               알고리즘
 * 002         김철수         경영학         bus202               경영이론
 * 
 * */

--1. 요구사항분석
대학생의 정보들을 담고자 한다. 
학생의 정보에는 학번, 이름, 전공, 과목코드, 과목명이 필요하다.
한 학생은 여러 과목을 들을 수 있으며 
한 과목은 여러 학생이 수강할 수 있다.

--2. 개념적설계
학생 엔티티
학번
이름
전공
과목코드
과목명

학생을 식별하는 기본 식별자로는 학번을 사용하는 것이 좋다.
학번을 PK로 사용한다.

학생의 정보를 담은 학번,이름,전공과
과목의 정보를 담은 과목코드, 과목명을 따로 분리하는 것이 좋다.

또한, 한 학생은 여러 과목을 들을 수 있으며 
한 과목은 여러 학생이 수강할 수 있다고 했었는데,
서로의 관점에서 봤을 때 다대다 관계가 성립하므로
중간테이블의 역할이 필요함을 알 수 있다. 


--3. 논리적설계(정규화)


따라서 원래 하나의 테이블이었던 학생 테이블을
학생 테이블과 과목 테이블 두개로 나눈다.

학생 테이블과 과목 테이블은 다대다 관계가 성립하므로 이를 해소하기 위해 중간 테이블을 하나 만든다.
중간 테이블의 역할은 학생의 PK와 과목의 PK를 FK로 받아서 학생테이블과 과목테이블에 뿌려주는 역할을 한다.
따라서 중간 테이블은 학번과 과목번호를 컬럼으로 가지는 수강신청테이블의 역할을 한다.
그리고 수강신청테이블의 PK는 학번과 과목번호를 조합하여 복합키로 만들어서 사용한다.
그 이유는, 학생1이 과목1과 과목2를 들을 수도 있으며
학생2가 과목1과 과목2를 들을 수 있는 것처럼 서로 다대다 관계를 가지기 때문이다.

학생 테이블의 기본 식별자로는 학번을 그대로 사용한다.
과목 테이블의 기본 식별자로는 새로운 컬럼을 하나 만들어서 => 과목번호를 만들어서 새로운 PK로 사용한다.

학생						과목					수강신청테이블
--------------------------------------------------------------------------------------------
학번(PK)[정수형]			과목번호(PK)[정수형]		학번(FK)	    => 학번,과목번호를 복합키로 묶어서 PK로 사용함.
이름[문자열]				과목코드[문자열]			과목번호(FK)
전공[문자열]				과목명[문자열]


-- 정규화 진행시 테이블 만들고 값 5개씩 넣기

--4. 물리적설계
학생 테이블의 이름 : TBL_STU
학번 (PK) : STU_ID
학생 이름 : STU_NAME
학생 전공 : STU_MAJOR

과목 테이블의 이름 : TBL_SUBJECT
과목번호 (PK) : SUBJECT_ID
과목코드 : SUBJECT_CODE
과목명 : SUBJECT_NAME

수강정보 테이블의 이름 : TBL_INFO
수강정보 테이블의 PK : (STU_ID,SUBJECT_ID)

TBL_STU								TBL_SUBJECT							TBL_INFO => (STU_ID,SUBJECT_ID)(PK) => PK_INFO라는 제한조건명
--------------------------------------------------------------------------------------------
STU_ID(PK)[NUMBER]					SUBJECT_ID(PK)[NUMBER]				STU_ID(FK)[NUMBER]	
STU_NAME(NOT NULL)[VARCHAR2(100)]	SUBJECT_CODE[VARCHAR2(100)]			SUBJECT_ID(FK)[NUMBER]	
STU_MAJOR(NOT NULL)[VARCHAR2(100)]	SUBJECT_NAME(NOT NULL)[VARCHAR2(100)]

--5. 구현
DROP TABLE TBL_STU;
DROP TABLE TBL_SUBJECT;
DROP TABLE TBL_INFO;


CREATE TABLE TBL_STU(
	STU_ID NUMBER,
	STU_NAME VARCHAR2(100),
	STU_MAJOR VARCHAR2(100),
	--PK 제한조건 설정
	CONSTRAINT PK_STU PRIMARY KEY(STU_ID)
);

CREATE TABLE TBL_SUBJECT(
	SUBJECT_ID NUMBER,
	SUBJECT_CODE VARCHAR2(100),
	SUBJECT_NAME VARCHAR2(100),
	CONSTRAINT PK_SUBJECT PRIMARY KEY(SUBJECT_ID)
);

CREATE TABLE TBL_INFO(
	STU_ID NUMBER,
	SUBJECT_ID NUMBER,
	-- PK 제한조건 설정
	CONSTRAINT PK_INFO PRIMARY KEY(STU_ID, SUBJECT_ID),
	-- FK 제한조건 설정
	CONSTRAINT FK_STU_ID FOREIGN KEY(STU_ID) REFERENCES TBL_STU(STU_ID),
	CONSTRAINT FK_SUBJECT_ID FOREIGN KEY(SUBJECT_ID) REFERENCES TBL_SUBJECT(SUBJECT_ID)
);

SELECT * FROM TBL_INFO;
SELECT * FROM TBL_STU;
SELECT * FROM TBL_SUBJECT;


-- 학생 테이블에 데이터 추가
INSERT INTO TBL_STU 
VALUES(001, '이남혁', '컴퓨터공학과');

INSERT INTO TBL_STU 
VALUES(002, '강버들', '컴퓨터공학과');

INSERT INTO TBL_STU 
VALUES(003, '박건아', '조리학과');

INSERT INTO TBL_STU 
VALUES(004, '전보라', '보안학과');

INSERT INTO TBL_STU 
VALUES(005, '김기수', '경영학과');


SELECT * FROM TBL_INFO;
SELECT * FROM TBL_STU;
SELECT * FROM TBL_SUBJECT;

-- 과목 테이블에 데이터 추가
INSERT INTO TBL_SUBJECT
VALUES(1, 'A1', '데이터통계');

INSERT INTO TBL_SUBJECT
VALUES(2, 'A2', '알고리즘');

INSERT INTO TBL_SUBJECT
VALUES(7, 'D1', '자바');

INSERT INTO TBL_SUBJECT
VALUES(8, 'D2', 'C++');

INSERT INTO TBL_SUBJECT
VALUES(11, 'E1', '정보보안학');

--수강신청테이블에 데이터 추가
INSERT INTO TBL_INFO
VALUES(001,1); -- 이남혁 데이터통계 수강신청
INSERT INTO TBL_INFO
VALUES(001,11); -- 이남혁 정보보안학 수강신청
INSERT INTO TBL_INFO
VALUES(002,1); -- 강버들 데이터통계 수강신청
INSERT INTO TBL_INFO
VALUES(003,2); -- 박건아 알고리즘 수강신청
INSERT INTO TBL_INFO
VALUES(004,7); -- 전보라 자바 수강신청
INSERT INTO TBL_INFO
VALUES(004,11); -- 전보라 정보보안학 수강신청


















