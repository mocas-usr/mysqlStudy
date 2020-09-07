/*一 查出至少有一个员工的部门,显示部门编号、部门名称、部门位置、部门人数
1查询的列 部门编号、部门名称、部门位置、部门人数
2 查询的表 dept AS d 部门人数 SELECT deptno,COUNT(*) cnt FROM emp GROUP BY deptno AS z
3 WHERE条件，多表需要去除笛卡尔积
*/

SELECT  d.*,z.cnt
FROM dept AS d,(SELECT deptno,COUNT(*) cnt FROM emp GROUP BY deptno) AS z
WHERE d.deptno=z.deptno


/* 二 列出所有员工的姓名及其直接上级的姓名
1 查询的列 emp e.ename,emp m.ename，两个相同的表
2 查询表emp e,emp m
3 查询条件 e.上级 = m.编号,去除笛卡尔积
*/

SELECT e.ename,IFNULL(m.ename,'boss') AS 上级 #由于emp表中曾阿牛是董事长,其无上级,为null我们起个别名为boss
FROM emp e LEFT OUTER JOIN emp m#左外连接作用即:左表全部显示右表只会显示符合搜索条件的记录,右表记录不足的地方均为NULL
ON e.mgr=m.empno

/*三 列出受雇日期早于直接上级的所有员工的编号、姓名、部门名称
1 查询的列 enp e.empno,e.ename,dept d.dname 
2 查询的表 emp e emp m dept d
3 条件 e.mgr=m.empno e的上级是m e.hiredate<m.hiredate，去笛卡尔积
*/

SELECT e.empno,e.ename,d.dname
FROM emp e,emp m,dept d
WHERE e.mgr=m.empno AND e.hiredate<m.hiredate AND e.deptno=d.deptno

/*四 列出部门名称和这些部门的员工信息，同时列出那些没有员工的部门
1.查询的列 dept d.dname,emp e.* （所有部门全部列出）
2 查询的表 dept d,emp e
3 查询条件 所有部门全部列出
*/

SELECT d.dname,e.*
FROM dept d LEFT OUTER JOIN emp e
ON e.deptno=d.deptno


/*五 列出最低薪金大于15000的各种工作及从事此工作的员工人数。
1 查询的列 job,cout(*)
2 查询的表 emp 
3 查询条件 分组之后min(sal)>15000

*/

SELECT job, COUNT(*)
FROM emp e
GROUP BY job
HAVING MIN(sal) > 15000


/*六 列出在销售部工作的员工的姓名，假定不知道销售部的部门编号
1 查询的列 dempt d.dname,emp e.ename,
2 查询的表emp e,dept d
3 查询条件 d.dname='销售部’

*/
SELECT d.dname,e.ename
FROM emp e,dept d
WHERE e.deptno=(SELECT deptno FROM dept WHERE dname='销售部') AND e.deptno=d.deptno

/*七 列出薪金高于公司平均薪金的所有员工信息，所在部门名称，上级领导，工资等级
1 查询的列 emp e.*,dept d.dname,m.ename，s.grade
2 查询的表emp e，emp m,dept d,salgrade s
3 查询条件e.sal>(select avg(sal) from emp) 笛卡尔积连接

*/
/*这个不行
SELECT e.*, d.dname, m.ename, s.grade
FROM emp e, dept d, emp m, salgrade s
WHERE e.sal>(SELECT AVG(sal) FROM emp) AND e.deptno=d.deptno AND e.mgr=m.empno AND e.sal BETWEEN s.losal AND s.hisal
*/
SELECT e.*, d.dname, m.ename, s.grade
FROM 
emp e LEFT OUTER JOIN dept d ON e.deptno=d.deptno
LEFT OUTER JOIN emp m ON e.mgr=m.empno
LEFT OUTER JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE e.sal>(SELECT AVG(sal) FROM emp)


/*八 列出与庞统从事相同工作的所有员工及部门名称。
1查询的列 emp e.ename，dept d.dname
2 查询的表 emp e,dept d
3 查询条件 WHERE job=(SELECT job FROM emp WHERE ename='庞统')

*/

SELECT e.*,d.dname
FROM 
emp e INNER JOIN dept d ON e.deptno=d.deptno
WHERE e.job=(SELECT job FROM emp WHERE ename='庞统')


/*九 列出薪金高于在部门30工作的所有员工的薪金　的员工姓名和薪金、部门名称。

1查询列 emp e.ename,e.sal,dept d.dname
2 查询表 emp e.dept d
3 查询条件 e.sal>ALL(SELECT sal FROM emp WHERE deptno=30) 笛卡尔积


*/

SELECT e.ename,e.sal,d.dname
FROM emp e INNER JOIN dept d ON e.deptno=d.deptno
WHERE e.sal>ALL(SELECT sal FROM emp WHERE deptno=30)


/*十 列出薪金比关羽高的所有员工*/
SELECT *
FROM emp e
WHERE e.sal>(SELECT sal FROM emp WHERE ename='关羽')


/*十 列出所有文员的姓名及其部门名称，部门的人数。*/
SELECT e.ename,d.dname,z.cnt
FROM emp e INNER JOIN dept d ON e.deptno=d.deptno
	   INNER JOIN (SELECT deptno,COUNT(*) cnt FROM emp GROUP BY deptno)z ON z.deptno=d.deptno
WHERE e.job='文员'


/*列出每个部门的员工数量、平均工资。*/
SELECT d.dname,e1.*
FROM (SELECT e.deptno,COUNT(*),AVG(sal) FROM emp e GROUP BY e.deptno)e1 INNER JOIN dept d
ON e1.deptno=d.deptno;



