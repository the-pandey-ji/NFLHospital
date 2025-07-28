<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.* "%>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>


<%
String comno = "";

Connection conn  = null;    
     try {
          Class.forName("oracle.jdbc.driver.OracleDriver");
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	          conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.126.84:1521:orcl","production","prod");
	             Statement stmt=conn.createStatement();
	               stmt=conn.createStatement();
	                  ResultSet rs = stmt.executeQuery("select nvl(max(COMMITTEENUMBER),0)+1 comn from COMMITTEE");
	                           if(rs.next())
	                              {
                                   comno=rs.getString("comn");
                                  } 
                                else
                                  {
              	                   comno = "1";
                                  }
                                                        
         }//end of try block
              
                 catch(SQLException e) 
                  {
                   out.println("SQLException : "+ e.getMessage() + "<BR>");
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
                }//end of finally

%>