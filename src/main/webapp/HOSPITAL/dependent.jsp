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
<title>Leaves Details</title>
</head>
<% 
	String en = request.getParameter("T1");
	String dname = "";
	String rel = "";
	String by = "";
	int a = 0;
			
Connection conn  = null;    
try {
Class.forName("oracle.jdbc.driver.OracleDriver");
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.111.107:1521:orcl2","production","prod");
	Statement stmt=conn.createStatement();
	stmt=conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * FROM PRODUCTION.dependents where empn="+en);
%>
<div align="center">
  <center>
  <table border="0" width="60%" height="1" style="border-style: solid; border-width: 1">
    <tr>
    <td width="23%" height="1">
      <p align="center"><b><font size="3">Sr. No.</font></b></td>
     
    <td width="23%" height="1"><b><font size="3">Name</font></b></td>
     
  	 <td width="23%" height="1"><b><font size="3">Relation</font></b></td>
     
  	 <td width="23%" height="1"><b><font size="3">Birth Year</font></b></td>
  	 
  	 <td width="23%" height="1"><b><font size="3">Details</font></b></td>

     
    </tr>
<%
while(rs.next())
	{
	 a = 1;
	dname = rs.getString("dname");
	rel = rs.getString("relation");
	by = rs.getString("birthyear");
	session.setAttribute("nm",dname); 
	session.setMaxInactiveInterval(-1);
  	%>
  	 
    <tr>
  	 <td width="23%" height="1"><%= a%></td>
  	 <td width="23%" height="1"><%=dname%></td>
  	 <td width="23%" height="1"><%=rel%></td>
  	 <td width="23%" height="1"><%=by%></td>
  	 <td width="23%" height="1"><a href="http://10.3.122.104:81/HOSPITAL/details.jsp">details</a></td>
    </tr>
    
   <%	
	}
	a++;
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
  </table>
  </center>
</div>

</html>
