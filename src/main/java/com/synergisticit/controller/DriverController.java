package com.synergisticit.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.client.DriverClient;
import com.synergisticit.domain.Driver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class DriverController {
    @Autowired
    DriverClient driverClient;

    @PostMapping("/saveDriver")
    public JsonNode saveDriver(@RequestBody Driver driver){

        return driverClient.saveDriver(driver);
    }


    @GetMapping("/driver/{id}")
    public JsonNode findDriverById(@PathVariable Long id){
        return driverClient.findDriverById(id);
    }

    @GetMapping("/drivers")
    public JsonNode findAllDrivers(){

        return driverClient.findAllDrivers();
    }

    @GetMapping("/driverByUsername/{username}")
    public JsonNode driverByUsername(@PathVariable String username){
        return driverClient.findDriverByUsername(username);
    }
}
