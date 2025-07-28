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
	String n1 = request.getParameter("D1");
	//String r1 = request.getParameter("T2");
	//String n2 = request.getParameter("T4");

	String en1 = session.getAttribute("nm").toString();
	int n2;
	n2 = Integer.parseInt(en1);
	String dname = "";
	String ename = "";
	String rel = "";
	String by = "";
	String srno ="";
	String sex="";
	String d="";
					
Connection conn  = null;    
try {
Class.forName("oracle.jdbc.driver.OracleDriver");
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.111.107:1521:orcl2","production","prod");
	Statement stmt=conn.createStatement();
	stmt=conn.createStatement();
	ResultSet rs = stmt.executeQuery("select initcap(dname) DNAME,sex,initcap(relation) RELATION,to_char(sysdate,'yyyy')-to_char(BIRTHYEAR,'yyyy') age FROM PRODUCTION.dependents where dname like '%"+n1+"%' and to_char(empn)="+en1);
while(rs.next())
	{
	
	dname = rs.getString("dname");
	rel = rs.getString("relation");
	by = rs.getString("age");
	sex = rs.getString("sex");
	}
ResultSet rs1 = stmt.executeQuery("select initcap(name) name FROM PRODUCTION.W_personal1 where to_char(empn)="+en1);
while(rs1.next())
	{
	
	ename = rs1.getString("name");
	}
	ResultSet rs2 = stmt.executeQuery("select to_char(sysdate,'DD.MM.YYYY:HH24:MI') sysd FROM dual");
	while(rs2.next())
	{
	
	d = rs2.getString("sysd");
	}

ResultSet rs3 = stmt.executeQuery("insert into production.opd(srno,patientname,empname,relation,age,opddate,sex,empn) values(patient_seq.NEXTVAL,'"+dname+"','"+ename+"','"+rel+"','"+by+"',sysdate,'"+sex+"','"+n2+"')");
	while(rs3.next())
	{
	
	// d = rs2.getString("sysd");
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
Connection conn1  = null;    
try {
Class.forName("oracle.jdbc.driver.OracleDriver");
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	conn1 =DriverManager.getConnection("jdbc:oracle:thin:@10.3.111.107:1521:orcl2","production","prod");
	Statement stmt=conn1.createStatement();
	stmt=conn1.createStatement();
	ResultSet rs5 = stmt.executeQuery("select srno,relation from production.opd where srno=(select max(srno) from production.opd)");
	while(rs5.next())
	{
	srno = rs5.getString("srno");
	//rel = rs5.getString("relation");
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
if(conn1 != null) {
try{
conn1.close();
}
catch (Exception ignored) {}
}
}
%>

<p style="margin-bottom: -13">&nbsp;</p>
<div align="center">
  <center>
  <table border="0" width="46%" height="55" style="border-style: solid; border-width: 1">
    <tr>
    <td width="92%" height="19" colspan="4" style="border-bottom-style: solid">
      <p align="center"><b><font size="3" color="#003300">NF L, Panipat Unit </font><font size="3">OPD
      SLIP</font></b></td>
     
    </tr>
    <tr>
    <td width="20%" height="1"><font size="1" face="Arial"><b>Sr. No.</b></font></td>
     
  	 <td width="40%" height="1"><font size="1" face="Arial"><%=srno%></font></td>
     
  	 <td width="19%" height="1"><font size="1" face="Arial"><b>Date</b></font></td>
     
  	 <td width="35%" height="1"><font size="1" face="Arial"><%=d%></font></td>
    </tr>
    <tr>
    <td width="20%" height="1"><b><font face="Arial" size="1">Name</font></b></td>
     
  </center>
     
  	 <td width="40%" height="1">
      <p align="left"><font size="1"><%=dname%></font></td>
     
  <center>
     
  	 <td width="19%" height="1"><b><font face="Arial" size="1">Relation</font></b></td>
     
  	 <td width="35%" height="1"><font size="1"><%=rel%></font></td>
    </tr>
     <tr>
  	 <td width="20%" height="1"><b><font face="Arial" size="1">E. Code</font></b></td>
  	 <td width="40%" height="1"><font size="1"><%=en1%></font></td>
  	 <td width="19%" height="1"><b><font face="Arial" size="1">E. Name</font></b></td>
  	 <td width="35%" height="1"><font size="1"><%=ename%></font></td>
    </tr>
     <tr>
  	 <td width="20%" height="1"><b><font face="Arial" size="1">Sex</font></b></td>
  	 <td width="40%" height="1"><font size="1"><%=sex%></font></td>
  	 <td width="19%" height="1"><b><font face="Arial" size="1">Age</font></b></td>
  	 <td width="35%" height="1"><font size="1"><%=by%></font></td>
   </tr>
     <tr>
  	 <td width="92%" height="11" colspan="4">
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;
      <p>&nbsp;
      <p>&nbsp;
      <p>&nbsp;</td>
    </tr>
	</table>
  </center>
</div>

<p align="center"><script>
document.write("<input type='button' " +
"onClick='window.print()' " +
"class='printbutton' " +
"value='Print This Page'/>");
</script>
</p>
</body>
</html>


