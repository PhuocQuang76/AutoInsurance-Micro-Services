package com.synergisticit.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.client.DocumentClient;
import com.synergisticit.dto.ClaimUpdateDTO;
import com.synergisticit.dto.DocumentDTO;
import com.synergisticit.dto.DocumentUpdateDTO;
import com.synergisticit.service.FileService;
import com.synergisticit.service.InformEmailService;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.nio.Buffer;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@RestController
public class DocumentController {

    @Value("${FILE_PATH}")
    private String path;

    @Autowired
    DocumentClient documentClient;

    @Autowired
    InformEmailService informEmailService;


    private static String generateUUIDFileName(String originalFileName) {
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString();
        return uuid + extension;
    }

    @PostMapping("/document/save")
    public JsonNode saveDocument(@RequestParam("file") MultipartFile file,@RequestParam String username,@RequestParam String status,@RequestParam String comment) throws IOException {
        String fileName = file.getOriginalFilename();

        //Convert file into byte then use Stream to save the file into the path
        byte[] fileUpload = file.getBytes();

        String UUID_fileName = generateUUIDFileName(fileName);
        Path filePath = Paths.get(path, UUID_fileName);


        FileOutputStream stream = new FileOutputStream(String.valueOf(filePath));
        stream.write(fileUpload);
        stream.close();

        return documentClient.saveDocument(username,status,comment,UUID_fileName);


    }


    @GetMapping("/document/{id}")
    public JsonNode findDocumentById(@PathVariable Long id){
        return documentClient.findDocumentById(id);
    }

    @GetMapping("/documents")
    public JsonNode findAllDocuments(){

        return documentClient.findAllDocuments();
    }

    @GetMapping("/documents/username/{username}")
    public JsonNode documentByUsername(@PathVariable String username){
        return documentClient.findDocumentByUsername(username);
    }

    @PutMapping("/updateDocument")
    public JsonNode updateDocument(@RequestBody DocumentUpdateDTO documentUpdateDTO) {
        informEmailService.sendConfirmation(documentUpdateDTO);
        return documentClient.updateDocument(documentUpdateDTO);
    }



//    @GetMapping("/download_file/{fileName}")
//    public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) throws IOException {
//        File file = new File("/Users/aileen/MyProjects/JQUERY/Project2/Project-2/AutoInsurance/download" + fileName);
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


    //    @GetMapping("/download_file")
//    public void downloadFile(@PathVariable String fileName) throws IOException {
//        HttpServletResponse response.setContentType("application/octet-stream");
//        File file = new File("/Users/aileen/MyProjects/JQUERY/Project2/Project-2/AutoInsurranceMirco/" + fileName);
//        System.out.println("path:" + path);
//        System.out.println("File: " + file);
//        HttpServletResponse response.setContentType("application/octet-stream");
//        String headerKey = "Content-Disposition";
//        String headerValue = "attachment; filename =" + fileName;
//
//        response.setHeader(headerKey,headerValue);
//        ServletOutputStream outputStream = response.getOutputStream();
//
//        BufferedInputStream inputStream = new BufferedInputStream(new FileInputStream(file));
//
//        byte[] buffer = new byte[8192];
//        int bytesRead = -1;
//
//        while ((bytesRead = inputStream.read(buffer)) != -1){
//            outputStream.write(buffer,0,bytesRead);
//        }
//        inputStream.close();
//        outputStream.close();
//
//    }


}
