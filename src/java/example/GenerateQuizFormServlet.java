package example;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class GenerateQuizFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int numQuestions;
        int quizId;

        try {
            numQuestions = Integer.parseInt(request.getParameter("numQuestions"));
            quizId = Integer.parseInt(request.getParameter("quiz_id"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Invalid input data.");
            return;
        }

        request.setAttribute("numQuestions", numQuestions);
        request.setAttribute("quiz_id", quizId);
        request.getRequestDispatcher("generateQuizDataForm.jsp").forward(request, response);
    }
}
