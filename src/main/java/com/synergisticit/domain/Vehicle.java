package com.synergisticit.domain;


import jakarta.persistence.*;


public class Vehicle {

    private Long id;

    private String username;

    private String brand;

    private String year;

    private int mileage;

    private int accidentCount;

    private int vehicleValue;

    private String purchaseDate;
    public Vehicle() {
        super();
    }

    public Vehicle(Long id, String username, String brand, String year, int mileage, int accidentCount, int vehicleValue, String purchaseDate) {
        this.id = id;
        this.username = username;
        this.brand = brand;
        this.year = year;
        this.mileage = mileage;
        this.accidentCount = accidentCount;
        this.vehicleValue = vehicleValue;
        this.purchaseDate = purchaseDate;
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

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public int getMileage() {
        return mileage;
    }

    public void setMileage(int mileage) {
        this.mileage = mileage;
    }

    public int getAccidentCount() {
        return accidentCount;
    }

    public void setAccidentCount(int accidentCount) {
        this.accidentCount = accidentCount;
    }

    public int getVehicleValue() {
        return vehicleValue;
    }

    public void setVehicleValue(int vehicleValue) {
        this.vehicleValue = vehicleValue;
    }

    public String getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(String purchaseDate) {
        this.purchaseDate = purchaseDate;
    }
}