/*有主键的主表*/
CREATE TABLE dept (
	deptno INT PRIMARY KEY AUTO_INCREMENT,
	dname VARCHAR (50)
);

INSERT INTO dept VALUES(10,'研发部');
INSERT INTO dept VALUES(20,'人力部');
INSERT INTO dept VALUES(30,'财务部');

SELECT * FROM dept;


/*创建从表。含有外键*/


CREATE TABLE emp (
	empno INT PRIMARY KEY AUTO_INCREMENT,
	ename VARCHAR (50),
	dno INT,
	CONSTRAINT fk_emp_dept FOREIGN KEY (dno) REFERENCES dept (deptno)
);

INSERT INTO emp(empno,ename) VALUES(NULL,'zhangsan');
INSERT INTO emp(empno,ename,dno) VALUES(NULL,'lisi',10);
INSERT INTO emp(empno,ename,dno) VALUES(NULL,'wangwu',20);


SELECT * FROM emp;