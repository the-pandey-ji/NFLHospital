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
<style type="text/css" media="print">
.printbutton 
  {
     visibility: hidden;
     display: none;
  }
</style>
</head>
<body>
<% 
	String empn = session.getAttribute("nm").toString();
	String name = "";
	String relation = "Self";
	String age = "";
	String age1 = "";
	String sex = "";
	String dt = "";
	String srno ="";
	String srno1 ="";
	String typ = "N";
	int sr1=0,sr2=0;
					
    String dataSourceName = "hosp";
    String dbURL = "jdbc:odbc:"+ dataSourceName;
				
    Connection con  = null;    
    try 
        {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           con = DriverManager.getConnection(dbURL,"","");
           Statement stmt=con.createStatement();
          
	       
	       ResultSet rs = stmt.executeQuery("select ename,format(Date(),'yyyy') - format(birthdate,'yyyy'), sex, format(Date(),'dd-mmm-yyyy') FROM employeemaster where empn="+empn);
           while(rs.next())
	          {
	             name = rs.getString(1);
	             age = rs.getString(2);
                     sex = rs.getString(3);
                     dt=rs.getString(4);
	          }
           age1=age.substring(0,age.length()-2);
           
           ResultSet rs1 = stmt.executeQuery("select max(srno)+1 from OPD");
           while(rs1.next())
	          {
	             srno = rs1.getString(1);

	          }
	       ResultSet rs3 = stmt.executeQuery("insert into opd(SRNO, PATIENTNAME, RELATION, AGE, OPDDATE, SEX, EMPN,TYP) values('"+srno+"','"+name+"','Self','"+age1+"','"+dt+"','"+sex+"','"+empn+"','"+typ+"')");
	       while(rs3.next())
	          {
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
<p style="margin-bottom: -1">&nbsp;</p>
<div align="center">
  <center>
  <table border="0" width="80%" height="78%" style="border-style: solid; border-width: 1">
    <tr>
     <td width="100%" height="19" colspan="4" style="border-bottom-style: solid">
     <!-- <p align="center"><b><font size="3" color="#003300">NFL Hospital, Panipat </font><font size="3">OPD SLIP</font></b> -->

<p align="center" >
        <font face="Kruti Dev 011" size="5">us'kuy
        QfVZykbZtlZ fyfeVsM  ikuhir
        bdkbZ </font></p>
        <p align="center" style="line-height: 100%; margin-top: 0; margin-bottom: 0">
        <font face="Kruti Dev 011" size="4">cká jksxh foHkkx ¼vksihMh½ & iphZ</font></p>

	</td>

    </tr>
    <tr >
     <td width="20%" height="1"><font size="1" face="Arial"><b>Sr. No.</b></font> 
     <font face="Kruti Dev 011" size="2"> Øe la[;k </font> :  </td>
  	 <td width="20%" height="1"><font size="1" face="Arial"><%=srno%></font></td>
   	 <td width="30%" height="1" align="left"><font size="1" face="Arial"><b>Date</b></font>  
<font face="Kruti Dev 011" size="2"> rkjh[k</font> : </td>
  	 <td width="30%" height="1" align="left"><font size="1" face="Arial"><%=dt%></font></td>
    </tr>
    <tr>
     <td width="20%" height="1" align="left"><b><font face="Arial" size="1">Name</font></b>
<font face="Kruti Dev 011" size="2"> uke</font> :</td>
  </center>
   	 <td width="20%" height="1">
      <p align="left"><font size="1" face="Arial"><%=name%></font></td>
   <center>
     <td width="30%" height="1" align="left"><b><font face="Arial" size="1">Relation</font></b>
<font face="Kruti Dev 011" size="2"> laca/k</font> :</td>
     <td width="30%" height="1" align="left"><font face="Arial" size="1"><%=relation%></font></td>
    </tr>
     <tr>
  	 <td width="25%" height="1"><b><font face="Arial" size="1">E.Code</font></b>
<font face="Kruti Dev 011" size="2"> deZpkjh la[;k</font> :</td>
  	 <td width="15%" height="1"><font size="1" face="Arial"><%=empn%></font></td>
  	 <td width="30%" height="1"><b><font face="Arial" size="1">E.Name</font></b>
<font face="Kruti Dev 011" size="2"> deZpkjh uke</font> :</td>
  	 <td width="30%" height="1"><font size="1" face="Arial"><%=name%></font></td>
    </tr>
     <tr>
  	 <td width="20%" height="1"><b><font face="Arial" size="1">Sex</font></b>
<font face="Kruti Dev 011" size="2"> fyax</font> :</td>
  	 <td width="20%" height="1"><font size="1" face="Arial"><%=sex%></font></td>
  	 <td width="30%" height="1"><b><font face="Arial" size="1">Age</font></b>
<font face="Kruti Dev 011" size="2"> vk;q</font> :</td>
  	 <td width="30%" height="1"><font size="1" face="Arial"><maxlength="2"><%=age1%></font></td>
   </tr>
     <tr>
  	 <td width="100%" height="1" colspan="4" style="border-top-style: solid">
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;
      <p>&nbsp;<p>&nbsp;<p>&nbsp;<p>&nbsp; &nbsp;
      <p>&nbsp;</td>
    </tr>
	</table>
  </center>
</div>
<p align="center"><script>
document.write("<input type='button' " +
"onClick='window.print()' " +
"class='printbutton' " +
"value='Print This Page'/>");
</script>
</p></body>
</html>