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
    <title>Teacher Dashboard</title>
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

        /* Username display */
        .username-display {
            position: absolute;
            top: 20px;
            right: 20px;
            color: #2e86de;
            font-weight: bold;
            font-size: 1.1em;
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
               /* Notes section styling */
        .notes-section {
            padding: 20px;
            width: 100%;
            text-align: left;
            border-radius: 10px;
        }

        .notes-section h3 {
            color: #1e3799;
            margin-bottom: 10px;
        }

        .notes-section textarea {
            width: 100%;
            padding: 10px;
            font-size: 1em;
            border: none; /* No border */
            outline: none; /* Remove outline on focus */
            resize: none;
            height: 300px;
            background-color: #bbdefb; /* Light yellow background */
        }

        .notes-section button {
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #1e3799;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s;
        }

        .notes-section button:hover {
            background-color: #450fa1;
        }

        /* Course cards container */
        .course-cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            width: 100%;
        }

        /* Course card styling */
        .course-card {
            background-color: #fff;
            width: 250px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            text-align: left;
        }

        .course-card h3 {
            color: #1e3799;
            margin-bottom: 10px;
        }

        .course-card p {
            margin: 5px 0;
            color: #333;
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
        <a href="CourseListServlet?target=assessments">Record Assessments</a> <!-- Add this line -->
        <a href="discussion_forum.jsp">Discussion Forum</a>
        <a href="LogoutServlet">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Username Display -->
        <%
            // Retrieve loggedInUser from session
            User loggedInUser = (User) session.getAttribute("user");
            if (loggedInUser == null) {
                // If user is not logged in, redirect to login page
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div class="username-display">
            <%= loggedInUser.getUsername() %>
        </div>

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
        <h2 class="dashboard-title">Teacher Dashboard</h2>

        <!-- Course Cards -->
        <div class="course-cards">
            <%
                if ("teacher".equals(loggedInUser.getRole())) {
                    int teacherId = loggedInUser.getId();
                    CourseDAO courseDAO = new CourseDAO();
                    List<Course> courses = courseDAO.getCoursesByTeacherId(teacherId);
                    courseDAO.close();

                    for (Course course : courses) {
            %>
            <div class="course-card">
                <h3><%= course.getCourseName() %></h3>
                <p><strong>Course ID:</strong> <%= course.getCourseId() %></p>
                <p><strong>Description:</strong> <%= course.getDescription() %></p>
            </div>
            <%
                    }
                } else {
                    out.print("<p>You are not authorized to view this page.</p>");
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
