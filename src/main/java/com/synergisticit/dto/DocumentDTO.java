package com.synergisticit.dto;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public class DocumentDTO {
    private Long id;
    private String username;

    private String status;

    private byte[] file;

    private String comment;

    private String fileName;

//    @Lob
//    private byte[] data;

    public DocumentDTO() {
    }

    public DocumentDTO(Long id, String username, String status, byte[] file, String comment, String fileName) {
        this.id = id;
        this.username = username;
        this.status = status;
        this.file = file;
        this.comment = comment;
        this.fileName = fileName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public byte[] getFile() {
        return file;
    }

    public void setFile(byte[] file) {
        this.file = file;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;

    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}
