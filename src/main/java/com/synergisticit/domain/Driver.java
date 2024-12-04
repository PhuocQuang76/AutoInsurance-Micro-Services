package com.synergisticit.domain;

import jakarta.persistence.*;

import java.util.Set;


public class Driver {


    private Long id;
    private String username;

    private String firstname;

    private String lastname;

    private String DOB;

    private Gender gender;
    @Embedded
    private Address address;

    private String driverLicenseNo;

    @ManyToMany(mappedBy="drivers")
    private Set<Member> members;


    // Constructors, getters and setters...
    public Driver() {
    }

    public Driver(Long id, String username, String firstname, String lastname, String DOB, Gender gender, Address address, String driverLicenseNo, Set<Member> members) {
        this.id = id;
        this.username = username;
        this.firstname = firstname;
        this.lastname = lastname;
        this.DOB = DOB;
        this.gender = gender;
        this.address = address;
        this.driverLicenseNo = driverLicenseNo;
        this.members = members;
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

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public String getDriverLicenseNo() {
        return driverLicenseNo;
    }

    public void setDriverLicenseNo(String driverLicenseNo) {
        this.driverLicenseNo = driverLicenseNo;
    }

    public Set<Member> getMembers() {
        return members;
    }

    public void setMembers(Set<Member> members) {
        this.members = members;
    }
}