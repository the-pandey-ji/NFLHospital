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
<title>Local Reference</title>
<base target="main">
<script language="Javascript">

 
   
 </script>
</head>



<body>
<%@ include file="/navbar.jsp" %>


<form name="MyForm" method="POST" action="/hosp1/HOSPITAL/Localref/self/refdetaildep.jsp" target="main" onsubmit="validate();" >
    <p align="center" style="margin-top: -4px; margin-bottom: -4px"><b><font size="3" face="Tahoma">Enter Reference Nos&nbsp;&nbsp;&nbsp;&nbsp;
    </font></b><input type="text" name="refno" size="20"><font face="Tahoma" size="3">
    <b><input type="submit" value="Detail" name="B1"></b></font></p>
</form>
<hr width="80%">
<p align="center">&nbsp;</p>
</body>
</html>