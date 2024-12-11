package example;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ShowQuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int quizId = Integer.parseInt(request.getParameter("quiz_id"));
        int studentId = Integer.parseInt(request.getParameter("student_id"));

        QuizDataDAO quizDataDAO = new QuizDataDAO();
        List<QuizData> questions = quizDataDAO.getQuestionsByQuizId(quizId);
        quizDataDAO.close();

        request.setAttribute("questions", questions);
        request.setAttribute("quiz_id", quizId);
        request.setAttribute("student_id", studentId);
        request.getRequestDispatcher("attempt_quiz.jsp").forward(request, response);
    }
}
