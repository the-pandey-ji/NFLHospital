<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>
<%
Connection con=DBConnect.getConnection(); 
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT medicinename FROM medicinemaster");

    while (rs.next()) {
        String medicine = rs.getString("medicinename");
%>
        <option value="<%= medicine %>"><%= medicine %></option>
<%
    }

    rs.close();
    stmt.close();
    con.close();
%>