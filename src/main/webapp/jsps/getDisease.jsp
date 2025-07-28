<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>
<%
Connection con=DBConnect.getConnection(); 
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT disease_name FROM diseases");

    while (rs.next()) {
        String disease = rs.getString("disease_name");
%>
        <option value="<%= disease %>"><%= disease %></option>
<%
    }

    rs.close();
    stmt.close();
    con.close();
%>