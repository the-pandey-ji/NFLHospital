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
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Medical Certificate</title>
<style type="text/css" media="print">
.printbutton 
    {
        visibility: hidden;
        display: none;
    }
</style>
</head>
<body>
<%
String pname = request.getParameter("pname");
	String relation = request.getParameter("relation");
	String empn = request.getParameter("empn");
	String desg = request.getParameter("desg");
	String dept = request.getParameter("dept");
	String disease = request.getParameter("disease");
	String days = request.getParameter("days");
	String father = request.getParameter("father");
	String fromdt = request.getParameter("fromdt");
	String todt = request.getParameter("todt");
	String fitdt = request.getParameter("fitdt");
	int srno = 0;
	String dt="";
			
   
		
    Connection conn  = null;    
    try 
        {
           conn = DBConnect.getConnection();
           Statement stmt=conn.createStatement();
             
           ResultSet rs = stmt.executeQuery("select max(srno)+1, to_char(sysdate,'dd-mm-yyyy') from medicalcrt");
	           while(rs.next())
	                {
	                     srno=rs.getInt(1);
	                     dt=rs.getString(2);
	                }
	          
	     //  ResultSet rs1 = stmt.executeQuery("insert into medicalcrt(srno,patientname,relation,fathername,empn,desg,dept,disease,sdate,edate,ldays,mdate,fit) values('"+srno+"','"+pname+"','"+relation+"','"+father+"','"+empn+"','"+desg+"','"+dept+"','"+disease+"','"+fromdt+"','"+todt+"','"+days+"',to_char(sysdate,'dd-mm-yyyy'),'"+fitdt+"')");
	   PreparedStatement ps = conn.prepareStatement(
  "INSERT INTO medicalcrt (srno, patientname, relation, fathername, empn, desg, dept, disease, sdate, edate, ldays, mdate, fit) " +
  "VALUES (?, ?, ?, ?, ?, ?, ?, ?, TO_DATE(?, 'DD-MM-YYYY'), TO_DATE(?, 'DD-MM-YYYY'), ?, SYSDATE, TO_DATE(?, 'DD-MM-YYYY'))");

ps.setInt(1, srno);
ps.setString(2, pname);
ps.setString(3, relation);
ps.setString(4, father);
ps.setString(5, empn);
ps.setString(6, desg);
ps.setString(7, dept);
ps.setString(8, disease);
ps.setString(9, fromdt);
ps.setString(10, todt);
ps.setString(11, days); // Use setInt if ldays is NUMBER
ps.setString(12, fitdt);

ps.executeUpdate();


		}
    catch (SQLException e) {
	while ((e = e.getNextException()) != null)
		out.println(e.getMessage() + "<BR>");
		}

		finally {
	if (conn != null) {
		try {
			conn.close();
		} catch (Exception ignored) {
		}
	}
		}
%>
<p>&nbsp;</p>
<p>&nbsp;</p>
<div align="center">
  <center>
  <table border="0" width="61%">
    <tr>
      <td width="100%" style="border-style: solid">
        <p align="center" style="margin-bottom: -10">
        <font size="5" face="Arial Black">NATIONAL FERTILIZERS LIMITED</font></p>
        <p align="center" style="margin-bottom: -12"><font face="Arial Black">PANIPAT UNIT </font></p>
        <p align="center" style="margin-bottom: -11"><b><font face="Arial">MEDICAL DEPARTMENT
        </font></b> </p>
        <p align="center"><b><font face="Arial">FITNESS CERTIFICATE</font></b></p>
      </td>
    </tr>
    <tr>
      <td width="100%" style="border-style: solid">
      <p><b>NFL/PNP/HOS/&nbsp;<%=srno%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date:<%=dt%></b></p>
      <p align="left" style="line-height: 150%; margin-top: 0; margin-bottom: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="4">&nbsp; 
      </font>
      </p>
      <p align="left" style="line-height: 150%; margin-top: 0; margin-bottom: 0"><font size="4">Certified that Mr./Mrs.&nbsp;<b><%= pname%></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <b><%=relation%></b> Sh&nbsp;<b><%= father%></b>&nbsp; E. Code No.&nbsp;<b><%= empn%></b>&nbsp;&nbsp;
      Designation&nbsp;<b><%= desg%></b>&nbsp;&nbsp;
      Deptt&nbsp;&nbsp;<b><%= dept%></b>&nbsp;&nbsp; was suffering from&nbsp;&nbsp;<b><%= disease%></b>.&nbsp; He/She was on medical leave for&nbsp;&nbsp;<b><%=days%></b>&nbsp;&nbsp;
      Days&nbsp; w.e.f.&nbsp;&nbsp;<b><%= fromdt%></b>
      to&nbsp;&nbsp;<b><%= todt%>.</b>&nbsp;&nbsp; </font>
      </p>
      <p align="left" style="line-height: 150%; margin-top: 0; margin-bottom: 0">&nbsp;</p>
      <p align="left" style="line-height: 150%; margin-top: 0; margin-bottom: 0"><font size="4">He/She is fit to resume duty w.e.f. 
     &nbsp;</font><b><font size="4"><%= fitdt%>.</font></b></p>
      <p align="left">&nbsp;</p>
      <p align="left"><b>&nbsp;Sign. of the Patient &nbsp;&nbsp;&nbsp;&nbsp;<align="left">&nbsp; Sign. of Auth. Medical Officer</b></p>
        <align="left">
        <p>&nbsp;</td>
    </tr>
  </table>
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