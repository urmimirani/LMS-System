<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Data Form</title>
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
        .quiz-data-form {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
        }

        .quiz-data-form label {
            color: #1e3799;
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        .quiz-data-form input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .quiz-data-form input[type="submit"] {
            background-color: #1e3799;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s;
            padding: 10px;
            width: 100%;
            border-radius: 5px;
        }

        .quiz-data-form input[type="submit"]:hover {
            background-color: #450fa1;
        }
    </style>
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
        <h2 class="dashboard-title">Enter Quiz Data</h2>

        <!-- Quiz Data Form -->
        <div class="quiz-data-form">
            <form action="GenerateQuizFormServlet" method="post">
                <input type="hidden" name="quiz_id" value="<%= request.getParameter("quiz_id") %>">

                <label for="numQuestions">Number of Questions:</label>
                <input type="number" id="numQuestions" name="numQuestions" min="1" required>

                <input type="submit" value="Generate Form">
            </form>
        </div>
    </div>

    <script>
        // Display current time
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleTimeString();
            document.getElementById("currentTime").textContent = timeString;
        }
        setInterval(updateTime, 1000); // Update time every second
    </script>

</body>
</html>
