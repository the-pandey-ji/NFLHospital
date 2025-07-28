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
<title>Print Test</title>
<style type="text/css" media="print">
.printbutton {
  visibility: hidden;
  display: none;
}
</style>
</head>
<body>

<% 
	String dt = request.getParameter("T1");
	String pname = "";
	String ename = "";
	String rel = "";
	String by = "";
	String srno ="";
	String sex="";
	String empn="";
	String no="";
%>	<table border="1" width="100%">
<p align="center"><b><font size="4"> OPD Detail on <%=dt%></font> <font size="5"> </font></b>  
<tr>
    <td width="11%" align="center">OPD No</td>
    <td width="27%">Patient Name</td>
    <td width="47%">Employee Name</td>
    <td width="9%" align="center">E.Code&nbsp;</td>
    <td width="10%" align="center">Relation</td>
    <td width="6%" align="center">Age</td>
    <td width="5%" align="center">Sex</td>
  </tr>
<%				
Connection conn  = null;    
try {
Class.forName("oracle.jdbc.driver.OracleDriver");
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	conn =DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.1:1521:orcl2","production","prod");
	Statement stmt=conn.createStatement();
	stmt=conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * FROM PRODUCTION.opdo where TO_CHAR(opddate,'ddmmyyyy') ='"+dt+"'");
while(rs.next())
	{
	
	pname = rs.getString("patientname");
	ename = rs.getString("EMPNAME");
	rel = rs.getString("relation");
	by = rs.getString("age");
	sex = rs.getString("sex");
	empn = rs.getString("empn");
	srno = rs.getString("srno");
%>	
<tr>
    <td width="11%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=srno%></span></font></td>
    <td width="27%"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=pname%></span></font></td>
    <td width="47%"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=ename%></span></font></td>
    <td width="9%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=empn%></span></font></td>
    <td width="10%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=rel%></span></font></td>
    <td width="6%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=by%></span></font></td>
    <td width="5%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=sex%></span></font></td>
  </tr>

<%	


}
%>
</table>
<%
ResultSet rs1 = stmt.executeQuery("select count(*) nopd from production.opdo where to_char(opddate,'dd-mon-yyyy') ='"+dt+"'");
while(rs1.next())
	{
	no = rs1.getString("nopd");
	}
%> 
<p>&nbsp;</p>
<p> 
  Total Number Of OPD on <%=dt%>: <%=no%>
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


  
</p>


  
</body>
</html>


