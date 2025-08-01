-- 3번 : 서브쿼리 실습
-- 단일행, 다중행, 연관, 비연관   => 어떤 서브쿼리 유형인지
-- SELECT, FROM, WHERE 서브쿼리 => 서브쿼리를 어디에 쓸지
-- 연산자, 집계함수   => 어떤 연산자를 쓸지
-- 쿼리를 메인쿼리와 서브쿼리로 나눠서 작성

-- 1. 전체 직원 중 급여가 가장 높은 직원의 이름과 급여 조회
-- 단일행 / 비연관
-- WHERE
-- MAX()

SELECT MAX(SALARY) FROM EMPLOYEES; -- 1개행(서브쿼리)

SELECT FIRST_NAME, SALARY
FROM EMPLOYEES; -- 107행(메인쿼리)

SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES);

-- 2. 전체 평균급여보다 많이 받는 직원의 이름과 급여 조회
-- 서브쿼리 유형 : 단일행 / 비연관
-- 연산자 : >
-- 서브쿼리 위치 : WHERE

-- 평균급여 조회
SELECT AVG(SALARY)
FROM EMPLOYEES; -- 1개 행(서브쿼리)

-- 전체 직원 조회(이름, 급여)
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES; -- 107행(메인쿼리)

SELECT FIRST_NAME 이름, SALARY 급여
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

-- 3. IT 부서에 소속된 직원의 이름과 부서ID, 급여 조회
-- 서브쿼리 유형 : 다중행 / 비연관
-- 연산자 : IN
-- 서브쿼리 위치 : WHERE

-------------------------------------------------연습-------------------------------------
SELECT FIRST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;
-------------------------------------------------연습-------------------------------------

-- 서브쿼리 : IT = DEPARTMENT_NAME인 직원 조회
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT'; -- 1행(60번)

-- 메인쿼리
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES e;    -- 107행

-- 두개의 테이블이 다르므로 공통되는 컬럼을 찾아서 비교

SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN ( SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT');

--ORA-00913: too many values 
-- 하나의 값(1열)이 필요한 곳에서 여러 열 또는 행을 반환하는 서브쿼리를 넣었을때 발생하는 오류

--ORA-00905: missing keyword
-- SQL문에서 문법적으로 필수 키워드가 빠졌을 때 발생하는 오류

-- 4. ST_CLERK 직무를 가진 직원의 급여 평균 조회
-- 서브쿼리 유형 : 단일행 / 비연관
-- 연산자 =
-- 서브쿼리 위치 : 단독실행
SELECT AVG(SALARY)
FROM EMPLOYEES
WHERE JOB_ID = 'ST_CLERK';

-- 5. 부서별 최대 급여를 받는 직원들의 이름과 급여, 부서ID 조회
-- 서브쿼리 유형 : 다중행, 연관
-- 연산자 : =, MAX()
-- 서브쿼리 위치 : WHERE

-- 부서별 최대 급여
SELECT DEPARTMENT_ID, MAX(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; -- 12행

SELECT FIRST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES E
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES WHERE E.DEPARTMENT_ID = DEPARTMENT_ID);

-- 6. 부서가 존재하지 않는 직원 조회
-- 서브쿼리 유형 : 비연관 OR 연관
-- 연산자 : NOT IN OR NOT EXISTS
-- 서브쿼리 위치 : WHERE

-- 부서가 NULL인 직원만 찾는 것
-- 존재하지 않는 부서에 속한 직원은 걸러지지 않음(그런 부서에 속한 직원을 찾아야함!!)
-- EX ) EMPLOYEES 테이블에는 DEPARTMENT_ID = 190 이 있는데
-- DEPARTMENTS테이블에는 DEPARTMENT_ID = 190이 없는 경우 이 부서에 속한 직원을 찾는 것!!!
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES 
WHERE DEPARTMENT_ID IS NULL;

-- 비연관서브쿼리(NOT IN)
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID
FROM EMPLOYEES E
WHERE DEPARTMENT_ID NOT IN (SELECT D.DEPARTMENT_ID FROM DEPARTMENTS d)
   OR DEPARTMENT_ID IS NULL;

-- 연관서브쿼리(NOT EXISTS)
-- EXISTS() : 서브쿼리가 결과를 반환하면 TRUE, 없으면 FALSE
-- NOT EXISTS() : 서브쿼리가 결과를 반환하지 않는 경우만 TRUE
 
SELECT E.EMPLOYEE_ID 
FROM EMPLOYEES E
WHERE NOT EXISTS( SELECT 1 
         FROM DEPARTMENTS D 
         WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
);

SELECT E.EMPLOYEE_ID 
FROM EMPLOYEES E
WHERE NOT EXISTS( SELECT NULL
         FROM DEPARTMENTS D 
         WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
);

SELECT E.EMPLOYEE_ID 
FROM EMPLOYEES E
WHERE NOT EXISTS( SELECT D.DEPARTMENT_ID
         FROM DEPARTMENTS D 
         WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
);


-- 7. 급여가 평균보다 높은 직원들 중 SA_REP 직무를 가진 사람만 조회
-- 단일행, 비연관
-- AND, >, AVG()
-- WHERE

SELECT AVG(SALARY)
FROM EMPLOYEES;

SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID = 'SA_REP'
ORDER BY SALARY ;

SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) AND JOB_ID = 'SA_REP'
ORDER BY SALARY;

-- 8. 평균 급여보다 낮은 사원들의 급여를 20%( * 1.2) 인상한 결과 테이블 조회
--      직원번호, 이름, 급여, 인상급여

-- 단일행 / 비연관
-- 연산자 : <, * 1.2
-- WHERE
SELECT AVG(SALARY)
FROM EMPLOYEES; -- 6,461.831 (1행)

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY * 1.2 AS 인상급여
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);
-- 단일행에서 결과가 여러개 나오면 ORA-01427 : single-row subquery returns more than one row

-- 다중행은 서브쿼리에서 여러개의 결과를 반환할 수 있음
-- IN : 여러 값 중 포함 여부 판단
-- ANY : 하나라도 조건을 만족하면 TRUE
-- ALL : 전부 조건을 만족해야 TRUE

-- 연관 서브쿼리 : 메인쿼리의 컬럼 참조함
SELECT E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID
FROM EMPLOYEES E 
WHERE SALARY = (SELECT MAX(SALARY) 
         FROM EMPLOYEES 
         WHERE E.DEPARTMENT_ID = DEPARTMENT_ID);

-- 비연관 서브쿼리 : 메인쿼리의 어떤 컬럼도 참조하지 않음
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT FIRST_NAME
FROM EMPLOYEES 
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID   
   FROM DEPARTMENTS D
   WHERE D.LOCATION_ID = 1700
);

SELECT *
FROM DEPARTMENTS

SELECT EMPLOYEE_ID, SALARY
FROM EMPLOYEES E
WHERE SALARY > (SELECT AVG(SALARY) 
      FROM EMPLOYEES
      WHERE E.DEPARTMENT_ID = DEPARTMENT_ID);



