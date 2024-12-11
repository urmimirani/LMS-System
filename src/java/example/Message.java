package example;

import java.sql.Timestamp;

public class Message {
    private int messageId;
    private int userId;
    private String username;
    private String role;
    private String messageText;
    private Timestamp timestamp;

    public Message(int messageId, int userId, String username, String role, String messageText, Timestamp timestamp) {
        this.messageId = messageId;
        this.userId = userId;
        this.username = username;
        this.role = role;
        this.messageText = messageText;
        this.timestamp = timestamp;
    }

    // Getters
    public int getMessageId() { return messageId; }
    public int getUserId() { return userId; }
    public String getUsername() { return username; }
    public String getRole() { return role; }
    public String getMessageText() { return messageText; }
    public Timestamp getTimestamp() { return timestamp; }
}
