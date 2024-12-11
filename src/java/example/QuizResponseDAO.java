package example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class QuizResponseDAO {
    private Connection conn;

    public QuizResponseDAO() {
        try {
            conn = DBConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            // You may also choose to log this error or handle it in another way
        }
    }

    public void saveResponsesBatch(List<QuizResponse> responses) {
        String query = "INSERT INTO quiz_responses (quiz_id, student_id, question_no, answer_selected, marks) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            for (QuizResponse response : responses) {
                ps.setInt(1, response.getQuizId());
                ps.setInt(2, response.getStudentId());
                ps.setInt(3, response.getQuestionNo());
                ps.setInt(4, response.getAnswerSelected());
                ps.setInt(5, response.getMarks());
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void close() {
        try {
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
