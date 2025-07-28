<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.* "%>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Dependents</title>
</head>

<body background="../Stationery/Glacier%20Bkgrd.jpg">
<% 
	String en = request.getParameter("T1");
	String dname = "";
	String rel = "";
	String by = "";
	int a=1;
			
Connection conn  = null;    
try {
Class.forName("oracle.jdbc.driver.OracleDriver");
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.111.107:1521:orcl2","production","prod");
	Statement stmt=conn.createStatement();
	stmt=conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * FROM PRODUCTION.dependents where empn="+en);
	%>
<form method="POST" action="http://10.3.122.104:81/HOSPITAL/details.jsp">
   <p align="center">&nbsp;</p>
   <p align="center"><font face="Tahoma" size="3" color="#000080">Dependents of
   E. Code. - <%= en%> </font></p>
   <p align="center">&nbsp;</p>
   <p align="center">&nbsp;</p>
   <p align="center"><font face="Arial" size="2"><select size="1" name="D1">
<%
while(rs.next())
	{
	
	dname = rs.getString("dname");
	rel = rs.getString("relation");
	by = rs.getString("birthyear");
	session.setAttribute("nm",en); 
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
catch(ClassNotFoundException e) {
out.println("ClassNotFoundexception :" + e.getMessage() + "<BR>");
}
finally{
if(conn != null) {
try{
conn.close();
}
catch (Exception ignored) {}
}
}
%>

</body>

</html>
