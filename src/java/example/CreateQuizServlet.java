package example;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CreateQuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String quizTitle = request.getParameter("quiz_title");
        int courseId = Integer.parseInt(request.getParameter("course_id"));

        Quiz quiz = new Quiz();
        quiz.setQuizTitle(quizTitle);
        quiz.setCourseId(courseId);

        QuizDAO quizDAO = new QuizDAO();
        int quizId = quizDAO.createQuiz(quiz);

        // Redirect to quizdataform.jsp with quiz_id as parameter
        response.sendRedirect("quizdataform.jsp?quiz_id=" + quizId);
    }
}
