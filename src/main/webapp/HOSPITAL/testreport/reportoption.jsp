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

<body link="#808080" bgcolor="#CCFFFF">
 <div align="center" style="width: 877; height: 83">
    <tr>
        <td width="70%" align="center">
    <p><img border="0" src="path4.jpg" width="136" height="137"></p>
    <b><font size="4" color="#0000FF">SELECT ANY TEST REPORT TO SEE THE DETAIL</font></b><font size="5"></td>
  </tr>
    </font>
    <p>&nbsp;</p>
 <center>
 
   
     
     <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="50%">
   <tr>
     <td width="20%" align="center"><b><font size="4" color="#808080">Report No.</font></b></td>
     <td width="55%" align="center"><b><font size="4" color="#808080">Patient Name</font></b></td>
     <td width="25%" align="center"><b><font size="4" color="#808080">Report Date</font></b></td>
   </tr>
   
<% 
    String empn =request.getParameter("q");  
    String reportno = "";
    String pname = "";
    String testdate = "";
    boolean flag=false;
	String nm="";

    //out.println("i am here"+empn);
						
 Connection conn  = null;    
  try 
     {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	     conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.111.112:1521:orcl","hospital","hospital");
	     Statement stmt=conn.createStatement();
	     
	     ResultSet rs = stmt.executeQuery("select a.report_no, decode(a.self_dep,'S',b.ename,a.patientname) patientname, to_char(a.date_of_test,'dd-mon-yyyy') from TESTREPORT a, personnel.employeemaster b where b.oldnewdata='N' and a.empn=b.empn and a. empn= '"+empn+"' order by a.report_no desc");
          			
           if(rs!=null)
             {
                while(rs.next())
	                 {
	                   reportno = rs.getString(1);
	                   pname = rs.getString(2);
	                   testdate = rs.getString(3);
	                   flag=true;
	                 %>
	                   <font size="6"> 
	                   <tr>
	                    <td width="20%" align="center"><a href="report.jsp?q=<%=reportno%>"> <%=reportno%> </a> &nbsp;</td>
                        <td width="55%" align="center"><%=pname%>&nbsp;</td>
                        <td width="25%" align="center"><%=testdate%>&nbsp;</td>
	                  </tr>
	                  </font> 
	                 <% 
                     }
             }
           else
             {
             }
	  
	      if(flag==true)
	         {
	            //response.sendRedirect(response.encodeRedirectURL("report.jsp"));
	         }
	      else
	         {
	            response.sendRedirect(response.encodeRedirectURL("repnotfound.htm"));
	         }
	        
	  
	   //out.println("empolyee"+empn); 
	   
	   session.setAttribute("nm",empn); 
	   session.setMaxInactiveInterval(-1);
	 
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
 </tr>
 </table>
</body>
</html>