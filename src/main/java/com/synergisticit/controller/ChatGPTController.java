package com.synergisticit.controller;


import com.synergisticit.dto.*;
import com.synergisticit.service.ChatGPTService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
public class ChatGPTController {

    @RestController
    public class ChatGPTRestController{

        @Autowired
        ChatGPTService chatGPTService;


        @PostMapping("/searchChatGPT")
        public String searchChatGPT(@RequestBody SearchRequest searchRequest){

            System.out.println("SearchGPT:" + searchRequest.getQuery());
            System.out.println("RESPONDE: " + chatGPTService.processSearch(searchRequest.getQuery()));
            return chatGPTService.processSearch(searchRequest.getQuery());
        }

    }
}

