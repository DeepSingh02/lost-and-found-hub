package com.myproject.lostandfoundhub.auth;

import com.myproject.lostandfoundhub.utils.DatabaseConnection;
import java.io.*;
import java.nio.file.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(maxFileSize = 16177215) // 16MB file upload limit
public class FoundItemServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "C://project//Ankit Sir//LostAndFoundHub//src//main//webapp//data";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String itemCategory = request.getParameter("itemCategory");
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "";
            
            switch (itemCategory) {
                case "product":
                    sql = "INSERT INTO found_products (product_name, brand, color, description, found_location, found_date, serial_number, image_path, phone_number, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, request.getParameter("productName"));
                    stmt.setString(2, request.getParameter("productBrand"));
                    stmt.setString(3, request.getParameter("productColor"));
                    stmt.setString(4, request.getParameter("productDescription"));
                    stmt.setString(5, request.getParameter("foundLocation"));
                    stmt.setDate(6, getDate(request.getParameter("foundDate")));
                    stmt.setString(7, request.getParameter("serialNumber"));
                    stmt.setString(8, saveFile(request, "productImage"));
                    stmt.setString(9, request.getParameter("productPhone"));
                    stmt.setString(10, request.getParameter("productEmail"));
                    break;
                    
               case "humans_animals":
    sql = "INSERT INTO found_humans_animals (name, skin_tone, found_time, found_location, height, birthmark, behavioral_notes, found_date, phone_number, email, photo_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, request.getParameter("name"));
    stmt.setString(2, request.getParameter("skinTone"));
    stmt.setString(3, request.getParameter("foundTime"));
    stmt.setString(4, request.getParameter("foundLocationHuman"));
    stmt.setString(5, request.getParameter("height"));
    stmt.setString(6, request.getParameter("birthmark"));
    stmt.setString(7, request.getParameter("behavioralNotes"));
    stmt.setDate(8, getDate(request.getParameter("foundDateHuman")));
    stmt.setString(9, request.getParameter("humanPhone"));
    stmt.setString(10, request.getParameter("humanEmail"));
    stmt.setString(11, saveFile(request, "humanImage"));  // This is the critical fix
    break;
                    
                case "documents":
                    sql = "INSERT INTO found_documents (document_name, issued_by, document_number,  document_location, issue_date, found_date, document_image_path, phone_number , email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, request.getParameter("documentName"));
                    stmt.setString(2, request.getParameter("issuedBy"));
                    stmt.setString(3, request.getParameter("documentNumber"));
                    stmt.setString(4, request.getParameter("documentLocation"));
                    stmt.setDate(5, getDate(request.getParameter("issueDate")));
                    stmt.setDate(6, getDate(request.getParameter("foundDateDocument")));
                    stmt.setString(7, saveFile(request, "documentImage"));
                    stmt.setString(8, request.getParameter("docPhone"));
                    stmt.setString(9, request.getParameter("docEmail"));
                    break;
                    
                case "valuables":
                    sql = "INSERT INTO found_valuables ( valuables_description, valuables_location, found_date, valuables_image_path, phone_number, email) VALUES (?, ?, ?, ?, ?, ?)";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, request.getParameter("valuablesDescription"));
                    stmt.setString(2, request.getParameter("valuablesLocation"));
                    stmt.setDate(3, getDate(request.getParameter("foundDateValuables")));
                    stmt.setString(4, saveFile(request, "valuablesImage"));
                    stmt.setString(5, request.getParameter("valuablesPhone"));
                    stmt.setString(6, request.getParameter("valuablesEmail"));
                    break;
                    
                case "vehicles":
                    sql = "INSERT INTO found_vehicles (vehicle_type, vehicle_name, vehicle_color, registration_number, make_model, chassis_number, additional_notes, vehicle_found_date, vehicle_image_path, phone_number, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, request.getParameter("vehicleType"));
                    stmt.setString(2, request.getParameter("vehicleName"));
                    stmt.setString(3, request.getParameter("vehicleColor"));
                    stmt.setString(4, request.getParameter("registrationNumber"));
                    stmt.setString(5, request.getParameter("makeModel"));
                    stmt.setString(6, request.getParameter("chassisNumber"));
                    stmt.setString(7, request.getParameter("additionalNotes"));
                    stmt.setDate(8, getDate(request.getParameter("vehicleFoundDate")));
                    stmt.setString(9, saveFile(request, "vehicleImage"));
                    stmt.setString(10, request.getParameter("vehiclePhone"));
                    stmt.setString(11, request.getParameter("vehicleEmail"));
                    break;
                    
                default:
                    response.sendRedirect("error.jsp");
                    return;
            }

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("success.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL Error: " + e.getMessage());
            response.getWriter().println("SQL Error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("General Error: " + e.getMessage());
            response.getWriter().println("General Error: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    // Helper method to save uploaded files
    private String saveFile(HttpServletRequest request, String fileParam) throws IOException, ServletException {
        Part filePart = request.getPart(fileParam);
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            File file = new File(uploadDir, fileName);
            filePart.write(file.getAbsolutePath());
            return "data/" + fileName; // Store relative path in DB
        }
        return null;
    }

    // Helper method to parse date strings
    private java.sql.Date getDate(String dateStr) {
        if (dateStr == null || dateStr.isEmpty()) {
            return null;
        }
        try {
            return java.sql.Date.valueOf(dateStr);
        } catch (IllegalArgumentException e) {
            System.err.println("Invalid date format: " + dateStr);
            return null;
        }
    }
}