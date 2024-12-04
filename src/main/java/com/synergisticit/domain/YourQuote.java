package com.synergisticit.domain;

import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;

public class YourQuote {

    private Long yourQuoteId;

    private String purchaseDate;

    private String username;

    private String email;


    private Long driverId;


    private Long vehicleId;


    private Long desiredPlanId;

    private Long total;

    private String status;
    public YourQuote() {
    }

    public YourQuote(Long yourQuoteId, String purchaseDate, String username, String email, Long driverId, Long vehicleId, Long desiredPlanId, Long total, String status) {
        this.yourQuoteId = yourQuoteId;
        this.purchaseDate = purchaseDate;
        this.username = username;
        this.email = email;
        this.driverId = driverId;
        this.vehicleId = vehicleId;
        this.desiredPlanId = desiredPlanId;
        this.total = total;
        this.status = status;
    }

    public Long getYourQuoteId() {
        return yourQuoteId;
    }

    public void setYourQuoteId(Long yourQuoteId) {
        this.yourQuoteId = yourQuoteId;
    }

    public String getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(String purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Long getDriverId() {
        return driverId;
    }

    public void setDriverId(Long driverId) {
        this.driverId = driverId;
    }

    public Long getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(Long vehicleId) {
        this.vehicleId = vehicleId;
    }

    public Long getDesiredPlanId() {
        return desiredPlanId;
    }

    public void setDesiredPlanId(Long desiredPlanId) {
        this.desiredPlanId = desiredPlanId;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
