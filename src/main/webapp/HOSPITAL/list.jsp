<%-- 


<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.* "%>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jstl/functions" %>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Leaves Details</title>
</head>
<body>
<c:choose>






<%-- 



<c:when test="${empList.rowCount==0}>
sorry, No epmloyee were found.
</c:when>
The Following were found:
<p>
<table border="1">
<th> Name </th>
<th> Relation </th>
<th> Birth Yaer </th>
<c:forEach items="${empList.rows}" var="row">
<tr>
	<td>${fn:escapeXml(row.dname)}</td>
	<td>${fn:escapeXml(row.relation)}</td>
	<td>${fn:escapeXml(row.birthyear)}</td>
	<td>
	<form action="delete.jsp" mrthod="post">
	<input type="hidden" name=Name"
		value="${fn:escapeXml(row.dname)}">
	<input type="hidden" name=Name"
		value="${fn:escapeXml(row.relation)}">
	<input type="hidden" name=Name"
		value="${fn:escapeXml(row.birthyear)}">
	<input type="submit" value="Delete">
	</form>
</td>
</tr>
</c:otherwise>
</c:choose> 



--%>






<% 
	String n1 = request.getParameter("T1");
	String r1 = request.getParameter("T2");
	String n2 = request.getParameter("T4");

	String en1 = session.getAttribute("nm").toString();
	String dname = "";
	String rel = "";
	String by = "";
			
	
	
/* 

Connection conn  = null;    
try {
Class.forName("oracle.jdbc.driver.OracleDriver");
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.111.107:1521:orcl2","production","prod");
	Statement stmt=conn.createStatement();
	stmt=conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * FROM PRODUCTION.dependents where dname like '%"+n1+"%' and relation like '%"+r1+"%' and srno ='"+n2+"' and to_char(empn)="+en1);
while(rs.next())
	{
	
	dname = rs.getString("dname");
	rel = rs.getString("relation");
	by = rs.getString("birthyear");
	}
  	}

catch(SQLException e) {
out.println("SQLException : "+ e.getMessage() + "<BR>");
while((e = e.getNextException()) != null)
out.println(e.getMessage() + "<BR>");
}
catch(ClassNotFoundException e) {
out.println("ClassNotFoundexception :" + e.getMessage() + "<BR>");
}
finally{
if(conn != null) {
try{
conn.close();
}
catch (Exception ignored) {}
}
} 


*/
%>

</body>
</html>
 --%>