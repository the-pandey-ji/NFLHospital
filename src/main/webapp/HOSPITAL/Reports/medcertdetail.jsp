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
	String ldays = "";
	String rel = "";
	int srno =0;
	int empn=0;
	String no="";
	String mdate="";
%>	<table border="1" width="100%">
<p align="center"><b><font size="4">Medical Certificate Detail as on <%=dt%></font><font size="5"> </font></b>  
<tr>
    <td width="9%" align="center">Med. No.</td>
    <td width="23%">Patient Name</td>
    <td width="11%" align="center">E. Code&nbsp;</td>
    <td width="12%" align="center">Date</td>
    <td width="17%" align="center">Leave&nbsp; Days</td>
    <td width="18%" align="center">Relation</td>
  </tr>
<%				
   
				
    Connection conn  = null;    
    try 
        {
           conn = DBConnect.getConnection();
           Statement stmt=conn.createStatement();
           
	       ResultSet rs = stmt.executeQuery("select patientname,ldays,relation,empn,to_char(mdate,'dd-mm-yyyy'),srno FROM MEDICALCRT where to_char(mdate,'ddmmyyyy') ='"+dt+"'");
           while(rs.next())
	            {
	                pname = rs.getString(1);
	                ldays = rs.getString(2);
	                rel = rs.getString(3);
	                empn = rs.getInt(4);
	                mdate= rs.getString(5);
	                srno = rs.getInt(6);
%>	
<tr>
    <td width="9%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=srno%></span></font>&nbsp;</td>
    <td width="23%"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=pname%></span></font>&nbsp;</td>
    <td width="11%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=empn%></span></font>&nbsp;</td>
    <td width="12%" align="center"><%=mdate%>&nbsp;</td>
    <td width="17%" align="center"><%=ldays%>&nbsp;</td>
    <td width="18%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=rel%></span></font>&nbsp;</td>
  </tr>

<%	
                }
%>
</table>
<%
ResultSet rs1 = stmt.executeQuery("select count(*) from MEDICALCRT  where to_char(mdate,'ddmmyyyy') ='"+dt+"'");
while(rs1.next())
	{
	no = rs1.getString(1);
	}
%> 
<p>&nbsp;</p>
<p> 
  Total Number of MEDICAL CERTIFICATES on <%=dt%> : <%=no%>
<%
	}//end of try block
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