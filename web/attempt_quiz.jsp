<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="example.QuizData" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attempt Quiz</title>
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

        .quiz-section {
            background-color: #fff;
            padding: 20px;
            margin: 20px auto;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 80%;
            max-width: 600px;
        }

        .quiz-section h3 {
            font-size: 1.2em;
            margin-bottom: 10px;
            color: #1e3799;
        }

        .quiz-section label {
            font-size: 1em;
            color: #333;
            display: block;
            margin: 5px 0;
        }

        .quiz-section input[type="radio"] {
            margin-right: 10px;
        }

        .quiz-section input[type="submit"] {
            background-color: #2e86de;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.3s;
            display: block;
            margin: 20px auto 0;
        }

        .quiz-section input[type="submit"]:hover {
            background-color: #1e3799;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <a href="student_dashboard.jsp">Dashboard</a>
        <a href="discussion_forum.jsp">Discussion Forum</a>
        <a href="LogoutServlet">Logout</a>
    </div>

    <div class="main-content">
        <div class="dashboard-title">Attempt Quiz</div>

        <div class="quiz-section">
            <form action="SubmitQuizServlet" method="post">
                <%
                    int quizId = (int) request.getAttribute("quiz_id");
                    int studentId = (int) request.getAttribute("student_id");
                    List<QuizData> questions = (List<QuizData>) request.getAttribute("questions");
                %>
                <input type="hidden" name="quiz_id" value="<%= quizId %>">
                <input type="hidden" name="student_id" value="<%= studentId %>">
                
                <%
                    for (QuizData question : questions) {
                %>
                    <h3>Question <%= question.getQuestionNo() %>: <%= question.getQuestionText() %></h3>
                    <label>
                        <input type="radio" name="answer_<%= question.getQuestionNo() %>" value="1" required>
                        <%= question.getOption1() %>
                    </label>
                    <label>
                        <input type="radio" name="answer_<%= question.getQuestionNo() %>" value="2" required>
                        <%= question.getOption2() %>
                    </label>
                    <label>
                        <input type="radio" name="answer_<%= question.getQuestionNo() %>" value="3" required>
                        <%= question.getOption3() %>
                    </label>
                    <label>
                        <input type="radio" name="answer_<%= question.getQuestionNo() %>" value="4" required>
                        <%= question.getOption4() %>
                    </label>
                <%
                    }
                %>
                <input type="submit" value="Submit Quiz">
            </form>
        </div>
    </div>
</body>
</html>
