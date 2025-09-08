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
 <%@ include file="/navbar.jsp" %>
 
 <%
  String yr = request.getParameter("D1");
  	String refno = request.getParameter("refno");
  	String name ="";
  	String sex ="";
  	String relation ="";
  	String age ="";
  	String refdt ="";
  	String refdt1 ="";
  	int empn =0;
  	String empn1 ="";
  	String dname ="";
      String code ="";
      String hcode ="";
      String hname ="";
      String disease ="",empname="",typ="";

      
      Connection conn  = null; 

      try 
          {
      	conn = DBConnect.getConnection();
      	
      	Statement stmt1 = conn.createStatement();

      	ResultSet rsdetail = stmt1.executeQuery("select typ,empname from opd where srno = " + refno);
  		if (rsdetail.next()) {
  
  	typ = rsdetail.getString("typ");
  	empname = rsdetail.getString("empname");
  

  
  		}
  		
  		if(typ.equals("C"))
  		 typ="CISF";
  		else
  			typ="Other";
  		

  		Statement stmt = conn.createStatement();

  		ResultSet rs = stmt.executeQuery(
  		"select a.patientname,a.empn,a.sex,a.rel,a.age,a.doc,c.HCODE,c.HNAME, to_char(a.refdate,'dd-mm-yyyy'),to_char(sysdate,'dd-mm-yyyy'),a.disease from LOACALREFDETAIL"
  				+ yr + " A, LOCALHOSPITAL C WHERE a.SPECIALIST=c.HCODE and a.refno = " + refno + "");
  		if (rs.next()) {
  	name = rs.getString("patientname");

  	empn = rs.getInt("empn");

  	sex = rs.getString("sex");

  	relation = rs.getString("rel");

  	age = rs.getString("age");

  	dname = rs.getString("doc");

  	hcode = rs.getString("hcode");

  	hname = rs.getString("hname");

  	refdt = rs.getString(9);

  	refdt1 = rs.getString(10);

  	disease = rs.getString(11);
  %>
<form name="MyForm" method="POST" action="/hosp1/HOSPITAL/Localrefoth/refdetaillocal2other2revisit.jsp" onsubmit="validate();" >
  <p align="center"><font face="Tahoma" size="4" color="#0000FF"><b><span style="text-transform: uppercase"><u>
  revisit For Local Reference</u></span></b></font></p>
  <p align="center">&nbsp;</p>
<div align="center">
  <center>
  <table border="0" width="44%" style="border-style: solid; border-width: 1">
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Reference No </b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="refno" readonly value="<%= refno%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Patient Name </b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="name" readonly  value="<%= name%>" size="21"></b></font></td>
    </tr>
    
	<tr>
	   <td width="50%"><font face="Tahoma" size="2"><b>Employee Name </b></font></td>
		<td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="empname" readonly value="<%=empname%>" size="21"></b></font></td>
		</tr>
	<tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Employee Code</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="empn" readonly  value="<%= empn%>" size="21"></b></font></td>
    </tr>
    <tr>
	   <td width="50%"><font face="Tahoma" size="2"><b>Employee Category </b></font></td>
		<td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="typ" readonly value="<%=typ%>" size="21"></b></font></td>
	<tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Relation</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="relation" readonly value="<%= relation%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Age</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="age" readonly value="<%= age%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Date</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="refdt" readonly  value="<%= refdt%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Sex</b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="sex" readonly  value="<%= sex%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Referred to&nbsp; </b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF">
       <input type="text" name="referto" readonly value="<%= hname %>" size="21">
     </b></font></td>
    </tr>
    
    
    
   <tr>
                <td width="50%"><font face="Tahoma" size="2"><b>Refered By</b></font></td>
                <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b>
                    <input type="text" name="referby"  readonly  value="<%=user1.getUsername()  %>" size="21"></b></font></td>
            </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Disease</b></font></td>
      <td width="50%"><input type="text" name="disease" readonly value="<%=disease%>" size="20"></td>
    </tr>
  </table>
  </center>
  <input type="hidden" name="yr1" value="<%=yr%>">
  
  <input type="hidden" name="refdate1" value="<%=refdt1%>">
  
  <input type="hidden" name="hcode" value="<%=hcode%>">

</div>
<p align="center">
<input type="submit" value="Save" name="B1">
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