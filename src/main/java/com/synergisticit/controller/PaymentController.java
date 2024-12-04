package com.synergisticit.controller;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentCreateParams;
import com.synergisticit.domain.CreatePaymentRequest;
import com.synergisticit.domain.CreatePaymentResponse;
import com.synergisticit.domain.FailureResponse;
import com.synergisticit.domain.YourQuote;
import com.synergisticit.service.EmailService;
import jakarta.annotation.PostConstruct;
import com.google.gson.Gson;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping(path = "/api/v1/payments")
public class PaymentController {
    @Autowired
    EmailService emailService;

    static class ConfigResponse {
        private String publishableKey;

        public ConfigResponse(String publishableKey) {
            this.publishableKey = publishableKey;
        }
    }

    @Value("${application.stripe.publishable.key}")
    private String publishableKey;
    @Value("${application.stripe.private.key}")
    private String privateKey;

    private Gson gson = new Gson();

    @PostConstruct
    public void init() {
        Stripe.apiKey = privateKey;
        Stripe.setAppInfo(
                "Aileen Insurance App",
                "0.0.1"
        );
    }

    @RequestMapping("/config")
    public String getStripeConfig() {
        return gson.toJson(new ConfigResponse(publishableKey));
    }

    @PostMapping("/create-payment-intent")
    public String createPaymentIntent(@RequestBody CreatePaymentRequest paymentRequest, HttpServletResponse response) {

        PaymentIntentCreateParams.Builder paramsBuilder = new PaymentIntentCreateParams
                .Builder()
                .setCurrency(paymentRequest.getCurrency())
                .addPaymentMethodType(paymentRequest.getPaymentMethodType())
                .setAmount(paymentRequest.getAmount())
                .setReceiptEmail(paymentRequest.getEmail());


//        if (paymentRequest.getPaymentMethodType().equals("link")) {
//            paramsBuilder.addPaymentMethodType("card");
//            paramsBuilder.addPaymentMethodType("link");
//        }
//
//        System.out.println(paymentRequest.getPaymentMethodType());
//        if (paymentRequest.getPaymentMethodType().equals("acss_debit")) {
//            paramsBuilder.setPaymentMethodOptions(
//                    PaymentIntentCreateParams.PaymentMethodOptions
//                            .builder()
//                            .setAcssDebit(PaymentIntentCreateParams
//                                    .PaymentMethodOptions
//                                    .AcssDebit
//                                    .builder()
//                                    .setMandateOptions(PaymentIntentCreateParams
//                                            .PaymentMethodOptions
//                                            .AcssDebit
//                                            .MandateOptions
//                                            .builder()
//                                            .setPaymentSchedule(PaymentIntentCreateParams.PaymentMethodOptions.AcssDebit.MandateOptions.PaymentSchedule.SPORADIC)
//                                            .setTransactionType(PaymentIntentCreateParams.PaymentMethodOptions.AcssDebit.MandateOptions.TransactionType.PERSONAL)
//                                            .build())
//                                    .build())
//                            .build());
//        }

        PaymentIntentCreateParams createParams = paramsBuilder.build();
        String link = "localhost:9696/upload";
        try {
            // Create a PaymentIntent with the order amount and currency
            PaymentIntent intent = PaymentIntent.create(createParams);

            // Send PaymentIntent details to client
            System.out.println("Successfully paid....");

            Date today = new Date();

            System.out.println("Sending Email....");

            Long amount = intent.getAmount() /100;
            // send your email here....
            emailService.sendPurchaseConfirmation(intent.getReceiptEmail(), amount,today,intent.getStatus(),link);

            return gson.toJson(new CreatePaymentResponse(intent.getClientSecret()));


        } catch (StripeException e) {
            response.setStatus(400);
            return gson.toJson(new FailureResponse(e.getMessage()));
        } catch (Exception e) {
            response.setStatus(500);
            return gson.toJson(e);
        }

    }
}


