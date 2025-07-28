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
<p align="center">
<% 
	
	String pname = "";
	String ename = "";
	String rel = "";
	String by = "";
	String srno ="";
	String sex="";
	String empn="";
	String no="";
%>	
<%
Connection conn  = null;    
try {
Class.forName("oracle.jdbc.driver.OracleDriver");
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.111.107:1521:orcl2","production","prod");
	Statement stmt=conn.createStatement();
	stmt=conn.createStatement();
ResultSet rs1 = stmt.executeQuery("select count(*) nopd from production.opd where opddate > sysdate-1");
while(rs1.next())
	{
	no = rs1.getString("nopd");
	}
%> 
<p>&nbsp;</p>
<p> 
  &nbsp;


  
</p>


  
<p> 
  &nbsp;


  
</p>


  
<div align="center">
  <center>
  <table border="1" width="59%">
    <tr>
      <td width="50%">Specialist </td>
      <td width="50%">Number of cases</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">ORTHOPEDICS</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">ENT</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">PHYSICIAN</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">SURGEON</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">NEURO-PHYSICIAN</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">DENTIST</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">EYE-SPECIALIST</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">CHILD-SPECIALIST</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">GYNAECOLOGIST</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">SKIN-SPECIALIST</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">PSYCHIATRIST</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">AYURVEDIC</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">HOMEOPATHY</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%"><font SIZE="1">PATHOLOGIST</font></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%">Total</td>
      <td width="50%">&nbsp;</td>
    </tr>
  </table>
  </center>
</div>
<p align="center"> 
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


