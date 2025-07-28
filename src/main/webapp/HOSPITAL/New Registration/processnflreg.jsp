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
<title>OPD Slip</title>
</head>
<body bgcolor="#CCFFCC">
<% 
	String name = request.getParameter("T1");
	String desg = request.getParameter("T2");
	String empn = request.getParameter("T3");
	String dob = request.getParameter("T4");
	String dept = request.getParameter("T5");
	String sex = request.getParameter("D1");
%>
	<!--alert(<%=name%>,<%=desg %>,<%=empn %>,<%=dob %>,<%=dept %>,<%=sex %>);-->
<%				
    String dataSourceName = "hosp";
    String dbURL = "jdbc:odbc:"+ dataSourceName;
				
    Connection con  = null;    
    try 
        {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           con = DriverManager.getConnection(dbURL,"","");
           Statement stmt=con.createStatement();
           
           ResultSet rs = stmt.executeQuery("insert into employeemaster(EMPN, ENAME, DEPTCODE, DESIGNATION, BIRTHDATE, SEX) values('"+empn+"','"+name+"','"+dept+"','"+desg+"','"+dob+"','"+sex+"')");
	
	       while(rs.next())
	            {
	                //out.println("One Record successfully added !!");
	            }
	    }

catch(SQLException e) {
//out.println("SQLException : "+ e.getMessage() + "<BR>");
while((e = e.getNextException()) != null)
out.println(e.getMessage() + "<BR>");
}
catch(ClassNotFoundException e) {
out.println("ClassNotFoundexception :" + e.getMessage() + "<BR>");
}
finally{
if(con != null) {
try{
con.close();
}
catch (Exception ignored) {}
}
}
%>
<P align="center">One Record Added !!

<P align="center"><input type="button" value="Close" 
onclick="self.close()"></P>
</body>
</html>