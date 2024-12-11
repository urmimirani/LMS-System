<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="example.CourseDAO, example.MaterialDAO, example.UserDAO" %>
<%@ page import="example.Course, example.Material, example.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Course Details</title>
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

        .course-details, .materials-section {
            background-color: #fff;
            padding: 20px;
            margin: 20px auto;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 80%;
            max-width: 600px;
        }

        .course-details p, .materials-section h3 {
            font-size: 1.2em;
            line-height: 1.5;
        }

        .course-details p strong {
            color: #1e3799; 
            font-size: 1em; 
        }

        .materials-section h3 {
            color: #1e3799; 
            font-size: 1.2em;
            margin-bottom: 15px;
        }

        .material-item a {
            color: #333;
            font-size: 1em;
            text-decoration: none;
        }

        .material-item a:hover {
            text-decoration: underline;
        }

        /* Add spacing between sections */
        .course-details {
            margin-bottom: 20px;
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
        <div class="dashboard-title">Course Details</div>
        
        <div class="course-details">
            <%
                int courseId = Integer.parseInt(request.getParameter("course_id"));

                CourseDAO courseDAO = new CourseDAO();
                Course course = courseDAO.getCourseById(courseId);
                courseDAO.close();

                UserDAO userDAO = new UserDAO();
                User teacher = userDAO.getUserById(course.getTeacherId());
                userDAO.close();
            %>
            <p><strong>Course Name:</strong> <%= course.getCourseName() %></p>
            <p><strong>Course ID:</strong> <%= course.getCourseId() %></p>
            <p><strong>Description:</strong> <%= course.getDescription() %></p>
            <p><strong>Teacher:</strong> <%= teacher.getUsername() %></p>
        </div>

        <div class="materials-section">
            <h3>Course Materials</h3>
            <ul>
                <%

                    MaterialDAO materialDAO = new MaterialDAO();
                    List<Material> materials = materialDAO.getMaterialsByCourseId(courseId);
                    materialDAO.close();

                    if (materials.isEmpty()) {
                %>
                    <p>No materials available for this course.</p>
                <%
                    } else {
                        for (Material material : materials) {
                %>
                    <li class="material-item">
                        <a href="<%= request.getContextPath() %>/<%= material.getFilePath() %>" download>
                            <%= material.getFilePath().substring(material.getFilePath().lastIndexOf("/") + 1) %>
                        </a>
                    </li>
                <%
                        }
                    }
                %>
            </ul>
        </div>
    </div>
</body>
</html>
