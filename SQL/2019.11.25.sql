-- 2019.11.25


-- CROSS JOIN : 테이블을 단순히 붙여준다.
-- JOIN -> 테이블을 집합으로 보고 집합의 곱 연산의 결과이다 -> N*M ( 결과 행이다 )
select *
from emp, dept
;

-- equi join
select *
from emp, dept
where emp.deptno=dept.deptno
;

-- 이름이 'SCOTT' 인 사원의 소속부서의 이름을 사원이름과 함께 출력하자
select ename, dname, d.deptno
from emp e, dept d
where e.deptno=d.deptno
    and ename='SCOTT'
;


select e.sal, s.losal, s.hisal, e.ename, s.grade
from emp e, salgrade s
where sal BETWEEN s.losal and s.hisal
order by s.grade
;

select mgr
from emp
where ename='SMITH'
;
select ename
from emp
where empno=7902;

select e1.ename, e2.ename, d.dname
from emp e1, emp e2, dept d
where e1.mgr=e2.empno and e1.deptno=d.deptno
order by e2.ename
;

select e.ename, m.ename
from emp e, emp m
where e.mgr=m.empno(+)
;


-- ANSI JOIN
-- CORSS JOIN
select * from emp, dept;
select * from emp cross join dept; -- mysql, ms-sq1, oracle

-- inner join
select * from emp e, dept d where e.deptno=d.deptno;
select * from emp e inner join dept d on e.deptno=d.deptno;
select * from emp inner join dept on emp.deptno=dept.deptno;

-- USING
select * from emp inner join dept using(deptno);
--                                on emp.deptno=dept.deptno

-- natural join
select * from emp NATURAL JOIN dept;

-- left|right|full outer join
select * from emp e, emp m where e.mgr=m.empno(+);
select * from emp e inner join emp m on e.mgr=m.empno;
select * from emp e left outer join emp m on e.mgr=m.empno;

select * from emp m right outer join emp e on e.mgr=m.empno;


select * from dept d, emp e where d.deptno=e.deptno(+);
select distinct(dname) from dept d, emp e where d.deptno=e.deptno(+);
select * from emp e, dept d where d.deptno=e.deptno(+);



-- 부속질의 : 쿼리 안에 쿼리 작성
-- select (부속질의) from (부속질의) where 컬럼 조건식 (부속질의)

-- emp 테이블에서 평균 급여보다 급여를 더 많이 받는 사원의 리스트를 출력
-- sal > 평균급여 <- 부속질의
select avg(sal) from emp ; -- 2074
select ename, sal from emp where sal > 2073.214285714285714285714285714285714286;

select *
from emp
where sal > (
    --select sal from emp where sal > 2000
    select avg(sal) from emp
)
;

-- 다중행 조건
-- 3000 이상 받는 사원이 소속된 부서(10번, 20번)와 동일한 부서에서 근무하는 사원출력
-- 3000 이상 받는 사원이 소속된 부서 : 부속질의
-- 동일한 부서에서 근무하는 사원출력
select distinct deptno from emp where sal>=3000;
select ename, deptno
from emp
where deptno in ( select distinct deptno from emp where sal>=3000 )
;

-- 30번 소속 사원들 중에서 급여를 가장 많이 받는 사원보다 더 많은 급여를 받는 사람의 이름, 급여를 출력하는 쿼리문을 작성해 봅시다.
-- 30번 소속 사원들 중에서 급여를 가장 많이 받는 사원
select ename, sal from emp where deptno=30;
select ename, sal
from emp
where sal > all ( select sal from emp where deptno=30 )
;
select sal from emp where deptno=30;

SELECT ENAME, SAL FROM EMP
WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=30)
;

-- 부서번호가 30번인 사원들의 급여 중 가장 작은 값(950)보다 많은 급여를 받는 사원의 이름, 급여를 출력하는 예제를 작성해 봅시다.
-- 부서번호가 30번인 사원들의 급여 중 가장 작은 값(950)보다
SELECT SAL FROM EMP WHERE DEPTNO=30;
SELECT ENAME, SAL FROM EMP
WHERE SAL > ANY (SELECT SAL FROM EMP WHERE DEPTNO=30)
;
SELECT ENAME, SAL FROM EMP
WHERE SAL > ( SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30 )
;

DESC EMP;

-- ROWNUM
SELECT ENAME, ROWNUM FROM EMP;

