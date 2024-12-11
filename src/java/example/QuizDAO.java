package example;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizDAO {
    private Connection conn;

    public QuizDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms_db?useSSL=false", "root", "");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public int createQuiz(Quiz quiz) {
        int quizId = -1; // Default value if insertion fails
        String query = "INSERT INTO quizzes (quiz_title, course_id) VALUES (?, ?)";
        
        try (PreparedStatement ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, quiz.getQuizTitle());
            ps.setInt(2, quiz.getCourseId());
            ps.executeUpdate();
            
            // Retrieve the generated quiz ID
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                quizId = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return quizId;
    }
    
    // Method to retrieve quizzes by course ID
    public List<Quiz> getQuizzesByCourseId(int courseId) {
        List<Quiz> quizzes = new ArrayList<>();
        String query = "SELECT * FROM quizzes WHERE course_id = ?";
        
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Quiz quiz = new Quiz(
                    rs.getInt("quiz_id"),
                    rs.getString("quiz_title"),
                    rs.getInt("course_id")
                );
                quizzes.add(quiz);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return quizzes;
    }

    public void close() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
