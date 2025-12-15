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
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Medical Exam Due</title>

<style type="text/css" media="print">
.printbutton {
  visibility: hidden;
  display: none;
}
</style>
</head>
<body>
 <%@include file="/navbar.jsp" %> 
<p align="center"><b><font size="4">&nbsp;</font><font face="Arial" size="3">Alert For Medical Examination
</font></b><% 
	
	String pname = "";
	String ename = "";
	String rel = "";
	String by = "";
	String srno ="";
	String sex="";
	String empn="";
	String no="";
%>	
<div align="center">
  <center>	<table border="1" width="72%">
  <tr>
    <td width="11%" align="center">E.Code</td>
    <td width="46%">Employee Name</td>
    <td width="8%" align="center">Age</td>
    <td width="5%" align="center">Sex</td>
  </tr>
<%				
Connection conn  = null;    
try {
conn = DBConnect.getConnection1();
	Statement stmt=conn.createStatement();
	stmt=conn.createStatement();
	ResultSet rs = stmt.executeQuery("SELECT m.ename, m.sex, m.empn, TRUNC(MONTHS_BETWEEN(SYSDATE, m.birthdate) / 12) AS age FROM personnel.employeemaster m WHERE m.oldnewdata = 'N' AND m.onpayroll = 'A'  AND NOT EXISTS ( SELECT 1  FROM hospital.medexam em WHERE em.empn = m.empn AND em.dated >= SYSDATE - 365 ) ORDER BY m.empn");
while(rs.next())
	{
	
	
	ename = rs.getString("ENAME");
	
	by = rs.getString("age");
	sex = rs.getString("sex");
	empn = rs.getString("empn");
	
%>	
<tr>
    <td width="11%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=empn%></span></font></td>
    <td width="46%"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=ename%></span></font></td>
    <td width="8%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=by%></span></font></td>
    <td width="5%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=sex%></span></font></td>
  </tr>

<%	


}
%>
</table>
  </center>
</div>
<%-- <%
ResultSet rs1 = stmt.executeQuery("select count(*) nopd from opd where opddate > sysdate-1");   
while(rs1.next())
	{
	no = rs1.getString("nopd");
	}
%>  --%>
<p>&nbsp;</p>
<p><font face="Arial" size="3">Note :Please intimate these employees</font></p>
<p> 
<%
	}

	

catch(SQLException e) {
out.println("SQLException : "+ e.getMessage() + "<BR>");
while((e = e.getNextException()) != null)
out.println(e.getMessage() + "<BR>");
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


