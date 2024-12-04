package com.synergisticit.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.client.YourQuoteClient;
import com.synergisticit.domain.YourQuote;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class YourQuoteController {
    @Autowired
    YourQuoteClient yourQuoteClient;

    @PostMapping("/saveYourQuote")
    public JsonNode saveYourQuote(@RequestBody YourQuote yourQuote){
        return yourQuoteClient.saveYourQuote(yourQuote);
    }


    @GetMapping("/yourQuotes")
    public JsonNode findAllYourQuote(){
        return yourQuoteClient.findAllYourQuotes();
    }

    @GetMapping("/yourQuoteByUsername/{username}")
    public JsonNode findByUsername(@PathVariable String username){
        return yourQuoteClient.findYourQuoteByUsername(username);
    }


}
