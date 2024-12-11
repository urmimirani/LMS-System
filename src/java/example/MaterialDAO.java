package example;

//import Material;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MaterialDAO {
    private Connection conn;

    // Constructor to set up the connection
    public MaterialDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms_db?useSSL=false", "root", "");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to add a new material
    public void addMaterial(Material material) {
    String query = "INSERT INTO Materials (course_id,file_path) VALUES (?, ?)";
    try (PreparedStatement ps = conn.prepareStatement(query)) {
        
        ps.setInt(1, material.getCourseId());
        ps.setString(2, material.getFilePath());
        int rows = ps.executeUpdate();
        System.out.println("Rows inserted: " + rows);
        System.out.println("Inserting file: " + material.getFilePath() + " for course: " + material.getCourseId());

    } catch (SQLException e) {
        System.out.println("SQL error in addMaterial:");
        e.printStackTrace();
    }
}

    // Method to get materials by course ID
    public List<Material> getMaterialsByCourseId(int courseId) {
        List<Material> materials = new ArrayList<>();
        String query = "SELECT * FROM Materials WHERE course_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Material material = new Material();
                material.setMaterialId(rs.getInt("material_id"));
                material.setFilePath(rs.getString("file_path"));
                material.setCourseId(rs.getInt("course_id"));
                materials.add(material);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materials;
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
