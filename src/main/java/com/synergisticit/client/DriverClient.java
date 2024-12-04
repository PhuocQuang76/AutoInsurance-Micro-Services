package com.synergisticit.client;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.synergisticit.domain.Driver;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;



@Component
public class DriverClient {
    public JsonNode saveDriver(Driver driver) {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .postForEntity( "http://localhost:8686//saveDriver", driver, Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode findDriverById(Long id) {
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8686//driver/"+ id , Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode findAllDrivers() {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8686//drivers", Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode findDriverByUsername(String username) {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8686//driverByUsername/"+ username, Object.class);
        Object objects = responseEntity.getBody();
        if(objects == null){
            System.out.println("Can not find the object.");
        }
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }
}
