package com.synergisticit.service;

import com.google.gson.Gson;
import com.synergisticit.dto.*;
import jakarta.persistence.Entity;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ChatGPTService {
    @Value("${OPEN_AI_URL}")
    private String OPEN_AI_URL;

    @Value("${OPEN_AI_KEY}")
    private String OPEN_AI_KEY;

    public String processSearch(String query)  {
        ChatGPTRequest chatGPTRequest = new ChatGPTRequest();
        chatGPTRequest.addMessage(query);

        String url = OPEN_AI_URL;
        //HttpPost class is used to represent a POST request, with url as the endpoint for the request.
        // chatGPTRequest as request body
        HttpPost post = new HttpPost(url);
        post.addHeader("Content-Type","application/json");
        post.addHeader("Authorization","Bearer " + OPEN_AI_KEY);

        //The gson.toJson method is used to serialize an object to a JSON string
        Gson gson = new Gson();
        String body = gson.toJson(chatGPTRequest);

        System.out.println("body: " + body);
        try {
            //creating a StringEntity using the body string and set it to HttpPost
            final StringEntity entity = new StringEntity(body);
            post.setEntity(entity);

            //HttpClient will built and esecute the post then return a response body.
            try (CloseableHttpClient httpClient = HttpClients.custom().build();
                 CloseableHttpResponse response = httpClient.execute(post)) {

                //Then EntityUtils will convert response to String
                String responseBody = EntityUtils.toString(response.getEntity());
                System.out.println("responseBody :" + responseBody);


                ChatGPTResponse chatGPTResponse = gson.fromJson(responseBody,ChatGPTResponse.class);

                List<ChatGPTChoice> choices = chatGPTResponse.getChoices();
                for (ChatGPTChoice choice : choices) {
                    System.out.println("Choice content: " + choice.getMessage().getContent());
                    return choice.getMessage().getContent();
                }

            } catch (Exception e) {
                return "failed";
            }
        }catch (Exception e) {
            return "failed";


        }
        return  null;
    }

}

