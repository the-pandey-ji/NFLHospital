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
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Registration for Dependents</title>
</head>

<body bgcolor="#CCFFCC">

<p align="center"><b><font face="Arial" size="4">Registration for Dependents</font></b></p>

<form name="MyForm" method="POST" action="http://192.168.0.2:81/HOSPITAL/New Registration/processdepen.jsp">
  <div align="center">
    <center>
    <table border="0" width="68%">
      <tr>
        <td width="49%">Dependent Name</td>
        <td width="57%"><input type="text" name="T1" size="25"></td>
      </tr>
      <tr>
        <td width="49%">Relationship with Employee</td>
        <td width="57%"><select size="1" name="D1">
            <option value="Father">Father</option>
            <option value="Mother">Mother</option>
            <option value="Son">Son</option>
            <option value="Daughter">Daughter</option>
            <option value="Wife">Wife</option>
            <option value="Husband">Husband</option>
          </select></td>
      </tr>
      <tr>
        <td width="49%">Date Of Birth (as 01-jan-1983)</td>
        <td width="57%"><input type="text" name="T3" size="25"></td>
      </tr>
      <tr>
        <td width="49%">Employee Number</td>
        <td width="57%"><input type="text" name="T4" size="25"></td>
      </tr>
      <tr>
        <td width="49%">Sex</td>
        <td width="57%"><select size="1" name="D2">
            <option>M</option>
            <option>F</option>
          </select></td>
      </tr>
    </table>
    </center>
  </div>
  <p align="center"><input type="button" value="Save" name="B1" onClick="checkForm();"><input type="reset" value="Reset" name="B2"></p>
</form>

<SCRIPT LANGUAGE="JavaScript">
        <!--
        function checkForm()
        {
           if(document.MyForm.T1.value == "")
           {
             alert("Please Enter Your Dependent Name !!")
             document.MyForm.T1.focus();
           }  
           else if(document.MyForm.T3.value == "")
           {
             alert("Please Enter Date of Birth !!")
             document.MyForm.T3.focus();
           }
           else if(document.MyForm.T4.value == "")
           {
             alert("Please Enter Employee Number !!")
             document.MyForm.T4.focus();
           }
           else
           {
            document.MyForm.submit();
           }
        }

	//-->
</SCRIPT>


<p>&nbsp;</p>

</body>

</html>
