package com.synergisticit.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.client.PlanClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PlanController {
    @Autowired
    PlanClient planClient;


    @GetMapping("/plans")
    public JsonNode findPlans(){
        return planClient.findPlans();
    }

    @GetMapping("/plan/{id}")
    public JsonNode findPlanById(@PathVariable Long id){
        return planClient.findPlanById(id);
    }
}
