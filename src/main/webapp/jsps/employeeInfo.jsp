<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.* "%>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.DB.DBConnect" %>


<%
String sendString="";

String emp = request.getParameter("q");
System.out.println("emp:::"+emp);
//String emp="8338";
String name = "";
String age = "";
String sex = "";
				
//String dataSourceName = "hosp";
// String dbURL = "jdbc:oracle:thin:@10.3.126.84:1521:ORCL";



Connection con=DBConnect.getConnection(); 
Connection con1=DBConnect.getConnection1(); 

try 
    {

       String query = "select ename,to_char(sysdate,'yyyy') - to_char(birthdate,'yyyy'), sex FROM employeemaster where empn='"+emp+"'";           
       
       
        Statement stmt=con1.createStatement();


     //  PreparedStatement pstmt = con1.prepareStatement(query);
	//	pstmt.setString(1, empn);
		//ResultSet rs = pstmt.executeQuery();
		ResultSet rs = stmt.executeQuery(query);


       while(rs.next())
          {
             name = rs.getString(1);
             age = rs.getString(2);
                 sex = rs.getString(3);
                
          }
       
       System.out.println("name:"+name);
       System.out.println("agr:"+age);
       System.out.println("sex:"+sex);
       
   
    	
     // ResultSet rs3 = stmt.executeQuery("insert into opd(SRNO, PATIENTNAME,RELATION, AGE, OPDDATE, SEX, EMPN,TYP,EMPNAME) values ('"+srno+"','"+name+"','SELF','"+age1+"',SYSDATE,'"+sex+"','"+empn+"','"+typ+"','"+name+"')");
        




    }
    
catch(SQLException e) 
{
  while((e = e.getNextException()) != null)
  out.println(e.getMessage() + "<BR>");
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
}//end of finally
   
sendString = name+"#"+age+"#"+sex;
out.println(sendString);
%>