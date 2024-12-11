<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="example.Course" %>
<%@ page import="example.CourseDAO" %>
<%@ page import="example.UserDAO" %>
<%@ page import="example.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Course</title>
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

        /* Content container */
        .content-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
            width: 100%;
        }

        /* Date and time card styling */
        .date-time-card {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #fff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            color: #1e3799;
            font-size: 1em;
            text-align: center;
            width: 300px;
            z-index: 10;
        }

        /* Form styling */
        .create-course-form {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
        }

        .create-course-form label {
            color: #1e3799;
            font-weight: bold;
        }

        .create-course-form input, .create-course-form textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .create-course-form input[type="submit"] {
            background-color: #1e3799;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s;
        }

        .create-course-form input[type="submit"]:hover {
            background-color: #450fa1;
        }
    </style>
    <script>
        // Display current time
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleTimeString();
            document.getElementById("currentTime").textContent = timeString;
        }
        setInterval(updateTime, 1000); // Update time every second
    </script>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <a href="teacher_dashboard.jsp">Dashboard</a>
        <a href="create_course.jsp">Create a Course</a>
        <a href="CourseListServlet?target=create_quiz">Create Quiz</a>
        <a href="CourseListServlet?target=enroll_students">Enroll Students in Course</a>
        <a href="CourseListServlet?target=upload_materials">Upload Course Materials</a>
        <a href="discussion_forum.jsp">Discussion Forum</a>
        <a href="LogoutServlet">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Date and Time Card -->
        <div class="date-time-card">
            <div>
                <%
                    // Display day and date
                    SimpleDateFormat dayDateFormat = new SimpleDateFormat("EEEE, MMMM d, yyyy");
                    String currentDayDate = dayDateFormat.format(new Date());
                    out.print(currentDayDate);
                %>
            </div>
            <div>
                Current Time: <span id="currentTime"><%= new SimpleDateFormat("HH:mm:ss").format(new Date()) %></span>
            </div>
        </div>

        <!-- Title -->
        <h2 class="dashboard-title">Create a New Course</h2>

        <!-- Content Container -->
        <div class="content-container">
            <div class="create-course-form">
                <form action="CreateCourseServlet" method="post">
                    <label for="course_name">Course Name:</label>
                    <input type="text" id="course_name" name="course_name" required>

                    <label for="description">Description:</label>
                    <textarea id="description" name="description" required></textarea>

                    <input type="submit" value="Create Course">
                </form>
            </div>
        </div>
    </div>

</body>
</html>