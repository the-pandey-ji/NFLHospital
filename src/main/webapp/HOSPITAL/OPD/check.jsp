<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
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

<body>
<% 
	String en1 = request.getParameter("T1");
	
    
    
	String empn = "";
	boolean flag=false;
	String nm="";
    String dataSourceName = "hosp";
    String dbURL = "jdbc:oracle:thin:@10.3.126.84:1521:ORCL";
				
    Connection con  = null;   

 
 
    try 
        {
           Class.forName("oracle.jdbc.driver.OracleDriver");
           con = java.sql.DriverManager.getConnection(dbURL,"hospital","hospital");
           Statement stmt=con.createStatement();
	       ResultSet rs = stmt.executeQuery("select * FROM employeemaster where empn="+en1);
System.out.println("outsite iff statement");
           if(rs!=null)
              {
                 while(rs.next())
	                 {
	                     empn = rs.getString("empn");
	                     
	                     if(empn.equals(en1))
	                        {
	                           flag=true;
	                           session.setAttribute("nm",empn); 
	                           session.setMaxInactiveInterval(-1);
	                        }
	                 }
	          }
	       //out.print("empn is: "+empn);
	       if(flag==true)
	         {
	              response.sendRedirect(response.encodeRedirectURL("selfdetails.jsp"));
	         }
	       else
	         {
	              response.sendRedirect(response.encodeRedirectURL("localrepnotfound.htm"));
	         }
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
         if(con != null) 
            {
               try
                   {
                       con.close();
                   }
               catch (Exception ignored) {}
            }
     }
%>
</body>
</html>