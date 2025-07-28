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
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Registration for NFL Employee</title>
<style type="text/css" media="print">
</style>
</head>
<body>
<% 
	String medexamno = request.getParameter("medexamno");
	String name = "";
	int empn = 0;
	String dt = "";
	String sex = "";
	String age = "";
	String meno ="";
					
    String dataSourceName = "hosp";
    String dbURL = "jdbc:odbc:"+ dataSourceName;
				
    Connection conn  = null;    
    try 
        {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           conn = DriverManager.getConnection(dbURL,"","");
           Statement stmt=conn.createStatement();
           
	       ResultSet rs = stmt.executeQuery("select name,empn,sex,age,meno,Format(dated,'dd-mm-yyyy') from medexam where meno="+medexamno);
             while(rs.next())  
            {
               name = rs.getString(1);
               empn = rs.getInt(2);
               sex = rs.getString(3);
               age = rs.getString(4);
               dt = rs.getString(6);
               meno = rs.getString(5);
            }
      } //end of try block

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
 <p style="line-height: 70%; margin-top: -3; margin-bottom: -10" align="center"><font face="Arial">National
 Fertilizers Limited</font></p>
 <p style="line-height: 70%; margin-bottom: -10" align="center"><font face="Arial">Panipat
 Unit: Medical department</font></p>
 <p style="line-height: 70%" align="center"><b><font face="Arial">Medical
 Examination Proforma</font></b></p>
 <div align="center">
  <form name="medex" action="/hosp1/HOSPITAL/Medical Examination/finalreport.jsp" method="post" >
  <table border="1" width="87%" height="53">
    <tr>
      <td width="50%" height="18" align="center" style="border-style: solid; border-width: 1" colspan="2">
        <p align="left">Med. Examination Date : <%=dt%></td>
  <center>
      <td width="50%" height="18" style="border-style: solid; border-width: 1" colspan="2"><font face="Arial" size="2">Med.
        Examination No. : 
      <input name="meno" type="text" value="<%=meno%>" size="20" /></font></td>
    </tr>
    <tr>
      <td width="6%" height="18" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">1.</font></td>
      <td width="44%" height="18" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Name</font></td>
      <td width="50%" height="18" style="border-style: solid; border-width: 1" colspan="2"><font face="Arial" size="2"><%=name%></font></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">2.</font></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">E.
        Code</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><font face="Arial" size="2"><%=empn%></font></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">3.</font></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Department</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2">
      <input type="text" name="T26" size="20"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">4.</font></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Age&nbsp;&nbsp;<%=age%></font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=sex%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </font></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">5.</font></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Height</font></td>
      <td width="24%" height="19" style="border-style: solid; border-width: 1"><select size="1" name="D1">
<%
  for (int i=125;i<210;i++)
     {
     %>
         <option value="<%=i%>"><%=i%></option>
     <%
     }      
%>
       </select>cm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Weight</td>
      <td width="26%" height="19" style="border-style: solid; border-width: 1">
      <input type="text" name="T28" size="6"> Kg </td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1">
      <font face="Arial" size="2">6.</font></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Investigation</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)
        Hb.</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T1" size="58"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)
        Urine</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><font face="Arial" size="2">Alb.<input type="text" name="T2" size="40"></font></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><font face="Arial" size="2">Sugar<input type="text" name="T3" size="38"></font></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)
        Blood Group</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T4" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">d)
        X-ray Chest</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T5" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">e)
        E.C.G. above 40 years</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T6" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="22" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="22" style="border-style: solid; border-width: 1"><font face="Arial" size="2">f)
        Any other investigation if required</font></td>
      <td width="50%" height="22" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T7" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="20" align="center" style="border-style: solid; border-width: 1">
      <font face="Arial" size="2">7.</font></td>
      <td width="44%" height="20" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Medical</font></td>
      <td width="50%" height="20" style="border-style: solid; border-width: 1" colspan="2"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)
        Pulse</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T8" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)
        B.P.</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T9" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)
        Heart</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T10" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">d)
        Lung</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T11" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">e)
        Abdomen</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T12" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">f)
        Any other Medical Problem</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T13" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1">
      <font face="Arial" size="2">8.</font></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Surgical</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)
        Hernia</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T14" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)
        Hydrocele</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T15" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)
        Piles</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T16" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">d)
        Any other surgical problem</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T17" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1">
      <font face="Arial" size="2">9.</font></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)
        Near Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T18" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)
        Distant Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T19" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)
        Color Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T20" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1">
      <font face="Arial" size="2">10.</font></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">E.
        N. T. Check up</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T21" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">11.</font></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Gynae
        &amp; Obst checkup for females</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T22" size="44"></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">
      12.</font></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Remarks</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><font face="Arial" size="2">Fit/Unfit/Need
        Treatment/Any other</font></td>
    </tr>
    <tr>
      <td width="6%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="44%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2"><input type="text" name="T24" size="51"></font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1" colspan="2"><input type="text" name="T25" size="58"></td>
    </tr>
  </table>
    &nbsp;
  <p>
  <input type="Submit" value="Save" />&nbsp;&nbsp;&nbsp; <input type="Reset" value="Clear" />
  </p>
 </form> 
  </center>
 </div>
 <p style="margin-top: 0; margin-bottom: 0">&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 (Medical Officer)</p>
 <p style="margin-top: 0; margin-bottom: 0">&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NFL Hospital, Panipat Unit</p>
 <p align="left"><i>Note:
 After completion of Medical Examination, this is to be deposited at Hospital reception/office for record</i></p>
 </body>
</html>