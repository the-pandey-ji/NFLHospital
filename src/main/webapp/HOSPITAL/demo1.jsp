<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.* "%>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page contentType="text/html" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<html>
<body                 bgcolor=lightblue>
 <form   method=post  action="http://10.3.122.104:81/HOSPITAL/demo1.jsp">
 NAME <input  type=text  name="text1"><br>
 PLACE<input  type=text  name="text2"><br>
       <input type=submit>
 </form> 

 NAME:<c:out    value="${param.text1}"  /><br>
 PLACE:<c:out   value="${param.text2}"  />
</body>
</html>

