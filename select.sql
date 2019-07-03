# 1.查询同时存在1课程和2课程的情况

    SELECT *
    FROM student_course
    WHERE studentId IN(
        SELECT studentId FROM student_course
        WHERE courseId = 1 OR courseId = 2
        GROUP BY studentId
        HAVING COUNT(*) = 2
    );

# 2.查询同时存在1课程和2课程的情况

    SELECT *
    FROM student_course
    WHERE studentId IN(
        SELECT studentId FROM student_course
        WHERE courseId = 1 OR courseId = 2
        GROUP BY studentId
        HAVING COUNT(*) = 2
    );

# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩

    SELECT s.id AS '学生编号', s.name AS '学生姓名', AVG(sc.score) as '平均成绩'
    FROM student s, student_course sc
    WHERE s.id = sc.studentId
    GROUP BY s.id
    HAVING AVG(sc.score) >= 60;

# 4.查询在student_course表中不存在成绩的学生信息的SQL语句

    SELECT * FROM student
    WHERE id NOT IN(
        SELECT studentId
        FROM student_course
        WHERE score IS NOT NULL
    );

# 5.查询所有有成绩的SQL

    SELECT *
    FROM student
    WHERE id IN (
        SELECT studentId
        FROM student_course
        WHERE score IS NOT NULL
    );

# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息

    SELECT *
    FROM student
    WHERE id IN(
        SELECT studentId
        FROM student_course
        WHERE courseId = 1 OR courseId = 2
        GROUP BY studentId
        HAVING COUNT(*) = 2
    );

# 7.检索1课程分数小于60，按分数降序排列的学生信息

    SELECT s.*
    FROM student_course sc, student s
    WHERE sc.studentId = s.id AND sc.courseId = 1 AND sc.score < 60
    ORDER BY sc.score DESC;

# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列

    SELECT courseId, AVG(score) AS '平均成绩'
    FROM student_course
    GROUP BY courseId
    ORDER BY AVG(score) DESC, courseId ASC;

# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数

    SELECT s.name, sc.score
    FROM student_course sc, student s
    WHERE sc.studentId = s.id AND sc.score < 60
    AND sc.courseId in(
        SELECT id FROM course
        WHERE name = '数学'
    )
