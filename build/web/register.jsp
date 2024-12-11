<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="example.LoginServlet" %>
<%@ page import="example.User" %>
<%@ page import="example.RegisterServlet" %>
<%@ page import="example.UserDAO" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
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
        .register-container {
            background-color: #fff;
            width: 300px;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        /* Title styling */
        .register-title {
            font-size: 1.5em;
            font-weight: bold;
            margin-bottom: 20px;
            color: #1e3799;
        }

        /* Input fields styling */
        .register-container input[type="text"],
        .register-container input[type="password"],
        .register-container input[type="email"],
        .register-container select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        /* Button styling */
        .register-btn {
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

        .register-btn:hover {
            background-color: #450fa1;
        }

        /* Link styling */
        .login-link {
            display: block;
            margin-top: 20px;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2 class="register-title">Create Your Account</h2>
        <form action="RegisterServlet" method="post">
            <input type="text" name="username" placeholder="User name" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="email" name="email" placeholder="Email" required>
            <select name="role" required>
                <option value="" disabled selected>Select role</option>
                <option value="student">Student</option>
                <option value="teacher">Teacher</option>
            </select>
            <button type="submit" class="register-btn">Register</button>
        </form>
        <p class="login-link">Already have an account? <a href="login.jsp">Log in here</a></p>
    </div>
</body>
</html>
