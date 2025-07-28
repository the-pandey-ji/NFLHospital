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
<title>Reference No</title>
</head>
<body background="../Stationery/Glacier%20Bkgrd.jpg">
<%
	String rn = request.getParameter("T2");
	String name = request.getParameter("T3");
	String empn = request.getParameter("T4");
	String rel = request.getParameter("T5");
	String age = request.getParameter("T6");
	String refd = request.getParameter("T7");
	String sex = request.getParameter("T8");
	String dis = request.getParameter("D1");
	String doc = request.getParameter("D2");
	
Connection conn  = null;    
try 
{
Class.forName("oracle.jdbc.driver.OracleDriver");
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.126.84:1521:ORCL","production","prod");
	Statement stmt=conn.createStatement();
	stmt=conn.createStatement();
        ResultSet rs = stmt.executeQuery("insert into production.opd(srno,patientname,empname,relation,age,opddate,sex,empn) values(patient_seq.NEXTVAL,'"+name+"','"+name+"','"+rel+"','"+age+"',sysdate,'"+sex+"','"+empn+"')");
	while(rs.next())
	{
	
	// d = rs.getString("sysd");
	}
	
        %>
        <form method="POST" action="http://10.3.122.104:81/HOSPITAL/references.jsp">
<%
while(rs.next())
	{
	name = rs.getString("patientname");
	empn = rs.getString("empn");
	sex = rs.getString("sex");
	rel = rs.getString("relation");
	age = rs.getString("age");
	refd = rs.getString("opddate");
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
  <p align="center"><font face="Tahoma" size="4" color="#0000FF"><b><span style="text-transform: uppercase"><u>Entry
  For Local Reference</u></span></b></font></p>
  <p align="center">&nbsp;</p>
<div align="center">
  <center>
  <table border="0" width="44%" style="border-style: solid; border-width: 1">
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Reference No </b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="T2" value="<%= rn%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Patient Name </b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="T3" value="<%= name%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Employee Code</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="T4" value="<%= empn%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Relation</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="" value="<%= rel%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Age</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="T5" value="<%= age%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Date</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="T6" value="<%= refd%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Sex</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="T7" value="<%= sex%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Referred to&nbsp; </b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><select size="1" name="D1">
  <option>ORTHOPADICS</option>
  <option>ENT</option>
  </select>
        </b></font></td>
    </tr>
    <tr>
      <td width="50%"><b><font face="Tahoma" size="2">Refered By </font></b></td>
      <td width="50%"><select size="1" name="D2">
          <option>Dr. Naveen Mehrotra</option>
          <option>Dr.Dinesh Lal</option>
          <option>Dr. Rajeev Hajelay</option>
        </select></td>
    </tr>
  </table>
  </center>
</div>
<p align="center"><input type="submit" value="Save" name="B1"><input type="reset" value="Clear" name="B2"></p>
<hr width="80%">
<p align="center">&nbsp;</p>
  <p>&nbsp;</p>
</form>
</body>

</html>
