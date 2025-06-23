package com.myproject.lostandfoundhub.auth;

import com.myproject.lostandfoundhub.utils.DatabaseConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Login Attempt: Email = " + email + ", Password = " + password); // DEBUG

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            out.println("<h2>Error: All fields are required!</h2>");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE email = ? AND password_hash = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            rs = stmt.executeQuery();

            if (rs.next()) {
                System.out.println("✅ User Found: " + email); // DEBUG

                // Create session and store user data
                HttpSession session = request.getSession();
                session.setAttribute("user_id", rs.getInt("user_id"));
                session.setAttribute("name", rs.getString("name"));
                session.setAttribute("email", rs.getString("email"));

                // Redirect to dashboard
                response.sendRedirect("dashboard.jsp");
            } else {
                System.out.println("❌ Invalid Login Attempt: " + email); // DEBUG
                out.println("<h2>Error: Invalid Email or Password!</h2>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<h2>Error: " + e.getMessage() + "</h2>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
