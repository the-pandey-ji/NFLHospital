<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page contentType="text/html;charset=iso-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.*" %>
<%-- <jsp:useBean class = "nflportal.sqlData.FormBean" id= "userid" scope = "application" ></jsp:useBean> --%>
//<jsp:setProperty name = "userid" property="*" />
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Leaves</title>
</head>
<body>
<%

String en = request.getParameter("en1");  
String en3 = request.getParameter("en2"); 
String pass ="";
String name ="";
boolean userValidate,passwdValidate;
userValidate=false;
passwdValidate=false; 
Connection conn  = null;    
try
{
Class.forName("oracle.jdbc.driver.OracleDriver");
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	conn =DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.1:1521:orcl2","production","prod");
	Statement stmt=conn.createStatement();
	stmt=conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from production.usrpass");
if(rs!=null)
	{ 
	while (rs.next())
		{ 
		name = rs.getString("username");
		if(name.equals(en))
		{
		userValidate=true;
		pass = rs.getString("passwd");
	     	if(pass.equals(en3))
		{
		passwdValidate=true;
		}
		}
		}
		}
if((userValidate==true)&&(passwdValidate==true))
	{
	response.sendRedirect(response.encodeRedirectURL("../Home/main1.htm"));
	}
else if((userValidate==true)&&(passwdValidate==false))
	{
	response.sendRedirect(response.encodeRedirectURL("../Home/wrongpassword.htm"));
	//out.println("Invalid Password");
	//msg("Please Re Enter Your Employee Code !!");
	}
else
{
response.sendRedirect(response.encodeRedirectURL("../Home/wrongpassword.htm"));
//out.println("");
}
}

finally{
 if(conn != null) {
 try{
 conn.close();
 }
 catch (Exception ignored) {}
}
}


%>

</body>
</html>
