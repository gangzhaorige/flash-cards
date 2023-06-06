package com.flashcards.server.payload.requests;

import java.util.List;

public class MultipleChoiceCardInfoRequest extends CardInfoRequest {
    List<String> choices;
    public MultipleChoiceCardInfoRequest(String question, String answer, boolean isMultipleChoice, List<String> choices) {
        super(question, answer, isMultipleChoice);
        this.choices = choices;
    }

    public List<String> getChoices() {
        return this.choices;
    }

    public void setChoices(List<String> choices) {
        this.choices = choices;
    }
}