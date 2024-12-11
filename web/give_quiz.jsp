<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="example.QuizDAO, example.Quiz" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Give Quiz</title>
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

        .quiz-list-section {
            background-color: #fff;
            padding: 20px;
            margin: 20px auto;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 600px;
        }

        .quiz-list-section h3 {
            font-size: 1.2em;
            margin-bottom: 15px;
            color: #1e3799;
        }

        .quiz-item a {
            display: block;
            color: #333;
            font-size: 1em;
            text-decoration: none;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }

        .quiz-item a:hover {
            background-color: #2e86de;
            color: #fff;
        }

        .no-quizzes-message {
            font-size: 1.1em;
            color: #999;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <a href="student_dashboard.jsp">Dashboard</a>
        <a href="discussion_forum.jsp">Discussion Forum</a>
        <a href="LogoutServlet">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="dashboard-title">Give Quiz</div>

        <!-- Quiz List Section -->
        <div class="quiz-list-section">
            <%
                int courseId = Integer.parseInt(request.getParameter("course_id"));
                int studentId = Integer.parseInt(request.getParameter("student_id"));

                QuizDAO quizDAO = new QuizDAO();
                List<Quiz> quizzes = quizDAO.getQuizzesByCourseId(courseId);
                quizDAO.close();

                if (quizzes.isEmpty()) {
            %>
                <p class="no-quizzes-message">No quizzes available for this course.</p>
            <%
                } else {
                    for (Quiz quiz : quizzes) {
            %>
                <div class="quiz-item">
                    <a href="ShowQuizServlet?quiz_id=<%= quiz.getQuizId() %>&student_id=<%= studentId %>">
                        <%= quiz.getQuizTitle() %>
                    </a>
                </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
