package com.synergisticit.client;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.synergisticit.dto.*;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

@Component
public class DocumentClient {
//    public JsonNode saveDocument(DocumentDTO documentDTO, MultipartFile multipartFile) {
//        RestTemplate restTemplate = new RestTemplate();
//
//        ResponseEntity<Object> responseEntity = restTemplate
//                .postForEntity( "http://localhost:8686//document/save", documentDTO, Object.class);
//        Object objects = responseEntity.getBody();
//        ObjectMapper mapper = new ObjectMapper();
//        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
//        return returnObj;
//    }

//    public JsonNode saveDocument(byte[] file,String username,String status, String comment,String fileName) {
//        DocumentDTO documentDTO = new DocumentDTO();
//        documentDTO.setUsername(username);
//        documentDTO.setFile(file);
//        documentDTO.setStatus(status);
//        documentDTO.setComment(comment);
//        documentDTO.setFileName(fileName);
//
//        RestTemplate restTemplate = new RestTemplate();
//
//        ResponseEntity<Object> responseEntity = restTemplate
//                .postForEntity( "http://localhost:8686//document/save", documentDTO, Object.class);
//
//        Object objects = responseEntity.getBody();
//        ObjectMapper mapper = new ObjectMapper();
//        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
//        return returnObj;
//    }

    public JsonNode saveDocument(String username,String status, String comment,String fileName) {
        DocumentDTO documentDTO = new DocumentDTO();
        documentDTO.setUsername(username);
        documentDTO.setStatus(status);
        documentDTO.setComment(comment);
        documentDTO.setFileName(fileName);

        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .postForEntity( "http://localhost:8686//document/save", documentDTO, Object.class);

        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }


    public JsonNode findDocumentById(Long id) {
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8686//document/"+ id , Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode findAllDocuments() {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8686//documents", Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode findDocumentByUsername(String username) {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .getForEntity( "http://localhost:8686//documents/username/"+ username, Object.class);
        Object objects = responseEntity.getBody();
        if(objects == null){
            System.out.println("Can not find the object.");
        }
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }

    public JsonNode updateDocument(DocumentUpdateDTO documentUpdateDTO) {
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Object> responseEntity = restTemplate
                .postForEntity( "http://localhost:8686//updateDocument", documentUpdateDTO, Object.class);
        Object objects = responseEntity.getBody();
        ObjectMapper mapper = new ObjectMapper();
        JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
        return returnObj;
    }
}

