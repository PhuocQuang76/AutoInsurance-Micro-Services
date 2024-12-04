package com.synergisticit.dto;


import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import lombok.Data;

@Data
public class ChatGPTRequest {

    //davinci-002
    // gpt-3.5-turbo
    private String model = "gpt-3.5-turbo";
    private JsonArray messages;

    public void addMessage(String message) {
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("role", "user");
        jsonObject.addProperty("content", message);
        messages = new JsonArray();
        messages.add(jsonObject);
    }

    public ChatGPTRequest() {
    }
}
