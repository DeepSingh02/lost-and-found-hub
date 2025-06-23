<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Found Items Gallery</title>
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
        
        .btn-claim {
            display: inline-block;
            padding: 8px 15px;
            background-color: #28a745;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s;
            font-size: 0.9rem;
            border: none;
            cursor: pointer;
        }
        
        .btn-claim:hover {
            background-color: #218838;
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
        <h1><center>Recently Found Items</center></h1>
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
                        "SELECT id, product_name, found_location, found_date, image_path " +
                        "FROM found_products LIMIT 8");

                    while (rs.next()) {
            %>
            <div class="item product">
                <a href="item-details.jsp?id=<%= rs.getInt("id") %>">
                    <img src="<%= rs.getString("image_path") %>" alt="<%= rs.getString("product_name") %>">
                </a>
                <div class="item-info">
                    <h3><%= rs.getString("product_name") %></h3>
                    <p><strong>Found at:</strong> <%= rs.getString("found_location") %></p>
                    <p><strong>Date:</strong> <%= rs.getDate("found_date") %></p>
                    <div class="item-actions">
                        <a href="item-details.jsp?id=<%= rs.getInt("id") %>" class="view-details">🔍 View Details</a>
                        <a href="claim-item.jsp?item_id=<%= rs.getInt("id") %>&category=Product" class="btn-claim">✅ Claim</a>
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
                        "SELECT id, name, found_location, found_date, photo_path " +
                        "FROM found_humans_animals LIMIT 8");

                    while (rs.next()) {
            %>
            <div class="item humans-animals">
                <a href="item-details-human.jsp?id=<%= rs.getInt("id") %>">
                    <img src="<%= rs.getString("photo_path") %>" alt="<%= rs.getString("name") %>">
                </a>
                <div class="item-info">
                    <h3><%= rs.getString("name") %></h3>
                    <p><strong>Found at:</strong> <%= rs.getString("found_location") %></p>
                    <p><strong>Date:</strong> <%= rs.getDate("found_date") %></p>
                    <div class="item-actions">
                        <a href="item-details-human.jsp?id=<%= rs.getInt("id") %>" class="view-details">🔍 View Details</a>
                        <a href="claim-item.jsp?item_id=<%= rs.getInt("id") %>&category=Humans/Animals" class="btn-claim">✅ Claim</a>
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
                        "SELECT id, document_name, issued_by, document_number, document_location, found_date, document_image_path " +
                        "FROM found_documents LIMIT 8");

                    while (rs.next()) {
            %>
            <div class="item documents">
                <a href="item-details-document.jsp?id=<%= rs.getInt("id") %>">
                    <img src="<%= rs.getString("document_image_path") %>" alt="<%= rs.getString("document_name") %>">
                </a>
                <div class="item-info">
                    <h3><%= rs.getString("document_name") %></h3>
                    <p><strong>Issued by:</strong> <%= rs.getString("issued_by") %></p>
                    <p><strong>Number:</strong> <%= rs.getString("document_number") %></p>
                    <p><strong>Found at:</strong> <%= rs.getString("document_location") %></p>
                    <p><strong>Date:</strong> <%= rs.getDate("found_date") %></p>
                    <div class="item-actions">
                        <a href="item-details-document.jsp?id=<%= rs.getInt("id") %>" class="view-details">🔍 View Details</a>
                        <a href="claim-item.jsp?item_id=<%= rs.getInt("id") %>&category=Documents" class="btn-claim">✅ Claim</a>
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
                        "SELECT id, valuables_description, valuables_location, found_date, valuables_image_path " +
                        "FROM found_valuables LIMIT 8");

                    while (rs.next()) {
            %>
            <div class="item valuables">
                <a href="item-details-valuables.jsp?id=<%= rs.getInt("id") %>">
                    <img src="<%= rs.getString("valuables_image_path") %>" alt="<%= rs.getString("valuables_description") %>">
                </a>
                <div class="item-info">
                    <h3><%= rs.getString("valuables_description") %></h3>
                    <p><strong>Found at:</strong> <%= rs.getString("valuables_location") %></p>
                    <p><strong>Date:</strong> <%= rs.getDate("found_date") %></p>
                    <div class="item-actions">
                        <a href="item-details-valuables.jsp?id=<%= rs.getInt("id") %>" class="view-details">🔍 View Details</a>
                        <a href="claim-item.jsp?item_id=<%= rs.getInt("id") %>&category=Valuables" class="btn-claim">✅ Claim</a>
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
                        "SELECT id, vehicle_type, vehicle_name, vehicle_color, registration_number, vehicle_found_date, vehicle_image_path " +
                        "FROM found_vehicles LIMIT 8");

                    while (rs.next()) {
            %>
            <div class="item vehicles">
                <a href="item-details-vehicle.jsp?id=<%= rs.getInt("id") %>">
                    <img src="<%= rs.getString("vehicle_image_path") %>" alt="<%= rs.getString("vehicle_name") %>">
                </a>
                <div class="item-info">
                    <h3><%= rs.getString("vehicle_type") %>: <%= rs.getString("vehicle_name") %></h3>
                    <p><strong>Color:</strong> <%= rs.getString("vehicle_color") %></p>
                    <p><strong>Reg No:</strong> <%= rs.getString("registration_number") != null ? rs.getString("registration_number") : "N/A" %></p>
                    <p><strong>Date:</strong> <%= rs.getDate("vehicle_found_date") %></p>
                    <div class="item-actions">
                        <a href="item-details-vehicle.jsp?id=<%= rs.getInt("id") %>" class="view-details">🔍 View Details</a>
                        <a href="claim-item.jsp?item_id=<%= rs.getInt("id") %>&category=Vehicles" class="btn-claim">✅ Claim</a>
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
                item.style.display = 'block'; // Show all items initially

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

        // When the page loads, show all items
        window.onload = function() {
            document.getElementById("categoryDropdown").value = "All";
            filterCategory();
        };
    </script>
</body>
</html>