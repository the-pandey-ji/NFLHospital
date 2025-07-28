<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>


<%
    String medicineName = request.getParameter("medicineName");

    try {
    	Connection conn=DBConnect.getConnection(); 
        PreparedStatement ps = conn.prepareStatement("INSERT INTO medicinemaster (medicinename) VALUES (?)");
        ps.setString(1, medicineName);
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
