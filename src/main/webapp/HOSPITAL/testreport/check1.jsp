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
<title>check</title>
</head>

<body>
<% 
    String emp =request.getParameter("useridpath");    
	String pwd =request.getParameter("passwdpath");
	String empn ="";
    String passw ="";
    boolean flag=false;
	String nm="";
	
					
 Connection conn  = null;    
  try 
     {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	     conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.111.112:1521:orcl","hospital","hospital");
	     Statement stmt=conn.createStatement();
	     
	     ResultSet rs = stmt.executeQuery("select A.USERNAME, A.PASSWD from PERSONNEL.USRPASS A, PRODUCTION.USERPASSHOSP B where A.USERNAME = TO_CHAR(B.EMPN) AND a.username='"+emp+"' and a.passwd='"+pwd+"'");
          			
           if(rs!=null)
             {
                while(rs.next())
	                 {
	                   empn = rs.getString(1);
	                   passw = rs.getString(2);
	                   if(empn.equals(emp) && passw.equals(pwd))
	                      {
	                         flag=true;
	                         session.setAttribute("nm",empn); 
	                         session.setMaxInactiveInterval(-1);
	                      }
	                   else
	                      {
	                      }
	                 }
             }
           else
             {
             }
	  
	      if(flag==true)
	         {
	            response.sendRedirect(response.encodeRedirectURL("entryform.jsp"));
	         }
	      else
	         {
	            response.sendRedirect(response.encodeRedirectURL("repnotfound.htm"));
	         }
	       out.println("empolyee"+emp);  
	}
	

catch(SQLException e) 
   {
       while((e = e.getNextException()) != null)
       out.println(e.getMessage() + "<BR>");
   }
 catch(ClassNotFoundException e) 
      {
          out.println("ClassNotFoundexception :" + e.getMessage() + "<BR>");
      }
 finally
      {
          if(conn != null) 
            {
               try
                  {
                      conn.close();
                  }
               catch (Exception ignored) {}
            }
      }
         

%>
</body>
</html>