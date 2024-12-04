package com.synergisticit.service;

import com.synergisticit.dto.DocumentDTO;
import com.synergisticit.dto.DocumentStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
public class FileService {
    @Autowired
    private RestTemplate restTemplate;

    public void passFileToOtherService(byte[] file,String username,String status, String comment) throws IOException {
        // Convert MultipartFile to byte array
        //byte[] fileBytes = file.getBytes();
        // Create the request to pass the file to the other service
        // Replace "http://other-service-url/uploadFile" with the actual endpoint of the other service
        //restTemplate.postForObject("http://localhost:8686//document/save", fileBytes, String.class);

        DocumentDTO documentDTO = new DocumentDTO();
        documentDTO.setUsername(username);
        documentDTO.setFile(file);
        documentDTO.setStatus(status);
        documentDTO.setComment(comment);


        // Create the request to pass the file and other fields to the other service
        restTemplate.postForObject("http://localhost:8686//document/save", documentDTO, String.class);

    }
}
