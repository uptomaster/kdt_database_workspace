-- 2번 : 연산자
-- 피연산자 자리에 어떤 타입의 값이 오는지
-- 연산자가 어떻게 동작하는지
-- 연산의 결과가 어떤 타입의 값인지

-- 자료형 : 문자형(CHAR, VARCAHR2), 숫자형(NUMBER), 날짜(DATE, TIMESTAMP)

-- (1) 연결연산자
-- a || b : a와 b를 연결해준다
-- dual 테이블 : 다른 테이블을 참조할 필요 없이 값을 확인하고 싶을 떄 사용할 수 있는 오라클의 기본 테이블
SELECT 10, 20, 10 || 20
FROM dual;

SELECT 'a',
	'b',
	'a' || 'b'
FROM dual;

-- employees 테이블에서 이름과 성을 연결해서 이름이라는 별칭으로 조회
SELECT first_name || ' ' || last_name 이름
FROM employees;

-- 날짜 타입의 값 확인 => 결과는 문자자료형으로 나온다
SELECT
	hire_date || ' 안녕!'
FROM
	employees;

/* 실습
 * 사원의 이름과 메일주소를 출력하기
 * 이 때 이름은 이름과 성이 띄어쓰기로 이어져서 이름이라는 컬럼명으로 있고
 * 메일 주소는 사원메일주소@koreait.com으로 메일 주소 라는 컬럼명이 있다
 */
SELECT first_name || ' ' || last_name 이름,
	email || '@koreait.com' "메일 주소"
		-- 2) first_name과 last_name 연결해서 이름이라는 별칭, email에 @koreait.com 연결해서 조회하겠다
FROM employees;								-- 1) employees 테이블에서

-- (2) 산술연산자
-- 숫자 타입 산술연산의 결과 => 숫자 타입
SELECT employee_id, employee_id + 10, employee_id - 10,
	employee_id * 10, employee_id / 10
FROM employees;

-- 날짜타입과 산술연산
-- 날짜와 숫자 => 결과는 날짜 타입(~일 수, ~일 전으로 나온다)
SELECT hire_date,
	hire_date + 10,
	hire_date - 10
FROM employees;

-- 날짜와 날짜
SELECT sysdate
FROM dual;

-- 날짜 - 날짜 => 며칠이 지났는지 결과로 나온다(숫자 타입)
SELECT hire_date,
	sysdate,
	sysdate - hire_date
FROM employees;


-- 날짜 - 날짜만 가능하다 결과타입은 숫자로 나온다
SELECT sysdate,
	to_date('2025-12-24', 'yyyy-mm-dd'),
-- '2025-12-24' - sysdate  문자 - 날짜 데이터타입 뺄 수 없다
	to_date('2025-12-24', 'yyyy-mm-dd') - sysdate
FROM dual;

-- 날짜 + 날짜 => 오류 발생
-- 날짜와 숫자의 연산에서 기본적으로 숫자는 일 수를 의미하기 때문에 시간, 분 단위로 연산하고 싶다면
-- 일(24h)로 환산해야 한다

SELECT sysdate, 
	sysdate + 0.5,
	sysdate - 0.5
	-- 12/24	-- 12시간
	-- 1/24		-- 1시간
	-- 30/60/24	-- 30분
FROM dual;

SELECT
	sysdate "현재 시간",
	sysdate - 0.5 "12시간 전",
	sysdate + 0.5 "12시간 후",
	sysdate + 1/24	"1시간 후", -- 1/24 0.0416
	sysdate + 0.1	"0.1ㅎㅎ", -- 1/10 0.1
	sysdate + 30/60/24	"30분 후"
FROM dual;



