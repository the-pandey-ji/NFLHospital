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
<title>Registration for KV/CISF/MKTG/Others</title>
</head>
<body bgcolor="#DFFFFF">
 <p align="center">&nbsp;<p align="center"><b><font size="3"><span style="text-transform: uppercase">OPD ENRTY FOR KV / CISF / MKTG / OTHERS</span></font></b>
 <p align="center">&nbsp;<form name="MyForm" method="POST" action="/hosp1/HOSPITAL/OPDO/selfdetail.jsp" >
    <div align="center">
    <center>
  <table border="0" width="35%">
    <tr>
      <td width="99%">KV/CISF/Other</td>
      <td width="154%"><select size="1" name="category">
          <option value="C">CISF</option>
          <option value="K">KV</option>
          <option value="M">MKTG</option>
          <option value="S">KV-STUDENT</option>
          <option value="O">OTHER</option>
        </select></td>
    </tr>
    <tr>
      <td width="99%">Patient Name</td>
      <td width="154%"><input type="text" name="pname" size="25" maxlength="25"></td>
    </tr>
    <tr>
      <td width="99%">E.Code</td>
      <td width="143%"><input type="text" name="empn" size="15" maxlength="15"></td>
    </tr>
    <tr>
      <td width="99%">E.Name</td>
      <td width="143%"><input type="text" name="ename" size="25" maxlength="25"></td>
    </tr>
    <tr>
      <td width="99%">Relation</td>
      <td width="143%">
      <select size="1" name="relation">
          <option value="SELF">SELF</option>
          <option value="W">WIFE</option>
          <option value="WIFE">HUSBAND</option>
          <option value="SON">SON</option>
          <option value="DAUGHTER">DAUGHTER</option>
          <option value="FATHER">FATHER</option>
          <option value="MOTHER">MOTHER</option>
          <option value="FATHER-IN-LAW">FATHER-IN-LAW</option>
          <option value="MOTHER-IN-LAW">MOTHER-IN-LAW</option>
          <option value="SISTER">SISTER</option>
          <option value="BROTHER">BROTHER</option>
      </select>
      </td>
    </tr>
    <tr>
      <td width="99%">Age</td>
      <td width="143%"><input type="text" name="age" size="3" maxlength="3"></td>
    </tr>
    <tr>
      <td width="99%">Sex</td>
      <td width="143%"><select size="1" name="sex">
          <option>M</option>
          <option>F</option>
        </select></td>
    </tr>
  </table>
    </center>
  </div>
  <p align="center">
&nbsp;</p>
  <p align="center">
<input type="button" value="Proceed" name="B1" onClick="checkForm();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<input type="reset" value="Reset" name="B2"></p>
</form>
<SCRIPT LANGUAGE="JavaScript">
    <!--
        function checkForm()
           {
                if(document.MyForm.pname.value == "")
                  {
                      alert("Please Enter Name !!")
                      document.MyForm.pname.focus();
                  }  
                else if(document.MyForm.age.value == "")
                  {
                      alert("Please Enter Age !!")
                      document.MyForm.age.focus();
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