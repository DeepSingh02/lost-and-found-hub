<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lost Items Gallery</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            color: #333;
        }
        
        .header {
            background-color: #4CAF50;
            color: white;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }
        
        .filter-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .nav-buttons {
            display: flex;
            gap: 10px;
        }
        
        .btn {
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
        }
        
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
        
        select {
            padding: 10px 15px;
            border-radius: 5px;
            border: 1px solid #ced4da;
            font-size: 16px;
            min-width: 250px;
            background-color: white;
        }
        
        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            padding: 10px;
        }
        
        .item {
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            overflow: hidden;
            transition: all 0.3s ease;
            background-color: white;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
        }
        
        .item:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-bottom: 1px solid #eee;
        }
        
        .item-info {
            padding: 20px;
        }
        
        .item-info h3 {
            margin-top: 0;
            color: #2c3e50;
            font-size: 1.2rem;
        }
        
        .item-info p {
            margin: 8px 0;
            color: #555;
            font-size: 0.95rem;
        }
        
        .item-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        
        .view-details {
            display: inline-block;
            padding: 8px 15px;
            color: #4CAF50;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s;
            border: 1px solid #4CAF50;
            border-radius: 5px;
        }
        
        .view-details:hover {
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
        }
        
        .no-items {
            text-align: center;
            grid-column: 1 / -1;
            padding: 40px;
            color: #6c757d;
        }
        
        @media (max-width: 768px) {
            .filter-section {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .gallery {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Recently Lost Items</h1>
    </div>
    
    <div class="container">
        <div class="filter-section">
            <div>
                <label for="categoryDropdown" style="font-weight: 600; margin-right: 10px;">Filter by Category:</label>
                <select id="categoryDropdown" onchange="filterCategory()">
                    <option value="All">All Categories</option>
                    <option value="Products">Products</option>
                    <option value="Humans/Animals">Humans/Animals</option>
                    <option value="Documents">Documents</option>
                    <option value="Valuables">Valuables</option>
                    <option value="Vehicles">Vehicles</option>
                </select>
            </div>
            
            <div class="nav-buttons">
                <a href="dashboard.jsp" class="btn btn-secondary">🏠 Dashboard</a>
                <a href="index.html" class="btn btn-primary">🏡 Home</a>
            </div>
        </div>

        <div id="allGallery" class="gallery">
            <%-- Displaying Products --%>
            <%
                String url = "jdbc:mysql://localhost:3306/lost_and_found_db";
                String user = "root";
                String password = "1234";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection(url, user, password);

                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(
                        "SELECT id, product_name, brand, color, lost_location, lost_date, bill as image_path " +
                        "FROM lost_products LIMIT 8");

                    while (rs.next()) {
            %>
            <div class="item product">
                <% if (rs.getString("image_path") != null) { %>
                    <img src="<%= rs.getString("image_path") %>" alt="<%= rs.getString("product_name") %>">
                <% } else { %>
                    <div style="height:200px; background:#eee; display:flex; align-items:center; justify-content:center;">
                        No Image
                    </div>
                <% } %>
                <div class="item-info">
                    <h3><%= rs.getString("product_name") %></h3>
                    <% if (rs.getString("brand") != null) { %>
                        <p><strong>Brand:</strong> <%= rs.getString("brand") %></p>
                    <% } %>
                    <p><strong>Color:</strong> <%= rs.getString("color") %></p>
                    <p><strong>Lost at:</strong> <%= rs.getString("lost_location") %></p>
                    <p><strong>Date:</strong> <%= rs.getDate("lost_date") %></p>
                    <div class="item-actions">
                        <a href="lost-item-details.jsp?id=<%= rs.getInt("id") %>&category=Products" class="view-details">🔍 View Details</a>
                    </div>
                </div>
            </div>
            <%
                    }
                    rs.close();
                    stmt.close();
                } catch (Exception e) {
                    out.println("<p class='error'>Error loading products: " + e.getMessage() + "</p>");
                }
            %>

           <%-- Displaying Humans/Animals --%>
<%
    try {
        Connection con = DriverManager.getConnection(url, user, password);
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(
            "SELECT id, name, skin_tone, last_seen_location, last_seen_time, photo as image_path " +
            "FROM lost_humans_animals LIMIT 8");

        while (rs.next()) {
%>
<div class="item humans-animals">
    <% if (rs.getString("image_path") != null) { %>
        <img src="<%= rs.getString("image_path") %>" alt="<%= rs.getString("name") %>">
    <% } else { %>
        <div style="height:200px; background:#eee; display:flex; align-items:center; justify-content:center;">
            No Image
        </div>
    <% } %>
    <div class="item-info">
        <h3><%= rs.getString("name") %></h3>
        <p><strong>Last seen at:</strong> <%= rs.getString("last_seen_location") %></p>
        <% if (rs.getString("skin_tone") != null) { %>
            <p><strong>Skin Tone:</strong> <%= rs.getString("skin_tone") %></p>
        <% } %>
        <% if (rs.getString("last_seen_time") != null) { %>
            <p><strong>Last seen:</strong> <%= rs.getString("last_seen_time") %></p>
        <% } %>
        <div class="item-actions">
            <a href="lost-item-details.jsp?id=<%= rs.getInt("id") %>&category=Humans/Animals" class="view-details">🔍 View Details</a>
        </div>
    </div>
</div>
<%
        }
        rs.close();
        stmt.close();
    } catch (Exception e) {
        out.println("<p class='error'>Error loading humans/animals: " + e.getMessage() + "</p>");
    }
%>
            <%-- Displaying Documents --%>
            <%
                try {
                    Connection con = DriverManager.getConnection(url, user, password);
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(
                        "SELECT id, document_name, issued_by, document_number, lost_location, lost_date, xerox_copy as image_path " +
                        "FROM lost_documents LIMIT 8");

                    while (rs.next()) {
            %>
            <div class="item documents">
                <% if (rs.getString("image_path") != null) { %>
                    <img src="<%= rs.getString("image_path") %>" alt="<%= rs.getString("document_name") %>">
                <% } else { %>
                    <div style="height:200px; background:#eee; display:flex; align-items:center; justify-content:center;">
                        No Image
                    </div>
                <% } %>
                <div class="item-info">
                    <h3><%= rs.getString("document_name") %></h3>
                    <% if (rs.getString("issued_by") != null) { %>
                        <p><strong>Issued by:</strong> <%= rs.getString("issued_by") %></p>
                    <% } %>
                    <% if (rs.getString("document_number") != null) { %>
                        <p><strong>Document No:</strong> <%= rs.getString("document_number") %></p>
                    <% } %>
                    <p><strong>Lost at:</strong> <%= rs.getString("lost_location") %></p>
                    <p><strong>Date:</strong> <%= rs.getDate("lost_date") %></p>
                    <div class="item-actions">
                        <a href="lost-item-details.jsp?id=<%= rs.getInt("id") %>&category=Documents" class="view-details">🔍 View Details</a>
                    </div>
                </div>
            </div>
            <%
                    }
                    rs.close();
                    stmt.close();
                } catch (Exception e) {
                    out.println("<p class='error'>Error loading documents: " + e.getMessage() + "</p>");
                }
            %>

            <%-- Displaying Valuables --%>
            <%
                try {
                    Connection con = DriverManager.getConnection(url, user, password);
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(
                        "SELECT id, description, lost_location, lost_date " +
                        "FROM lost_valuables LIMIT 8");

                    while (rs.next()) {
            %>
            <div class="item valuables">
                <div style="height:200px; background:#eee; display:flex; align-items:center; justify-content:center;">
                    No Image
                </div>
                <div class="item-info">
                    <h3>Valuable Item</h3>
                    <p><strong>Description:</strong> <%= rs.getString("description") %></p>
                    <p><strong>Lost at:</strong> <%= rs.getString("lost_location") %></p>
                    <p><strong>Date:</strong> <%= rs.getDate("lost_date") %></p>
                    <div class="item-actions">
                        <a href="lost-item-details.jsp?id=<%= rs.getInt("id") %>&category=Valuables" class="view-details">🔍 View Details</a>
                    </div>
                </div>
            </div>
            <%
                    }
                    rs.close();
                    stmt.close();
                } catch (Exception e) {
                    out.println("<p class='error'>Error loading valuables: " + e.getMessage() + "</p>");
                }
            %>

            <%-- Displaying Vehicles --%>
            <%
                try {
                    Connection con = DriverManager.getConnection(url, user, password);
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(
                        "SELECT id, vehicle_type, vehicle_name, color, registration_number, lost_date, rc_copy as image_path " +
                        "FROM lost_vehicles LIMIT 8");

                    while (rs.next()) {
            %>
            <div class="item vehicles">
                <% if (rs.getString("image_path") != null) { %>
                    <img src="<%= rs.getString("image_path") %>" alt="<%= rs.getString("vehicle_name") %>">
                <% } else { %>
                    <div style="height:200px; background:#eee; display:flex; align-items:center; justify-content:center;">
                        No Image
                    </div>
                <% } %>
                <div class="item-info">
                    <h3><%= rs.getString("vehicle_type") %></h3>
                    <% if (rs.getString("vehicle_name") != null) { %>
                        <p><strong>Model:</strong> <%= rs.getString("vehicle_name") %></p>
                    <% } %>
                    <p><strong>Color:</strong> <%= rs.getString("color") %></p>
                    <% if (rs.getString("registration_number") != null) { %>
                        <p><strong>Reg No:</strong> <%= rs.getString("registration_number") %></p>
                    <% } %>
                    <p><strong>Lost Date:</strong> <%= rs.getDate("lost_date") %></p>
                    <div class="item-actions">
                        <a href="lost-item-details.jsp?id=<%= rs.getInt("id") %>&category=Vehicles" class="view-details">🔍 View Details</a>
                    </div>
                </div>
            </div>
            <%
                    }
                    rs.close();
                    stmt.close();
                    con.close();
                } catch (Exception e) {
                    out.println("<p class='error'>Error loading vehicles: " + e.getMessage() + "</p>");
                }
            %>
        </div>
    </div>

    <script>
        function filterCategory() {
            var selectedCategory = document.getElementById("categoryDropdown").value;
            var allItems = document.querySelectorAll('.item');

            allItems.forEach(function(item) {
                item.style.display = 'block';

                if (selectedCategory === 'Products' && !item.classList.contains('product')) {
                    item.style.display = 'none';
                } 
                else if (selectedCategory === 'Humans/Animals' && !item.classList.contains('humans-animals')) {
                    item.style.display = 'none';
                }
                else if (selectedCategory === 'Documents' && !item.classList.contains('documents')) {
                    item.style.display = 'none';
                }
                else if (selectedCategory === 'Valuables' && !item.classList.contains('valuables')) {
                    item.style.display = 'none';
                }
                else if (selectedCategory === 'Vehicles' && !item.classList.contains('vehicles')) {
                    item.style.display = 'none';
                }
            });
        }

        window.onload = function() {
            document.getElementById("categoryDropdown").value = "All";
            filterCategory();
        };
    </script>
</body>
</html>