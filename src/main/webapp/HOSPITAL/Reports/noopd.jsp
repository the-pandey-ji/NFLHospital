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
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>No Of OPD</title>
<title>Print Test</title>
<style type="text/css" media="print">
.printbutton 
   {
       visibility: hidden;
       display: none;
   }
</style>
</head>
<body>
<p align="center"><b><font size="4">Today's OPD Detail</font><font size="5"> </font></b>
<% 
	String pname = "";
	String ename = "";
	String relation = "";
	String age = "";
	int srno =0;
	String sex="";
	long empn=0;
	String no="";
	String typ="";
%>	<table border="1" width="100%">
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
    String dataSourceName = "hosp";
    String dbURL = "jdbc:odbc:"+ dataSourceName;
				
    Connection con  = null;    
    try 
        {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           con = DriverManager.getConnection(dbURL,"","");
           Statement stmt=con.createStatement();
           Statement stmt1=con.createStatement();
           
	       ResultSet rs = stmt.executeQuery("select srno,patientname,relation,age,empn,sex,empname,typ FROM opd where Format(opddate,'dd-mm-yyyy') = Format(date(),'dd-mm-yyyy') order by srno");
            while(rs.next())
	          {
	             
	              srno = rs.getInt(1);
	              pname = rs.getString(2);
	              relation = rs.getString(3);
	              age = rs.getString(4);
	              empn = rs.getLong(5);
	              sex = rs.getString(6);
	              ename = rs.getString(7);
	              typ=rs.getString(8);
	             
	              if (typ.equals("N")) 
	                          {
	                             ResultSet rs2 = stmt1.executeQuery("select ename from employeemaster where empn="+empn);
	                              while(rs2.next())
	                                 {
                                        ename=rs2.getString("ename");
                                     } 
                              }
%>	
   <tr>
    <td width="11%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=srno%></span></font>&nbsp;</td>
    <td width="27%"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=pname%></span></font>&nbsp;</td>
    <td width="47%"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=ename%></span></font>&nbsp;</td>
    <td width="9%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=empn%></span></font>&nbsp;</td>
    <td width="10%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=relation%></span></font>&nbsp;</td>
    <td width="6%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=age%></span></font>&nbsp;</td>
    <td width="5%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=sex%></span></font>&nbsp;</td>
  </tr>

<%	
             }
%>
</table>
<%
      ResultSet rs1 = stmt.executeQuery("select count(*) from opd where Format(opddate,'dd-mm-yyyy') = Format(date(),'dd-mm-yyyy')");
        while(rs1.next())
	      {
	          no = rs1.getString(1);
	      }
%> 
<p>&nbsp;</p>
<p> 
  Total Number Of Today's OPD : <%=no%>
<%
	}
catch(SQLException e) 
   {
       while((e = e.getNextException()) != null)
       out.println(e.getMessage() + "<BR>");
   }
 catch(ClassNotFoundException e) 
      {
          out.println("ClassNotFoundexception :" + e.getMessage() + "<BR>");
      }
 finally
      {
          if(con != null) 
            {
               try
                  {
                      con.close();
                  }
               catch (Exception ignored) {}
            }
      }
%>
</p>
</body>
</html>