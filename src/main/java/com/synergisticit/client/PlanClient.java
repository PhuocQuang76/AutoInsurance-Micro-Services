package com.synergisticit.client;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class PlanClient {
    public JsonNode findPlans() {
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8686//plans", Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode findPlanById(Long id) {
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8686//plan/"+ id , Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }
}
