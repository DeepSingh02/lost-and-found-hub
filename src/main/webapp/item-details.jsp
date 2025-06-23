<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Product Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            text-align: center;
        }
        .document-image {
            max-width: 300px;
            margin: 20px auto;
            display: block;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .detail-row {
            margin-bottom: 15px;
        }
        .detail-label {
            font-weight: bold;
            color: #555;
            display: inline-block;
            width: 150px;
        }
        .detail-value {
            display: inline-block;
            padding: 8px;
            background: #f9f9f9;
            border-radius: 4px;
            border-left: 3px solid #4CAF50;
            width: calc(100% - 170px);
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 8px 15px;
            background: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .back-link:hover {
            background: #45a049;
        }
        .error {
            color: #d9534f;
            padding: 10px;
            background: #f2dede;
            border-radius: 4px;
        }
        @media (max-width: 600px) {
            .detail-label, .detail-value {
                display: block;
                width: 100%;
            }
            .detail-label {
                margin-bottom: 5px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            String itemId = request.getParameter("id");
            if (itemId != null) {
                String url = "jdbc:mysql://localhost:3306/lost_and_found_db";
                String user = "root";
                String password = "1234";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection(url, user, password);
                    
                    PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM found_products WHERE id = ?");
                    ps.setInt(1, Integer.parseInt(itemId));
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
        %>
        <h1><%= rs.getString("product_name") %></h1>
        
        <img src="<%= rs.getString("image_path") %>" class="document-image" 
             alt="<%= rs.getString("product_name") %>">
        
        <div class="detail-row">
            <span class="detail-label">Brand:</span>
            <span class="detail-value"><%= rs.getString("brand") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Color:</span>
            <span class="detail-value"><%= rs.getString("color") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Description:</span>
            <span class="detail-value"><%= rs.getString("description") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Found Location:</span>
            <span class="detail-value"><%= rs.getString("found_location") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Found Date:</span>
            <span class="detail-value"><%= rs.getDate("found_date") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Serial Number:</span>
            <span class="detail-value"><%= rs.getString("serial_number") %></span>
        </div>
        
     
        
        <div style="text-align: center;">
            <a href="view-found-reports.jsp" class="back-link">← Back to Gallery</a>
        </div>
        <%
                    } else {
                        out.println("<p class='error'>Item not found.</p>");
                    }
                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                }
            } else {
                out.println("<p class='error'>Invalid item ID.</p>");
            }
        %>
    </div>
</body>
</html>