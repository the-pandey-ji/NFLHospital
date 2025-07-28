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
<title>Reference No</title>
</head>
<body background="../Stationery/Glacier%20Bkgrd.jpg">
<form method="POST" action="/hosp1/HOSPITAL/Outref/dep/refdetailoutdep.jsp">
<%
	String refno = request.getParameter("refno");
	String name ="";
	String sex ="";
	String relation ="";
	String age ="";
	String refdt ="";
	int empn=0;
	
    String dataSourceName = "hosp";
    String dbURL = "jdbc:odbc:"+ dataSourceName;
				
    Connection conn  = null;    
    try 
        {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           conn = DriverManager.getConnection(dbURL,"","");
           Statement stmt=conn.createStatement();
           
           ResultSet rs = stmt.executeQuery("select patientname,empn,sex,relation,age,format(opddate,'dd-mm-yyyy') from opd where srno="+refno);
                                              
           while(rs.next())
	          {
	              name = rs.getString("patientname");
	              empn = rs.getInt("empn");
	              sex = rs.getString("sex");
	              relation = rs.getString("relation");
	              age = rs.getString("age");
	              refdt = rs.getString(6);
	          }
 %>
  <p align="center"><font face="Tahoma" size="4" color="#0000FF"><b><span style="text-transform: uppercase"><u>Entry For OUT Reference</u></span></b></font></p>
  <p align="center">&nbsp;</p>
 <div align="center">
  <center>
  <table border="0" width="78%" style="border-style: solid; border-width: 1">
    <tr>
      <td width="43%"><font face="Tahoma" size="2"><b>Reference No </b></font></td>
      <td width="57%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="refno" value="<%= refno%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="43%"><font face="Tahoma" size="2"><b>Patient Name </b></font></td>
      <td width="57%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="name" value="<%= name%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="43%"><font face="Tahoma" size="2"><b>Employee Code</b></font></td>
      <td width="57%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="empn" value="<%= empn%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="43%"><font face="Tahoma" size="2"><b>Relation</b></font></td>
      <td width="57%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="relation" value="<%= relation%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="43%"><font face="Tahoma" size="2"><b>Age</b></font></td>
      <td width="57%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="age" value="<%= age%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="43%"><font face="Tahoma" size="2"><b>Date</b></font></td>
      <td width="57%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="refdt" value="<%= refdt%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="43%"><font face="Tahoma" size="2"><b>Sex</b></font></td>
      <td width="57%"><font face="Tahoma" size="2" color="#0000FF"><b><input type="text" name="sex" value="<%= sex%>" size="21"></b></font></td>
    </tr>
    <tr>
      <td width="43%"><font face="Tahoma" size="2"><b>Referred to&nbsp;Hospital </b></font></td>
     <td width="57%"><font face="Tahoma" size="2" color="#0000FF"><b>
    <select size="1" name="referto">      
 <%
      String hcode ="";
      String hname ="";
      String place ="";
      
             ResultSet rs1 = stmt.executeQuery("select * from outstationhospital");
             while(rs1.next())
	              {
	                 hcode = rs1.getString("hcode");
	                 hname = rs1.getString("hname");
	                 place = rs1.getString("city");
 %>
	                <option value="<%=hcode%>"><%=hname%> , <%=place%></option>
 <%
	              }
 %>
	</select>
    </b></font>
    </td>
    </tr>
     <tr>
      <td width="43%"><font face="Tahoma" size="2"><b>Escort</b></font></td>
      <td width="57%"><font face="Tahoma" size="2" color="#0000FF"><b>
      <select size="1" name="escort">
           <option value="Y">Yes</option>
           <option value="N">No</option>
        </select>
        </b></font>
        </td>
    </tr>
    <tr>
      <td width="43%"><b><font face="Tahoma" size="2">Referred By </font></b></td>
      <td width="57%"><select size="1" name="referby">
       <option value="">--Select--</option>
  <%       
             ResultSet rs2 = stmt.executeQuery("select code, doctor_name from DOCTOR order by doctor_name");
               while(rs2.next())
                    {
  %>
                       <option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option>
  <%
                    }
  %> 
       </select>
        </td>
    </tr>
<%
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
      <tr>
      <td width="43%"><b><font face="Tahoma" size="2">Disease</font></b>
      </td>
      <td width="57%"><input type="text" name="disease" size="60">
      </td>
    </tr>
  </table>
  </center>
</div>
<p align="center">
<input type="submit" value="Save" name="B1">
<input type="reset" value="Clear" name="B2"></p>
<hr width="80%">
<p align="center">&nbsp;</p>
<p>&nbsp;</p>
</form>
</body>
</html>