<%-- 
    Document   : login
    Created on : Oct 23, 2024, 5:29:05 PM
    Author     : urmim
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="example.LoginServlet" %>
<%@ page import="example.User" %>
<%@ page import="example.RegisterServlet" %>
<%@ page import="example.UserDAO" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        /* Basic reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Centering container */
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            font-family: Arial, sans-serif;
            background-color: #e6f7ff; /* Light blue background */
        }

        /* Card container */
        .login-container {
            background-color: #fff;
            width: 300px;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        /* Title styling */
        .login-title {
            font-size: 1.5em;
            font-weight: bold;
            margin-bottom: 20px;
            color: #1e3799;
        }

        /* Input fields styling */
        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        /* Button styling */
        .login-btn {
            width: 100%;
            padding: 10px;
            background-color: #1e3799;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s;
        }

        .login-btn:hover {
            background-color: #450fa1;
        }

        /* Link styling */
        .forgot-password {
            display: block;
            margin-top: 15px;
            color: #e91e63;
            font-size: 0.9em;
            text-decoration: none;
        }

        .forgot-password:hover {
            text-decoration: underline;
        }

        .register-link {
            display: block;
            margin-top: 20px;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2 class="login-title">Welcome Back<br>Log In!</h2>
        <%

            HttpSession userSession = request.getSession(false);
            if (userSession != null) {
                User loggedInUser = (User) userSession.getAttribute("user");
                if (loggedInUser != null) {
                    String role = loggedInUser.getRole();

                    if ("student".equals(role)) {
                        response.sendRedirect("student_dashboard.jsp");
                    } else if ("teacher".equals(role)) {
                        response.sendRedirect("teacher_dashboard.jsp");
                    } else {
                        response.sendRedirect("login.jsp"); 
                    }
                    return;
                }
            }
        %>
        <%-- Check for error message --%>
        <%
            String error = request.getParameter("error");
            if ("invalid".equals(error)) {
        %>
            <div style="color: red; margin-bottom: 10px;">Invalid username or password!</div>
        <%
            }
        %>
        <form action="LoginServlet" method="post">
            <input type="text" name="username" placeholder="User name" required>
            <input type="password" name="password" placeholder="Password" required>
            <label>
                <input type="checkbox" name="rememberMe"> Remember Me
            </label>
            <button type="submit" class="login-btn">Log In</button>
        </form>
        <p class="register-link">Not registered? <a href="register.jsp">Register here</a></p>
    </div>
</body>
</html>
