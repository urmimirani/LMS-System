package example;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/deleteMessage")
public class DeleteMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public DeleteMessageServlet() {
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int messageId = Integer.parseInt(request.getParameter("messageId"));
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user != null && userDAO.deleteMessage(messageId, user.getId())) {
            response.sendRedirect("discussion_forum.jsp");
        } else {
            response.getWriter().write("Failed to delete message. You can only delete your own messages.");
        }
    }
}
