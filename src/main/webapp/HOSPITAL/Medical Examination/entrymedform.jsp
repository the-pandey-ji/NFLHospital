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
.printbutton {
  visibility: hidden;
  display: none;
}
</style>
</head>

<body>
<% 
	String en1 = request.getParameter("T1");
	String name = "";
	String empn = "";
	String dept = "";
	String sex = "";
	String age = "";
	String srno ="";
					
    String dataSourceName = "hosp";
    String dbURL = "jdbc:odbc:"+ dataSourceName;
				
    Connection con  = null;    
    try 
        {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           con = DriverManager.getConnection(dbURL,"","");
           Statement stmt=con.createStatement();
    
		   ResultSet rs = stmt.executeQuery("select ename,empn,sex,Format(Date,'yyyy'))-Format(birthdate,'yyyy')) from employeemaster where empn="+en1);
     
           while(rs.next())  
                {
                    name = rs.getString(1);
                    empn = rs.getString(2);
                    sex = rs.getString(3);
                    age = rs.getString(4);
                }

        } //end of try block

catch(SQLException e) {
//out.println("SQLException : "+ e.getMessage() + "<BR>");
while((e = e.getNextException()) != null)
out.println(e.getMessage() + "<BR>");
}
catch(ClassNotFoundException e) {
out.println("ClassNotFoundexception :" + e.getMessage() + "<BR>");
}
finally{
if(con != null) {
try{
con.close();
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
 <div align="center" style="width: 979; height: 746">
  
  <table border="1" width="86%" height="53">
    <tr>
      <td width="50%" height="18" align="center" style="border-style: solid; border-width: 1" colspan="2">
        <p align="left">Med. Exam. Date :</td>
  <center>
      <td width="50%" height="18" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Med.Exam. No. :</font></td>
    </tr>
    <tr>
      <td width="5%" height="18" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">1.</font></td>
      <td width="45%" height="18" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Name</font></td>
      <td width="50%" height="18" style="border-style: solid; border-width: 1"><font face="Arial" size="2"><%=name%></font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">2.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">E.Code</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2"><%=empn%></font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">3.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Department</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">4.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Age&nbsp;&nbsp;</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2"><%=age%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=sex%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">5.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Investigation</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)
        Hb.</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)
        Urine</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Alb.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Sugar</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)
        Blood Group</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">d)
        X-ray Chest</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">e)
        E.C.G. above 40 years</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="22" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="22" style="border-style: solid; border-width: 1"><font face="Arial" size="2">f)
        Any other investigation if required</font></td>
      <td width="50%" height="22" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="20" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">6.</font></td>
      <td width="45%" height="20" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Medical</font></td>
      <td width="50%" height="20" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)
        Pulse</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)
        B.P.</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)
        Heart</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">d)
        Lung</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">e)
        Abdomen</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">f)
        Any other Medical Problem</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">7.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Surgical</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)
        Hernia</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)
        Hydrocele</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)
        Piles</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">d)
        Any other surgical problem</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">8.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)
        Near Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)
        Distant Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)
        Colour Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">9.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">E.
        N. T. Check up</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">10.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Gynae
        &amp; Obst checkup for females</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">11</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Remarks</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Fit/Unfit/Need
        Treatment/Any other</font></td>
    </tr>
  </table>
  
  </center>
 </div>
 <p align="left">&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 (Dr Incharge)</p>
 <p>&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 NFL Hospital Panipat Unit</p>
 <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 Note:
 After completion of Medical Examination, this is to be deposited at Hospital
 reception/office for record</P>
 <p align="center"><script>
document.write("<input type='button' " +
"onClick='window.print()' " +
"class='printbutton' " +
"value='Print This Page'/>");

 </script>
</p>
</body>

</html>