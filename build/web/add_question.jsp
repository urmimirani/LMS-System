<%-- 
    Document   : add_question
    Created on : Nov 10, 2024, 5:34:50 AM
    Author     : urmim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Add Question</title></head>
<body>
    <h2>Add a Question</h2>
    <form action="AddQuestionServlet" method="post">
        <input type="hidden" name="quiz_id" value="<%= request.getParameter("quizId") %>">
        
        <label>Question:</label><br>
        <textarea name="question_text" required></textarea><br><br>
        
        <label>Option 1:</label>
        <input type="text" name="option1" required><br>
        
        <label>Option 2:</label>
        <input type="text" name="option2" required><br>
        
        <label>Option 3:</label>
        <input type="text" name="option3" required><br>
        
        <label>Option 4:</label>
        <input type="text" name="option4" required><br>
        
        <label>Correct Answer:</label>
        <input type="text" name="correct" required><br><br>
        
        <input type="submit" value="Add Question">
    </form>
</body>
</html>

