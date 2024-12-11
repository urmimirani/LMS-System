package example;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CourseListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"teacher".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int teacherId = user.getId(); // Retrieve the teacher's ID
        CourseDAO courseDAO = new CourseDAO();
        List<Course> courses = courseDAO.getCoursesByTeacherId(teacherId);

        // Set the list of courses as a request attribute
        request.setAttribute("courses", courses); 

        // Determine which JSP to forward to based on the 'target' parameter
        String targetPage = request.getParameter("target");
        if ("enroll_students".equals(targetPage)) {
            request.getRequestDispatcher("enroll_students.jsp").forward(request, response);
        } else if ("upload_materials".equals(targetPage)) {
            request.getRequestDispatcher("upload_materials.jsp").forward(request, response);
        } else if ("create_quiz".equals(targetPage)) {
            request.getRequestDispatcher("create_quiz.jsp").forward(request, response);
        } else if ("assessments".equals(targetPage)) {
            request.getRequestDispatcher("assessments.jsp").forward(request, response);
        }
        else {
            response.sendRedirect("teacher_dashboard.jsp"); // Default redirection if target is not recognized
        }
    }
}
