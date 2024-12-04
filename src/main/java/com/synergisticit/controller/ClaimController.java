package com.synergisticit.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.client.ClaimClient;
import com.synergisticit.dto.ClaimDTO;
import com.synergisticit.dto.ClaimDetailDTO;
import com.synergisticit.dto.ClaimStatus;
import com.synergisticit.dto.ClaimUpdateDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@RestController
public class ClaimController {
    @Value("${FILE_PATH}")
    private String path;

    @Autowired
    ClaimClient claimClient;

    private static String generateUUIDFileName(String originalFileName) {
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString();
        return uuid + extension;
    }

    @PostMapping("/claim/save")
    public String saveClaim(@RequestParam("file") MultipartFile file, String username,String claimTitle,
                            String status,String accidentDate, String itemDetailName, Long itemCost) throws IOException {


        // fileService.passFileToOtherService(file.getBytes(),username,status,comment);
        String fileName = file.getOriginalFilename();

        //Convert file into byte then use Stream to save the file into the path
        byte[] fileUpload = file.getBytes();

        String UUID_fileName = generateUUIDFileName(fileName);
        Path filePath = Paths.get(path, UUID_fileName);


        //String filename = generateUUIDFileName(fileName);
//        Path filePath = Paths.get(".", fileName);

        FileOutputStream stream = new FileOutputStream(String.valueOf(filePath));
        stream.write(fileUpload);
        stream.close();


        claimClient.saveClaim(username,claimTitle,status,accidentDate, UUID_fileName, itemDetailName, itemCost);

        //ClaimDTO claimDTO = new ClaimDTO();
//        claimClient.saveClaim(file.getBytes(),username,claimTitle,status,accidentDate, fileName, itemDetailName, itemCost);
        return "File upload successful";

    }

    @GetMapping("/claimsByUsername/{username}")
    public JsonNode claimByUsername(@PathVariable String username){
        return claimClient.findAllClaims(username);
    }


    @GetMapping("/claim/{claimId}")
    public JsonNode findClaimById(@PathVariable Long claimId){
        return claimClient.findClaimById(claimId);
    }

    @PutMapping("/updateClaim")
    public JsonNode updateClaim(@RequestBody ClaimUpdateDTO claimUpdateDTO) {
        return claimClient.updateClaim(claimUpdateDTO);
    }

    @GetMapping("/claims")
    public JsonNode findAllClaims(){

        return claimClient.findAllClaims();
    }


//    @GetMapping("/claim/download_file/{fileName}")
//    public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) throws IOException {
//        File file = new File("/Users/aileen/MyProjects/JQUERY/Project2/Project-2/AutoInsurance/" + fileName);
//        Path filePath = file.toPath();
//        Resource resource = new InputStreamResource(new FileInputStream(file));
//
//        return ResponseEntity.ok()
//                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getName() + "\"")
//                .contentType(MediaType.parseMediaType("application/octet-stream"))
//                .contentLength(file.length())
//                .body(resource);
//
//    }
}

