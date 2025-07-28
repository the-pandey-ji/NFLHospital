<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.* "%>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Registration for NFL Employee</title>
</head>

<body bgcolor="#CCFFCC">
 <p align="center"><b><span style="text-transform: uppercase"><font size="3">REGISTRATION FORM FOR NFL EMPLOYEES</font></span></b>
<form name="MyForm" method="POST" action="/hosp/HOSPITAL/New Registration/processnflreg.jsp">
  
  <div align="center">
    <center>
  <table border="0" width="77%">
    <tr>
      <td width="145%">NFL Employee Name</td>
      <td width="108%"><input type="text" name="name" size="35"></td>
    </tr>
    <tr>
      <td width="145%">Designation</td>
      <td width="97%"><input type="text" name="desg" size="35"></td>
    </tr>
    <tr>
      <td width="145%">Employee Number</td>
      <td width="97%"><input type="text" name="empn" size="35"></td>
    </tr>
    <tr>
      <td width="145%">Date of Birth (as 01-jan-1983)</td>
      <td width="97%"><input type="text" name="dob" size="35"></td>
    </tr>
    <tr>
      <td width="145%">Date Of Joining (as 01-jan-2008)</td>
      <td width="97%"><input type="text" name="doj" size="35"></td>
    </tr>
    <tr>
      <td width="145%">Department Number</td>
      <td width="97%"><input type="text" name="deptno" size="35"></td>
    </tr>
    <tr>
      <td width="145%">Sex</td>
      <td width="97%"><select size="1" name="sex">
          <option>M</option>
          <option>F</option>
        </select></td>
    </tr>
  </table>
    </center>
  </div>
  <p align="center">
<input type="button" value="Save" name="B1" onClick="checkForm();">
<input type="reset" value="Reset" name="B2"></p>
</form>
<SCRIPT LANGUAGE="JavaScript">
      <!--
        function checkForm()
            {
                  if(document.MyForm.T1.value == "")
                      {
                          alert("Please Enter Your Employee Name !!")
                          document.MyForm.T1.focus();
                      }  
                  else if(document.MyForm.T2.value == "")
                      {
                          alert("Please Enter Designation !!")
                          document.MyForm.T2.focus();
                      }
                  else if(document.MyForm.T3.value == "")
	                  {
	                      alert("Please Enter Your Employee Number !!")
	                      document.MyForm.T3.focus();
                      }
	              else if(document.MyForm.T4.value == "")
                      {
  	                      alert("Please Enter Date of Birth !!")
	                      document.MyForm.T4.focus();
                      }
                  else if(document.MyForm.T5.value == "")
                      {
  	                      alert("Please Enter Date of Joining !!")
	                      document.MyForm.T5.focus();
                      }
                  else if(document.MyForm.T6.value == "")
                      {
  	                      alert("Please Enter Department Number !!")
	                      document.MyForm.T6.focus();
                      }
                  else
                      {
                          document.MyForm.submit();
                      }
          }
	//-->
 </SCRIPT>
</body>
</html>