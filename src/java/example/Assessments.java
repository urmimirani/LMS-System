package example;

public class Assessments {
    private int studentId;
    private int courseId;
    private String division;
    private Integer quiz; // Nullable in the database
    private Integer assignment;
    private Integer midsem;
    private Integer lab;
    private Integer endsem;

    // Constructor with all fields
    public Assessments(int studentId, int courseId, String division, Integer quiz, Integer assignment, Integer midsem, Integer lab, Integer endsem) {
        this.studentId = studentId;
        this.courseId = courseId;
        this.division = division;
        this.quiz = quiz;
        this.assignment = assignment;
        this.midsem = midsem;
        this.lab = lab;
        this.endsem = endsem;
    }

    // Default constructor
    public Assessments() {}

    // Getters and Setters
    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getDivision() {
        return division;
    }

    public void setDivision(String division) {
        this.division = division;
    }

    public Integer getQuiz() {
        return quiz;
    }

    public void setQuiz(Integer quiz) {
        this.quiz = quiz;
    }

    public Integer getAssignment() {
        return assignment;
    }

    public void setAssignment(Integer assignment) {
        this.assignment = assignment;
    }

    public Integer getMidsem() {
        return midsem;
    }

    public void setMidsem(Integer midsem) {
        this.midsem = midsem;
    }

    public Integer getLab() {
        return lab;
    }

    public void setLab(Integer lab) {
        this.lab = lab;
    }

    public Integer getEndsem() {
        return endsem;
    }

    public void setEndsem(Integer endsem) {
        this.endsem = endsem;
    }

    // Method to calculate total score (if needed)
    public Integer calculateTotalScore() {
        int total = 0;
        total += (quiz != null) ? quiz : 0;
        total += (assignment != null) ? assignment : 0;
        total += (midsem != null) ? midsem : 0;
        total += (lab != null) ? lab : 0;
        total += (endsem != null) ? endsem : 0;
        return total;
    }

    @Override
    public String toString() {
        return "Assessments{" +
                "studentId=" + studentId +
                ", courseId=" + courseId +
                ", division='" + division + '\'' +
                ", quiz=" + quiz +
                ", assignment=" + assignment +
                ", midsem=" + midsem +
                ", lab=" + lab +
                ", endsem=" + endsem +
                '}';
    }
}
