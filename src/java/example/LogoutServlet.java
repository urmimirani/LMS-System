package example;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current session
        HttpSession session = request.getSession(false); // Fetch session if it exists, don't create a new one

        if (session != null) {
            // Get session ID and delete it from the database
            String sessionId = session.getId();
            UserDAO userDAO = new UserDAO();
            boolean sessionDeleted = userDAO.deleteSession(sessionId);
            System.out.println("Session deletion status: " + sessionDeleted);

            // Invalidate the current session
            session.invalidate();
        }

        // Redirect to the login page
        response.sendRedirect("login.jsp");
    }
}
