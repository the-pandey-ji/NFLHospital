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
<title>Dependent Slip</title>
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
	String depname = request.getParameter("depnm");
	String empn = session.getAttribute("eno").toString();
	int emp=Integer.parseInt(empn);
	String dname = "";
	String ename = "";
	String relation = "";
	String age = "";
	String age1 = "";
	String srno ="";
	int sr1=0,sr2=0;
	String sex="";
	String sexcode="";
	String dt="";
	String typ = "N";
	
	//out.print("result is: "+emp);
  
    String dataSourceName = "hosp";
    String dbURL = "jdbc:odbc:"+ dataSourceName;
				
    Connection conn  = null;    
    try 
        {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           conn = DriverManager.getConnection(dbURL,"","");
           Statement stmt=conn.createStatement();
  
	       ResultSet rs = stmt.executeQuery("select a.dname, a.sex, a.relation, format(Date(),'yyyy') - format(birthyear,'yyyy'), format(Date(),'dd-mmm-yyyy') FROM dependents a where a.dname ='"+depname+"' and a.empn="+emp+"");
           while(rs.next())
	            {
	                 dname = rs.getString("dname");
	                 relation = rs.getString("relation");
	                 age = rs.getString(4);
	                 sex = rs.getString("sex");
	                 dt = rs.getString(5);
	            }
	       age1=age.substring(0,age.length()-2);
	       	       
           ResultSet rs1 = stmt.executeQuery("select ename FROM employeemaster where empn="+emp+"");
           while(rs1.next())
	            {
	                 ename = rs1.getString("ename");
	            } 
	
	       ResultSet rs4 = stmt.executeQuery("select max(srno)+1 from opd");
	       while(rs4.next())
	            {
	                 srno = rs4.getString(1);
	            }
	        
           ResultSet rs3 = stmt.executeQuery("insert into opd(srno,patientname,relation,age,opddate,sex,empn,typ) values('"+srno+"','"+dname+"','"+relation+"','"+age1+"','"+dt+"','"+sex+"','"+empn+"','N')");
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
  <table border="0" width="80%" height="70%" style="border-style: solid; border-width: 1">
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
    <tr>
    <td width="20%" height="1"><font size="1" face="Arial"><b>Sr. No.</b></font> <font face="Kruti Dev 011" size="2"> Øe la[;k </font> :  </td>
   	 <td width="20%" height="1"><font size="1.25" face="Arial"><b><%=srno%></b></font></td>
 	 <td width="30%" height="1"><font size="1" face="Arial"><b>Date</b></font><font face="Kruti Dev 011" size="2"> rkjh[k</font> : </td>
   	 <td width="30%" height="1"><font size="1" face="Arial"><%=dt%></font></td>
    </tr>
    <tr>
    <td width="20%" height="1"><b><font face="Arial" size="1">Name</font></b><font face="Kruti Dev 011" size="2"> uke</font> :</td>
   </center>
   	 <td width="20%" height="1">
     <p align="left"><font size="1"><%=dname%></font></td>
   <center>
   	 <td width="30%" height="1"><b><font face="Arial" size="1">Relation</font></b><font face="Kruti Dev 011" size="2"> laca/k</font> :</td>
   	 <td width="30%" height="1"><font size="1"><%=relation%></font></td>
    </tr>
     <tr>
  	 <td width="25%" height="1"><b><font face="Arial" size="1">E. Code</font></b><font face="Kruti Dev 011" size="2"> deZpkjh la[;k</font> :</td>
  	 <td width="15%" height="1"><font size="1.25" face="Arial"><%=empn%></font></td>
  	 <td width="30%" height="1"><b><font face="Arial" size="1">E. Name</font></b><font face="Kruti Dev 011" size="2"> deZpkjh uke</font> :</td>
  	 <td width="30%" height="1"><font size="1"><%=ename%></font></td>
    </tr>
     <tr>
  	 <td width="20%" height="1"><b><font face="Arial" size="1">Sex</font></b><font face="Kruti Dev 011" size="2"> fyax</font> :</td>
  	 <td width="20%" height="1"><font size="1"><%=sex%></font></td>
  	 <td width="30%" height="1"><b><font face="Arial" size="1">Age</font></b><font face="Kruti Dev 011" size="2"> vk;q</font> :</td>
  	 <td width="30%" height="1"><font size="1"><%=age1%></font></td>
   </tr>
     <tr>
  	 <td width="100%" height="11" colspan="4" style="border-top-style: solid">
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;
      <p>&nbsp;
      <p>&nbsp;
      <p>&nbsp;
      <p>&nbsp;<p>&nbsp;</td>
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
</p>
</body>
</html>