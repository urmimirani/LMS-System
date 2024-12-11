-- Create Users Table
CREATE TABLE users (
    user_id INT(11) NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    role ENUM('student', 'teacher') DEFAULT NULL,
    PRIMARY KEY (user_id)
);

-- Create Courses Table
CREATE TABLE courses (
    course_id INT(11) NOT NULL AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    description TEXT DEFAULT NULL,
    teacher_id INT(11) DEFAULT NULL,
    PRIMARY KEY (course_id),
    FOREIGN KEY (teacher_id) REFERENCES users(user_id)
);

-- Create Enrollments Table
CREATE TABLE enrollments (
    enrollment_id INT(11) NOT NULL AUTO_INCREMENT,
    course_id INT(11) DEFAULT NULL,
    student_id INT(11) DEFAULT NULL,
    PRIMARY KEY (enrollment_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (student_id) REFERENCES users(user_id)
);

-- Create Materials Table
CREATE TABLE materials (
    material_id INT(11) NOT NULL AUTO_INCREMENT,
    file_path VARCHAR(200) DEFAULT NULL,
    course_id INT(11) DEFAULT NULL,
    PRIMARY KEY (material_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Create Messages Table
CREATE TABLE messages (
    message_id INT(11) NOT NULL AUTO_INCREMENT,
    user_id INT(11) DEFAULT NULL,
    message_text TEXT DEFAULT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    edited_timestamp DATETIME DEFAULT NULL,
    PRIMARY KEY (message_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Create Quizzes Table
CREATE TABLE quizzes (
    quiz_id INT(11) NOT NULL AUTO_INCREMENT,
    quiz_title VARCHAR(100) NOT NULL,
    course_id INT(11) NOT NULL,
    PRIMARY KEY (quiz_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Create Quiz Data Table
CREATE TABLE quiz_data (
    quiz_id INT(11) DEFAULT NULL,
    question_no INT(11) NOT NULL,
    question_text VARCHAR(500) DEFAULT NULL,
    option1 VARCHAR(150) NOT NULL,
    option2 VARCHAR(150) NOT NULL,
    option3 VARCHAR(150) NOT NULL,
    option4 VARCHAR(150) NOT NULL,
    correct INT(11) NOT NULL,
    PRIMARY KEY (quiz_id, question_no),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(quiz_id)
);

-- Create Quiz Responses Table
CREATE TABLE quiz_responses (
    quiz_id INT(11) DEFAULT NULL,
    student_id INT(11) DEFAULT NULL,
    question_no INT(11) DEFAULT NULL,
    answer_selected INT(11) NOT NULL,
    marks INT(11) DEFAULT NULL,
    PRIMARY KEY (quiz_id, student_id, question_no),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(quiz_id),
    FOREIGN KEY (student_id) REFERENCES users(user_id)
);

-- Create Assessments Table
CREATE TABLE assessments (
    division VARCHAR(5) NOT NULL,
    student_id INT(11) NOT NULL,
    course_id INT(11) NOT NULL,
    quiz INT(11) NOT NULL,
    assignment INT(11) NOT NULL,
    midsem INT(11) NOT NULL,
    lab INT(11) NOT NULL,
    endsem INT(11) NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Create Sessions Table
CREATE TABLE sessions (
    session_id VARCHAR(255) NOT NULL,
    user_id INT(11) DEFAULT NULL,
    notes TEXT DEFAULT NULL,
    PRIMARY KEY (session_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
