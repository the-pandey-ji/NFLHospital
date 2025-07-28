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
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Registration for CISF Employee</title>
</head>

<body bgcolor="#CCFFCC">

<p align="center"><font face="Arial" size="4">OPD Form For CISF/KV/Others Employee</font></p>
<form name="MyForm" method="POST" action="http://127.0.0.1:81/HOSPITAL/New Registration/opdothers.jsp" >
 
  <div align="center">
    <center>
    <table border="0" width="44%">
      <tr>
        <td width="65%" align="left">Patient Name</td>
        <td width="154%" align="left"><input type="text" name="T1" size="29"></td>
      </tr>
      <tr>
        <td width="65%" align="left">Employee Name</td>
        <td width="154%" align="left"><input type="text" name="T2" size="29"></td>
      </tr>
      <tr>
        <td width="65%" align="left">Relation</td>
        <td width="154%" align="left"><select size="1" name="D2">
            <option>Father</option>
            <option>Mother</option>
            <option>Son</option>
            <option>Daughter</option>
            <option>Wife</option>
            <option>Husband</option>
          </select></td>
      </tr>
      <tr>
        <td width="65%" align="left">Age </td>
        <td width="154%" align="left"><input type="text" name="T3" size="29"></td>
      </tr>
      <tr>
        <td width="65%" align="left">Employee Number</td>
        <td width="154%" align="left"><input type="text" name="T5" size="29"></td>
      </tr>
      <tr>
        <td width="65%" align="left">
          <p align="left">Sex</td>
        <td width="154%" align="left"><select size="1" name="D1">
            <option>M</option>
            <option>F</option>
          </select></td>
      </tr>
    </table>
    </center>
  </div>
  <p align="center"><input type="button" value="Save" name="B1" onClick="checkForm();"><input type="reset" value="Reset" name="B2"></p>
</form>

</body>


<SCRIPT LANGUAGE="JavaScript">
        <!--
        function checkForm()
        {
           if(document.MyForm.T1.value == "")
           {
             alert("Please Enter Your Patient Name !!")
             document.MyForm.T1.focus();
           }  
           else if(document.MyForm.T2.value == "")
           {
             alert("Please Enter Age !!")
             document.MyForm.T2.focus();
           }
           else if(document.MyForm.T3.value == "")
           {
             alert("Please Enter Age !!")
             document.MyForm.T3.focus();
           }
           else if(document.MyForm.T5.value == "")
           {
             alert("Please Enter Employee Number !!")
             document.MyForm.T5.focus();
           }
           else
           {
            document.MyForm.submit();
           }
        }

	//-->
</SCRIPT>

</html>
