<%@page import="example.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="example.Course" %>
<%@ page import="example.CourseDAO" %>
<%@ page import="example.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <style>
        /* Basic reset */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        /* Body styling */
        body { font-family: Arial, sans-serif; background-color: #e6f7ff; padding: 0; display: flex; height: 100vh; overflow: hidden; }
        .logout-btn { background-color: #e91e63; margin: 10px; text-align: center; padding: 10px; border-radius: 5px; cursor: pointer; font-size: 1.1em; transition: background-color 0.3s; }
        .logout-btn:hover { background-color: #c2185b; }
        /* Main content area */
        .main-content { flex: 1; padding: 20px; position: relative; overflow-y: auto; }
        .dashboard-title { font-size: 2em; font-weight: bold; color: #1e3799; margin-bottom: 20px; text-align: center; }
        /* Sidebar styling */
        .sidebar { width: 250px; background-color: #2e86de; padding: 20px; display: flex; flex-direction: column; color: #fff; }
        .sidebar a { display: block; color: #fff; padding: 15px; text-decoration: none; border-radius: 5px; margin: 5px 0; transition: background-color 0.3s; text-align: left; }
        .sidebar a:hover, .sidebar a.active { background-color: #1e3799; }
        /* Username display */
        .username-display { position: absolute; top: 20px; right: 20px; color: #2e86de; font-weight: bold; font-size: 1.1em; }
        /* Course cards container */
        .course-cards { display: flex; flex-wrap: wrap; justify-content: center; gap: 20px; width: 100%; }
        /* Course card styling */
        .course-card { background-color: #fff; width: 250px; padding: 20px; border-radius: 10px; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2); text-align: left; }
        .course-card h3 { color: #1e3799; margin-bottom: 10px; }
        .course-card p { margin: 5px 0; color: #333; }
        .course-card button {
        background-color: #2e86de;
        color: #fff;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 1em;
        transition: background-color 0.3s;
    }
        .course-card form {
        margin-bottom: 15px; /* Space between buttons */
        }
    .course-card button:hover {
        background-color: #1e3799; /* Darker shade on hover */
    }
        /* Notes section styling */
        .notes-section { padding: 20px; width: 100%; text-align: left; border-radius: 10px; }
        .notes-section h3 { color: #1e3799; margin-bottom: 10px; }
        .notes-section textarea { width: 100%; padding: 10px; font-size: 1em; border: none; outline: none; resize: none; height: 300px; background-color: #bbdefb; }
        .notes-section button { margin-top: 10px; padding: 10px 20px; background-color: #1e3799; color: #fff; border: none; border-radius: 5px; cursor: pointer; font-size: 1em; transition: background-color 0.3s; }
        .notes-section button:hover { background-color: #450fa1; }  
    </style>
</head>
<body>
    <div class="sidebar">
        <a href="student_dashboard.jsp">Dashboard</a>
        <a href="discussion_forum.jsp">Discussion Forum</a>
        <a href="view_reports.jsp">Exam Reports</a>
        <a href="LogoutServlet">Logout</a>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <%
            User loggedInUser = (User) session.getAttribute("user");
            if (loggedInUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div class="username-display"><%= loggedInUser.getUsername() %></div>
        <div class="dashboard-title">Student Dashboard</div>

        <!-- Retrieve and Display Enrolled Courses -->
        <div class="course-cards">
            <%
                CourseDAO courseDAO = new CourseDAO();
                List<Course> enrolledCourses = courseDAO.getCoursesByStudentId(loggedInUser.getId());
                courseDAO.close();
                
                if (enrolledCourses.isEmpty()) {
                    out.print("<p>No courses enrolled.</p>");
                } else {
                    for (Course course : enrolledCourses) {
            %>
            <div class="course-card">
                <h3><%= course.getCourseName() %></h3>
    <form action="course_details.jsp" method="get">
        <input type="hidden" name="course_id" value="<%= course.getCourseId() %>">
        <button type="submit">Go to Course</button>
    </form>
    <form action="give_quiz.jsp" method="get">
        <input type="hidden" name="course_id" value="<%= course.getCourseId() %>">
        <input type="hidden" name="student_id" value="<%= loggedInUser.getId() %>">
        <button type="submit">Give Quiz</button>
    </form>
            </div>
            <%
                    }
                }
            %>
        </div>

        <!-- Notes Section with Form Submission -->
        <div class="notes-section">
            <h3>Notes</h3>
            <form action="SaveNotesServlet" method="POST">
                <textarea id="notes" name="notes" rows="5" placeholder="Enter your notes here..."><%= new UserDAO().getNotes(session.getId()) %></textarea>
                <button type="submit">Save Notes</button>
            </form>
        </div>
    </div>
</body>
</html>
