package example;

public class QuizData {
    private int quizId;
    private int questionNo;
    private String questionText;
    private String option1;
    private String option2;
    private String option3;
    private String option4;
    private int correct;

    public QuizData(int quizId, int questionNo, String questionText, String option1, String option2, String option3, String option4, int correct) {
        this.quizId = quizId;
        this.questionNo = questionNo;
        this.questionText = questionText;
        this.option1 = option1;
        this.option2 = option2;
        this.option3 = option3;
        this.option4 = option4;
        this.correct = correct;
    }

    public int getQuizId() {
        return quizId;
    }

    public int getQuestionNo() {
        return questionNo;
    }

    public String getQuestionText() {
        return questionText;
    }

    public String getOption1() {
        return option1;
    }

    public String getOption2() {
        return option2;
    }

    public String getOption3() {
        return option3;
    }

    public String getOption4() {
        return option4;
    }

    public int getCorrect() {
        return correct;
    }
}
