package com.flashcards.server.payload.responses;

public class CardInfoResponse {
    public Long id;
    public String question;
    public boolean isMultipleChoice;
    public String answer;

    public CardInfoResponse(Long id, String question, boolean isMultipleChoice, String answer) {
        this.id = id;
        this.question = question;
        this.isMultipleChoice = isMultipleChoice;
        this.answer = answer;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getQuestion() {
        return this.question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public boolean isIsMultipleChoice() {
        return this.isMultipleChoice;
    }

    public boolean getIsMultipleChoice() {
        return this.isMultipleChoice;
    }

    public void setIsMultipleChoice(boolean isMultipleChoice) {
        this.isMultipleChoice = isMultipleChoice;
    }

    public String getAnswer() {
        return this.answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

}
