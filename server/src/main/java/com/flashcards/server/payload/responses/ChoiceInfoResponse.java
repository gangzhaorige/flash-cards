package com.flashcards.server.payload.responses;

public class ChoiceInfoResponse {

    private long id;
    private String answer;
    private long cardId;

    public ChoiceInfoResponse(long id, String answer, long cardId) {
        this.id = id;
        this.answer = answer;
        this.cardId = cardId;
    }

    public long getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAnswer() {
        return this.answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public long getCardId() {
        return this.cardId;
    }

    public void setCardId(long cardId) {
        this.cardId = cardId;
    }

}