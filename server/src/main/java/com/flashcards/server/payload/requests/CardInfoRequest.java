package com.flashcards.server.payload.requests;

import javax.validation.constraints.NotBlank;

public class CardInfoRequest {
    @NotBlank
    private String question;

    @NotBlank
    private String answer;

    private boolean isMultipleChoice;


    public CardInfoRequest(String question, String answer, boolean isMultipleChoice) {
        this.question = question;
        this.answer = answer;
        this.isMultipleChoice = isMultipleChoice;
    }

    public String getQuestion() {
        return this.question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return this.answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
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
    
}
