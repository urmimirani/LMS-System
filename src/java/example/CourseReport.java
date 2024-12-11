package example;

public class CourseReport {
    private int courseId;
    private double ceMarks;
    private double labMarks;
    private double endsemMarks;
    private double finalMarks;
    private String grade;

    public CourseReport(int courseId, double ceMarks, double labMarks, double endsemMarks, double finalMarks, String grade) {
        this.courseId = courseId;
        this.ceMarks = ceMarks;
        this.labMarks = labMarks;
        this.endsemMarks = endsemMarks;
        this.finalMarks = finalMarks;
        this.grade = grade;
    }

    // Getters and setters
    public int getCourseId() {
        return courseId;
    }

    public double getCeMarks() {
        return ceMarks;
    }

    public double getLabMarks() {
        return labMarks;
    }

    public double getEndsemMarks() {
        return endsemMarks;
    }

    public double getFinalMarks() {
        return finalMarks;
    }

    public String getGrade() {
        return grade;
    }
}
