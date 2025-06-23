<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Get parameters
    String claim_id = request.getParameter("claim_id");
    String action = request.getParameter("action");
    
    // Validate inputs
    if (claim_id == null || action == null) {
        response.sendRedirect("admin-claims.jsp?error=invalid_params");
        return;
    }
    
    // Database connection
    String url = "jdbc:mysql://localhost:3306/lost_and_found_db";
    String dbUser = "root";
    String dbPassword = "1234";
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, dbUser, dbPassword);
        
        // Set status based on action
        String status = action.equals("approve") ? "Approved" : "Rejected";
        String sql = "UPDATE claims SET status = ? WHERE claim_id = ?";
        
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, status);
        pstmt.setInt(2, Integer.parseInt(claim_id));
        
        int rowsUpdated = pstmt.executeUpdate();
        pstmt.close();
        con.close();
        
        if (rowsUpdated > 0) {
            response.sendRedirect("admin-claims.jsp?success=" + action);
        } else {
            response.sendRedirect("admin-claims.jsp?error=update_failed");
        }
    } catch (Exception e) {
        response.sendRedirect("admin-claims.jsp?error=db_error");
    }
%>