
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
<title>New Page 1</title>
</head>

<body>
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
  
  <div align="center">
    <center>
    <table border="1" cellspacing="1">
      <tr>
        <td>
          Sr.No.</td>
        <td>
          <p align="center">Dependent Name</td>
        <td>
          <p align="center">Relation</td>
        <td>
          <p align="center">Birth Year</td>
        <td>&nbsp;</td>
      </tr>
      <%
      while(rs.next())
	{
	
	dname = rs.getString("dname");
	rel = rs.getString("relation");
	by = rs.getString("birthyear");
	session.setAttribute("nm",en); 
	session.setMaxInactiveInterval(-1);
  	%>
      <tr>
        <td><input type="text" name="T4" value=<%=a%> size="20"></td>
        <td><input type="text" name="T1" value=<%=dname%> size="20"></td>
        <td><input type="text" name="T2" value=<%=rel%> size="20"></td>
        <td><input type="text" name="T3" value=<%=by%> size="20"></td>
        <td><input type="submit" value="Submit" name="B1"></td>
      </tr>
      <%
	a++;	
	}
	
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
  
</form>

</body>

</html>
