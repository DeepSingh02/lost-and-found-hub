<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lost Item Details</title>
    <style>
        :root {
            --primary-color: #dc3545;
            --secondary-color: #6c757d;
            --reward-color: #ffc107;
            --light-bg: #f8f9fa;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-bg);
            margin: 0;
            padding: 0;
            color: #212529;
            line-height: 1.6;
        }
        
        .container {
            max-width: 900px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eee;
        }
        
        h1 {
            color: var(--primary-color);
            margin: 0;
            font-size: 28px;
        }
        
        .detail-card {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .image-section {
            position: relative;
        }
        
        .item-image {
            width: 100%;
            height: auto;
            max-height: 300px;
            object-fit: contain;
            border: 1px solid #eee;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        
        .no-image {
            height: 200px;
            background: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #999;
            font-weight: bold;
            border-radius: 8px;
        }
        
        .details-section {
            display: flex;
            flex-direction: column;
        }
        
        .detail-group {
            margin-bottom: 20px;
        }
        
        .detail-group-title {
            font-size: 18px;
            color: var(--primary-color);
            margin-bottom: 10px;
            padding-bottom: 5px;
            border-bottom: 1px dashed #ddd;
        }
        
        .detail-row {
            display: flex;
            margin-bottom: 8px;
        }
        
        .detail-label {
            font-weight: 600;
            min-width: 160px;
            color: var(--secondary-color);
        }
        
        .detail-value {
            flex: 1;
            word-break: break-word;
        }
        
        .reward-badge {
            background-color: var(--reward-color);
            color: #856404;
            padding: 5px 12px;
            border-radius: 20px;
            font-weight: bold;
            display: inline-block;
            font-size: 15px;
        }
        
        .contact-section {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
        }
        
        .back-btn {
            display: inline-flex;
            align-items: center;
            padding: 10px 20px;
            background: var(--secondary-color);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s;
        }
        
        .back-btn:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
        
        @media (max-width: 768px) {
            .detail-card {
                grid-template-columns: 1fr;
            }
            
            .detail-label {
                min-width: 120px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🔍 Lost Item Details</h1>
            <a href="view-lost-reports.jsp" class="back-btn">← Back to List</a>
        </div>
        
        <%
            String id = request.getParameter("id");
            String category = request.getParameter("category");
            
            if(id == null || category == null) {
                out.println("<div style='color:var(--primary-color); padding:20px; background:#fff5f5; border-radius:8px;'>");
                out.println("<p>Error: Missing required parameters</p>");
                out.println("</div>");
                return;
            }
            
            String url = "jdbc:mysql://localhost:3306/lost_and_found_db";
            String user = "root";
            String password = "1234";
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(url, user, password);
                
                String tableName = "";
                String imageColumn = "";
                String nameField = "";
                
                switch(category) {
                    case "Products": 
                        tableName = "lost_products"; 
                        imageColumn = "bill";
                        nameField = "product_name";
                        break;
                    case "Humans/Animals": 
                        tableName = "lost_humans_animals"; 
                        imageColumn = "photo";
                        nameField = "name";
                        break;
                    case "Documents": 
                        tableName = "lost_documents"; 
                        imageColumn = "xerox_copy";
                        nameField = "document_name";
                        break;
                    case "Valuables": 
                        tableName = "lost_valuables"; 
                        imageColumn = null;
                        nameField = "description";
                        break;
                    case "Vehicles": 
                        tableName = "lost_vehicles"; 
                        imageColumn = "rc_copy";
                        nameField = "vehicle_type";
                        break;
                    default: 
                        out.println("<div style='color:var(--primary-color);'>Invalid category specified</div>");
                        return;
                }
                
                String sql = "SELECT * FROM " + tableName + " WHERE id = ?";
                PreparedStatement stmt = con.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(id));
                ResultSet rs = stmt.executeQuery();
                
                if(rs.next()) {
        %>
        
        <div class="detail-card">
            <!-- Image Section -->
            <div class="image-section">
                <% if(imageColumn != null && rs.getString(imageColumn) != null) { %>
                    <img src="<%= rs.getString(imageColumn) %>" class="item-image" alt="Item image">
                <% } else { %>
                    <div class="no-image">No Image Available</div>
                <% } %>
            </div>
            
            <!-- Details Section -->
            <div class="details-section">
                <!-- Basic Info -->
                <div class="detail-group">
                    <h3 class="detail-group-title">Basic Information</h3>
                    <div class="detail-row">
                        <div class="detail-label">Category:</div>
                        <div class="detail-value"><%= category %></div>
                    </div>
                    
                    <% if(nameField != null && rs.getString(nameField) != null) { %>
                    <div class="detail-row">
                        <div class="detail-label"><%= category.equals("Vehicles") ? "Type" : "Name" %>:</div>
                        <div class="detail-value"><%= rs.getString(nameField) %></div>
                    </div>
                    <% } %>
                    
                    <% if(category.equals("Vehicles") && rs.getString("vehicle_name") != null) { %>
                    <div class="detail-row">
                        <div class="detail-label">Model:</div>
                        <div class="detail-value"><%= rs.getString("vehicle_name") %></div>
                    </div>
                    <% } %>
                </div>
                
                <!-- Category Specific Details -->
                <div class="detail-group">
                    <h3 class="detail-group-title">Detailed Information</h3>
                    <%
                        ResultSetMetaData metaData = rs.getMetaData();
                        int columnCount = metaData.getColumnCount();
                        
                        for(int i=1; i<=columnCount; i++) {
                            String columnName = metaData.getColumnName(i);
                            Object value = rs.getObject(i);
                            
                            // Skip these columns (handled separately or not needed)
                            if(columnName.equalsIgnoreCase("id") || 
                               columnName.equalsIgnoreCase(imageColumn) ||
                               columnName.equalsIgnoreCase(nameField) ||
                               columnName.equalsIgnoreCase("vehicle_name") ||
                               columnName.equalsIgnoreCase("phoneNumber") ||
                               columnName.equalsIgnoreCase("email") ||
                               columnName.equalsIgnoreCase("reward") ||
                               value == null || value.toString().isEmpty()) {
                                continue;
                            }
                            
                            String displayName = columnName.replace("_", " ");
                    %>
                    <div class="detail-row">
                        <div class="detail-label"><%= displayName.substring(0, 1).toUpperCase() + displayName.substring(1) %>:</div>
                        <div class="detail-value"><%= value %></div>
                    </div>
                    <%
                        }
                    %>
                </div>
                
                <!-- Reward Section -->
                <% if(rs.getObject("reward") != null && !rs.getString("reward").equals("0.00")) { %>
                <div class="detail-group">
                    <h3 class="detail-group-title">Reward Offered</h3>
                    <div class="detail-row">
                        <div class="detail-label">Amount:</div>
                        <div class="detail-value"><span class="reward-badge">₹<%= rs.getString("reward") %></span></div>
                    </div>
                </div>
                <% } %>
                
                <!-- Contact Section - Now properly shows for all categories -->
                <% 
                    String phone = rs.getString("phoneNumber");
                    String email = rs.getString("email");
                    if(phone != null || email != null) { 
                %>
                <div class="contact-section">
                    <h3 class="detail-group-title">Contact Information</h3>
                    <% if(phone != null) { %>
                    <div class="detail-row">
                        <div class="detail-label">Phone:</div>
                        <div class="detail-value">
                            <a href="tel:<%= phone %>"><%= phone %></a>
                        </div>
                    </div>
                    <% } %>
                    <% if(email != null) { %>
                    <div class="detail-row">
                        <div class="detail-label">Email:</div>
                        <div class="detail-value">
                            <a href="mailto:<%= email %>"><%= email %></a>
                        </div>
                    </div>
                    <% } %>
                </div>
                <% } %>
            </div>
        </div>
        <%
                } else {
                    out.println("<div style='padding:20px; background:#fff5f5; border-radius:8px;'>");
                    out.println("<p>No item found with ID: " + id + "</p>");
                    out.println("</div>");
                }
                
                rs.close();
                stmt.close();
                con.close();
            } catch(Exception e) {
                out.println("<div style='padding:20px; background:#fff5f5; border-radius:8px;'>");
                out.println("<p style='color:var(--primary-color);'>Error: " + e.getMessage() + "</p>");
                out.println("</div>");
            }
        %>
    </div>
</body>
</html>