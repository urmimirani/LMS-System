package example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AssessmentsDAO {
    public boolean checkAssessmentExists(int studentId, int courseId) throws SQLException {
        String query = "SELECT COUNT(*) FROM assessments WHERE student_id = ? AND course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public double calculateQuizScore(int studentId, int courseId) throws SQLException {
        String query = "SELECT SUM(marks) FROM quiz_responses qr " +
                       "JOIN quizzes q ON qr.quiz_id = q.quiz_id " +
                       "WHERE qr.student_id = ? AND q.course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        }
        return 0;
    }

    public void insertAssessment(int studentId, int courseId, String division, int assignment, int midsem, int lab, int endsem, double quiz) throws SQLException {
        String query = "INSERT INTO assessments (student_id, course_id, division, assignment, midsem, lab, endsem, quiz) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            stmt.setString(3, division);
            stmt.setInt(4, assignment);
            stmt.setInt(5, midsem);
            stmt.setInt(6, lab);
            stmt.setInt(7, endsem);
            stmt.setDouble(8, quiz);
            stmt.executeUpdate();
        }
    }
    
        public List<Assessments> getAssessmentsByStudentId(int studentId) throws SQLException {
        String query = "SELECT * FROM assessments WHERE student_id = ?";
        List<Assessments> assessmentsList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Assessments assessment = new Assessments(
                        rs.getInt("student_id"),
                        rs.getInt("course_id"),
                        rs.getString("division"),
                        rs.getInt("quiz"),
                        rs.getInt("assignment"),
                        rs.getInt("midsem"),
                        rs.getInt("lab"),
                        rs.getInt("endsem")
                );
                assessmentsList.add(assessment);
            }
        }
        return assessmentsList;
    }

    public void updateAssessment(int studentId, int courseId, String division, int assignment, int midsem, int lab, int endsem, double newQuizScore) throws SQLException {
        String query = "UPDATE assessments SET division = ?, assignment = ?, midsem = ?, lab = ?, endsem = ?, quiz = ? WHERE student_id = ? AND course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, division);
            stmt.setInt(2, assignment);
            stmt.setInt(3, midsem);
            stmt.setInt(4, lab);
            stmt.setInt(5, endsem);
            stmt.setDouble(6, newQuizScore);
            stmt.setInt(7, studentId);
            stmt.setInt(8, courseId);
            stmt.executeUpdate();
        }
    }
}
