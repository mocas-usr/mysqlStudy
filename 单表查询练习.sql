/*查询班级为2的所有同学*/
SELECT *
FROM students
WHERE class_id=2
/*查询一班所有学生的班级，性别*/
SELECT name,class_id,gender
FROM students
WHERE class_id=1
/*查询分数高于80分的学生*/
SELECT *
FROM students
WHERE score>80

/*查询二班所有男生信息，和三班女生信息*/
SELECT *
FROM students
WHERE (class_id=2 AND gender='M') OR (class_id=3 AND gender='F')

/*查询二班所有成绩大于80男生信息*/
SELECT *
FROM students
WHERE class_id=2 AND gender='M' AND score>80

/*查询名字由三个字组成的学生信息*/
SELECT *
FROM students
WHERE name LIKE '__'

/*按成绩升序排序所有学生信息*/
SELECT *
FROM students
ORDER BY score ASC

/*按成绩降序排序所有学生信息，如果成绩相同按id升序排序*/
SELECT *
FROM students
ORDER BY score DESC,id ASC

/*查询每个班级的平均成绩*/
SELECT class_id,AVG(score)平均工资
FROM students
GROUP BY class_id

/*查询每个班级的人数*/
SELECT class_id,COUNT(*) 人数
FROM students
GROUP BY class_id

