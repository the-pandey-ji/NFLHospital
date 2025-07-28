<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>


<%
    String diseaseName = request.getParameter("diseaseName");

    try {
    	Connection conn=DBConnect.getConnection(); 
        PreparedStatement ps = conn.prepareStatement("INSERT INTO diseases (disease_name) VALUES (?)");
        ps.setString(1, diseaseName);
        int rows = ps.executeUpdate();

        if (rows > 0) {
            out.print("OK");
        } else {
            out.print("FAIL");
        }

        ps.close();
        conn.close();
    } catch (Exception e) {
        out.print("FAIL");
    }
%>
