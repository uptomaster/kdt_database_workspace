-- 4번 : 연산자 실습

/*	이름은 이름과 성을 뜨이쓰기 포함하여 연결
 * 
 * [연습] 모든 직원의 이름, 급여 연봉, 출력하기
 * 
 * 
 */



SELECT * FROM employees;
SELECT first_name || ' ' || last_name 이름,
	salary 급여,
	salary * 12 연봉
FROM employees;


/*
 * 1. 모든 직원의 이름, 급여, 커미션, 커미션을 포함한 연봉을 총 보상이라는 이름으로 출력
 * 단, 커미션이 NULL인 경우 0으로 처리할 것
 * 
 * 2. 직원번호와 이메일을 연결해서 직원번호_이메일이라는 멸칭으로 출력하기
 * 조회할 컬럼명 : 직원번호, 이메일, 급여
 * 
 * 3. 급여가 7000 초과인 직원의 이름과 급여 출력하기
 * 
 * 4. 부서번호가 50 또는 80 번이 아닌 직원들만 출력하기
 * 
 * 5. 급여가 4000이상 7500 이하인 직원들 조회하기
 * 기본 조회할 컬럼명 : 직원번호, 이름, 급여, 입사일
 * 
 * 6. 직무 ID가 IT_PROG, SA_REP, SA_MAN인 직원만 호회하기
 * 
 * 7. 커미션을 받는 직원만 조회하기
 * 
 * 8. 이름에 D와 e가 포함되는 직원들만 조회하기
 * 
 * 9. 직무ID가 IP_PROG가 아닌 직원만 조회하기
 * 
 * */

--1)
SELECT FIRST_name || ' ' || LAST_name 이름, salary 급여, commission_pct 커미션,
	salary * 12 + SALARY * 12 * NVL2(COMMISSION_PCT, COMMISSION_PCT , 0) "총 보상"
FROM employees;
loyees;
SELECT 
first_name || ' ' || last_name 이름, 
salary 급여, 
commission_pct,
SALARY * 12 * NVL2(commission_pct,COMMISSION_PCT,0) "총 보상" 
FROM EMPLOYEES;
--2)
SELECT EMPLOYEE_ID || '_' || EMAIL 직원번호_이메일, salary 급여
FROM employees;
--3)
SELECT FIRST_name || ' ' || LAST_name 이름, salary 급여
FROM EMPLOYEES
WHERE salary > 7000;
--4)
SELECT FIRST_name || ' ' || LAST_name 이름, salary 급여
FROM employees
WHERE DEPARTMENT_ID NOT in(50, 80);
--5)
SELECT FIRST_name || ' ' || LAST_name 이름, salary 급여
FROM employees
WHERE salary >= 4000 OR salary <= 7500;
--6)
SELECT FIRST_name || ' ' || LAST_name 이름, salary 급여
FROM employees
WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'SA_REP' or JOB_ID = 'SA_MAN';
--7)
SELECT FIRST_name || ' ' || LAST_name 이름, salary 급여
FROM employees
WHERE COMMISSION_PCT IS NOT null;
--8)
SELECT FIRST_name || ' ' || LAST_name 이름, salary 급여
FROM employees
WHERE FIRST_name || ' ' || LAST_name LIKE '%D%e%';
--9)
SELECT FIRST_name || ' ' || LAST_name 이름, salary 급여
FROM employees
WHERE JOB_ID <> 'IP_PROG';








