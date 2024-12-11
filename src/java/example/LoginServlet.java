package example;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe"); // Checkbox value

        UserDAO userDAO = new UserDAO();
        User user = userDAO.validateUser(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Check if "Remember Me" is selected
            if ("on".equals(rememberMe)) {
                // Create a cookie for the session
                Cookie userCookie = new Cookie("userSession", session.getId());
                userCookie.setMaxAge(1 * 1 * 60 * 60); 
                userCookie.setHttpOnly(true); // More secure
                userCookie.setPath("/"); // Make cookie available to the whole application
                response.addCookie(userCookie);
                userDAO.createSession(session.getId(), user.getId()); // Ensure the correct method is called
            }
            
            // Redirect to the appropriate dashboard based on role
            if ("student".equals(user.getRole())) {
                response.sendRedirect("student_dashboard.jsp");
            } else {
                response.sendRedirect("teacher_dashboard.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}
