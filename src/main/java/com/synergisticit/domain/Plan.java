package com.synergisticit.domain;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


public class Plan implements Serializable {

    private Long planId;

    private String name;
    private String planType;

    private String description;

    private Long basePrice;

//    @OneToOne(mappedBy = "plan")
//    @OneToMany
//    private List<DesiredPlan> desiredPlans = new ArrayList<>();
//    @ManyToMany(fetch=FetchType.EAGER)
//    @JoinTable(name="plan_desiredPlan",
//    joinColumns = { @JoinColumn(name="planId")},
//    inverseJoinColumns = {@JoinColumn(name="desiredPlanId")})
//    private List<DesiredPlan> desiredPlans = new ArrayList<>();

//    @JsonIgnore
    @ManyToMany(fetch=FetchType.EAGER)
    @JoinTable(name="plan_policy",
            joinColumns = { @JoinColumn(name="planId")},
            inverseJoinColumns = {@JoinColumn(name="policyId")})
    List<Policy> policies = new ArrayList<>();

    public Plan() {
    }

    public Plan(Long planId, String name, String planType, String description, Long basePrice, List<Policy> policies) {
        this.planId = planId;
        this.name = name;
        this.planType = planType;
        this.description = description;
        this.basePrice = basePrice;
        this.policies = policies;
    }

    public Long getPlanId() {
        return planId;
    }

    public void setPlanId(Long planId) {
        this.planId = planId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPlanType() {
        return planType;
    }

    public void setPlanType(String planType) {
        this.planType = planType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(Long basePrice) {
        this.basePrice = basePrice;
    }

    public List<Policy> getPolicies() {
        return policies;
    }

    public void setPolicies(List<Policy> policies) {
        this.policies = policies;
    }
}