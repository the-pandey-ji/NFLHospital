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
<title>Reference No</title>
<script language="JavaScript">
    <!-- // ignore if non-JS browser
          function validate() 
              {
                 
              }
   // -->
 </script>
</head>
<body background="../Stationery/Glacier%20Bkgrd.jpg">
<%@ include file="/navbar.jsp" %>
 <form name="MyForm">
 <p align="center"><font face="Tahoma" size="4" color="#0000FF"><b><span style="text-transform: uppercase"><u>Local Reference HISTORY</u></span></b></font></p>
  <div align="center">
    <center>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="81%">
    <tr>
      <td width="5%"><font face="Arial Narrow"><b>Ref.No.</b></font></td>
      <td width="11%"><font face="Arial Narrow"><b>Ref. Date</b></font></td>
      <td width="6%"><font face="Arial Narrow"><b>Empn</b></font></td>
      <td width="16%"><font face="Arial Narrow"><b>Patient Name</b></font></td>
      <td width="10%"><font face="Arial Narrow"><b>Relation</b></font></td>
      <td width="20%"><font face="Arial Narrow"><b>Referred To</b></font></td>
      <td width="19%"><font face="Arial Narrow"><b>Referred By</b></font></td>
      <td width="13%"><b><font face="Arial Narrow">Refer Type</font></b></td>
    </tr>
 <%
	String yr = request.getParameter("D1");
	String empn1 = request.getParameter("empn");
	long empn =Long.parseLong(empn1);
	String name ="";
	String sex ="";
	String relation ="";
	String age ="";
	String refdt ="";
	String reftype ="";
	String refby ="";
    String refto ="";
    String empname ="";
    int refno =0;
    
    //out.println(empn);
    
    Connection conn  = null; 

    try 
        {
    	conn = DBConnect.getConnection();
    	
           Statement stmt=conn.createStatement();
        
               ResultSet rs = stmt.executeQuery("SELECT  a.patientname, a.empn,  a.rel, TO_CHAR(a.refdate, 'dd-mm-yyyy') AS ref_date, a.refno,  a.doc,  c.hname,  CASE  WHEN a.revisitflag = 'N' THEN 'Refer' WHEN a.revisitflag = 'Y' THEN 'Revisit' WHEN a.revisitflag IS NULL THEN 'Refer' ELSE 'Unknown'  END AS visit_type FROM  LOACALREFDETAIL"+yr+" a JOIN localhospital c ON a.specialist = c.hcode WHERE  a.empn = "+empn+" AND a.refdate > ADD_MONTHS(SYSDATE, -6) ORDER BY  a.refdate DESC");
                 while(rs.next())
	               {
	                   name = rs.getString("patientname");
	                   empn = rs.getInt("empn");
	                   relation = rs.getString(3);
	                   refdt = rs.getString(4);
	                   refno = rs.getInt(5);
                       refby = rs.getString(6);
	                   refto = rs.getString(7);
	                   reftype = rs.getString(8);
%>
    
    <tr>
      <td width="5%"><%=refno%>&nbsp;</td>
      <td width="11%"><%=refdt%>&nbsp;</td>
      <td width="6%"><%=empn %>&nbsp;</td>
      <td width="16%"><%=name%>&nbsp;</td>
      <td width="10%"><%=relation%>&nbsp;</td>
      <td width="20%"><%=refto%>&nbsp;</td>
      <td width="19%"><%=refby%>&nbsp;</td>
      <td width="13%"><%=reftype%>&nbsp;</td>
    </tr>
 <%
   
    } //end of if loop
      } //end of try loop
     catch(SQLException e) 
        {
             while((e = e.getNextException()) != null)
             out.println(e.getMessage() + "<BR>");
        }
   
     finally
        {
             if(conn != null) 
               {
                   try
                        {
                             conn.close();
                        }
                   catch (Exception ignored) {}
               }
        }
       //out.print("result is: "+ename); 
%>

 </table>
    </center>
 </div>
<p align="center">&nbsp;</p>
<hr width="80%">
<p align="center">&nbsp;</p>
  <p>&nbsp;</p>
</form>
</body>
</html>