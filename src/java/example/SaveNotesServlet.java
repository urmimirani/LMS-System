package example;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class SaveNotesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String notes = request.getParameter("notes");
        HttpSession session = request.getSession(false);

        if (session != null) {

            String sessionId = session.getId();
            UserDAO userDAO = new UserDAO();

            User user = userDAO.getUserBySessionId(sessionId);

            if (user != null) {

                boolean saved = userDAO.saveNotes(sessionId, notes);

                if (saved) {

                    String role = user.getRole();
                    if ("student".equalsIgnoreCase(role)) {
                        response.sendRedirect("student_dashboard.jsp"); 
                    } else if ("teacher".equalsIgnoreCase(role)) {
                        response.sendRedirect("teacher_dashboard.jsp"); 
                    } else {
                        response.getWriter().write("Unknown role: access denied.");
                    }
                } else {
                    response.getWriter().write("Failed to save notes.");
                }
            } else {
                response.getWriter().write("Session error: user not found. Please log in again.");
            }
        } else {
            response.getWriter().write("Session error: please log in again.");
        }
    }
}
