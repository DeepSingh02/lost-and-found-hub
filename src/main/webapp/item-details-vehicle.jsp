<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Vehicle Details</title>
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
        }
        .document-image {
            max-width: 300px;
            margin: 20px 0;
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
            String url = "jdbc:mysql://localhost:3306/lost_and_found_db";
            String user = "root";
            String password = "1234";
            String id = request.getParameter("id");
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(url, user, password);
                
                PreparedStatement stmt = con.prepareStatement(
                    "SELECT * FROM found_vehicles WHERE id = ?");
                stmt.setString(1, id);
                ResultSet rs = stmt.executeQuery();
                
                if (rs.next()) {
        %>
        <h1><%= rs.getString("vehicle_type") %> Details</h1>
        
        <img src="<%= rs.getString("vehicle_image_path") %>" class="document-image" 
             alt="<%= rs.getString("vehicle_name") %>">
        
        <div class="detail-row">
            <span class="detail-label">Vehicle Name:</span>
            <span class="detail-value"><%= rs.getString("vehicle_name") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Color:</span>
            <span class="detail-value"><%= rs.getString("vehicle_color") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Registration Number:</span>
            <span class="detail-value"><%= rs.getString("registration_number") != null ? rs.getString("registration_number") : "N/A" %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Make/Model:</span>
            <span class="detail-value"><%= rs.getString("make_model") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Chassis Number:</span>
            <span class="detail-value"><%= rs.getString("chassis_number") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Additional Notes:</span>
            <span class="detail-value"><%= rs.getString("additional_notes") %></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Found Date:</span>
            <span class="detail-value"><%= rs.getDate("vehicle_found_date") %></span>
        </div>
        
       
        
        <a href="view-found-reports.jsp" class="back-link">← Back to Gallery</a>
        
        <%
                }
                rs.close();
                stmt.close();
                con.close();
            } catch (Exception e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            }
        %>
    </div>
</body>
</html>