package com.synergisticit.service;

import com.synergisticit.dto.DocumentUpdateDTO;
import jakarta.mail.Multipart;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.thymeleaf.TemplateEngine;

import java.util.Date;

public class InformEmailService {
    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private TemplateEngine templateEngine;

    @Autowired
    private InvoiceService invoiceService;

    @Async
    public void sendConfirmation(DocumentUpdateDTO documentUpdateDTO) {
        String email = "aileensession55@gmail.com";
        System.out.println("Email address:" +email);
        MimeMessage message = javaMailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            byte[] invoiceBytes = invoiceService.generateInvoice(email,documentUpdateDTO);

            MimeBodyPart attachementPart = new MimeBodyPart();
            attachementPart.setContent(invoiceBytes,"application/pdf");
            attachementPart.setFileName("invoice.pdf");

            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setContent(this.getEmailBody(email,documentUpdateDTO), "text/html;charset=UTF-8");

            helper.setTo(email);
            helper.setSubject("Submitted Document information.");
            helper.setText(this.getEmailBody(email,  documentUpdateDTO), true);

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(attachementPart);
            multipart.addBodyPart(textPart);

            message.setContent(multipart);
//
            System.out.println("try to send email:");
            javaMailSender.send(message);

        } catch (Exception e) {
            System.out.println("Email Sending Exception : " + e.getMessage());
        }

    }

    private String getEmailBody(String email,DocumentUpdateDTO documentUpdateDTO) {
//        String link = "http://localhost:9696/documentForm";
        String htmlTemplate = """
            <!DOCTYPE html>
            <html>
            <head>
                <tittle> Your document was approved</title>
            </head>
                <body>
                    <div class="containter">
                        <h1>Thank you for your document. </h1>
                        <h3>It was approved by our Admin.</h3>

                        <table>
                            <tr>
                                <th>Purchase Detail</th>
                            </tr>
                            <tr>
                                <td>
                                    <p>Document Id: %s</p>
                                    <p>User Email : %s</p>
                                    <p>User Name: %s</p> 
                                    <p>Status: %s</p>
                                    
                                </td>
                            </tr>
                        </table>
                        
                       
                       <p>Thank you.</p>
                       <p>Admin</p>
                    <div>
                </body>
                </html>
                """.formatted(
                documentUpdateDTO.getDocumentId(),
                email,
                documentUpdateDTO.getUsername(),
                documentUpdateDTO.getStatus()

        );


        return htmlTemplate;
        //return "Email Sent !";
    }


//    public void sendNewMail(String to, String subject, String body, String uploadLink) {
//        SimpleMailMessage message = new SimpleMailMessage();
//        message.setTo(to);
//        message.setSubject(subject);
//        message.setText(body);
//        javaMailSender.send(message);
//    }
}
