package example;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/editMessage")
public class EditMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public EditMessageServlet() {
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int messageId = Integer.parseInt(request.getParameter("messageId"));
        String newMessageText = request.getParameter("newMessageText");
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user != null && userDAO.editMessage(messageId, newMessageText, user.getId())) {
            response.sendRedirect("discussion_forum.jsp");
        } else {
            response.getWriter().write("Failed to edit message. You can only edit your own messages.");
        }
    }
}

