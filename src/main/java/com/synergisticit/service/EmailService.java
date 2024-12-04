package com.synergisticit.service;


import com.synergisticit.domain.YourQuote;
import jakarta.mail.Multipart;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;

import java.util.Date;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private TemplateEngine templateEngine;

    @Async
    public void sendPurchaseConfirmation(String email, Long amount, Date date, String status, String uploadLink) {
        System.out.println("Email address:" +email);
        MimeMessage message = javaMailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            //byte[] invoiceBytes = invoiceService.generateInvoice(desiredPlan);

            //MimeBodyPart attachementPart = new MimeBodyPart();
            //attachementPart.setContent(invoiceBytes,"application/pdf");
            //attachementPart.setFileName("invoice.pdf");

            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setContent(this.getEmailBody(email, amount,date,status,uploadLink), "text/html;charset=UTF-8");

            helper.setTo(email);
            helper.setSubject("Auto Insurance Payment Confirmation.");
            helper.setText(this.getEmailBody(email, amount,date,status, uploadLink), true);

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(textPart);

            message.setContent(multipart);
//            Context context = new Context();
//            context.setVariable("uploadLink", uploadLink);
//            String htmlContent = templateEngine.process("uploadEmailTemplate", context);
//            helper.setText(htmlContent, true);
            System.out.println("try to send email:");
            javaMailSender.send(message);

        } catch (Exception e) {
            System.out.println("Email Sending Exception : " + e.getMessage());
        }

    }

    private String getEmailBody(String email, Long amount, Date date, String status, String uploadLink) {
        String link = "http://localhost:9696/documentForm";
        String htmlTemplate = """
            <!DOCTYPE html>
            <html>
            <head>
                <tittle> Auto Insurance Payment Confirmation</title>
            </head>
                <body>
                    <div class="containter">
                        <h1>your payment was Confirmed! </h1>
                        <h3>Thank you very much for your payment.</h3>

                        <table>
                            <tr>
                                <th>Purchase Detail</th>
                            </tr>
                            <tr>
                                <td>
                                    <p>Purchase date: %s</p>
                                    <p>User Email : %s</p>
                                    <p>Amount: $%s</p> 
                                    <p>Status: %s</p>
                                    
                                </td>
                            </tr>
                        </table>
                        
                       <p>Please click the following link to upload your document:</p>
                       <a href="%s">Upload File</a>
                       <p>Thank you.</p>
                    <div>
                </body>
                </html>
                """.formatted(
                        date,
                        email,
                        amount,
                        status,
                        link
                );


        return htmlTemplate;
        //return "Email Sent !";
    }


    public void sendNewMail(String to, String subject, String body, String uploadLink) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject(subject);
        message.setText(body);
        javaMailSender.send(message);
    }
}
