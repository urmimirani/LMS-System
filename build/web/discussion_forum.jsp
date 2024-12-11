<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="example.UserDAO" %>
<%@ page import="example.Message" %>
<%@ page import="example.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Discussion Forum</title>
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
        .discussion-form, .edit-form {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            margin: 0 auto 20px auto;
        }

        .discussion-form textarea, .edit-form textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .discussion-form button, .edit-form button {
            background-color: #1e3799;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 1em;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .discussion-form button:hover, .edit-form button:hover {
            background-color: #450fa1;
        }

        .message-container {
            background-color: #fff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            margin-bottom: 15px;
        }

        .message-container strong {
            color: #1e3799;
        }

        .message-container p {
            margin: 5px 0;
            color: #333;
        }

        .message-container small {
            color: #666;
        }

        .message-container a {
            color: #1e3799;
            margin-right: 10px;
        }

        .message-container hr {
            margin-top: 10px;
        }
    </style>
    <script>
        function showEditForm(messageId, currentText) {
            document.getElementById("editMessageId").value = messageId;
            document.getElementById("editMessageText").value = currentText;
            document.getElementById("editForm").style.display = "block";
        }
    </script>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <%
            
            User loggedInUser = (User) session.getAttribute("user");
            String dashboardLink = "login.jsp"; 
            if (loggedInUser != null) {
                
                if ("teacher".equals(loggedInUser.getRole())) {
                    dashboardLink = "teacher_dashboard.jsp";
                } else if ("student".equals(loggedInUser.getRole())) {
                    dashboardLink = "student_dashboard.jsp";
                }
            }
        %>
        <a href="<%= dashboardLink %>">Dashboard</a>
        <a href="discussion_forum.jsp" class="active">Discussion Forum</a>
        <a href="LogoutServlet">Logout</a>
    </div>


    <div class="main-content">

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

        <h2 class="dashboard-title">Discussion Forum</h2>

        <h3>Messages</h3>
        <%
            UserDAO userDAO = new UserDAO();
            List<Message> messages = userDAO.getAllMessages();
            for (Message message : messages) {
        %>
            <div class="message-container">
                <strong><%= message.getUsername() %> (<%= message.getRole() %>)</strong>
                <p><%= message.getMessageText() %></p>
                <small><%= message.getTimestamp() %></small>
                <br>
                <a href="javascript:void(0);" onclick="showEditForm(<%= message.getMessageId() %>, '<%= message.getMessageText() %>')">Edit</a> |
                <a href="deleteMessage?messageId=<%= message.getMessageId() %>">Delete</a>
                <hr>
            </div>
        <%
            }
        %>

        <div id="editForm" class="edit-form" style="display:none;">
            <h3>Edit Message</h3>
            <form action="editMessage" method="post">
                <input type="hidden" id="editMessageId" name="messageId">
                <textarea id="editMessageText" name="newMessageText" required></textarea>
                <button type="submit">Save Changes</button>
                <button type="button" onclick="document.getElementById('editForm').style.display='none'">Cancel</button>
            </form>
        </div>

        <div class="discussion-form">
            <form action="saveMessage" method="post">
                <textarea name="messageText" placeholder="Enter your message here..." required></textarea>
                <button type="submit">Send</button>
            </form>
        </div>
    </div>

    <script>

        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleTimeString();
            document.getElementById("currentTime").textContent = timeString;
        }
        setInterval(updateTime, 1000); 
    </script>

</body>
</html>
