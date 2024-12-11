package example;

import java.io.IOException;
import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import example.User;
import example.UserDAO;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        
        User user = new User(username, password, email, role);
        UserDAO userDAO = new UserDAO();
        boolean isSuccess = userDAO.registerUser(user);
        
        if (isSuccess) {
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("register.jsp?error=exists");
        }
    }
}
