package example;

public class QuizResponse {
    private int quizId;
    private int studentId;
    private int questionNo;
    private int answerSelected;
    private int marks;

    public QuizResponse(int quizId, int studentId, int questionNo, int answerSelected, int marks) {
        this.quizId = quizId;
        this.studentId = studentId;
        this.questionNo = questionNo;
        this.answerSelected = answerSelected;
        this.marks = marks;
    }

    // Getters and Setters
    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getQuestionNo() {
        return questionNo;
    }

    public void setQuestionNo(int questionNo) {
        this.questionNo = questionNo;
    }

    public int getAnswerSelected() {
        return answerSelected;
    }

    public void setAnswerSelected(int answerSelected) {
        this.answerSelected = answerSelected;
    }

    public int getMarks() {
        return marks;
    }

    public void setMarks(int marks) {
        this.marks = marks;
    }
}
