package com.synergisticit.domain;

import java.util.HashMap;

public class FailureResponse {
    private HashMap<String, String> error;

    public FailureResponse(String message) {
        this.error = new HashMap<String, String>();
        this.error.put("message", message);
    }
}
