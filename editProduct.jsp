<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String productId = request.getParameter("id");
    String name = "";
    String description = "";
    String price = "";
    String category = "";

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/yourdatabase";
    String dbUser = "yourusername";
    String dbPassword = "yourpassword";
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://192.168.18.245:3306/javadb_168", "javadb_168", "Sp3cJa5A2k24");
        String sql = "SELECT * FROM products WHERE id = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, productId);
        rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            description = rs.getString("description");
            price = rs.getString("price");
            category = rs.getString("category");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<html>
<head>
    <title>Edit Product</title>
</head>
<body>
    <h1>Edit Product</h1>
    <form action="updateProduct.jsp" method="post">
        <input type="hidden" name="id" value="<%= productId %>">
        <label for="name">Product Name:</label>
        <input type="text" id="name" name="name" value="<%= name %>"><br><br>
        <label for="description">Description:</label>
        <textarea id="description" name="description"><%= description %></textarea><br><br>
        <label for="price">Price:</label>
        <input type="text" id="price" name="price" value="<%= price %>"><br><br>
        <label for="category">Category:</label>
        <input type="text" id="category" name="category" value="<%= category %>"><br><br>
        <input type="submit" value="Update Product">
    </form>
</body>
</html>
