<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Record Assessment</title>
    <style>
        /* Basic reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #e6f7ff;
            padding: 0;
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        /* Sidebar styling */
        .sidebar {
            width: 250px;
            background-color: #2e86de;
            padding: 20px;
            display: flex;
            flex-direction: column;
            color: #fff;
        }

        .sidebar a {
            display: block;
            color: #fff;
            padding: 15px;
            text-decoration: none;
            border-radius: 5px;
            margin: 5px 0;
            transition: background-color 0.3s;
            text-align: left;
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: #1e3799;
        }

        .logout-btn {
            background-color: #e91e63;
            margin: 10px;
            text-align: center;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: #c2185b;
        }

        /* Main content area */
        .main-content {
            flex: 1;
            padding: 20px;
            position: relative;
            overflow-y: auto;
        }

        /* Title styling */
        .dashboard-title {
            font-size: 2em;
            font-weight: bold;
            color: #1e3799;
            margin-bottom: 20px;
            text-align: center;
        }

        /* Form container */
        .assessment-form {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
        }

        .assessment-form label {
            color: #1e3799;
            font-weight: bold;
        }

        .assessment-form input, .assessment-form select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .assessment-form input[type="submit"] {
            background-color: #1e3799;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s;
        }

        .assessment-form input[type="submit"]:hover {
            background-color: #450fa1;
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <a href="teacher_dashboard.jsp">Dashboard</a>
        <a href="create_course.jsp">Create a Course</a>
        <a href="CourseListServlet?target=create_quiz">Create Quiz</a>
        <a href="CourseListServlet?target=enroll_students">Enroll Students in Course</a>
        <a href="CourseListServlet?target=upload_materials">Upload Course Materials</a>
        <a href="discussion_forum.jsp">Discussion Forum</a>
        <a href="LogoutServlet">Logout</a>
    </div>


    <div class="main-content">

        <h2 class="dashboard-title">Enter Assessment Details</h2>

        <div class="assessment-form">
            <form action="SaveAssessmentsServlet" method="post">
                <label for="division">Division:</label>
                <input type="text" id="division" name="division" required>

                <label for="student_id">Student ID:</label>
                <input type="number" id="student_id" name="student_id" required>

                <label for="course_id">Course:</label>
                <select id="course_id" name="course_id" required>
                    <c:forEach var="course" items="${courses}">
                        <option value="${course.courseId}">${course.courseName}</option>
                    </c:forEach>
                </select>

                <label for="assignment">Assignment:</label>
                <input type="number" id="assignment" name="assignment">

                <label for="midsem">Midsem:</label>
                <input type="number" id="midsem" name="midsem">

                <label for="lab">Lab:</label>
                <input type="number" id="lab" name="lab">

                <label for="endsem">Endsem:</label>
                <input type="number" id="endsem" name="endsem">

                <input type="submit" value="Save Assessment">
            </form>
        </div>
    </div>

</body>
</html>
