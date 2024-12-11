package example;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public class SaveAssessmentsServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch input data from the form
        String division = request.getParameter("division");
        int studentId = Integer.parseInt(request.getParameter("student_id"));
        int courseId = Integer.parseInt(request.getParameter("course_id"));
        int assignment = Integer.parseInt(request.getParameter("assignment"));
        int midsem = Integer.parseInt(request.getParameter("midsem"));
        int lab = Integer.parseInt(request.getParameter("lab"));
        int endsem = Integer.parseInt(request.getParameter("endsem"));

        // Instantiate DAO to perform database operations
        AssessmentsDAO dao = new AssessmentsDAO();
        try {
            // Calculate quiz score using quiz responses
            double quizScore = dao.calculateQuizScore(studentId, courseId);

            // Check if the assessment record already exists
            if (dao.checkAssessmentExists(studentId, courseId)) {
                // If exists, update the record
                dao.updateAssessment(studentId, courseId, division, assignment, midsem, lab, endsem, quizScore);
            } else {
                // If not exists, insert a new record
                dao.insertAssessment(studentId, courseId, division, assignment, midsem, lab, endsem, quizScore);
            }

            // Redirect to a confirmation or success page
            response.sendRedirect("teacher_dashboard.jsp");
        } catch (SQLException e) {
            // Handle SQL errors
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
