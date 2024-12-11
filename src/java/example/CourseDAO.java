package example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {
    private Connection conn;

    // Constructor to set up the connection
    public CourseDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms_db?useSSL=false", "root", "");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to create a new course
    public void createCourse(Course course) {
        String query = "INSERT INTO Courses (course_name, description, teacher_id) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, course.getCourseName());
            ps.setString(2, course.getDescription());
            ps.setInt(3, course.getTeacherId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to retrieve courses by teacher ID
    public List<Course> getCoursesByTeacherId(int teacherId) {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT * FROM Courses WHERE teacher_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setCourseName(rs.getString("course_name"));
                course.setDescription(rs.getString("description"));
                course.setTeacherId(rs.getInt("teacher_id"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    public Course getCourseById(int courseId) {
    Course course = null;
    String query = "SELECT * FROM Courses WHERE course_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, courseId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            course = new Course();
            course.setCourseId(rs.getInt("course_id"));
            course.setCourseName(rs.getString("course_name"));
            course.setDescription(rs.getString("description"));
            course.setTeacherId(rs.getInt("teacher_id"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return course;
}

    
    public List<Course> getCoursesByStudentId(int studentId) {
    List<Course> courses = new ArrayList<>();
    String query = "SELECT c.course_id, c.course_name, c.description, c.teacher_id " +
                   "FROM Courses c " +
                   "JOIN Enrollments e ON c.course_id = e.course_id " +
                   "WHERE e.student_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, studentId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Course course = new Course();
            course.setCourseId(rs.getInt("course_id"));
            course.setCourseName(rs.getString("course_name"));
            course.setDescription(rs.getString("description"));
            course.setTeacherId(rs.getInt("teacher_id"));
            courses.add(course);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return courses;
}


    // Closing connection manually, similar to UserDAO approach
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
