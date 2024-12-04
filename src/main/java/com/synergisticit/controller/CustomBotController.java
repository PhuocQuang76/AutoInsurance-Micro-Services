package com.synergisticit.controller;

import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.exceptions.UnirestException;
import com.synergisticit.dto.ChatGPTRequest;
import com.synergisticit.dto.ChatGPTResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import com.mashape.unirest.http.Unirest;

@RestController
@RequestMapping("/bot")
public class CustomBotController {

//    @Value("${openai.model}")
//    private String model;
//
//    @Value("${openai.api.url}")
//    private String apiURL;

//    @Autowired
//    private RestTemplate template;
//
//    @GetMapping("/chat")
//    public String chat(@RequestParam("prompt") String prompt){
//        ChatGPTRequest request=new ChatGPTRequest(model, prompt);
//        request.setModel(model);
//        System.out.println(model);
//        ChatGPTResponse chatGptResponse = template.postForObject(apiURL, request, ChatGPTResponse.class);
//        return chatGptResponse.getChoices().get(0).getMessage().getContent();
//        Unirest.setTimeouts(0, 0);
//        String chatprompt = "{\n    \"prompt\": \"" + prompt + "\"\n}";
//        try {
//            HttpResponse<String> response = Unirest.post("https://api.openai.com/v1/engines/davinci-002/completions")
//                    .header("Authorization", "Bearer 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")
//                    .header("Content-Type", "application/json")
//                    .header("Cookie", "__cf_bm=etnnIaJchRH2_Ogd0LUmfpxncZjTNnGfuy5H3pQu0gg-1709072315-1.0-AXsAM4n/HYZaFc3iF3uCms6Q7GdT71c9iJY0loOKSRBaEwrNtCqOtW++2M9GwQ/f0HzHFaA1Vl6Q+bogi2J9Wro=; _cfuvid=kwLCygVAMzmBd9gCc1Wb6TJyT8OpCW_crmpBTeZEMgo-1709066428043-0.0-604800000")
//                    .body(chatprompt)
//                    .asString();
//            return response.getBody();
//        } catch (UnirestException e) {
//            throw new RuntimeException(e);
//        }
//    }
}
