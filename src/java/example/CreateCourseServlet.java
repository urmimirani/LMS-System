package example;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CreateCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String courseName = request.getParameter("course_name");
        String description = request.getParameter("description");

        // Retrieve the user from session and get the userId
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Check if user is null to prevent NullPointerException
        if (user == null) {
            // If user is not logged in, redirect to login page
            response.sendRedirect("login.jsp?error=notLoggedIn");
            return;
        }

        int teacherId = user.getId(); // Retrieve userId from the User object

        // Create a new course with the provided details
        Course course = new Course();
        course.setCourseName(courseName);
        course.setDescription(description);
        course.setTeacherId(teacherId);

        // Save the course using CourseDAO
        CourseDAO courseDAO = new CourseDAO();
        courseDAO.createCourse(course);

        // Redirect back to the teacher dashboard
        response.sendRedirect("teacher_dashboard.jsp");
    }
}
