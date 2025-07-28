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
<title>Reports</title>
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
int refno=0;
String pname="";
int empn=0;
String relation="";
String age="";
String refdt="";
String sex="";
String disease="";
String doctor="";
String spc="";
String yr="";
String revisit="";

%>
<p align="center"><font color="#800000" size="3" face="Tahoma"><b>Details of Local References</b></font></p>
 <table border="1" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse" bordercolor="#111111" width="75%" height="38">
  <tr>
    <td width="5%" height="18" bgcolor="#FFCCCC"><b><font SIZE="2">REF.NO</font></b></td>
    <td width="15%" height="18" bgcolor="#FFCCCC"><b><font SIZE="2">PATIENTNAME</font></b></td>
    <td width="5%" height="18" bgcolor="#FFCCCC"><b><font SIZE="2">EMPN</font></b></td>
    <td width="10%" height="18" bgcolor="#FFCCCC"><b><font SIZE="2">RELATION</font></b></td>
    <td width="10%" height="18" bgcolor="#FFCCCC"><b><font SIZE="2">REF.DATE</font></b></td>
    <td width="14%" height="18" bgcolor="#FFCCCC"><b><font SIZE="2">DOCTOR</font></b></td>
    <td width="16%" height="18" bgcolor="#FFCCCC"><b><font SIZE="2">SPECIALIST</font></b></td>
    <td width="16%" height="18" bgcolor="#FFCCCC"><font size="2"><b>REFER / 
    REVISIT</b></font></td>
  </tr>
<%
    String dataSourceName = "hosp";
    String dbURL = "jdbc:odbc:"+ dataSourceName;
				
    Connection conn  = null;    
    try 
        {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           conn = DriverManager.getConnection(dbURL,"","");
           Statement stmt=conn.createStatement();
	       
	       ResultSet rsyr = stmt.executeQuery("select Format(Date(),'yyyy') from opd");
            while(rsyr.next())
	            {
	                yr = rsyr.getString(1);
                }
	       
	       ResultSet rs = stmt.executeQuery("select a.REFNO,a.PATIENTNAME,a.EMPN,a.REL,a.AGE,b.hname,Format(a.REFDATE,'dd-mm-yyyy'),SEX,DISEASE,c.doctor_name,Switch(a.revisitflag='N','Refer',a.revisitflag='Y','Revisit',a.revisitflag is null,'Refer') from LOACALREFDETAIL"+yr+" a, LOCALHOSPITAL b, DOCTOR c where a.specialist=b.hcode and a.doc=c.CODE and Format(refdate,'ddmmyyyy')='"+dt+"'");
            while(rs.next())
	         {
	         refno = rs.getInt(1);
	         pname = rs.getString(2);
	         empn = rs.getInt(3);
	         relation = rs.getString(4);
	         age = rs.getString(5);
	         spc= rs.getString(6);
	         refdt = rs.getString(7);
	         sex = rs.getString(8);
             disease = rs.getString(9);
	         doctor = rs.getString(10);
	         revisit= rs.getString(11); 
  %>
  <tr>
    <td width="5%" height="19"><%=refno%></td>
    <td width="15%" height="19"><%=pname%></td>
    <td width="5%" height="19"><%=empn%></td>
    <td width="10%" height="19"><%=relation%></td>
    <td width="10%" height="19"><%=refdt%></td>
    <td width="14%" height="19"><%=doctor%></td>
    <td width="16%" height="19"><%=spc%></td>
    <td width="16%" height="19"><%=revisit%></td>
   </tr>
<%
          }
%>
  </table>
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
          if(conn != null) 
            {
               try
                  {
                      conn.close();
                  }
               catch (Exception ignored) {}
            }
      }
 
	String special="";
	String nos="";
	String total="";
%>	
<p align="center">
<font color="#800000"><font size="3" face="Tahoma"><b>Referred&nbsp; Detail&nbsp;</b></font>
<div align="center">
  <center>	
  <table border="1" width="29%">
  <tr>
    <td width="23%" align="left" bgcolor="#FFCCCC"><font face="Tahoma"><b>Specialist</b></font></td>
    <td width="15%" align="center" bgcolor="#FFCCCC"><font face="Tahoma"><b>No of cases</b></font></td>
   </tr>
<%				
  Connection conn1 = null;    
   try 
      {
         Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
         conn1 = DriverManager.getConnection(dbURL,"","");
         Statement stmt=conn1.createStatement();
	     ResultSet rs = stmt.executeQuery("select b.hname, count(*) from LOACALREFDETAIL"+yr+" a, LOCALHOSPITAL b where a.SPECIALIST=b.hcode and Format(a.refdate,'ddmmyyyy')='"+dt+"' group by b.hname");
         while(rs.next())
	          {
		         special = rs.getString(1);
	             nos = rs.getString(2);
%>	
 <tr>
    <td width="23%" align="left"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=special%></span></font>&nbsp;</td>
    <td width="15%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=nos%></span></font>&nbsp;</td>
   </tr>
<%	
              }
                 ResultSet rs1 = stmt.executeQuery("select count(*) from LOACALREFDETAIL"+yr+" where Format(refdate,'ddmmyyyy')='"+dt+"'");
                 while(rs1.next())
	                  {
		                  total = rs1.getString(1);
	                  }
%>
<tr>
   
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
          if(conn1 != null) 
            {
               try
                  {
                      conn1.close();
                  }
               catch (Exception ignored) {}
            }
      }
%>
 <!--alert(<%=total%>,<%=special%>,<%=nos%>); -->

 <td width="23%" align="left"><font face="Tahoma" size="2"><span style="text-transform: uppercase">Total</span></font></td>
    <td width="15%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=total%></span></font>&nbsp;</td>
    </tr>
</table>
  </center>
</div>
<%  
String refno1="";
String pname1="";
int empn1=0;
String relation1="";
String age1="";
String refdt1="";
String escort1="";
String doctor1="";
String hospital1="";
String city1="";
String revisit1="";

%>
<p align="center"><b><font color="#800000" face="Tahoma" size="3">Out Station References</font></b></p>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="89%" height="37">
  <tr>
    <td width="5%" bgcolor="#FFCCCC" height="17"><font SIZE="2"><b>REFNO</b></font></td>
    <td width="18%" bgcolor="#FFCCCC" height="17"><font SIZE="2"><b>PATIENTNAME</b></font></td>
    <td width="5%" bgcolor="#FFCCCC" height="17"><font SIZE="2"><b>EMPN</b></font></td>
    <td width="10%" bgcolor="#FFCCCC" height="17"><font SIZE="2"><b>REL</b></font></td>
    <td width="5%" bgcolor="#FFCCCC" height="17"><font SIZE="2"><b>AGE</b></font></td>
    <td width="10%" bgcolor="#FFCCCC" height="17"><font SIZE="2"><b>REFDATE</b></font></td>
    <td width="14%" bgcolor="#FFCCCC" height="17"><font SIZE="2"><b>HOSPITAL</b></font></td>
    <td width="16%" bgcolor="#FFCCCC" height="17"><font SIZE="2"><b>DOC</b></font></td>
    <td width="8%" bgcolor="#FFCCCC" height="17"><font SIZE="2"><b>ESCORT</b></font></td>
    <td width="22%" bgcolor="#FFCCCC" height="17"><font size="2"><b>REFER / 
    REVISIT</b></font></td>
  </tr>
 <%
  Connection conn2 = null;    
    try 
       {
          Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
          conn2 = DriverManager.getConnection(dbURL,"","");
          Statement stmt=conn2.createStatement();
          ResultSet rs = stmt.executeQuery("select a.REFNO, a.PATIENTNAME, a.EMPN, a.REL, a.AGE, Format(a.REFDATE,'dd-mm-yyyy'), b.hname, b.city, c.DOCTOR_NAME, a.ESCORT,Switch(a.revisitflag='N','Refer',a.revisitflag='Y','Revisit',a.revisitflag is null,'Refer') from OUTREFDETAIL"+yr+" a,OUTSTATIONHOSPITAL b,DOCTOR c where a.hospital=b.HCODE and a.doc=c.code and Format(refdate,'ddmmyyyy')='"+dt+"'");
    
          while(rs.next())
	         {
                refno1 = rs.getString(1);
                pname1 = rs.getString(2);
                empn1 = rs.getInt(3);
                relation1= rs.getString(4);
                age1 = rs.getString(5);
                refdt1= rs.getString(6);
                hospital1= rs.getString(7);
                city1= rs.getString(8);
                doctor1= rs.getString(9);
                escort1= rs.getString(10);
                revisit1= rs.getString(11);
  %>	 
  <tr>
    <td width="5%" height="19"><%=refno1%>&nbsp;</td>
    <td width="18%" height="19"><%=pname1%>&nbsp;</td>
    <td width="5%" height="19"><%=empn1%>&nbsp;</td>
    <td width="10%" height="19"><%=relation1%>&nbsp;</td>
    <td width="5%" height="19"><%=age1%>&nbsp;</td>
    <td width="10%" height="19"><%=refdt1%>&nbsp;</td>
    <td width="14%" height="19"><%=hospital1%>&nbsp;</td>
    <td width="16%" height="19"><%=doctor1%>&nbsp;</td>
    <td width="8%" height="19"><%=escort1%>&nbsp;</td>
    <td width="22%" height="19"><%=revisit1%></td>
  </tr>
 <%	
            }
 %>
 </table>
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
          if(conn != null) 
            {
               try
                  {
                      conn.close();
                  }
               catch (Exception ignored) {}
            }
      }
%>
</body>
</html>