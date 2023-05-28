package com.flashcards.server.payload.responses;

import java.util.List;

public class UserInfoResponse {
    private Long id;
    private String email;
    private String username;
    private List<String> roles;

    public UserInfoResponse(Long id, String email, String username, List<String> roles) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.roles = roles;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    public List<String> getRoles() {
        return roles;
    }
}