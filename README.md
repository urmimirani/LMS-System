# LMS SYSTEM

## Overview
This project is an Advanced Java-based application that provides a comprehensive platform for educational management, catering to students, teachers, and administrators. It features role-based access control, user management, and modules to handle notes, discussions, quizzes, assessments, courses, and study materials. The application utilizes MySQL (via XAMPP) for data storage and offers a user-friendly interface with robust session management and error handling.

---

## Features

### 1. User Management Module
- **Authentication**: Role-based login/logout and session management to ensure secure access.
- **Registration**: Enables students and teachers to register with their details.
- **Session Tracking**: Maintains session tables to log active users and timestamps for analytics.

### 2. Notes and Discussion Module
- **Notes**: Create, save, update, and delete notes.
- **Discussion Forum**: Post, edit, and delete messages, organized by course threads.

### 3. Quiz Module
- **Quiz Creation**: Teachers can create quizzes with multiple-choice and descriptive questions.
- **Quiz Participation**: Students can attempt quizzes, view feedback, and track scores.

### 4. Assessment Module
- **Marks Management**: Manage marks for assignments, practicals, and exams.
- **Grade Reporting**: Automatic calculation and reporting of final grades.

### 5. Courses Module
- **Course Management**: Teachers can create and manage courses with details and descriptions.
- **Student Enrollment**: Students can enroll in courses and manage their relationships in the database.

### 6. Materials Module
- **Upload Materials**: Teachers can upload study resources such as PDFs and Word files.
- **Access Materials**: Students can view and download resources for their courses.

### 7. Student Portal Module
- **Dashboard**: Displays enrolled courses, deadlines, and performance summaries.
- **Reports**: View detailed performance reports with grades and marks.

### Additional Functionalities
- **Role-Based Access Control**: Customized dashboards for Students and Teachers.
- **Error Handling**: Robust validation for database operations and inputs.

---

## Technologies Used
- **Backend**: Java - servlets, jsp, jdbc
- **Frontend**: HTML, CSS, JavaScript (Homepage: `index.html`)
- **Database**: MySQL (via XAMPP)
- **Server**: Apache (via XAMPP)

---

## Installation and Setup

### Prerequisites
Ensure you have the following installed and configured on your system:
1. **Java Development Kit (JDK)**: Version 8 or higher.
2. **XAMPP**: To run MySQL and Apache server.
3. **Git**: For cloning the repository.
4. **IDE**: Recommended IDEs include Eclipse or IntelliJ IDEA or Apache Netbeans

---

### Steps to Download and Set Up the Project

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd project
   ```

2. **Set Up the Database**:
   - Start XAMPP and ensure the MySQL and Apache modules are running.
   - Open `phpMyAdmin` (accessible at `http://localhost/phpmyadmin`).
   - Create a new database named `lms_db`.
   - Import the SQL file provided in the project folder (e.g., `schema.sql`) to set up the tables.
     ```java
     DB_URL = "jdbc:mysql://localhost:3306/lms_db";
     DB_USERNAME = "root";
     DB_PASSWORD = ""; // Leave blank if using the default MySQL root password.
     ```

3. **Run the Application**:
   - Place the project folder (`project`) in the `htdocs` directory of your XAMPP installation.
   - Start the Apache server using the XAMPP control panel.
   - Open a browser and navigate to:
     ```
     http://localhost/project/index.html
     ```

4. **Access the Application**:
   - Use the homepage (`index.html`) to interact with the application.

---

## License
MIT License
