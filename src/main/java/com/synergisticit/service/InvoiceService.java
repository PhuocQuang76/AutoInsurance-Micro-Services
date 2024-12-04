package com.synergisticit.service;


import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.synergisticit.dto.DocumentUpdateDTO;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Date;


@Service
public class InvoiceService {
    public byte[] generateInvoice(String email, DocumentUpdateDTO documentUpdateDTO) {
        Document document = new Document();
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        try{
            PdfWriter.getInstance(document,outputStream);
            document.open();
            addContent(document, email, documentUpdateDTO);
            document.close();
            return outputStream.toByteArray();
        }catch (DocumentException e){
            e.printStackTrace();
        }finally {
            try{
                outputStream.close();
            }catch (IOException e){
                e.printStackTrace();
            }
        }

        return null;
    }

    private void addContent(Document document, String email, DocumentUpdateDTO documentUpdateDTO) throws DocumentException {
        Font headerFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);
        Font regularFont = new Font(Font.FontFamily.TIMES_ROMAN, 12);

        Paragraph header = new Paragraph("Invoice", headerFont);
        header.setAlignment(1);
        document.add(header);
        document.add(new Paragraph("\n"));

        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        try {
            table.setWidths(new int[]{1,2});
        } catch (DocumentException e) {
            throw new RuntimeException(e);
        }

        PdfPCell cell;

        cell = new PdfPCell(new Phrase("Document Id", regularFont));
        table.addCell(cell);


        cell = new PdfPCell(new Phrase(String.valueOf(documentUpdateDTO.getDocumentId()), regularFont));
        table.addCell(cell);

        cell = new PdfPCell(new Phrase("Customer Email:", regularFont));
        table.addCell(cell);

        cell = new PdfPCell(new Phrase(email, regularFont));
        table.addCell(cell);


        cell = new PdfPCell(new Phrase("User Name:", regularFont));
        table.addCell(cell);
        cell = new PdfPCell(new Phrase( documentUpdateDTO.getUsername(), regularFont));
        table.addCell(cell);


        cell = new PdfPCell(new Phrase("Purchase Status:", regularFont));
        table.addCell(cell);
        cell = new PdfPCell(new Phrase(String.valueOf(documentUpdateDTO.getStatus()), regularFont));
        table.addCell(cell);

        document.add(table);

        document.add(new Paragraph("\n"));

//        Paragraph totalSavings = new Paragraph("Total Amount: $" + amount * 10, headerFont);
//        totalSavings.setAlignment(Element.ALIGN_RIGHT);
//        document.add(totalSavings);
    }

    private String getCurrentDate(){
        java.util.Date today = new java.util.Date();
        return today.toString();
    }
}
