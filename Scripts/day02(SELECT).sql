-- 1번 : SELECT

-- SELECT 컬럼명 FROM 테이블명;
-- 해당 테이블에서 특정 컬럼을 선택해서 조회하겠다는 의미
-- 컬럼명 자리에 *를 쓰면 모든 컬럼을 의미
SELECT * FROM EMPLOYEES;
--해석 : EMPLOYEES 테이블에서 모든 컬럼을 조회하겠다

-- HR.테이블명 작성하는 이유는 여러 계정의 같은 이름의 테이블 이름이 존재할 수 있기 때문이다
-- 지금 로그인한 계정의 테이블의 우선순위가 높기 때무에 일반적으로 계정명은 생략이 가능하다
SELECT first_name FROM employees;
SELECT first_name FROM hr.EMPLOYEES;
-- 해석 : HR 계정에 있는 employees 테이블에서 first_name 컬럼을 조회하겠다

-- 두 개의 결과는 다르다(select 뒤에 작성된 컬럼명대로 Result 테이블에 표시된다)
-- 컬럼 조회 시 순서가 중요하다
SELECT first_name, last_name
FROM employees;

SELECT last_name, first_name
FROM employees;
-- 해석 : employees 테이블에서 LAST_NAME, FIRST_NAME 컬럼을 조회하겠다

-- 정렬해서 조회하기
-- SELECT 컬럼명 FROM 테이블명 ORDER BY 컬럼명 [ASC or DESC];

-- employees 테이블에서 사원의 이름(FIRST_NAME), 성(LAST_NAME), 급여(SALARY)를
-- 급여 낮은 순서부터(오름차순) 조회하기
SELECT * FROM employees;

SELECT first_name, last_name, salary --2) FIRST_NAME, LAST_NAME, SALARY컬럼을 조회할거야
FROM employees						--1) EMPLOYEES 테이블에서
ORDER BY salary;					--3) SALARY 컬럼을 오름차순으로 정렬해서

-- ORDER BY에 ASC나 DESC를 쓰지 않으면 기본 오름차순(ASC) 정렬
-- 오름차순 정렬 ASC(Asceding) : 앞글자 3글자만 따서 ASC로 사용한다
-- 내림차순 정렬 DESC(Descending) : 앞글자 4글자만 따서 DESC로 사용한다

SELECT first_name, last_name, salary	--2) first_name, last_name, salary 컬럼을 조회할거야
FROM employees							--1) employees 테이블에서
ORDER BY salary DESC;					--3) salary 컬럼을 내림차순으로 정렬해서

SELECT * FROM EMPLOYEES;
-- 문자의 정렬 (first_name) ASC로 정렬 시 a -> z 까지 순서대로 정렬, DESC로 정렬 시 z - a까지 순서대로 정렬
SELECT first_name
FROM employees
ORDER BY first_name ASC;

-- 날짜의 정렬(hire_date) ASC로 정렬 시 예전 날짜부터 최신날짜 순으로 정렬, DESC로 정렬 시 최신 날짜부터 과거 날짜 순으로 정렬
SELECT hire_date
FROM employees
ORDER BY hire_date ASC;

-- ORDER BY절의 컬럼명은 조회하는 컬럼명과 반드시 일치하지 않아도 가능하다
-- 해당 테이블에 있는 컬럼이라면 다른 컬럼명으로 정렬해도 무방하다
SELECT * FROM employees;

-- 조회할 컬럼 : EMPLOYEE_ID, 정렬할 컬럼 : SALARY
SELECT employee_id
FROM employees
order BY salary;

SELECT employee_id, salary	--2) EMPLOYEE_ID와 SALARY 컬럼을 조회하겠다
FROM EMPLOYEES				--1) EMPLOYEES 테이블에서
ORDER BY salary ASC;		--3) SALARY 컬럼의 오름차순 정렬로

-- 2개의 정렬기준
-- 첫 번째 작성한 컬럼의 값을 기준으로 잡아 정렬하고 해당 컬럼의 값이 동일하다면
-- 2차적으로 그 다음 컬럼값을 기준으로 정렬한다

-- EMPLOYEES 테이블에서 FIRST_NAME, SALARY, JOB_ID 컬럼 조회하는데
-- SALARY를 기준으로 내림차순 정렬, FIRST_NAME 오름차순 정렬
SELECT FIRST_NAME, SALARY, JOB_ID
FROM EMPLOYEES
ORDER BY SALARY DESC, FIRST_NAME ASC;

-- 사원테이블에서 직무 ID
SELECT job_id
FROM employees;

-- 직무의 종류를 확인하기 위해 중복 행 제거
-- DISTINCT : 해당 컬럼의 중복되는 값을 제외시킨다
-- SELECT [DISTINCT]컬럼명
-- FROM 테이블명
-- ORDER BY 정렬할컬럼명 [ASC or DESC];

SELECT DISTINCT job_id	--2) job_id 컬럼을 중복 제거하고 조회할거다
FROM employees;			--1) employees 테이블에서
-- 결과 19행

-- 컬럼을 여러개 넣으면 DINSTINCT는 어떻게 작동할까?
SELECT DISTINCT job_id, hire_date
FROM employees;
--105행

-- 별칭 붙여 조회하기
SELECT first_name AS "이름"
FROM employees;

SELECT first_name AS "이름", LAST_name AS "성", employee_id AS "사원 번호"
FROM employees;

-- AS 키워드 생략 가능
-- "" 생략 가능(단, 별칭에 띄어쓰기 포함되어 있으면 ""는 생략 불가능)
SELECT first_name "이름", last_name 성, employee_id "사원 번호"
FROM employees;

-- 사원의 이름, 성, 봉급을 조회하는데 봉급 내림차순으로 별칭사용하여 조회하기
-- 쿼리문 작성 시 순서	1) SELECT 조회할 컬럼 생각 -> 별칭 부여 2) FROM 테이블 생각 3) ORDER BY 정렬 생각
-- 쿼리문 실행 순서		FROM -> SELECT -> ORDER BY
SELECT first_name "이름", last_name "성", salary "봉급"
--2) first_name 컬럼은 이름이라는 별칭으로, last_name 컬럼은 성이라는 별칭으로,
--	salary 컬럼은 봉급이라는 별칭으로 조회할거야
FROM EMPLOYEES		-- 1) employees 테이블에서
ORDER BY 봉급 DESC;	-- 3) 봉급이라는 별칭으로 내림차순 정렬해서





