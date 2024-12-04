package com.synergisticit.client;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.synergisticit.dto.ClaimDTO;
import com.synergisticit.dto.ClaimStatus;
import com.synergisticit.dto.ClaimUpdateDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;


@Component
public class ClaimClient {
    public JsonNode saveClaim(String username,String claimTitle,String status, String accidentDate,
                              String fileName, String itemDetailName, Long itemCost ) {
        ClaimDTO claimDTO = new ClaimDTO();
        claimDTO.setUsername(username);
//        claimDTO.setFile(file);
        claimDTO.setClaimTitle(claimTitle);

        claimDTO.setFileName(fileName);

        claimDTO.setStatus(ClaimStatus.valueOf(status));
        claimDTO.setItemDetailName(itemDetailName);
        claimDTO.setAccidentDate(accidentDate);
        claimDTO.setItemCost(itemCost);
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .postForEntity( "http://localhost:8989/claim/save", claimDTO, Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode findAllClaims(String username) {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8989//claimsByUsername/"+ username, Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode findClaimById(Long claimId) {
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8989//claim/"+ claimId , Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode updateClaim(ClaimUpdateDTO claimUpdateDTO) {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .postForEntity( "http://localhost:8989//updateClaim", claimUpdateDTO, Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    // Create a request object that includes the claimId and status
    public JsonNode findAllClaims() {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8989//claims", Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

}
