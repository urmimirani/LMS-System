package example;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet("/saveMessage")
public class SaveMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public SaveMessageServlet() {
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            String messageText = request.getParameter("messageText");

            if (user != null && messageText != null && !messageText.trim().isEmpty()) {
                boolean saved = userDAO.saveMessage(user.getId(), messageText);
                if (saved) {
                    response.sendRedirect("discussion_forum.jsp");
                } else {
                    response.getWriter().write("Failed to save message.");
                }
            } else {
                response.getWriter().write("Message text is required.");
            }
        } else {
            response.getWriter().write("Session error: please log in again.");
        }
    }
}
