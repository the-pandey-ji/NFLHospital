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
 <form name="MyForm" method="POST" action="/hosp1/HOSPITAL/Localrefoth/refdetaillocalself.jsp" onsubmit="validate();">
<%
	String refno = request.getParameter("refno");
	String name ="";
	String sex ="";
	String relation ="";
	String age ="";
	String refdt ="";
	int empn =0;
	String yr ="";
	
    String dataSourceName = "hosp";
    String dbURL = "jdbc:odbc:"+ dataSourceName;
				
    Connection conn  = null;    
    try 
        {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           conn = DriverManager.getConnection(dbURL,"","");
           Statement stmt=conn.createStatement();

           ResultSet rsyr = stmt.executeQuery("select format(Now(),'yyyy') from opd");
              while(rsyr.next())
	               {
	                 yr = rsyr.getString(1);
	               }
	               
            ResultSet rsref = stmt.executeQuery("select srno from opd where srno = "+refno);
              if(rsref.next())
	            {

                  ResultSet rsdetail = stmt.executeQuery("select patientname,empn,sex,relation,age,format(opddate,'dd-mmm-yyyy') from opd where srno = "+refno);
                   while(rsdetail.next())
	                 {
	                    name = rsdetail.getString("patientname");
	                    empn = rsdetail.getInt("empn");
	                    sex = rsdetail.getString("sex");
	                    relation = rsdetail.getString("relation");
	                    age = rsdetail.getString("age");
	                    refdt = rsdetail.getString(6);
	                 }
       
%>

  <p align="center"><font face="Tahoma" size="4" color="#0000FF"><b><span style="text-transform: uppercase"><u>Entry
  For Local Reference</u></span></b></font></p>
  <p align="center">&nbsp;</p>
<div align="center">
  <center>
  <table border="0" width="59%" style="border-style: solid; border-width: 1">
    <tr>
      <td width="61%"><font face="Tahoma" size="2"><b>Reference No </b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="refno" value="<%= refno%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="61%"><font face="Tahoma" size="2"><b>Patient Name </b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="name" value="<%= name%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="61%"><font face="Tahoma" size="2"><b>Employee Code</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="empn" value="<%= empn%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="61%"><font face="Tahoma" size="2"><b>Relation</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="relation" value="<%= relation%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="61%"><font face="Tahoma" size="2"><b>Age</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="age" value="<%= age%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="61%"><font face="Tahoma" size="2"><b>Date</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="refdt" value="<%= refdt%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="61%"><font face="Tahoma" size="2"><b>Sex</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="sex" value="<%= sex%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="61%"><font face="Tahoma" size="2"><b>Referred to&nbsp; </b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF">
     <b><select size="1" name="referto">
      <option value="">--Select--</option>
  <%       
              ResultSet rshosp = stmt.executeQuery("select hcode, hname from LOCALHOSPITAL order by hcode");
               while(rshosp.next())
               {
  %>
                     <option value="<%=rshosp.getString(1)%>"><%=rshosp.getString(2)%></option>
  <%
               }
  %>  
  
  </select>
    </b></font>
    </td>
    </tr>
    <tr>
      <td width="61%"><b><font face="Tahoma" size="2">Refered By </font></b></td>
      <td width="50%"><select size="1" name="referby">
        <option value="">--Select--</option>
  <%       
             ResultSet rsdoctor = stmt.executeQuery("select code, doctor_name from DOCTOR order by doctor_name");
               while(rsdoctor.next())
                    {
  %>
                       <option value="<%=rsdoctor.getInt(1)%>"><%=rsdoctor.getString(2)%></option>
  <%
                    }
  

  %>  
        </select>
        </td>
    </tr>
    <tr>
      <td width="61%"><font face="Tahoma" size="2"><b>Disease</b></font>
      </td>
      <td width="50%"><input type="text" name="disease" size="21">
      </td>
    </tr>
  </table>
  </center>
</div>
<p align="center"><input type="submit" value="Save" name="B1">
<input type="reset" value="Clear" name="B2"></p>
<hr width="80%">
<p align="center">&nbsp;</p>
  <p>&nbsp;</p>
<%
 } //end of If loop
          else
            {
               out.print("Invalid Reference No."); 
            }
            
    } //end of conn
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
</form>
</body>
</html>