
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
<html>
<head>
<title>Reference No</title>
</head>
<body>
<%@ include file="/navbar.jsp" %>

<%
String refno = request.getParameter("refno");
boolean showDetails = false;
String name = "", sex = "", relation = "", age = "", refdt = "";
int empn = 0;
String yr = "";

if (refno != null && !refno.trim().isEmpty()) {
    Connection conn = null;
    try {
        conn = DBConnect.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rsref = stmt.executeQuery("select srno from opd where srno = " + refno);
        if (rsref.next()) {
            ResultSet rsdetail = stmt.executeQuery("select patientname,empn,sex,relation,age,to_char(opddate,'dd-mon-yyyy') from opd where srno = " + refno);
            if (rsdetail.next()) {
                name = rsdetail.getString("patientname");
                empn = rsdetail.getInt("empn");
                sex = rsdetail.getString("sex");
                relation = rsdetail.getString("relation");
                age = rsdetail.getString("age");
                refdt = rsdetail.getString(6);
                showDetails = true;
            }
        } else {
            out.print("<p align='center' style='color:red;'>Invalid Reference No.</p>");
        }
    } catch(SQLException e) {
        while((e = e.getNextException()) != null)
            out.println(e.getMessage() + "<BR>");
    } finally {
        if(conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
}
%>

<!-- Reference Number Form -->
<form name="RefForm" method="POST" action="">
    <p align="center">
        <b><font size="3" face="Tahoma">Enter Reference No&nbsp;&nbsp;&nbsp;&nbsp;</font></b>
        <input type="text" name="refno" size="20" value="<%= (refno != null ? refno : "") %>">
        <input type="submit" value="Detail" name="B1">
    </p>
</form>
<hr width="80%">

<% if (showDetails) { %>
<!-- Details Form -->
<form name="MyForm" method="POST" action="/hosp1/HOSPITAL/Outref/dep/refdetailoutdep.jsp">
    <p align="center"><font face="Tahoma" size="4" color="#0000FF"><b><span style="text-transform: uppercase"><u>Entry For OUT Reference</u></span></b></font></p>
    <div align="center">
        <table border="0" width="44%" style="border-style: solid; border-width: 1">
            <!-- Details fields as before, using fetched values -->
            <tr>
                <td width="50%"><font face="Tahoma" size="2"><b>Reference No </b></font></td>
                <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b>
                    <input type="text" name="refno" readonly value="<%= refno %>" size="21"></b></font></td>
            </tr>
            <tr>
                <td width="50%"><font face="Tahoma" size="2"><b>Patient Name </b></font></td>
                <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b>
                    <input type="text" name="name" readonly  value="<%= name %>" size="21"></b></font></td>
            </tr>
            <tr>
                <td width="50%"><font face="Tahoma" size="2"><b>Employee Code</b></font></td>
                <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b>
                    <input type="text" name="empn" readonly  value="<%= empn %>" size="21"></b></font></td>
            </tr>
            <tr>
                <td width="50%"><font face="Tahoma" size="2"><b>Relation</b></font></td>
                <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b>
                    <input type="text" name="relation" readonly  value="<%= relation %>" size="21"></b></font></td>
            </tr>
            <tr>
                <td width="50%"><font face="Tahoma" size="2"><b>Age</b></font></td>
                <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b>
                    <input type="text" name="age" readonly  value="<%= age %>" size="21"></b></font></td>
            </tr>
            <tr>
                <td width="50%"><font face="Tahoma" size="2"><b>Date</b></font></td>
                <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b>
                    <input type="text" name="refdt" readonly  value="<%= refdt %>" size="21"></b></font></td>
            </tr>
            <tr>
                <td width="50%"><font face="Tahoma" size="2"><b>Sex</b></font></td>
                <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b>
                    <input type="text" name="sex" readonly  value="<%= sex %>" size="21"></b></font></td>
            </tr>
               <tr>
                <td width="50%"><font face="Tahoma" size="2"><b>Refered By</b></font></td>
                <td width="50%"><font face="Tahoma" size="2" color="#0000FF"><b>
                    <input type="text" name="referby" readonly  value="<%=user1.getUsername()  %>" size="21"></b></font></td>
            </tr>
            <!-- Add other fields as needed -->
            
            
                <tr>
      <td width="43%"><font face="Tahoma" size="2"><b>Referred to&nbsp;Hospital </b></font></td>
     <td width="57%"><font face="Tahoma" size="2" color="#0000FF"><b>
    <select size="1" name="referto">      
 <%
 Connection conn1  = null;    
 try 
   {

	  conn1 = DBConnect.getConnection();
     Statement stmt1=conn1.createStatement();
      String hcode ="";
      String hname ="";
      String place ="";
      
             ResultSet rs1 = stmt1.executeQuery("select * from outstationhospital");
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
      <select size="1" name="escort">d
           <option value="Y">Yes</option>
           <option value="N">No</option>
        </select>
        </b></font>
        </td>
    </tr>
            
            
            

  <%
                    
     }
   catch(SQLException e) 
     {
       while((e = e.getNextException()) != null)
       out.println(e.getMessage() + "<BR>");
     }
  
   finally
      {
          if(conn1 != null) 
            {
               try
                  {
                      conn1.close();
                  }
               catch (Exception ignored) {}
            }
      }
 %>  
   </select>
   </td>
    </tr>
    <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Disease</b></font></td>
      <td width="50%"><input type="text" name="disease" size="20"></td>
    </tr>
        </table>
    </div>
    <p align="center">
        <input type="submit" value="Save" name="B1">
        <input type="reset" value="Clear" name="B2">
    </p>
    <hr width="80%">
</form>
<%   } %>

</body>
</html>
