package com.synergisticit.dto;

public class ChatGptMessage {
    private String content;
    private String role;

    public ChatGptMessage(String prompt) {
        this.role = "user";
        this.content = prompt;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContent() {
        return content;
    }

    public String getRole() {
        return role;
    }
}
