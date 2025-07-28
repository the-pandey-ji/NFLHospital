<%@ page import="java.sql.*, java.util.*" %>
<%
    String[] diseases = request.getParameterValues("diseases");

    if (diseases != null && diseases.length > 0) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_db", "username", "password");

            stmt = conn.prepareStatement("INSERT INTO selected_diseases (disease_name) VALUES (?)");

            for (String disease : diseases) {
                stmt.setString(1, disease);
                stmt.executeUpdate();
            }

            out.print("OK");

        } catch (Exception e) {
            e.printStackTrace();
            out.print("Error: " + e.getMessage());
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    } else {
        out.print("No diseases selected.");
    }
%>
