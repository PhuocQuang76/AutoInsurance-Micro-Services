package com.synergisticit.domain;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;


public class Policy {
    private Long id;

    private String name;

    @ManyToMany(mappedBy="policies")
    private List<Plan> plans = new ArrayList<>();

    public Policy() {
    }

    public Policy(Long id, String name, List<Plan> plans) {
        this.id = id;
        this.name = name;
        this.plans = plans;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Plan> getPlans() {
        return plans;
    }

    public void setPlans(List<Plan> plans) {
        this.plans = plans;
    }
}
