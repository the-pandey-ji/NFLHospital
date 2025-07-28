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
<title>Provident Fund</title>
</head>
<% String en1 = request.getParameter("en"); 
	String name ="";
	String desg ="";
	String owncont ="";
	String opt ="";
	String cocont ="";
	String refad ="";
	String nrefad ="";
	String loanrp =""; 
	String balp ="";
	String asondate="";
Connection conn  = null;    
try {
Class.forName("oracle.jdbc.driver.OracleDriver");
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.111.107:1521:orcl2","production","prod");
	Statement stmt=conn.createStatement();
	stmt=conn.createStatement();
              ResultSet rs = stmt.executeQuery("select l.name,l.designation,p.own_contribution,p.as_on_date, p.optional_pf,p.co_contribution,p.co_contribution,p.refundable_advance,p.non_refundable_advance,p.loan_repaid,p.balance_pf  from leaves l,providentfund p where l.empn = p.empn and p.empn = " + en1);
while(rs.next())
	{
	name = rs.getString("name");
	desg = rs.getString("designation");
	owncont = rs.getString("own_contribution");
	opt = rs.getString("optional_pf");
	cocont = rs.getString("co_contribution");
	refad= rs.getString("refundable_advance");
	nrefad = rs.getString("non_refundable_advance");
	loanrp = rs.getString("loan_repaid");
	balp = rs.getString("balance_pf");
	asondate = rs.getString("as_on_date");
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

<body background="../Stationery/Glacier%20Bkgrd.jpg">

<div align="center">
 <center>
  <table border="0" width="72%" height="83" cellspacing="1">
    <tr>
      <td width="19%" background="../logo/NFL%20logorajinder'spc.gif" height="79">
        <p style="margin-bottom: -30">&nbsp;</p>
      </td>
      <td width="81%" height="79">
        <p align="center" style="line-height: 100%; margin-top: -5; margin-bottom: -5"><img border="0" src="../logo/fin.gif" width="400" height="35"></p>
        <p align="center" style="line-height: 100%; margin-bottom: -10"><span style="letter-spacing: 1pt"><font face="Times New Roman" color="#008000" size="5"><sup><b>National
        Fertilizers Limited, Panipat Unit</b></sup></font></span></p>
      </td>
    </tr>
  </table>
  </center>
</div>
<blockquote>
  <p align="left" style="margin-top: -25"><b><font color="#800000" size="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></b>
  </p>
  <hr width="80%" size="5" color="#003300">
  <p align="center" style="margin-top: 5"><b><font color="#800000" size="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <u>Details of Provident Fund As On  <%= asondate %></u></font></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </p>
</blockquote>
<div align="center">
  <center>
  <table border="0" width="475" height="8">
    <tr>
      <td width="59" height="2"><font color="#000000">&nbsp; <font size="4"><b>Name
        </b></font></font></td>
      <td width="189" height="2"><%= name %></td>
      <td width="99" height="2"><font color="#000000" size="4"><b>Designation </b></font></td>
      <td width="100" height="2"><%= desg %></td>
    </tr>
  </table>
  </center>
</div>
<p style="margin-top: -5; margin-bottom: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color="#000000"><font size="4"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</b></font></font><font color="#000000" size="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</font></p>
<div align="center">
  <center>
  <table border="1" width="358" height="159">
    <tr>
      <td width="198" height="19"><font size="4" color="#003300">Own Contribution </font></td>
      <td width="144" height="19"><%= owncont%></td>
    </tr>
    <tr>
      <td width="198" height="19"><font color="#003300"><font size="4">Optional PF </font></font></td>
      <td width="144" height="19"><%= opt %></td>
    </tr>
    <tr>
      <td width="198" height="19"><font size="4" color="#003300">Co's Contribution </font></td>
      <td width="144" height="19"><%= cocont %></td>
    </tr>
    <tr>
      <td width="198" height="19"><font size="4" color="#003300">Refundable Advance</font></td>
      <td width="144" height="19"><%= refad %></td>
    </tr>
    <tr>
      <td width="198" height="19"><font size="4" color="#003300">Non Refundable Advance</font></td>
      <td width="144" height="19"><%= nrefad %></td>
    </tr>
    <tr>
      <td width="198" height="28"><font color="#003300"><font size="4">Loan Repaid
        &nbsp;</font></font></td>
      <td width="144" height="28"><%= loanrp %></td>
    </tr>
    <tr>
      <td width="198" height="29"><font size="4" color="#003300">Balance PF </font></td>
      <td width="144" height="29"><%= balp %></td>
    </tr>
  </table>
  </center>
</div>

<p align="center"><a href="pfentryform.htm" target="_top"><img border="0" src="../logo/back.JPG" width="76" height="18"></a><a href="../index.htm" target="_top"><img border="0" src="../logo/homepageyellow.jpg" width="76" height="18"></a></p>

</body>

</html>
