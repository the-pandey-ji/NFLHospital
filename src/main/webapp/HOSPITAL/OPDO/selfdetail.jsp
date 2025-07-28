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
	String pname = request.getParameter("pname");
	String age = request.getParameter("age");
    String empn = request.getParameter("empn");
    
    String sex = request.getParameter("sex");
    String ename = request.getParameter("ename");
	String relation = request.getParameter("relation");
	String category = request.getParameter("category");
	if(category.equals("K") ||category.equals("S") )
      {
        empn="0";
      }
	
    String dt = "";
	String srno ="";
	String relation1="";
	
	if(relation.equals("S"))
	   {
	      relation1="SELF";
	   }
	else if(relation.equals("W"))
	   {
	      relation1="WIFE";
       }
    else if(relation.equals("H"))
	   {
	      relation1="HUSBAND";
       }
    else if(relation.equals("S"))
	   {
	      relation1="SON";
       }
    else if(relation.equals("D"))
	   {
	      relation1="DAUGHTER";
       }
    else if(relation.equals("F"))
	   {
	      relation1="FATHER";
       }
    else if(relation.equals("M"))
	   {
	      relation1="MOTHER";
       }
    else if(relation.equals("FI"))
	   {
	      relation1="FATHER-IN-LAW";
       }
    else if(relation.equals("MI"))
	   {
	      relation1="MOTHER-IN-LAW";
       }
    else if(relation.equals("SI"))
	   {
	      relation1="SISTER";
       }
    else if(relation.equals("B"))
	   {
	      relation1="BROTHER";
       }
%>	
<!--alert(<%=pname%>,<%=age%>,<%=empn%>,<%=sex%>,<%=ename%>,<%=relation%>,<%=category %>);-->
<%						
    String dataSourceName = "hosp";
    String dbURL = "jdbc:odbc:"+ dataSourceName;
				
    Connection conn  = null;    
    try 
        {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           conn = DriverManager.getConnection(dbURL,"","");
           Statement stmt=conn.createStatement();
       
           ResultSet rs1 = stmt.executeQuery("select format(Date(),'dd-mmm-yyyy'), max(srno)+1 from opd");
	       while(rs1.next())
	            {
	                 srno = rs1.getString(2);
	                 dt = rs1.getString(1);
	            }
         
           ResultSet rs2 = stmt.executeQuery("insert into opd(SRNO, PATIENTNAME, EMPNAME, RELATION, AGE, SEX, EMPN, OPDDATE, TYP) values ('"+srno+"','"+pname+"','"+ename+"','"+relation+"','"+age+"','"+sex+"','"+empn+"','"+dt+"','"+category+"')");
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
<p style="margin-bottom: -1">&nbsp;</p>
<div align="center">
  <center>
  <table border="1" width="80%" height="70%" style="border-style: solid; border-width: 1">
    <tr >
<td width="5%" height="19" style="border-bottom-style: solid" align="Center">
<img src="NFL.jpg" alt="NFL" >
</td>
     <td width="95%" height="19" colspan="3" style="border-bottom-style: solid">
     <!-- <p align="center"><b><font size="3" color="#003300">NFL Hospital, Panipat </font><font size="3">OPD SLIP</font></b> -->

<p align="center" >
        <font face="Kruti Dev 011" size="5"><b>us'kuy QfVZykbtlZ fyfeVsM </b></font> <br/><font face="Kruti Dev 011" size="4">,u-,Q-,y- fpfdRlky;] ikuhir </font>
<br/><font face="Kruti Dev 011" size="3">cká jksxh foHkkx ¼vksihMh½ & iphZ</font> </p>
<!--      
  <p align="center" style="line-height: 100%; margin-top: 0; margin-bottom: 0">
        <font face="Kruti Dev 011" size="3">cká jksxh foHkkx ¼vksihMh½ & iphZ</font></p> -->

	</td>

    </tr>
    <tr>
    <td width="20%" height="1"> <font face="Kruti Dev 011" size="2"> Øe la[;k </font>&nbsp;<font size="1" face="Arial"><b>Sr. No.</b></font> : </td>
   	 <td width="20%" height="1"><font size="1" face="Arial"><%=srno%></font></td>
   	 <td width="30%" height="1"><font face="Kruti Dev 011" size="2"> rkjh[k</font>&nbsp;<font size="1" face="Arial"><b>Date</b></font> : </td>
     <td width="30%" height="1"><font size="1" face="Arial"><%=dt%></font></td>
    </tr>
    <tr>
    <td width="20%" height="1"><font face="Kruti Dev 011" size="2"> uke</font>&nbsp;<b><font face="Arial" size="1">Name</font></b> :</td>
   </center>
   	 <td width="20%" height="1">
      <p align="left"><font size="1" face="Arial"><%=pname%></font></td>
   <center>
    <td width="30%" height="1"><font face="Kruti Dev 011" size="2"> laca/k</font>&nbsp;<b><font face="Arial" size="1">Relation</font></b> :</td>
   	 <td width="30%" height="1"><font face="Arial" size="1"><%=relation%></font></td>
    </tr>
     <tr>
  	 <td width="25%" height="1"><font face="Kruti Dev 011" size="2"> deZpkjh la[;k</font>&nbsp;<b><font face="Arial" size="1">E.Code</font></b> :</td>
  	 <td width="15%" height="1"><font size="1" face="Arial"><%=empn%></font></td>
  	 <td width="30%" height="1"><font face="Kruti Dev 011" size="2"> deZpkjh uke</font>&nbsp;<b><font face="Arial" size="1">E.Name</font></b> :</td>
  	 <td width="30%" height="1"><font size="1" face="Arial"><%=ename%></font></td>
    </tr>
     <tr>
  	 <td width="20%" height="1"><font face="Kruti Dev 011" size="2"> fyax</font>&nbsp;<b><font face="Arial" size="1">Sex</font></b> :</td>
  	 <td width="20%" height="1"><font size="1" face="Arial"><%=sex%></font></td>
  	 <td width="30%" height="1"><font face="Kruti Dev 011" size="2"> vk;q</font>&nbsp;<b><font face="Arial" size="1">Age</font></b> :</td>
  	 <td width="30%" height="1"><font size="1" face="Arial"><%=age%></font></td>
   </tr>
     <tr>
  	 <td width="100%" height="11" colspan="4" style="border-top-style: solid">
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;
      <p>&nbsp;
      <p>&nbsp;
      <p>&nbsp;<p>&nbsp;</td>
    </tr>
	</table>
<font size="2" face="Arial"><b>Prevention is better than cure</b></font> <font face="Kruti Dev 011" size="3">¼ bykt ls csgrj gS jksdFkke ½</font>
  </center>
</div>
<p align="center"><script>
document.write("<input type='button' " +
"onClick='window.print()' " +
"class='printbutton' " +
"value='Print This Page'/>");
</script>
</p>
</body>
</html>