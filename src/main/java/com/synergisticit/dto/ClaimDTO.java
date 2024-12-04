package com.synergisticit.dto;
import jakarta.persistence.OneToMany;

import java.util.List;

public class ClaimDTO {
    private Long claimId;
    private String username;

    private String claimTitle;

    private String accidentDate;

    private ClaimStatus status;

    //private List<byte[]> files;

    private byte[] file;

    private String fileName;

//    private List<ClaimDetailDTO> claimDetails;@OneToMany
//    private ClaimDetailDTO claimDetailDTO;

    private String itemDetailName;

    private Long itemCost;

    public ClaimDTO() {
    }

    public Long getClaimId() {
        return claimId;
    }

    public void setClaimId(Long claimId) {
        this.claimId = claimId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getClaimTitle() {
        return claimTitle;
    }

    public void setClaimTitle(String claimTitle) {
        this.claimTitle = claimTitle;
    }

    public String getAccidentDate() {
        return accidentDate;
    }

    public void setAccidentDate(String accidentDate) {
        this.accidentDate = accidentDate;
    }

    public ClaimStatus getStatus() {
        return status;
    }

    public void setStatus(ClaimStatus status) {
        this.status = status;
    }

    public byte[] getFile() {
        return file;
    }

    public void setFile(byte[] file) {
        this.file = file;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getItemDetailName() {
        return itemDetailName;
    }

    public void setItemDetailName(String itemDetailName) {
        this.itemDetailName = itemDetailName;
    }

    public Long getItemCost() {
        return itemCost;
    }

    public void setItemCost(Long itemCost) {
        this.itemCost = itemCost;
    }
}