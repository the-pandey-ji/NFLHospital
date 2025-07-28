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
<title>OPD Slip</title>
</head>
<body bgcolor="#CCFFCC">
<% 
	String dname = request.getParameter("T1");
	String relation = request.getParameter("D1");
	String dob = request.getParameter("T3");
	String empn = request.getParameter("T4");
	String sex = request.getParameter("D2");
	
					
Connection conn  = null;    
try {
Class.forName("oracle.jdbc.driver.OracleDriver");
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	conn =DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.1:1521:orcl2","production","prod");
	Statement stmt=conn.createStatement();
	stmt=conn.createStatement();
ResultSet rs = stmt.executeQuery("insert into production.dependents(DNAME, RELATION, BIRTHYEAR, EMPN, SEX) values('"+dname+"','"+relation+"','"+dob+"','"+empn+"','"+sex+"')");
	while(rs.next())
	{
	// d = rs2.getString("sysd");
	}
	
	}

catch(SQLException e) {
//out.println("SQLException : "+ e.getMessage() + "<BR>");
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
<P align="center"><font color="#000080">Thanks One Record Saved !! Do You want
to add new record?</font></P>
<P align="center"><input type="button" value="Yes" onclick="depen_form.jsp"><input type="button" value="No" 
onclick="self.close()"></P>
</body>
</html>
