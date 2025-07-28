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
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Medical Certificate</title>
<script language="JavaScript" type="text/javascript" src="/hosp1/Date/datetimepicker.js"></script>
</head>
<body background="../../Stationery/Clear%20Day%20Bkgrd.jpg">
<form name="MyForm" method="POST" action="/hosp1/HOSPITAL/Medical Certificate/mcert.jsp" >
  <p align="center">&nbsp;&nbsp; <b><font size="4" face="Tahoma"> Entry For Medical Certificate</font></b></p>
  <div align="center">
    <center>
    <table border="0" width="58%" bgcolor="#CCFFFF">
      <tr>
        <td width="53%"><font size="2" face="Tahoma"><b>Patient name</b></font></td>
        <td width="49%"><input type="text" name="pname" size="28"></td>
      </tr>
      <tr>
        <td width="53%"><font face="Tahoma" size="2"><b>Relation</b></font></td>
        <td width="49%"><select size="1" name="relation">
            <option>S/O</option>
            <option>D/O</option>
            <option>W/O</option>
          </select></td>
      </tr>
      <tr>
        <td width="53%"><font face="Tahoma" size="2"><b>Father/Husband</b></font></td>
        <td width="49%"><input type="text" name="father" size="28"></td>
      </tr>
      <tr>
        <td width="53%"><font face="Tahoma" size="2"><b>Employee Code</b></font></td>
        <td width="49%"><input type="text" name="empn" size="28"></td>
      </tr>
      <tr>
        <td width="53%"><font face="Tahoma" size="2"><b>Designation</b></font></td>
        <td width="49%"><input type="text" name="desg" size="28"></td>
      </tr>
      <tr>
        <td width="53%"><font face="Tahoma" size="2"><b>Department</b></font></td>
        <td width="49%"><input type="text" name="dept" size="28"></td>
      </tr>
      <tr>
        <td width="53%"><font face="Tahoma" size="2"><b>Suffering From</b></font></td>
        <td width="49%"><input type="text" name="disease" size="28"></td>
      </tr>
      <tr>
        <td width="53%"><font face="Tahoma" size="2"><b>Leave Days</b></font></td>
        <td width="49%"><select size="1" name="days">
            			    <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option> 
       </select>
       </td>
      </tr>
      <tr>
        <td width="53%"><font face="Tahoma" size="2"><b>From&nbsp; Date</b></font></td>
        <td width="49%"><input type="text" name="fromdt" id="fromdt" size="9"> <a href="javascript:NewCal('fromdt','ddmmmyyyy')"><img src="/hosp1/Date/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
       </td>
      </tr>
      <tr>
        <td width="53%"><font face="Tahoma" size="2"><b>To&nbsp; Date</b></font></td>
        <td width="49%"><input type="text" name="todt" id="todt" size="9"> <a href="javascript:NewCal('todt','ddmmmyyyy')"><img src="/hosp1/Date/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
       </td>
      </tr>
      <tr>
        <td width="53%"><font face="Tahoma" size="2"><b>Fit For Duty from</b></font></td>
        <td width="49%"><input type="text" name="fitdt" id="fitdt" size="9"> <a href="javascript:NewCal('fitdt','ddmmmyyyy')"><img src="/hosp1/Date/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
       </td>
      </tr>
    </table>
    </center>
  </div>
  <p align="center">&nbsp;<input type="button" value="Save" name="B1" onClick="checkForm();">&nbsp;&nbsp;
  <input type="reset" value="Reset" name="B2" /></p>
</form>
<SCRIPT LANGUAGE="JavaScript">
       <!--
         function checkForm()
            {
                  if(document.MyForm.pname.value == "")
                     {
                          alert("Please Enter Patient Name !!")
                          document.MyForm.pname.focus();
                     }  
                  else if(document.MyForm.father.value == "")
                     {
                          alert("Please Enter Father's Name !!")
                          document.MyForm.father.focus();
                     }
                  else if(document.MyForm.desg.value == "")
                     {
                          alert("Please Enter Designation !!")
                          document.MyForm.desg.focus();
                     }
                  else if(document.MyForm.dept.value == "")
                     {
                          alert("Please Enter Department !!")
                          document.MyForm.dept.focus();
                     }
                  else if(document.MyForm.disease.value == "")
                     {
                          alert("Please Enter Suffering from !!")
                          document.MyForm.disease.focus();
                     }
                  else
                     {
                          document.MyForm.submit();
                     }
           }
	//-->
</SCRIPT>
</html>