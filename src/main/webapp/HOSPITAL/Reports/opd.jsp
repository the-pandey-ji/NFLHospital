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
<title>Daily OPD List</title>
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
	String dt = request.getParameter("dt");
	String pname = "";
	String ename = "";
	String relation = "";
	String age = "";
	String srno ="";
	String sex="";
	long empn=0;
	int no=0;
	String typ="";
	String doc="";
%>	
<table border="1" width="88%">
   <p align="center"><b><font size="4">OPD Detail On <%=dt%></font>
   <font size="5"> </font></b>  
 <tr>
    <td width="11%" align="center">OPD No</td>
    <td width="20%">Patient Name</td>
    <td width="20%">Employee Name</td>
    <td width="13%" align="center">E.Code&nbsp;</td>
    <td width="15%" align="center">Relation</td>
    <td width="5%" align="center">Age</td>
    <td width="5%" align="center">Sex</td>
     <td width="20%" align="center">doc</td>
  </tr>
<%				
   
				
    Connection con  = null,con1=null;    
    try 
        {
    	con = DBConnect.getConnection();
    	con1= DBConnect.getConnection1();
           Statement stmt=con.createStatement();
           Statement stmt1=con1.createStatement();

           
	         ResultSet rs = stmt.executeQuery("select patientname,relation,age,sex,empn,srno,typ,empname,doctor FROM opd where to_char(opddate,'ddmmyyyy') ='"+dt+"' order by srno");
              while(rs.next())
	              {
	                    pname = rs.getString(1);
	                    relation = rs.getString(2);
	                    age = rs.getString(3);
	                    sex = rs.getString(4);
	                    empn = rs.getLong(5);
	                    srno = rs.getString(6);
	                    typ = rs.getString(7);
                        ename = rs.getString(8);
                        doc = rs.getString(9);
	                    
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
    <td width="20%"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=pname%></span></font>&nbsp;</td>
    <td width="20%"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=ename%></span></font>&nbsp;</td>
    <td width="13%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=empn%></span></font>&nbsp;</td>
    <td width="15%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=relation%></span></font>&nbsp;</td>
    <td width="5%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=age%></span></font>&nbsp;</td>
    <td width="5%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=sex%></span></font>&nbsp;</td>
    <td width="20%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=doc%></span></font>&nbsp;</td>
  </tr>
<%	                                 
                 } 
%>
</table>
<%
        
         
          ResultSet rs1 = stmt.executeQuery("select count(*) from opd where to_char(opddate,'ddmmyyyy') ='"+dt+"'");
             while(rs1.next())
	             {
	                no = rs1.getInt(1);
	             }
%> 
<p> 
  Total Number OPD on <%=dt%> : <%=no%>
 </p>

<%
	  }
catch(SQLException e) 
   {
       while((e = e.getNextException()) != null)
       out.println(e.getMessage() + "<BR>");
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
</body>
</html>