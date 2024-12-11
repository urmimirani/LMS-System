package example;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizDataDAO {
    private Connection conn;

    public QuizDataDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms_db?useSSL=false", "root", "");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to save quiz data in batch mode
    public void saveQuizDataBatch(List<QuizData> quizDataList) {
        String query = "INSERT INTO quiz_data (quiz_id, question_no_data, question_text, option1, option2, option3, option4, correct) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            for (QuizData quizData : quizDataList) {
                ps.setInt(1, quizData.getQuizId());
                ps.setInt(2, quizData.getQuestionNo());
                ps.setString(3, quizData.getQuestionText());
                ps.setString(4, quizData.getOption1());
                ps.setString(5, quizData.getOption2());
                ps.setString(6, quizData.getOption3());
                ps.setString(7, quizData.getOption4());
                ps.setInt(8, quizData.getCorrect());
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to retrieve questions by quiz_id
    // Method to retrieve questions by quiz_id
    public List<QuizData> getQuestionsByQuizId(int quizId) {
        List<QuizData> questions = new ArrayList<>();
        String query = "SELECT question_no_data, question_text, option1, option2, option3, option4, correct FROM quiz_data WHERE quiz_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, quizId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                QuizData question = new QuizData(
                    quizId,
                    rs.getInt("question_no_data"),
                    rs.getString("question_text"),
                    rs.getString("option1"),
                    rs.getString("option2"),
                    rs.getString("option3"),
                    rs.getString("option4"),
                    rs.getInt("correct")
                );
                questions.add(question);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
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
