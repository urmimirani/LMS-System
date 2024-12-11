package example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private Connection conn;

    // Constructor to establish a connection to the database
    public UserDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms_db?useSSL=false", "root", "");
            System.out.println("Database connected successfully.");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Database connection failed.");
            e.printStackTrace();
        }
    }

    // Validates user credentials and retrieves user details
    public User validateUser(String username, String password) {
        User user = null;
        try {
            String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("role"));
                System.out.println("User validated: " + user.getUsername() + " with role: " + user.getRole());
            } else {
                System.out.println("Invalid username or password.");
            }
        } catch (SQLException e) {
            System.out.println("SQL exception during user validation.");
            e.printStackTrace();
        }
        return user;
    }

    // Registers a new user in the database
    public boolean registerUser(User user) {
        try {
            String sql = "INSERT INTO Users (username, password, email, role) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getRole());
            int rows = stmt.executeUpdate();
            System.out.println("User registered: " + user.getUsername() + " with role: " + user.getRole());
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("SQL exception during user registration.");
            e.printStackTrace();
        }
        return false;
    }

    // Creates a session for the user in the sessions table
    public boolean createSession(String sessionId, int userId) {
        try {
            System.out.println("Creating session with sessionId: " + sessionId + " for userId: " + userId);
            String sql = "INSERT INTO sessions (sessionId, userId) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, sessionId);
            stmt.setInt(2, userId);
            int rows = stmt.executeUpdate();
            System.out.println("Session created: " + (rows > 0));
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("SQL exception during session creation.");
            e.printStackTrace();
        }
        return false;
    }

    // Retrieves a user based on a session ID from the sessions table
    public User getUserBySessionId(String sessionId) {
        User user = null;
        try {
            String sql = "SELECT u.* FROM users u INNER JOIN sessions s ON u.user_id = s.userId WHERE s.sessionId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, sessionId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("role"));
                System.out.println("User retrieved by sessionId: " + sessionId + " - Username: " + user.getUsername());
            } else {
                System.out.println("No user found for sessionId: " + sessionId);
            }
        } catch (SQLException e) {
            System.out.println("SQL exception during retrieval by sessionId.");
            e.printStackTrace();
        }
        return user;
    }
    
    public boolean deleteSession(String sessionId) {
    try {
        String sql = "DELETE FROM sessions WHERE sessionId = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, sessionId);
        int rows = stmt.executeUpdate();
        System.out.println("Session deleted: " + (rows > 0));
        return rows > 0;
    } catch (SQLException e) {
        System.out.println("SQL exception during session deletion.");
        e.printStackTrace();
    }
    return false;
    }
    
    // Method to save notes in the session
    public boolean saveNotes(String sessionId, String notes) {
        try {
            String sql = "UPDATE sessions SET notes = ? WHERE sessionId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, notes);
            stmt.setString(2, sessionId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("SQL exception during notes saving.");
            e.printStackTrace();
        }
        return false;
    }

    // Method to retrieve notes from the session
    public String getNotes(String sessionId) {
        String notes = "";
        try {
            String sql = "SELECT notes FROM sessions WHERE sessionId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, sessionId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                notes = rs.getString("notes");
            }
        } catch (SQLException e) {
            System.out.println("SQL exception during notes retrieval.");
            e.printStackTrace();
        }
        return notes;
    }
    
    // Method to save a message to the discussion forum
public boolean saveMessage(int userId, String messageText) {
    try {
        String sql = "INSERT INTO Messages (UserID, MessageText) VALUES (?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        stmt.setString(2, messageText);
        int rows = stmt.executeUpdate();
        return rows > 0;
    } catch (SQLException e) {
        System.out.println("SQL exception during message saving.");
        e.printStackTrace();
    }
    return false;
}

// Method to retrieve all messages with username and role
public List<Message> getAllMessages() {
    List<Message> messages = new ArrayList<>();
    try {
        String sql = "SELECT m.MessageID, m.UserID, m.MessageText, m.Timestamp, u.username, u.role " +
                     "FROM Messages m " +
                     "JOIN Users u ON m.UserID = u.user_id " +
                     "ORDER BY m.Timestamp ASC";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            Message message = new Message(
                rs.getInt("MessageID"),
                rs.getInt("UserID"),
                rs.getString("username"),
                rs.getString("role"),
                rs.getString("MessageText"),
                rs.getTimestamp("Timestamp")
            );
            messages.add(message);
        }
    } catch (SQLException e) {
        System.out.println("SQL exception during message retrieval.");
        e.printStackTrace();
    }
    return messages;
}
// Check if the logged-in user is the owner of the message
private boolean isMessageOwner(int messageId, int userId) {
    try {
        String sql = "SELECT COUNT(*) FROM Messages WHERE MessageID = ? AND UserID = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, messageId);
        stmt.setInt(2, userId);
        ResultSet rs = stmt.executeQuery();
        rs.next();
        return rs.getInt(1) > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

// Method to edit a message only if the user is the owner
public boolean editMessage(int messageId, String newMessageText, int userId) {
    if (isMessageOwner(messageId, userId)) {
        try {
            String sql = "UPDATE Messages SET MessageText = ?, EditedTimestamp = CURRENT_TIMESTAMP WHERE MessageID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newMessageText);
            stmt.setInt(2, messageId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    return false;
}

// Method to delete a message only if the user is the owner
public boolean deleteMessage(int messageId, int userId) {
    if (isMessageOwner(messageId, userId)) {
        try {
            String sql = "DELETE FROM Messages WHERE MessageID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, messageId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    return false;
}

public User getUserById(int userId) {
    User user = null;
    String query = "SELECT * FROM Users WHERE user_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            user = new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("role"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return user;
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
