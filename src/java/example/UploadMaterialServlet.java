package example;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10,  // 10 MB
                 maxFileSize = 1024 * 1024 * 50,       // 50 MB
                 maxRequestSize = 1024 * 1024 * 100)   // 100 MB
public class UploadMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIR = "C:/uploads"; // Absolute path for uploads

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int courseId = Integer.parseInt(request.getParameter("course_id"));
            Part filePart = request.getPart("file");

            if (filePart == null || filePart.getSubmittedFileName() == null || filePart.getSubmittedFileName().isEmpty()) {
                System.out.println("File part is null or file name is empty.");
                response.sendRedirect("upload_material.jsp?error=file");
                return;
            }

            // Ensure the uploads directory exists
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String fileName = filePart.getSubmittedFileName();
            String filePath = UPLOAD_DIR + File.separator + fileName;

            // Write the file manually using FileOutputStream to avoid GlassFish deployment path issues
            try (InputStream inputStream = filePart.getInputStream();
                 FileOutputStream outputStream = new FileOutputStream(filePath)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            }

            // Save the relative path in the database
            Material material = new Material();
            material.setFilePath("uploads/" + fileName); // Store relative path in the database
            material.setCourseId(courseId);

            MaterialDAO materialDAO = new MaterialDAO();
            materialDAO.addMaterial(material);

            System.out.println("File uploaded successfully to: " + filePath);
            response.sendRedirect("teacher_dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("upload_material.jsp?error=internal");
        }
    }
}
