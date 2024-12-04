package com.synergisticit.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.client.VehicleClient;
import com.synergisticit.domain.Vehicle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class VehicleController {
    @Autowired
    VehicleClient vehicleClient;

    @PostMapping("/saveVehicle")
    public JsonNode saveDriver(@RequestBody Vehicle vehicle){

        return vehicleClient.saveVehicle(vehicle);
    }


    @GetMapping("/vehicle/{id}")
    public JsonNode findVehicleById(@PathVariable Long id){
        return vehicleClient.findVehicleById(id);
    }


    @GetMapping("/vehicles")
    public JsonNode findAllVehicles(){

        return vehicleClient.findAllVehicles();
    }

    @GetMapping("/vehicleByUsername/{username}")
    public JsonNode vehicleByUsername(@PathVariable String username){
        return vehicleClient.findVehicleByUsername(username);
    }
}