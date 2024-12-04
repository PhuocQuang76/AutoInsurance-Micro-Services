package com.synergisticit.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
public class ChatGPTResponse {
    private List<ChatGPTChoice> choices;

}
