package example;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SaveQuizDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int quizId = Integer.parseInt(request.getParameter("quiz_id"));
        int numQuestions = Integer.parseInt(request.getParameter("numQuestions"));

        QuizDataDAO quizDataDAO = new QuizDataDAO();
        List<QuizData> quizDataList = new ArrayList<>();

        try {
            for (int i = 1; i <= numQuestions; i++) {
                int questionNo = Integer.parseInt(request.getParameter("question_no_" + i));
                String questionText = request.getParameter("question_text_" + i);
                String option1 = request.getParameter("option1_" + i);
                String option2 = request.getParameter("option2_" + i);
                String option3 = request.getParameter("option3_" + i);
                String option4 = request.getParameter("option4_" + i);
                int correct = Integer.parseInt(request.getParameter("correct_" + i));

                QuizData quizData = new QuizData(quizId, questionNo, questionText, option1, option2, option3, option4, correct);
                quizDataList.add(quizData);
            }

            quizDataDAO.saveQuizDataBatch(quizDataList);
            response.sendRedirect("create_quiz.jsp");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Invalid input data. Please check and try again.");
        } finally {
            quizDataDAO.close();
        }
    }
}
