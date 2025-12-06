-- =============================================
-- 学籍管理数据库系统 - 完整建库脚本
-- 包含：数据库创建、表结构、基础数据、存储过程、视图
-- =============================================

-- 第一步：创建数据库
DROP DATABASE IF EXISTS student_management;
CREATE DATABASE student_management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE student_management;

-- =============================================
-- 创建表结构
-- =============================================

-- 1. 专业表
CREATE TABLE majors (
    major_id VARCHAR(10) PRIMARY KEY,
    major_name VARCHAR(50) NOT NULL
);

-- 2. 班级表
CREATE TABLE classes (
    class_id VARCHAR(10) PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    major_id VARCHAR(10),
    enroll_year INT,
    FOREIGN KEY (major_id) REFERENCES majors(major_id)
);

-- 3. 学生表
CREATE TABLE students (
    student_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender ENUM('男', '女') NOT NULL,
    birth_date DATE,
    class_id VARCHAR(10),
    total_failed_required_credits INT DEFAULT 0,
    total_failed_elective_credits INT DEFAULT 0,
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

-- 4. 课程表
CREATE TABLE courses (
    course_id VARCHAR(20) PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0)
);

-- 5. 教师表
CREATE TABLE teachers (
    teacher_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender ENUM('男', '女')
);

-- 6. 教学计划表
CREATE TABLE teaching_plans (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    major_id VARCHAR(10),
    course_id VARCHAR(20),
    course_type ENUM('必修', '选修') NOT NULL,
    suggested_semester INT CHECK (suggested_semester BETWEEN 1 AND 8),
    FOREIGN KEY (major_id) REFERENCES majors(major_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE KEY unique_major_course (major_id, course_id)
);

-- 7. 授课表
CREATE TABLE teaching_assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id VARCHAR(10),
    course_id VARCHAR(20),
    class_id VARCHAR(10),
    semester INT,
    academic_year VARCHAR(10),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    UNIQUE KEY unique_teacher_class_semester (teacher_id, class_id, semester)
);

-- 8. 成绩表
CREATE TABLE scores (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(10),
    course_id VARCHAR(20),
    semester INT,
    academic_year VARCHAR(10),
    regular_score DECIMAL(5,2) CHECK (regular_score BETWEEN 0 AND 100),
    makeup_score DECIMAL(5,2) CHECK (makeup_score BETWEEN 0 AND 100),
    final_score DECIMAL(5,2) CHECK (final_score BETWEEN 0 AND 100),
    is_passed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE KEY unique_student_course (student_id, course_id)
);

-- =============================================
-- 插入基础数据
-- =============================================

-- 插入专业数据
INSERT INTO majors (major_id, major_name) VALUES
('CS', '计算机科学'),
('MA', '数学'),
('PH', '物理');

-- 插入班级数据
INSERT INTO classes (class_id, class_name, major_id, enroll_year) VALUES
('CS2003', '计算机2003班', 'CS', 2003),
('MA2003', '数学2003班', 'MA', 2003),
('PH2003', '物理2003班', 'PH', 2003);

-- 插入学生数据（基于您提供的文件）
INSERT INTO students (student_id, name, gender, class_id) VALUES
('03051001', '许艳芳', '女', 'CS2003'),
('03051002', '林丽娟', '女', 'CS2003'),
('03051003', '魏娜', '女', 'CS2003'),
('03051004', '张亚楠', '女', 'CS2003'),
('03051005', '孙寅秋', '女', 'CS2003'),
('03051006', '袁巍巍', '女', 'CS2003'),
('03051007', '王洁', '女', 'CS2003'),
('03051008', '宋丽', '女', 'CS2003'),
('03051009', '张璐', '女', 'CS2003'),
('03051010', '田旻', '女', 'CS2003'),
('03051011', '吝倩', '女', 'CS2003'),
('03051012', '武杏杏', '女', 'CS2003'),
('03051013', '杨一诺', '女', 'CS2003'),
('03051014', '李霞', '女', 'CS2003'),
('03051015', '郝艳青', '男', 'CS2003'),
('03051016', '谢志宏', '男', 'CS2003'),
('03051017', '苏宇铭', '男', 'CS2003'),
('03051018', '陈杰', '男', 'CS2003'),
('03051019', '张琦', '男', 'CS2003'),
('03051020', '彭良庆', '男', 'CS2003'),
('03051021', '唐国柱', '男', 'CS2003'),
('03051022', '农飞', '男', 'CS2003'),
('03051023', '史继宾', '男', 'CS2003'),
('03051024', '程淼', '男', 'CS2003'),
('03051025', '宋建雷', '男', 'CS2003'),
('03051026', '牛伟', '男', 'CS2003'),
('03051027', '习晨', '男', 'CS2003'),
('03051028', '苏春宇', '男', 'CS2003'),
('03051029', '金磊', '男', 'CS2003'),
('03051030', '马彪', '男', 'CS2003'),
('03051031', '张锐', '男', 'CS2003'),
('03051032', '刘建国', '男', 'CS2003'),
('03051033', '张帆', '男', 'CS2003'),
('03051034', '周治中', '男', 'CS2003'),
('03051035', '周晓飞', '男', 'CS2003'),
('03051036', '徐文章', '男', 'CS2003'),
('03051037', '王德海', '男', 'CS2003'),
('03051038', '周立新', '男', 'CS2003'),
('03051039', '唐博', '男', 'CS2003'),
('03051040', '鲁军', '男', 'CS2003'),
('03051041', '韦洪宇', '男', 'CS2003'),
('03051042', '梁亚雄', '男', 'CS2003'),
('03051043', '赵克敏', '男', 'CS2003'),
('03051044', '张弛', '男', 'CS2003'),
('03051045', '宋涛', '男', 'CS2003'),
('03051046', '任江宁', '男', 'CS2003'),
('03051047', '徐亚文', '男', 'CS2003'),
('03051048', '雷磊', '男', 'CS2003'),
('03051049', '王慧安', '男', 'CS2003'),
('03051050', '董璇', '男', 'CS2003'),
('03051051', '李涛', '男', 'CS2003'),
('03051052', '刘政', '男', 'CS2003'),
('03051053', '王俊涛', '男', 'CS2003'),
('03051054', '周星', '男', 'CS2003'),
('03051055', '熊伟', '男', 'CS2003'),
('03051056', '王小琪', '女', 'CS2003'),
('03051057', '陈羽', '女', 'CS2003'),
('03051058', '高丽丽', '女', 'CS2003'),
('03051059', '江潇潇', '女', 'CS2003'),
('03051060', '胡瑞雪', '女', 'CS2003'),
('03051061', '乐苹芳', '女', 'CS2003'),
('03051062', '綦晓颖', '女', 'CS2003'),
('03051063', '曹莹', '女', 'CS2003'),
('03051064', '张昕', '女', 'CS2003'),
('03051065', '赵铁梅', '女', 'CS2003'),
('03051066', '刘青', '女', 'CS2003'),
('03051067', '杨淑玲', '女', 'CS2003'),
('03051068', '和文艳', '女', 'CS2003'),
('03051069', '吕涛', '男', 'CS2003'),
('03051070', '林雨', '男', 'CS2003'),
('03051071', '陈熙', '男', 'CS2003'),
('03051072', '陈永德', '男', 'CS2003'),
('03051073', '黎学森', '男', 'CS2003'),
('03051074', '林德成', '男', 'CS2003'),
('03051075', '林中晓', '男', 'CS2003'),
('03051076', '詹俊武', '男', 'CS2003'),
('03051077', '张永晓', '男', 'CS2003'),
('03051078', '付凯元', '男', 'CS2003'),
('03051079', '冯尧', '男', 'CS2003'),
('03051080', '包瑞飞', '男', 'CS2003'),
('03051081', '许超', '男', 'CS2003'),
('03051082', '梁建威', '男', 'CS2003'),
('03051083', '赵迪', '男', 'CS2003'),
('03051084', '张山', '男', 'CS2003'),
('03051085', '熊焕明', '男', 'CS2003'),
('03051086', '刘洋', '男', 'CS2003'),
('03051087', '丁路', '男', 'CS2003'),
('03051088', '黄金', '男', 'CS2003'),
('03051089', '田文生', '男', 'CS2003'),
('03051090', '李林', '男', 'CS2003'),
('03051091', '陈星宇', '男', 'CS2003'),
('03051092', '刘金涛', '男', 'CS2003'),
('03051093', '宋君', '男', 'CS2003'),
('03051094', '张海龙', '男', 'CS2003'),
('03051095', '杨金虎', '男', 'CS2003'),
('03051096', '付云生', '男', 'CS2003'),
('03051097', '苗新明', '男', 'CS2003'),
('03051098', '薛心', '男', 'CS2003'),
('03051099', '王旭', '男', 'CS2003'),
('03051100', '田冬宝', '男', 'CS2003'),
('03051101', '刘宁', '男', 'CS2003'),
('03051102', '舒添翼', '男', 'CS2003'),
('03051103', '豆云', '男', 'CS2003'),
('03051104', '陈琛', '男', 'CS2003'),
('03051105', '边金元', '男', 'CS2003'),
('03051106', '程永帅', '男', 'CS2003'),
('03051107', '吕思游', '男', 'CS2003'),
('03051108', '俞飞江', '男', 'CS2003');

-- 插入课程数据（基于您提供的课程文件）
INSERT INTO courses (course_id, course_name, credits) VALUES
('HA2113001', '毛泽东思想概论', 6),
('HA2113002', '马克思主义基本原理', 3),
('HA1113003', '中国近代史纲要', 2),
('IR1113001', '思想道德修养与法律基础', 3),
('IR1123002', '形势与政策', 2),
('AM1113001', '军事理论', 2),
('HE1123001', '体育', 4),
('HA1112004', '大学英语', 16),
('SC1112001', '高等数学', 12),
('SC1112003', '线性代数', 3),
('SC2112005', '概率论与数理统计', 3),
('SC1112007', '大学物理', 8),
('SC1112008', '物理实验', 2),
('EM1112001', '工程图学与计算机绘图', 3),
('IB2113001', '电路分析基础', 5),
('IB2113002', '信号与系统', 5),
('IB2113003', '电路、信号与系统实验', 1),
('CS2121001', '模拟电子技术基础', 3),
('IB2111005', '数字电路与逻辑设计', 3),
('CS2121003', '数电、模电、EDA实验', 2),
('CS1121004', '计算机导论', 2),
('CS1121005', '计算机导论实验', 1),
('CS1121006', '程序设计基础', 2),
('CS2121007', '离散数学', 3),
('CS3121009', '计算机组织与体系结构', 5),
('CS3121010', '微机系统', 5),
('CS3121011', '操作系统', 3),
('CS3121012', '操作系统实验', 1),
('CS3121013', '计算机通信与网络', 4),
('CS3121014', '数据库系统', 3),
('CS4121015', '软件工程', 3),
('CS2221016', '数据结构', 3),
('CS2221017', '数据结构实验', 1),
('CS3221018', '算法分析与设计', 2),
('CS4221019', '数值分析', 2),
('CS3221020', '计算机图形学', 2),
('CS4221021', '人工智能导论', 2),
('CS3221022', '计算机安全基础', 2),
('CS3221023', '代数系统', 2),
('CS3221024', '编译原理', 3),
('CS3221025', '面向对象程序设计', 3),
('CS4221026', '网络计算', 3),
('CS2221027', '数据结构与算法', 3),
('CS2221028', '数据结构与算法实验', 1),
('CS4221029', '嵌入式系统', 3),
('CS3221030', 'VLSI设计概论', 2),
('CS3221031', '数字信号处理', 3),
('CS3221032', '人机交互技术', 2),
('CS3221033', '数字图像处理', 2),
('CS4221034', '网络程序设计', 2),
('CS4221035', '网络管理', 2),
('CS3221036', '网络安全技术', 2),
('CS3221037', '计算机控制', 3),
('CS3321038', '组合数学', 2),
('CS4321039', '组网工程', 1),
('CS3321040', '网络多媒体技术', 2),
('CS3321041', '数据库应用', 2),
('CS4321042', '接口技术', 2),
('CS3321043', '数据挖掘', 2),
('CS4321044', '并行程序设计', 2),
('CS3321045', '模式识别', 2),
('CS4321046', 'DSP原理及应用', 2),
('CS3321047', '软件测试', 2),
('CS3321048', '驱动程序设计', 2),
('CS4321049', '电子商务', 2),
('CS4321050', '下一代互联网', 1),
('CS4321051', 'Unix环境编程', 2),
('SC2322002', '数学分析选讲', 2);

-- 插入教师数据
INSERT INTO teachers (teacher_id, name, gender) VALUES
('T001', '张教授', '男'),
('T002', '李教授', '女'),
('T003', '王老师', '男'),
('T004', '刘老师', '女'),
('T005', '陈教授', '男'),
('T006', '杨老师', '女'),
('T007', '赵教授', '男');

-- 插入教学计划数据
INSERT INTO teaching_plans (major_id, course_id, course_type, suggested_semester) VALUES
-- 计算机专业的教学计划
('CS', 'HA2113001', '必修', 1),
('CS', 'HA2113002', '必修', 2),
('CS', 'HA1113003', '必修', 1),
('CS', 'IR1113001', '必修', 1),
('CS', 'SC1112001', '必修', 1),
('CS', 'HA1112004', '必修', 1),
('CS', 'CS1121004', '必修', 1),
('CS', 'CS1121006', '必修', 2),
('CS', 'CS2121007', '必修', 3),
('CS', 'CS2221016', '必修', 3),
('CS', 'CS3121009', '必修', 4),
('CS', 'CS3121013', '必修', 5),
('CS', 'CS3121014', '必修', 5),
('CS', 'CS3221024', '必修', 6),
-- 选修课
('CS', 'CS3221020', '选修', 6),
('CS', 'CS4221021', '选修', 7),
('CS', 'CS3221036', '选修', 6),
('CS', 'CS4321049', '选修', 7);


-- 插入授课安排
INSERT INTO teaching_assignments (teacher_id, course_id, class_id, semester, academic_year) VALUES
('T001', 'HA2113001', 'CS2003', 1, '2003-2004'),
('T002', 'SC1112001', 'CS2003', 1, '2003-2004'),
('T003', 'HA1112004', 'CS2003', 1, '2003-2004'),
('T004', 'CS1121004', 'CS2003', 1, '2003-2004'),
('T005', 'CS1121006', 'CS2003', 2, '2003-2004');

-- =============================================
-- 创建存储过程和函数
-- =============================================
DELIMITER //

-- 学生录入存储过程
CREATE PROCEDURE AddStudent(
    IN p_student_id VARCHAR(10),
    IN p_name VARCHAR(50),
    IN p_gender ENUM('男', '女'),
    IN p_birth_date DATE,
    IN p_class_id VARCHAR(10)
)
BEGIN
    -- 检查班级是否存在
    IF NOT EXISTS (SELECT 1 FROM classes WHERE class_id = p_class_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '错误：班级不存在';
    END IF;
    
    -- 检查学号是否重复
    IF EXISTS (SELECT 1 FROM students WHERE student_id = p_student_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '错误：学号已存在';
    END IF;
    
    -- 插入学生信息
    INSERT INTO students (student_id, name, gender, birth_date, class_id)
    VALUES (p_student_id, p_name, p_gender, p_birth_date, p_class_id);
    
    SELECT '学生录入成功' as 结果;
END//


DELIMITER //

-- 成绩录入存储过程
CREATE PROCEDURE InsertOrUpdateScore(
    IN p_student_id VARCHAR(10),
    IN p_course_id VARCHAR(20),
    IN p_semester INT,
    IN p_academic_year VARCHAR(10),
    IN p_regular_score DECIMAL(5,2)
)
BEGIN
    DECLARE v_course_type ENUM('必修', '选修');
    DECLARE v_credits INT;
    DECLARE v_major_id VARCHAR(10);
    DECLARE v_is_passed BOOLEAN;
    DECLARE v_final_score DECIMAL(5,2);
    DECLARE v_old_is_passed BOOLEAN;
    
    -- 获取课程信息
    SELECT tp.course_type, c.credits, cl.major_id
    INTO v_course_type, v_credits, v_major_id
    FROM students s
    JOIN classes cl ON s.class_id = cl.class_id
    JOIN teaching_plans tp ON cl.major_id = tp.major_id
    JOIN courses c ON tp.course_id = c.course_id
    WHERE s.student_id = p_student_id AND c.course_id = p_course_id;
    
    -- 计算最终成绩和是否通过
    SET v_final_score = p_regular_score;
    SET v_is_passed = (v_final_score >= 60);
    
    -- 检查是否已有成绩记录
    SELECT is_passed INTO v_old_is_passed
    FROM scores 
    WHERE student_id = p_student_id AND course_id = p_course_id;
    
    -- 插入或更新成绩
    INSERT INTO scores (student_id, course_id, semester, academic_year, regular_score, final_score, is_passed)
    VALUES (p_student_id, p_course_id, p_semester, p_academic_year, p_regular_score, v_final_score, v_is_passed)
    ON DUPLICATE KEY UPDATE 
        regular_score = p_regular_score,
        final_score = v_final_score,
        is_passed = v_is_passed;
    
    -- 更新不及格学分统计
    IF v_old_is_passed IS NOT NULL AND NOT v_old_is_passed AND v_is_passed THEN
        -- 从不通过变为通过，减少不及格学分
        IF v_course_type = '必修' THEN
            UPDATE students 
            SET total_failed_required_credits = GREATEST(0, total_failed_required_credits - v_credits)
            WHERE student_id = p_student_id;
        ELSE
            UPDATE students 
            SET total_failed_elective_credits = GREATEST(0, total_failed_elective_credits - v_credits)
            WHERE student_id = p_student_id;
        END IF;
    ELSEIF (v_old_is_passed IS NULL OR v_old_is_passed) AND NOT v_is_passed THEN
        -- 从通过变为不通过，增加不及格学分
        IF v_course_type = '必修' THEN
            UPDATE students 
            SET total_failed_required_credits = total_failed_required_credits + v_credits
            WHERE student_id = p_student_id;
        ELSE
            UPDATE students 
            SET total_failed_elective_credits = total_failed_elective_credits + v_credits
            WHERE student_id = p_student_id;
        END IF;
    END IF;
END//

-- 计算加权平均成绩的函数
CREATE FUNCTION CalculateWeightedAverage(p_student_id VARCHAR(10), p_course_type VARCHAR(10))
RETURNS DECIMAL(5,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE avg_score DECIMAL(5,2) DEFAULT 0;
    DECLARE total_weight DECIMAL(10,2) DEFAULT 0;
    DECLARE weighted_sum DECIMAL(10,2) DEFAULT 0;
    
    IF p_course_type = 'ALL' THEN
        SELECT SUM(s.final_score * c.credits), SUM(c.credits)
        INTO weighted_sum, total_weight
        FROM scores s
        JOIN courses c ON s.course_id = c.course_id
        WHERE s.student_id = p_student_id AND s.final_score IS NOT NULL;
    ELSE
        SELECT SUM(s.final_score * c.credits), SUM(c.credits)
        INTO weighted_sum, total_weight
        FROM scores s
        JOIN courses c ON s.course_id = c.course_id
        JOIN students st ON s.student_id = st.student_id
        JOIN classes cl ON st.class_id = cl.class_id
        JOIN teaching_plans tp ON cl.major_id = tp.major_id AND c.course_id = tp.course_id
        WHERE s.student_id = p_student_id AND s.final_score IS NOT NULL AND tp.course_type = p_course_type;
    END IF;
    
    IF total_weight > 0 THEN
        SET avg_score = weighted_sum / total_weight;
    END IF;
    
    RETURN ROUND(avg_score, 2);
END//

DELIMITER ;

-- =============================================
-- 插入成绩数据（基于您提供的成绩文件）
-- =============================================

CALL InsertOrUpdateScore('03051001', 'HA2113001', 1, '2003-2004', 60);
CALL InsertOrUpdateScore('03051002', 'HA2113001', 1, '2003-2004', 60);
CALL InsertOrUpdateScore('03051003', 'HA2113001', 1, '2003-2004', 65);
CALL InsertOrUpdateScore('03051004', 'HA2113001', 1, '2003-2004', 66);
CALL InsertOrUpdateScore('03051005', 'HA2113001', 1, '2003-2004', 67);
CALL InsertOrUpdateScore('03051006', 'HA2113001', 1, '2003-2004', 67);
CALL InsertOrUpdateScore('03051007', 'HA2113001', 1, '2003-2004', 68);
CALL InsertOrUpdateScore('03051008', 'HA2113001', 1, '2003-2004', 70);

-- 插入一些其他课程的成绩用于测试
CALL InsertOrUpdateScore('03051001', 'SC1112001', 1, '2003-2004', 85);
CALL InsertOrUpdateScore('03051002', 'SC1112001', 1, '2003-2004', 45); -- 不及格
CALL InsertOrUpdateScore('03051003', 'SC1112001', 1, '2003-2004', 78);
CALL InsertOrUpdateScore('03051001', 'HA1112004', 1, '2003-2004', 82);
CALL InsertOrUpdateScore('03051002', 'HA1112004', 1, '2003-2004', 58); -- 不及格

-- =============================================
-- 创建视图
-- =============================================

-- 学生详细信息视图
CREATE VIEW student_details AS
SELECT s.student_id, s.name, s.gender, s.birth_date, 
       c.class_name, m.major_name,
       s.total_failed_required_credits, s.total_failed_elective_credits
FROM students s
JOIN classes c ON s.class_id = c.class_id
JOIN majors m ON c.major_id = m.major_id;

-- 学生成绩详情视图
CREATE VIEW student_scores_detail AS
SELECT s.student_id, s.name, c.course_id, c.course_name, 
       sc.regular_score, sc.makeup_score, sc.final_score, sc.is_passed,
       tp.course_type, c.credits, sc.semester, sc.academic_year
FROM students s
JOIN scores sc ON s.student_id = sc.student_id
JOIN courses c ON sc.course_id = c.course_id
JOIN classes cl ON s.class_id = cl.class_id
JOIN teaching_plans tp ON cl.major_id = tp.major_id AND c.course_id = tp.course_id;

-- 开除预警视图
CREATE VIEW dismissal_warning AS
SELECT student_id, name, 
       total_failed_required_credits as failed_required,
       total_failed_elective_credits as failed_elective,
       (10 - total_failed_required_credits) as remaining_required,
       (15 - total_failed_elective_credits) as remaining_elective,
       CASE 
           WHEN total_failed_required_credits >= 7 OR total_failed_elective_credits >= 12 THEN '高危'
           WHEN total_failed_required_credits >= 5 OR total_failed_elective_credits >= 10 THEN '警告'
           ELSE '安全'
       END as warning_level
FROM students;

-- 教师授课视图
CREATE VIEW teacher_assignments_view AS
SELECT t.teacher_id, t.name as teacher_name, c.course_name, 
       cl.class_name, ta.semester, ta.academic_year
FROM teachers t
JOIN teaching_assignments ta ON t.teacher_id = ta.teacher_id
JOIN courses c ON ta.course_id = c.course_id
JOIN classes cl ON ta.class_id = cl.class_id;

-- =============================================
-- 创建索引
-- =============================================

CREATE INDEX idx_student_name ON students(name);
CREATE INDEX idx_scores_student ON scores(student_id);
CREATE INDEX idx_scores_course ON scores(course_id);
CREATE INDEX idx_teaching_class ON teaching_assignments(class_id);
CREATE INDEX idx_student_class ON students(class_id);

-- =============================================
-- 测试查询
-- =============================================

-- 测试查询：按学号查询学生信息
SELECT '=== 测试1：按学号查询学生信息 ===' as test_info;
SELECT * FROM student_details WHERE student_id = '03051001';

-- 测试查询：学生成绩
SELECT '=== 测试2：学生成绩查询 ===' as test_info;
SELECT * FROM student_scores_detail WHERE student_id = '03051001';

-- 测试查询：加权平均成绩
SELECT '=== 测试3：加权平均成绩计算 ===' as test_info;
SELECT 
    CalculateWeightedAverage('03051001', '必修') as required_avg,
    CalculateWeightedAverage('03051001', 'ALL') as overall_avg;

-- 测试查询：开除预警
SELECT '=== 测试4：开除预警系统 ===' as test_info;
SELECT * FROM dismissal_warning WHERE warning_level != '安全';

-- 测试查询：教师授课信息
SELECT '=== 测试5：教师授课查询 ===' as test_info;
SELECT * FROM teacher_assignments_view;

-- 统计信息
SELECT '=== 系统统计信息 ===' as test_info;
SELECT 
    (SELECT COUNT(*) FROM students) as student_count,
    (SELECT COUNT(*) FROM courses) as course_count,
    (SELECT COUNT(*) FROM scores) as score_count,
    (SELECT COUNT(*) FROM teachers) as teacher_count;

-- =============================================
-- 完成提示
-- =============================================

SELECT '学籍管理数据库系统创建完成！' as completion_message;

