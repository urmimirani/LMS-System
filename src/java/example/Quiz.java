package example;

public class Quiz {
    private int quizId;
    private String quizTitle;
    private int courseId;
    
    public Quiz() {}

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public String getQuizTitle() {
        return quizTitle;
    }

    public void setQuizTitle(String quizTitle) {
        this.quizTitle = quizTitle;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }
    
    public Quiz(int quizId, String quizTitle, int courseId) {
        this.quizId = quizId;
        this.quizTitle = quizTitle;
        this.courseId = courseId;
    }

}
