-- =============================================
-- 学籍管理数据库系统 - 测试脚本
-- 文件名: test_student_management.sql
-- 说明: 此文件用于测试数据库各项功能
-- =============================================

-- 确保使用正确的数据库
USE student_management;
SELECT '=== 开始基础环境检查 ===' as 测试阶段;
-- 检查表是否存在
SHOW TABLES;
SELECT *
FROM students;
-- 查询学号为03051001的学生所修课程及性质
SELECT 
    c.course_id AS 课程编号,
    c.course_name AS 课程名称,
    tp.course_type AS 课程性质,
    c.credits AS 学分,
    sc.semester AS 学期,
    sc.academic_year AS 学年,
    sc.final_score AS 最终成绩,
    CASE 
        WHEN sc.is_passed = 1 THEN '通过'
        WHEN sc.is_passed = 0 THEN '未通过'
        ELSE '未考试'
    END AS 通过状态
FROM students s
JOIN classes cl ON s.class_id = cl.class_id
JOIN teaching_plans tp ON cl.major_id = tp.major_id
JOIN courses c ON tp.course_id = c.course_id
LEFT JOIN scores sc ON s.student_id = sc.student_id AND c.course_id = sc.course_id
WHERE s.student_id = '03051001'
ORDER BY sc.semester, c.course_name;
-- 查询接近开除条件的学生（距被开除差3学分之内）
SELECT 
    student_id AS 学号,
    name AS 姓名,
    total_failed_required_credits AS 不及格必修学分,
    total_failed_elective_credits AS 不及格选修学分,
    (10 - total_failed_required_credits) AS 剩余必修容错学分,
    (15 - total_failed_elective_credits) AS 剩余选修容错学分,
    CASE 
        WHEN total_failed_required_credits >= 7 OR total_failed_elective_credits >= 12 THEN '开除高危'
        WHEN total_failed_required_credits >= 5 OR total_failed_elective_credits >= 10 THEN '接近开除'
        ELSE '安全'
    END AS 预警等级
FROM students
WHERE total_failed_required_credits >= 7 
   OR total_failed_elective_credits >= 12
   OR total_failed_required_credits >= 5 
   OR total_failed_elective_credits >= 10
ORDER BY 
    CASE 
        WHEN total_failed_required_credits >= 7 OR total_failed_elective_credits >= 12 THEN 1
        WHEN total_failed_required_credits >= 5 OR total_failed_elective_credits >= 10 THEN 2
        ELSE 3
    END,
    total_failed_required_credits DESC,
    total_failed_elective_credits DESC;
