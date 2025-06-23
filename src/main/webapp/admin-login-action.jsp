<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    try {
        // 1. Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/lost_and_found_db", 
            "root", 
            "1234");
        
        // 2. Verify credentials against admin_users table
        String sql = "SELECT id, username FROM admin_users WHERE username=? AND password=?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        
        ResultSet rs = pstmt.executeQuery();
        
        // 3. Check if admin exists
        if (rs.next()) {
            // Valid admin - set session attributes
            session.setAttribute("admin_id", rs.getInt("id"));
            session.setAttribute("admin_username", rs.getString("username"));
            response.sendRedirect("admin-claims.jsp");
        } else {
            // Invalid credentials
            response.sendRedirect("admin-login.jsp?error=1");
        }
        
        // 4. Close resources
        rs.close();
        pstmt.close();
        con.close();
        
    } catch(ClassNotFoundException e) {
        out.println("Error: MySQL driver not found");
    } catch(SQLException e) {
        out.println("Database Error: " + e.getMessage());
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>