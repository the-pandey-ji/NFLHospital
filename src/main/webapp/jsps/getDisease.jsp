
<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>
<%
Connection con = DBConnect.getConnection();
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery("SELECT disease_code, disease_name FROM diseases");

while (rs.next()) {
    int diseaseCode = rs.getInt("disease_code");
    String diseaseName = rs.getString("disease_name");
%>
    <option value="<%= diseaseCode %>"><%= diseaseName %></option>
<%
}

rs.close();
stmt.close();
con.close();
%>
