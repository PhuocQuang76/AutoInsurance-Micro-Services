package com.synergisticit.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.client.DesiredPlanClient;
import com.synergisticit.client.DriverClient;
import com.synergisticit.domain.DesiredPlan;
import com.synergisticit.domain.Driver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class DesiredPlanController {
    @Autowired
    DesiredPlanClient desiredPlanClient;

    @PostMapping("/saveDesiredPlan")
    public JsonNode saveDesiredPlan(@RequestBody DesiredPlan desiredPlan){

        return desiredPlanClient.saveDriver(desiredPlan);
    }


    @GetMapping("/desiredPlan/{id}")
    public JsonNode findDesiredPlanById(@PathVariable Long id){
        return desiredPlanClient.findDesiredPlanById(id);
    }

    @GetMapping("/desiredPlans")
    public JsonNode findAllDesiredPlans(){

        return desiredPlanClient.findAllDesiredPlans();
    }


    @GetMapping("/desiredPlanByUsername/{username}")
    public JsonNode desiredPlanByUsername(@PathVariable String username){
        return desiredPlanClient.desiredPlanByUsername(username);
    }
}
