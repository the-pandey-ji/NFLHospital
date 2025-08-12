<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.* "%>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.DB.DBConnect" %>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Dependents</title>
</head>

<body background="../Stationery/Glacier%20Bkgrd.jpg">
<% 
	String empn = request.getParameter("T1");
	String dname = "";
	String rel = "";
	String age = "";
	//String nm = "";
			
    Connection con1=DBConnect.getConnection1(); 
    try 
        {

        
        Statement stmt1=con1.createStatement();
           
	       ResultSet rs = stmt1.executeQuery("select * FROM dependents where status='A' and empn="+empn);
	%>
<form method="POST" action="/hosp1/HOSPITAL/OPD/details.jsp">
   <p align="center">&nbsp;</p>
   <p align="center"><font face="Tahoma" size="3" color="#000080">Dependents of E. Code. - <%= empn%> </font></p>
   <p align="center">&nbsp;</p>
   <p align="center">&nbsp;</p>
   <p align="center"><font face="Arial" size="2"><select size="1" name="depnm">
<%
while(rs.next())
	{
	
	dname = rs.getString(2);
	rel = rs.getString(3);
	age = rs.getString(4);
	session.setAttribute("eno",empn); 
	session.setMaxInactiveInterval(-1);
  	%>
    <option><%=dname%></option>
  
<%
	}
	
	%>
	 </select></font><font color="#000080"><b><input type="submit" value="Submit" name="B1"></b></font></p>
</form>
<%
	
  	}

catch(SQLException e) {
out.println("SQLException : "+ e.getMessage() + "<BR>");
while((e = e.getNextException()) != null)
out.println(e.getMessage() + "<BR>");
}

finally{
if(con1 != null) {
try{
con1.close();
}
catch (Exception ignored) {}
}
}
%>

</body>

</html>