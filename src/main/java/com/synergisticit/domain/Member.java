package com.synergisticit.domain;

import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;

public class Member {

    private Long id;
    private String firstname;

    private String lastname;

    private String DOB;

    private String driverLicenseNo;

    @ManyToMany(fetch=FetchType.EAGER)
    @JoinTable(name="driver-member",
            joinColumns = { @JoinColumn(name="memberId")},
            inverseJoinColumns = {@JoinColumn(name="driverId")})
    Set<Driver> drivers = new HashSet<>();


    public Member() {
    }

    public Member(Long id, String firstname, String lastname, String DOB, String driverLicenseNo, Set<Driver> drivers) {
        this.id = id;
        this.firstname = firstname;
        this.lastname = lastname;
        this.DOB = DOB;
        this.driverLicenseNo = driverLicenseNo;
        this.drivers = drivers;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getDriverLicenseNo() {
        return driverLicenseNo;
    }

    public void setDriverLicenseNo(String driverLicenseNo) {
        this.driverLicenseNo = driverLicenseNo;
    }

    public Set<Driver> getDrivers() {
        return drivers;
    }

    public void setDrivers(Set<Driver> drivers) {
        this.drivers = drivers;
    }
}
