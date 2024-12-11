package example;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SubmitQuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int quizId = Integer.parseInt(request.getParameter("quiz_id"));
        int studentId = Integer.parseInt(request.getParameter("student_id"));

        QuizDataDAO quizDataDAO = new QuizDataDAO();
        List<QuizData> questions = quizDataDAO.getQuestionsByQuizId(quizId);
        quizDataDAO.close();

        List<QuizResponse> responses = new ArrayList<>();
        for (QuizData question : questions) {
            int questionNo = question.getQuestionNo();
            int selectedAnswer = Integer.parseInt(request.getParameter("answer_" + questionNo));
            int marks = (selectedAnswer == question.getCorrect()) ? 1 : 0;
            
            QuizResponse responseEntry = new QuizResponse(quizId, studentId, questionNo, selectedAnswer, marks);
            responses.add(responseEntry);
        }

        QuizResponseDAO quizResponseDAO = new QuizResponseDAO();
        quizResponseDAO.saveResponsesBatch(responses);
        quizResponseDAO.close();

        response.sendRedirect("student_dashboard.jsp");
    }
}
