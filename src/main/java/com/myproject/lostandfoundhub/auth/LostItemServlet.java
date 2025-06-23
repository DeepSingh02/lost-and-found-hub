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
public class LostItemServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "C://project//Ankit Sir//LostAndFoundHub//src//main//webapp//data";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
         System.out.println("Received lostDate from form: " + request.getParameter("lostDate"));

        String itemCategory = request.getParameter("itemCategory");
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DatabaseConnection.getConnection(); // Database connection utility

            String sql = "";
            switch (itemCategory) {
               
                case "product":
    sql = "INSERT INTO lost_products (product_name, brand, color, description, lost_location, lost_date, bill, serial_number, phoneNumber, email, reward) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, request.getParameter("productName"));
    stmt.setString(2, request.getParameter("brand"));
    stmt.setString(3, request.getParameter("color"));
    stmt.setString(4, request.getParameter("description"));
    stmt.setString(5, request.getParameter("lostLocation"));
    stmt.setDate(6, getDate(request.getParameter("lostDate")));
    stmt.setString(7, saveFile(request, "bill"));
    stmt.setString(8, request.getParameter("serialNumber"));
    stmt.setString(9, request.getParameter("phoneNumber"));  // Fix: Replacing contact_info with phoneNumber
    stmt.setString(10, request.getParameter("email"));  // Fix: Adding email
    stmt.setBigDecimal(11, getBigDecimal(request.getParameter("reward")));
    break;
    
    

              
               case "humans-animals":
    sql = "INSERT INTO lost_humans_animals (name, skin_tone, age, last_seen_time, last_seen_location, height, birthmark, behavioral_notes, photo, owner_relation, phoneNumber, email, reward) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, request.getParameter("name"));
    stmt.setString(2, request.getParameter("skinTone"));
    stmt.setString(3, request.getParameter("age"));
    stmt.setString(4, request.getParameter("lastSeenTime"));
    stmt.setString(5, request.getParameter("lastSeenLocation"));
    stmt.setString(6, request.getParameter("height"));
    stmt.setString(7, request.getParameter("birthmark"));
    stmt.setString(8, request.getParameter("behavioralNotes"));
    stmt.setString(9, saveFile(request, "photo"));
    stmt.setString(10, request.getParameter("ownerRelation"));
    stmt.setString(11, request.getParameter("human_phoneNumber")); // Fix: Use phoneNumber
    stmt.setString(12, request.getParameter("human_email")); // Fix: Use email
    stmt.setBigDecimal(13, getBigDecimal(request.getParameter("human_reward"))); // Adjust index
    break;
    
    
    
    
     case "documents":
    sql = "INSERT INTO lost_documents (document_name, issued_by, document_number, xerox_copy, lost_location, issue_date, lost_date, reward, phoneNumber, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
stmt = conn.prepareStatement(sql);
stmt.setString(1, request.getParameter("documentName"));
stmt.setString(2, request.getParameter("issuedBy"));
stmt.setString(3, request.getParameter("documentNumber"));
stmt.setString(4, saveFile(request, "xeroxCopy"));
stmt.setString(5, request.getParameter("doc_lostLocation"));
  // 🔍 Debugging: Check if lostDate is received from form
    System.out.println("Received lostDate: " + request.getParameter("lostDate"));
stmt.setDate(6, getDate(request.getParameter("doc_issueDate")));
stmt.setDate(7, getDate(request.getParameter("doc_lostDate")));
stmt.setBigDecimal(8, getBigDecimal(request.getParameter("documents_reward"))); // Fix order
stmt.setString(9, request.getParameter("documents_phoneNumber"));
stmt.setString(10, request.getParameter("documents_email"));
 break;
    
    
    
                case "valuables":
    sql = "INSERT INTO lost_valuables (description, lost_location, lost_date, phoneNumber, email, reward) VALUES (?, ?, ?, ?, ?, ?)";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, request.getParameter("description"));
    stmt.setString(2, request.getParameter("val_ostLocation"));
    stmt.setDate(3, getDate(request.getParameter("val_lostDate")));
    stmt.setString(4, request.getParameter("valuables_phoneNumber")); // Fix: Use phoneNumber
    stmt.setString(5, request.getParameter("valuables_email")); // Fix: Use email
    stmt.setBigDecimal(6, getBigDecimal(request.getParameter("val_reward"))); // Adjust index
    break;
    
    

              case "vehicles":
    sql = "INSERT INTO lost_vehicles (vehicle_type, vehicle_name, color, registration_number, make_model, chassis_number, additional_notes, rc_copy, lost_date, phoneNumber, email, reward) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, request.getParameter("vehicleType"));
    stmt.setString(2, request.getParameter("vehicleName"));
    stmt.setString(3, request.getParameter("color"));
    stmt.setString(4, request.getParameter("registrationNumber"));
    stmt.setString(5, request.getParameter("makeModel"));
    stmt.setString(6, request.getParameter("chassisNumber"));
    stmt.setString(7, request.getParameter("additionalNotes"));
    stmt.setString(8, saveFile(request, "rcCopy"));
    stmt.setDate(9, getDate(request.getParameter("vec_lostDate")));
    stmt.setString(10, request.getParameter("vehicles_phoneNumber")); // Fix: Use phoneNumber
    stmt.setString(11, request.getParameter("vehicles_email")); // Fix: Use email
    stmt.setBigDecimal(12, getBigDecimal(request.getParameter("vec_reward"))); // Adjust index
    break;

                default:
                    response.sendRedirect("error.jsp");
                    return;
            }

            // Execute the insert query
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("success.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }

        }
        catch (SQLException e) {
    e.printStackTrace(); // Prints full SQL error in server logs
    System.out.println("SQL Error: " + e.getMessage()); // Debug message in console
    response.getWriter().println("SQL Error: " + e.getMessage()); // Shows error in browser
} catch (Exception e) {
    e.printStackTrace();
    System.out.println("General Error: " + e.getMessage()); // Debug message in console
    response.getWriter().println("General Error: " + e.getMessage()); // Shows error in browser
}

        finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    // Saves file to local directory and returns relative path for DB
    private String saveFile(HttpServletRequest request, String fileParam) throws IOException, ServletException {
        Part filePart = request.getPart(fileParam);
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            File file = new File(UPLOAD_DIR, fileName);
            filePart.write(file.getAbsolutePath());
            return "data/" + fileName; // Store relative path in DB
        }
        return null; // No file uploaded
    }

  private java.sql.Date getDate(String dateStr) {
    if (dateStr == null || dateStr.isEmpty()) {
        return null; // Return null if no date is provided
    }
    try {
        return java.sql.Date.valueOf(dateStr); // Convert only if valid
    } catch (IllegalArgumentException e) {
        System.err.println("Invalid date format: " + dateStr);
        return null; // Prevents application crash on invalid input
    }
}
    private java.math.BigDecimal getBigDecimal(String value) {
        if (value == null || value.isEmpty()) return null;
        return new java.math.BigDecimal(value);
    }
}
