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
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>New Page 1</title>
</head>

<body>
<%


String en = request.getParameter("T1");  
String name="";
String nm="";
//String passwd="";
boolean userValidate,passwdValidate;
userValidate=false;
passwdValidate=false; 
Connection conn  = null;    
try
{
Class.forName("oracle.jdbc.driver.OracleDriver");
DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	conn =DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:orcl2","production","prod");
	Statement stmt=conn.createStatement();
	stmt=conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from production.opd where to_char(srno)=" +en);
if(rs!=null)
	{ 
	while (rs.next())
		{ 
		name = rs.getString("srno");
		if(name.equals(en))
		{
		//userid.setUserName(name);
		userValidate=true;
		session.setAttribute("nm",name); 
		session.setMaxInactiveInterval(-1);
		}
		}
		}
if(userValidate==true)
	{
	response.sendRedirect(response.encodeRedirectURL("refdetailself.jsp"));
	}
	else
	{
	response.sendRedirect(response.encodeRedirectURL("localrepwrong.htm"));

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
