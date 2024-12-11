<%@page import="example.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="example.AssessmentsDAO, example.Assessments, example.CourseReport" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Reports</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #e6f7ff; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; background-color: #fff; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
        table th, table td { border: 1px solid #ddd; padding: 8px; text-align: center; }
        table th { background-color: #2e86de; color: #fff; }
        .cgpa { font-size: 1.5em; font-weight: bold; color: #1e3799; text-align: center; margin-top: 20px; }
    </style>
</head>
<body>
    <h1>Exam Reports</h1>
    <%
 
        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

     
        AssessmentsDAO assessmentsDAO = new AssessmentsDAO();
        List<Assessments> studentAssessments = assessmentsDAO.getAssessmentsByStudentId(loggedInUser.getId());
        List<CourseReport> courseReports = new ArrayList<CourseReport>();
        double totalGradePoints = 0;
        int totalCourses = studentAssessments.size();

        
        for (int i = 0; i < studentAssessments.size(); i++) {
            Assessments assessment = studentAssessments.get(i);

            double quiz = assessment.getQuiz(); // Out of 20
            double assignment = assessment.getAssignment(); // Out of 20
            double midsem = (assessment.getMidsem() * 60) / 50.0; // Convert to 60
            double lab = (assessment.getLab() * 30) / 100.0; // Convert to 30
            double endsem = (assessment.getEndsem() * 40) / 100.0; // Convert to 40

            double ceMarks = quiz + assignment + midsem;
            double ceOutOf30 = (ceMarks * 30) / 100.0;

            double finalMarks = ceOutOf30 + lab + endsem;

            double gradePoints;
            String grade;
            if (finalMarks > 90) {
                grade = "O";
                gradePoints = 10;
            } else if (finalMarks > 80) {
                grade = "A+";
                gradePoints = 9;
            } else if (finalMarks > 70) {
                grade = "A";
                gradePoints = 8;
            } else if (finalMarks > 60) {
                grade = "B+";
                gradePoints = 7;
            } else if (finalMarks > 50) {
                grade = "B";
                gradePoints = 6;
            } else if (finalMarks > 40) {
                grade = "C";
                gradePoints = 5;
            } else {
                grade = "F";
                gradePoints = 0;
            }


            totalGradePoints += gradePoints;

            CourseReport report = new CourseReport(
                assessment.getCourseId(),
                ceMarks,
                lab,
                endsem,
                finalMarks,
                grade
            );
            courseReports.add(report);
        }

        double cgpa = (totalCourses > 0) ? totalGradePoints / totalCourses : 0;
    %>

    <table>
        <thead>
            <tr>
                <th>Course ID</th>
                <th>CE Marks (30)</th>
                <th>Lab Marks (30)</th>
                <th>Endsem Marks (40)</th>
                <th>Final Marks (100)</th>
                <th>Grade</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (int i = 0; i < courseReports.size(); i++) {
                    CourseReport report = courseReports.get(i);
            %>
            <tr>
                <td><%= report.getCourseId() %></td>
                <td><%= report.getCeMarks() %></td>
                <td><%= report.getLabMarks() %></td>
                <td><%= report.getEndsemMarks() %></td>
                <td><%= report.getFinalMarks() %></td>
                <td><%= report.getGrade() %></td>
            </tr>
            <%
                }
                if (courseReports.isEmpty()) {
            %>
            <tr>
                <td colspan="6">No data available</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <div class="cgpa">
        Your CGPA: <%= cgpa %>
    </div>
</body>
</html>
