package com.synergisticit.client;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.synergisticit.domain.DesiredPlan;
import com.synergisticit.domain.Driver;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class DesiredPlanClient {
    public JsonNode saveDriver(DesiredPlan desiredPlan) {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .postForEntity( "http://localhost:8686//saveDesiredPlan", desiredPlan, Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode findDesiredPlanById(Long desiredPlanId) {
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8686//desiredPlan/"+ desiredPlanId , Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode findAllDesiredPlans() {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8686//desiredPlans", Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode desiredPlanByUsername(String username) {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8686//desiredPlanByUsername/" + username, Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }
}
