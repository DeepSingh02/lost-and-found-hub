<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Document Details</title>
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
                    "SELECT * FROM found_documents WHERE id = ?");
                stmt.setString(1, id);
                ResultSet rs = stmt.executeQuery();
                
                if (rs.next()) {
        %>
        <h1><%= rs.getString("document_name") %></h1>
        
        <img src="<%= rs.getString("document_image_path") %>" class="document-image" 
             alt="<%= rs.getString("document_name") %>">
        
        <div class="detail-row">
            <span class="detail-label">Issued by:</span>
            <%= rs.getString("issued_by") %>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Document Number:</span>
            <%= rs.getString("document_number") %>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Found Location:</span>
            <%= rs.getString("document_location") %>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Found Date:</span>
            <%= rs.getDate("found_date") %>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Issue Date:</span>
            <%= rs.getDate("issue_date") %>
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