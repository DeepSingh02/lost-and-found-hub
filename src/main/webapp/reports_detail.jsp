<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Claim & Item Details</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 1000px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        
        h1, h2 {
            color: #343a40;
            margin-top: 0;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }
        
        h2 {
            margin-top: 30px;
            font-size: 1.5em;
        }
        
        .detail-section {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 5px;
        }
        
        .detail-row {
            display: flex;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px dashed #ddd;
        }
        
        .detail-row:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        
        .detail-label {
            flex: 0 0 200px;
            font-weight: 600;
            color: #495057;
        }
        
        .detail-value {
            flex: 1;
            color: #212529;
        }
        
        .item-image {
            max-width: 300px;
            max-height: 200px;
            margin-top: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        
        .back-btn:hover {
            background-color: #5a6268;
        }
        
        .error-message {
            color: #dc3545;
            padding: 10px;
            background-color: #f8d7da;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Claim & Item Details</h1>
        
        <%
            String claimId = request.getParameter("claim_id");
            if (claimId == null || claimId.isEmpty()) {
                out.println("<div class='error-message'>Error: No claim ID specified</div>");
                out.println("<a href='admin-claims.jsp' class='back-btn'>← Back to Claims</a>");
                return;
            }

            String url = "jdbc:mysql://localhost:3306/lost_and_found_db";
            String dbUser = "root";
            String dbPassword = "1234";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(url, dbUser, dbPassword);

                // 1. Get claim details and user info
                String claimSql = "SELECT c.*, u.name, u.email, u.phone " +
                                 "FROM claims c " +
                                 "JOIN users u ON c.user_id = u.user_id " +
                                 "WHERE c.claim_id = ?";
                
                PreparedStatement claimStmt = con.prepareStatement(claimSql);
                claimStmt.setInt(1, Integer.parseInt(claimId));
                ResultSet claimRs = claimStmt.executeQuery();
                
                if (!claimRs.next()) {
                    out.println("<div class='error-message'>Error: No claim found with ID " + claimId + "</div>");
                    out.println("<a href='admin-claims.jsp' class='back-btn'>← Back to Claims</a>");
                    return;
                }
                
                // Store claim details we'll need for item lookup
                int itemId = claimRs.getInt("item_id");
                String category = claimRs.getString("category");
        %>
        
        <!-- Claim Details Section -->
        <div class="detail-section">
            <h2>Claim Information</h2>
            
            <div class="detail-row">
                <div class="detail-label">Claim ID</div>
                <div class="detail-value"><%= claimRs.getInt("claim_id") %></div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Date Submitted</div>
                <div class="detail-value"><%= claimRs.getTimestamp("created_at") %></div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Claim Reason</div>
                <div class="detail-value"><%= claimRs.getString("claim_reason") %></div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Additional Details</div>
                <div class="detail-value"><%= claimRs.getString("additional_details") != null ? 
                    claimRs.getString("additional_details") : "N/A" %></div>
            </div>
        </div>
        
        <!-- Claimant Information Section -->
        <div class="detail-section">
            <h2>Claimant Information</h2>
            
            <div class="detail-row">
                <div class="detail-label">Name</div>
                <div class="detail-value"><%= claimRs.getString("name") %></div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Email</div>
                <div class="detail-value"><%= claimRs.getString("email") %></div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Phone</div>
                <div class="detail-value"><%= claimRs.getString("phone") != null ? 
                    claimRs.getString("phone") : "N/A" %></div>
            </div>
        </div>
        
        <%
                // Close claim result set
                claimRs.close();
                claimStmt.close();
                
                // 2. Get item details based on category
                String itemSql = "";
                String imageColumn = "";
                
                switch(category) {
                    case "Product":
                        itemSql = "SELECT * FROM found_products WHERE id = ?";
                        imageColumn = "image_path";
                        break;
                    case "Humans/Animals":
                        itemSql = "SELECT * FROM found_humans_animals WHERE id = ?";
                        imageColumn = "photo_path";
                        break;
                    case "Documents":
                        itemSql = "SELECT * FROM found_documents WHERE id = ?";
                        imageColumn = "document_image_path";
                        break;
                    case "Valuables":
                        itemSql = "SELECT * FROM found_valuables WHERE id = ?";
                        imageColumn = "valuables_image_path";
                        break;
                    case "Vehicles":
                        itemSql = "SELECT * FROM found_vehicles WHERE id = ?";
                        imageColumn = "vehicle_image_path";
                        break;
                    default:
                        out.println("<div class='error-message'>Error: Unknown item category</div>");
                        break;
                }
                
                if (!itemSql.isEmpty()) {
                    PreparedStatement itemStmt = con.prepareStatement(itemSql);
                    itemStmt.setInt(1, itemId);
                    ResultSet itemRs = itemStmt.executeQuery();
                    
                    if (itemRs.next()) {
        %>
        
        <!-- Item Details Section -->
        <div class="detail-section">
            <h2>Item Details (<%= category %>)</h2>
            
            <%
                // Display fields based on category
                switch(category) {
                    case "Product":
            %>
                        <div class="detail-row">
                            <div class="detail-label">Product Name</div>
                            <div class="detail-value"><%= itemRs.getString("product_name") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Brand</div>
                            <div class="detail-value"><%= itemRs.getString("brand") != null ? itemRs.getString("brand") : "N/A" %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Color</div>
                            <div class="detail-value"><%= itemRs.getString("color") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Description</div>
                            <div class="detail-value"><%= itemRs.getString("description") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Found Location</div>
                            <div class="detail-value"><%= itemRs.getString("found_location") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Found Date</div>
                            <div class="detail-value"><%= itemRs.getDate("found_date") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Serial Number</div>
                            <div class="detail-value"><%= itemRs.getString("serial_number") != null ? itemRs.getString("serial_number") : "N/A" %></div>
                        </div>
                        
                         <div class="detail-row">
            <span class="detail-label">Contact Number:</span>
            <span class="detail-value"><%= itemRs.getString("phone_number") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Email:</span>
            <span class="detail-value"><%= itemRs.getString("email") %></span>
        </div>
            <%
                        break;
                    case "Humans/Animals":
            %>
                        <div class="detail-row">
                            <div class="detail-label">Name</div>
                            <div class="detail-value"><%= itemRs.getString("name") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Skin Tone</div>
                            <div class="detail-value"><%= itemRs.getString("skin_tone") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Found Location</div>
                            <div class="detail-value"><%= itemRs.getString("found_location") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Height</div>
                            <div class="detail-value"><%= itemRs.getString("height") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Birthmark</div>
                            <div class="detail-value"><%= itemRs.getString("birthmark") != null ? itemRs.getString("birthmark") : "N/A" %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Behavioral Notes</div>
                            <div class="detail-value"><%= itemRs.getString("behavioral_notes") != null ? itemRs.getString("behavioral_notes") : "N/A" %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Found Date</div>
                            <div class="detail-value"><%= itemRs.getDate("found_date") %></div>
                        </div>
                        
                          <div class="detail-row">
            <span class="detail-label">Contact Number:</span>
            <span class="detail-value"><%= itemRs.getString("phone_number") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Email:</span>
            <span class="detail-value"><%= itemRs.getString("email") %></span>
        </div>
            <%
                        break;
                    case "Documents":
            %>
                        <div class="detail-row">
                            <div class="detail-label">Document Name</div>
                            <div class="detail-value"><%= itemRs.getString("document_name") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Issued By</div>
                            <div class="detail-value"><%= itemRs.getString("issued_by") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Document Number</div>
                            <div class="detail-value"><%= itemRs.getString("document_number") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Found Location</div>
                            <div class="detail-value"><%= itemRs.getString("document_location") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Issue Date</div>
                            <div class="detail-value"><%= itemRs.getDate("issue_date") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Found Date</div>
                            <div class="detail-value"><%= itemRs.getDate("found_date") %></div>
                        </div>
                        
                           <div class="detail-row">
            <span class="detail-label">Contact Phone:</span>
            <%= itemRs.getString("phone_number") %>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Contact Email:</span>
            <%= itemRs.getString("email") %>
        </div>
            <%
                        break;
                    case "Valuables":
            %>
                        <div class="detail-row">
                            <div class="detail-label">Description</div>
                            <div class="detail-value"><%= itemRs.getString("valuables_description") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Found Location</div>
                            <div class="detail-value"><%= itemRs.getString("valuables_location") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Found Date</div>
                            <div class="detail-value"><%= itemRs.getDate("found_date") %></div>
                        </div>
                        
                          <div class="detail-row">
            <span class="detail-label">Contact Number:</span>
            <span class="detail-value"><%= itemRs.getString("phone_number") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Email:</span>
            <span class="detail-value"><%= itemRs.getString("email") %></span>
        </div>
            <%
                        break;
                    case "Vehicles":
            %>
                        <div class="detail-row">
                            <div class="detail-label">Vehicle Type</div>
                            <div class="detail-value"><%= itemRs.getString("vehicle_type") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Vehicle Name</div>
                            <div class="detail-value"><%= itemRs.getString("vehicle_name") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Color</div>
                            <div class="detail-value"><%= itemRs.getString("vehicle_color") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Registration Number</div>
                            <div class="detail-value"><%= itemRs.getString("registration_number") != null ? itemRs.getString("registration_number") : "N/A" %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Make/Model</div>
                            <div class="detail-value"><%= itemRs.getString("make_model") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Chassis Number</div>
                            <div class="detail-value"><%= itemRs.getString("chassis_number") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Additional Notes</div>
                            <div class="detail-value"><%= itemRs.getString("additional_notes") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Found Date</div>
                            <div class="detail-value"><%= itemRs.getDate("vehicle_found_date") %></div>
                        </div>
                        
                         <div class="detail-row">
            <span class="detail-label">Contact Number:</span>
            <span class="detail-value"><%= itemRs.getString("phone_number") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Email:</span>
            <span class="detail-value"><%= itemRs.getString("email") %></span>
        </div>
            <%
                        break;
                }
                
                // Display image if available
                if (itemRs.getString(imageColumn) != null) {
            %>
            <div class="detail-row">
                <div class="detail-label">Image</div>
                <div class="detail-value">
                    <img src="<%= itemRs.getString(imageColumn) %>" alt="Item image" class="item-image">
                </div>
            </div>
            <%
                }
            %>
        </div>
        <%
                    } else {
                        out.println("<div class='error-message'>Error: Item details not found</div>");
                    }
                    
                    itemRs.close();
                    itemStmt.close();
                }
                
                con.close();
            } catch (Exception e) {
                out.println("<div class='error-message'>Error: " + e.getMessage() + "</div>");
            }
        %>
        
        <a href="my-reports.jsp" class="back-btn">← Back to Claims</a>
    </div>
</body>
</html>