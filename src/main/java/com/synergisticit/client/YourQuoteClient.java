package com.synergisticit.client;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.synergisticit.domain.YourQuote;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class YourQuoteClient {
    public JsonNode saveYourQuote(YourQuote yourQuote) {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .postForEntity( "http://localhost:8686//saveYourQuote", yourQuote, Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }


    public JsonNode findAllYourQuotes() {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8686//yourQuotes", Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode findYourQuoteByUsername(String username) {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8686//yourQuoteByUsername/"+ username, Object.class);
        Object objects = responseEntity.getBody();
        if(objects == null){
            System.out.println("Can not find the object.");
        }
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }
}
