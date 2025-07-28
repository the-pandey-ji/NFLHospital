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
<title>Reference No</title>
<script language="JavaScript">
    <!-- // ignore if non-JS browser
          function validate() 
              {
                 if(MyForm.disease.value=="")
                    {
                         alert("Please Enter the Disease Name on OPD Slip\n"); 
                         event.returnValue=false;
                         MyForm.disease.focus();
                    }
                 else
                    {
                         event.returnValue=true;
                    } 
              }
   // -->
 </script>
</head>
<body background="../Stationery/Glacier%20Bkgrd.jpg">
 <form name="MyForm" method="POST" action="/hosp1/HOSPITAL/Localref/self/refdetaillocaldep.jsp" onsubmit="validate();" >
 <%
	String yr = request.getParameter("D1");
	String refno = request.getParameter("refno");
	String name ="";
	String sex ="";
	String relation ="";
	String age ="";
	String refdt ="";
	int empn =0;
	String empn1 ="";
	String dname ="";
    String code ="";
    String hcode ="";
    String hname ="";
    String disease ="";

    String dataSourceName = "hosp";
    String dbURL = "jdbc:odbc:"+ dataSourceName;
				
    Connection conn  = null;    
    try 
        {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           conn = DriverManager.getConnection(dbURL,"","");
           Statement stmt=conn.createStatement();
	         
           ResultSet rs = stmt.executeQuery("select a.patientname,a.empn,a.sex,a.rel,a.age,b.code,b.doctor_name,c.HCODE,c.HNAME, format(a.refdate,'dd-mm-yyyy'),a.disease from LOACALREFDETAIL"+yr+" A, DOCTOR B, LOCALHOSPITAL C WHERE a.DOC=b.CODE and a.SPECIALIST=c.HCODE and a.refno = "+refno);
             if (rs.next())
                {
                  while(rs.next())
	               {
	                   name = rs.getString("patientname");
	                   empn = rs.getInt("empn");
	                   sex = rs.getString("sex");
	                   relation = rs.getString("rel");
	                   age = rs.getString("age");
	                   code = rs.getString("code");
	                   dname = rs.getString("doctor_name");
	                   hcode = rs.getString("hcode");
                       hname = rs.getString("hname");
	                   refdt = rs.getString(10);
	                   disease = rs.getString(11);
	               }
	             }
	        else
	           {
	           }  
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

  <p align="center"><font face="Tahoma" size="4" color="#0000FF"><b><span style="text-transform: uppercase"><u>
  revisit For Local Reference</u></span></b></font></p>
  <p align="center">&nbsp;</p>
<div align="center">
  <center>
  <table border="0" width="44%" style="border-style: solid; border-width: 1">
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Reference No </b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="refno" value="<%= refno%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Patient Name </b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="name" value="<%= name%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Employee Code</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="empn" value="<%= empn%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Relation</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="relation" value="<%= relation%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Age</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="age" value="<%= age%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Date</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="refdt" value="<%= refdt%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Sex</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="sex" value="<%= sex%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Referred to&nbsp; </b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF">
      <b><select size="1" name="referto"><option value="<%=hcode%>"><%=hname%></option>
     </b></font></td>
    </tr>
    <tr>
      <td width="50%"><b><font face="Tahoma" size="2">Referred By </font></b></td>
      <td width="50%"><select size="1" name="referby">
     <option value="<%=code%>"><%=dname%></option>
  <%     
     Connection conn1  = null;    
       try 
         {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           conn1 = DriverManager.getConnection(dbURL,"","");
           Statement stmt1=conn1.createStatement();
  
             ResultSet rs2 = stmt1.executeQuery("select code, doctor_name from DOCTOR order by doctor_name");
               while(rs2.next())
                    {
  %>
                       <option value="<%=rs2.getInt(1)%>"><%=rs2.getString(2)%></option>
  <%
                    }
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
   </select>
   </td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Disease</b></font></td>
      <td width="50%"><input type="text" name="disease" value="<%=disease%>" size="20"></td>
    </tr>
  </table>
  </center>
  <input type="hidden" name="yr1" value="<%=yr%>">
</div>
<p align="center">
<input type="submit" value="Save" name="B1">
<input type="reset" value="Clear" name="B2"></p>
<hr width="80%">
<p align="center">&nbsp;</p>
  <p>&nbsp;</p>
</form>
</body>
</html>