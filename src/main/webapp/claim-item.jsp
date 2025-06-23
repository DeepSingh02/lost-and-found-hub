<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Claim Item</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 600px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #4CAF50;
            margin-top: 0;
            text-align: center;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #495057;
        }
        
        input[type="text"], 
        textarea, 
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
            box-sizing: border-box;
        }
        
        input[type="text"]:focus, 
        textarea:focus, 
        select:focus {
            border-color: #4CAF50;
            outline: none;
            box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.2);
        }
        
        textarea {
            height: 120px;
            resize: vertical;
        }
        
        .btn {
            padding: 12px 24px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            margin-right: 10px;
            font-size: 16px;
            display: inline-block;
        }
        
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #3e8e41;
            transform: translateY(-1px);
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-1px);
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 16px;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .alert-info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        
        .form-actions {
            margin-top: 30px;
            text-align: center;
        }
        
        .hidden-field {
            display: none;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
                margin: 15px;
            }
            
            .btn {
                display: block;
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Claim Item</h1>
        
        <%
            // Check if user is logged in
            Integer userId = (Integer) session.getAttribute("user_id");
            if (userId == null) {
                response.sendRedirect("login.jsp?error=not_logged_in");
                return;
            }
            
            // Debug output (remove in production)
            out.println("<!-- Current user_id from session: " + userId + " -->");

            // Get parameters from URL
            String itemId = request.getParameter("item_id");
            String category = request.getParameter("category");
            
            // Check if form was submitted
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String claimReason = request.getParameter("claim_reason");
                String additionalDetails = request.getParameter("additional_details");
                
                if (itemId == null || itemId.isEmpty() || category == null || category.isEmpty()) {
                    out.println("<div class='alert alert-danger'>Invalid item information. Please go back and try again.</div>");
                } else {
                    Connection con = null;
                    PreparedStatement pstmt = null;
                    
                    try {
                        // Database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/lost_and_found_db", 
                            "root", 
                            "1234");
                        
                        // Check for duplicate claims
                        String checkSql = "SELECT claim_id FROM claims WHERE user_id = ? AND item_id = ? AND category = ?";
                        pstmt = con.prepareStatement(checkSql);
                        pstmt.setInt(1, userId);
                        pstmt.setInt(2, Integer.parseInt(itemId));
                        pstmt.setString(3, category);
                        
                        ResultSet rs = pstmt.executeQuery();
                        
                        if (rs.next()) {
                            out.println("<div class='alert alert-danger'>You have already submitted a claim for this item.</div>");
                        } else {
                            // Insert new claim
                            String insertSql = "INSERT INTO claims (user_id, item_id, category, claim_reason, additional_details) " +
                                            "VALUES (?, ?, ?, ?, ?)";
                            pstmt = con.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);  // Return the generated key (claim_id)
                            pstmt.setInt(1, userId);
                            pstmt.setInt(2, Integer.parseInt(itemId));
                            pstmt.setString(3, category);
                            pstmt.setString(4, claimReason);
                            pstmt.setString(5, additionalDetails);
                            
                            int rowsAffected = pstmt.executeUpdate();
                            
                            if (rowsAffected > 0) {
                                // Retrieve generated claim_id
                                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                                if (generatedKeys.next()) {
                                    int claimId = generatedKeys.getInt(1);  // Get the generated claim_id
                                    
                                    out.println("<div class='alert alert-success'>Your claim has been submitted successfully! The admin will review your request.</div>");
                                    out.println("<div class='alert alert-info'>Claim ID: " + claimId + "</div>");
                                    out.println("<div class='alert alert-info'>Our team will verify your claim within 48 hours. If approved, we'll connect you with the finder. You can check your approval status and the finder's contact information in the 'My Reports' section.</div>");
                                    
                                    out.println("<div class='form-actions'>");
                                    out.println("<a href='view-found-reports.jsp' class='btn btn-secondary'>Back to Gallery</a>");
                                    out.println("</div>");
                                    return;
                                }
                            } else {
                                out.println("<div class='alert alert-danger'>Failed to submit your claim. Please try again.</div>");
                            }
                        }
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>System error. Please try again later.<br>Error: " + e.getMessage() + "</div>");
                    } finally {
                        // Close resources
                        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
                        try { if (con != null) con.close(); } catch (SQLException e) {}
                    }
                }
            }
        %>
        
        <form method="POST" action="">
            <input type="hidden" name="item_id" value="<%= itemId %>">
            <input type="hidden" name="category" value="<%= category %>">
            
            <div class="form-group">
                <label for="claim_reason">Reason for Claim *</label>
                <textarea id="claim_reason" name="claim_reason" required 
                    placeholder="Please explain why you believe this item belongs to you..."></textarea>
            </div>
            
            <div class="form-group">
                <label for="additional_details">Supporting Evidence</label>
                <textarea id="additional_details" name="additional_details" 
                    placeholder="Provide any additional proof (identification marks, purchase receipts, etc.) that can help verify your claim..."></textarea>
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Submit Claim</button>
                <a href="view-found-reports.jsp" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
 