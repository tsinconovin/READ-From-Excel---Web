package ir.tsinco.service;

import ir.tsinco.model.Salary;

import java.util.List;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileOutputStream;

public class export {
    public static void exportToExcel(List<Salary> totalSalaiesList, String filePath) {
        //  new workbook
        Workbook workbook = new XSSFWorkbook();

        //   new sheet
        Sheet sheet = workbook.createSheet("Salary Data");

        //  header row
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("ID");
        headerRow.createCell(1).setCellValue("First Name");
        headerRow.createCell(2).setCellValue("Last Name");
        headerRow.createCell(3).setCellValue("Amount");
        headerRow.createCell(4).setCellValue("Year");
        headerRow.createCell(5).setCellValue("Month");

        //  data rows
        int rowNum = 1;
        for (Salary salary : totalSalaiesList) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(salary.getId());
            row.createCell(1).setCellValue(salary.getFirstName());
            row.createCell(2).setCellValue(salary.getLastName());
            row.createCell(3).setCellValue(salary.getAmount());
            row.createCell(4).setCellValue(salary.getYear());
            row.createCell(5).setCellValue(salary.getMonth());
        }

        // Auto-size columns
        for (int i = 0; i < 6; i++) {
            sheet.autoSizeColumn(i);
        }

        // the workbook to a file
        try (FileOutputStream outputStream = new FileOutputStream(filePath)) {
            workbook.write(outputStream);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
