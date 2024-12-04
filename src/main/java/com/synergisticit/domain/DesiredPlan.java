package com.synergisticit.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;


public class DesiredPlan {

    private Long id;

    private String username;

    private String email;
    private String purchasePeriod;

    private String desireStartDate;

//    @OneToOne(cascade = CascadeType.ALL)
//    @JoinColumn(name = "planId",referencedColumnName = "planId")
//    @ManyToOne(cascade = CascadeType.ALL)
//    @JoinColumn(name = "planId")
//    private Plan plan;

//    @ManyToMany(mappedBy="desiredPlans")
//    private List<Plan> plans = new ArrayList<>();
    private int planId;

    public DesiredPlan() {

    }

    public DesiredPlan(Long id, String username, String purchasePeriod, String desireStartDate, int planId, String email) {
        this.id = id;
        this.username = username;
        this.purchasePeriod = purchasePeriod;
        this.desireStartDate = desireStartDate;
        this.planId = planId;
        this.email = email;
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

    public String getPurchasePeriod() {
        return purchasePeriod;
    }

    public void setPurchasePeriod(String purchasePeriod) {
        this.purchasePeriod = purchasePeriod;
    }

    public String getDesireStartDate() {
        return desireStartDate;
    }

    public void setDesireStartDate(String desireStartDate) {
        this.desireStartDate = desireStartDate;
    }

    public int getPlanId() {
        return planId;
    }

    public void setPlanId(int planId) {
        this.planId = planId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
