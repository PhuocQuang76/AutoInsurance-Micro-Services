package com.synergisticit.domain;

import com.google.gson.annotations.SerializedName;

public class CreatePaymentRequest {
    @SerializedName("paymentMethodType")
    String paymentMethodType;

    @SerializedName("currency")
    String currency;

    Long amount;

    String email;

    String customer;

    public String getPaymentMethodType() {
        return paymentMethodType;
    }

    public String getCurrency() {
        return currency;
    }

    public Long getAmount() {
        return amount;
    }

    public String getEmail() {
        return email;
    }

    public String getCustomer() {
        return customer;
    }

    //    @SerializedName("paymentMethodType")
//    String paymentMethodType;
//
//    @SerializedName("currency")
//    String currency;
//
//    Long amount;
//
//    String email;
//
//
//    public String getPaymentMethodType() {
//        return paymentMethodType;
//    }
//    public String getCurrency() {
//        return currency;
//    }
//
//    public Long getAmount() {
//        return amount;
//    }
//
//    public String getEmail() {
//        return email;
//    }
}
