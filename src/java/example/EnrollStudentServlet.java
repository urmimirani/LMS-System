
package example;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
//import dao.EnrollmentDAO;


public class EnrollStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int courseId = Integer.parseInt(request.getParameter("course_id"));
        String[] studentIds = request.getParameter("student_ids").split(",");

        EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
        for (String studentId : studentIds) {
            enrollmentDAO.enrollStudent(courseId, Integer.parseInt(studentId.trim()));
        }

        response.sendRedirect("teacher_dashboard.jsp");
    }
}
