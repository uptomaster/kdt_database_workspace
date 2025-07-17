-- 3번 : 서브쿼리 실습
-- 연관, 비연관, 단일행, 다중행 => 어떤 서브쿼리 유형인지 파악
-- SELECT, FROM, WHERE 서브쿼리를 배웠음. => 어디에 서브쿼리를 쓸지 파악
-- 연산자까지 같이 사용하기. => 어떤 연산자를 쓸지 파악
-- 쿼리를 메인쿼리와 서브쿼리로 나눠 작성 => 행이 더 많은쪽이 메인쿼리다.
-- 서브쿼리가 메인쿼리를 참조하면 연관/참조하지 않으면 비연관


-- 1. 전체 직원 중 급여가 가장 높은 직원의 이름과 급여를 구하기.
-- 비연관, 단일행, WHERE서브쿼리
SELECT MAX(SALARY) FROM EMPLOYEES -- 1개행 -> 서브쿼리로 이동

SELECT FIRST_NAME, SALARY 
FROM EMPLOYEES -- 107개 행 -> 메인쿼리

SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES);

-- 2. 전체 평균급여보다 많이 받는 직원의 이름과 급여를 조회하기.
-- 우선 전체 평균급여를 구한다.
SELECT AVG(SALARY) 
FROM EMPLOYEES; -- 1행 => 서브쿼리

-- 이름과 급여를 조회
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES; -- 107행 => 메인쿼리

-- 메인쿼리와 서브쿼리를 조합하기
-- 2번문제 최종 : 단일행, WHERE 서브쿼리, 비연관
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) 
FROM EMPLOYEES); -- 51행

-- 3. IT 부서에 소속된 직원의 이름과 부서ID, 급여 조회하기.

-- 이름과 부서ID, 급여 조회하기
SELECT FIRST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES -- 107행 -> 메인쿼리

-- IT부서 찾아보기
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT' -- 1행 -> 서브쿼리

-- 3번문제 최종
-- 메인쿼리와 서브쿼리 합치기
-- 비연관, 단일행, SELECT 서브쿼리
-- SELECT절에 서브쿼리를 쓰면 원하는 결과 안나옴 -> FROM절에 작성
SELECT FIRST_NAME 이름, E.DEPARTMENT_ID 부서, SALARY 연봉, (SELECT DEPARTMENT_ID
	FROM DEPARTMENTS D
	WHERE D.DEPARTMENT_NAME = 'IT') IT부서번호
FROM EMPLOYEES E


-- 4. ST_CLERK 직무를 가진 직원의 급여 평균 조회하기.
-- JOB_ID 컬럼에서 찾아야함
-- 직무먼저찾기

SELECT AVG(SALARY) 연봉
FROM EMPLOYEES
WHERE JOB_ID = 'ST_CLERK';



-- 5. 부서별 최대 급여를 받는 직원들의 이름과 급여, 부서ID 조회
-- 최대급여 먼저찾기
SELECT MAX(SALARY)
FROM EMPLOYEES

-- 부서별 최대 급여 찾기
-- 다중행, WHERE 서브쿼리, 연관
SELECT DEPARTMENT_ID 부서, SALARY 급여` 
FROM EMPLOYEES E
WHERE SALARY = (SELECT MAX(SALARY)
	FROM EMPLOYEES
	WHERE DEPARTMENT_ID  = E.DEPARTMENT_ID
	)


-- 6. 부서가 존재하지 않는 직원 조회
	
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL

-- 연관서브쿼리(NOT EXISTS)
SELECT E.EMPLOYEE_ID
FROM EMPLOYEES E
WHERE NOT EXISTS(SELECT 1
	FROM DEPARTMENTS D
	WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID);



-- 7. 급여가 평균보다 높은 직원들 중 SA_REP 직무를 가진 사람만 조회하기.
-- 우선 평균 급여 찾기
SELECT AVG(SALARY)
	FROM EMPLOYEES -- 6461
-- SA_REP 직무를 가진 사람 조회하기
SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID = 'SA_REP'

-- 최종 결과 찾기
--
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = 'SA_REP' AND SALARY > (SELECT AVG(SALARY)
	FROM EMPLOYEES)


	 
-- 8. 평균 급여보다 낮은 사원들의 급여를 20% (* 1.2) 인상한 결과 테이블 조회
-- 직원번호, 이름, 급여, 인상급여 조회

-- 평균 급여찾기 먼저하기
SELECT AVG(SALARY)
	FROM EMPLOYEES -- 6461

-- 단일행, WHERE 서브쿼리, 비연관
SELECT EMPLOYEE_ID 직원번호, FIRST_NAME 직원이름, SALARY 급여, SALARY*1.2 인상급여
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY)
	FROM EMPLOYEES)
