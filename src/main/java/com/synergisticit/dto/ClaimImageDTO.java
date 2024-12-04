package com.synergisticit.dto;

import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

public class ClaimImageDTO {
    private Long id;

    private String claimName;

    private int cost;

    private byte[] file;

    @ManyToOne
    @JoinColumn(name="claimId")
    private ClaimDTO claimDTO;

}
