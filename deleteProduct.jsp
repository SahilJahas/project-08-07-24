<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<%
    String id = request.getParameter("id");

    if (id != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            // Establish a connection to the database
            conn = DriverManager.getConnection("jdbc:mysql://192.168.18.245:3306/javadb_168", "javadb_168", "Sp3cJa5A2k24");

            // SQL statement to delete the product
            String sql = "DELETE FROM products WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                out.println("Product deleted successfully.");
            } else {
                out.println("Product not found.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("Error deleting product: " + e.getMessage());
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    } else {
        out.println("Invalid product ID.");
    }
%>
<a href="viewproducts.jsp">Back to Product List</a>
