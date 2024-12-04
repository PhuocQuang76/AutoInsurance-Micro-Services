package com.synergisticit.dto;


import jakarta.persistence.*;


public class ClaimDetailDTO {
    private Long id;

    private String name;

    private int cost;


    private String description;

    @ManyToOne
    @JoinColumn(name="claimId")
    private ClaimDTO claimDTO;
}
