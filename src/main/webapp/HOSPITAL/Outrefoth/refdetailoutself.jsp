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
<body>
<%
	String refno = request.getParameter("refno");
	String name = request.getParameter("name");
	String empn = request.getParameter("empn");
	String relation = request.getParameter("relation");
	String age = request.getParameter("age");
	String refdt = request.getParameter("refdt");
	String sex = request.getParameter("sex");
	String disease = request.getParameter("disease");
	String referto = request.getParameter("referto");
	String referby = request.getParameter("referby");
	String escort = request.getParameter("escort");
	String escorta="";
	String desg ="";
	String dept ="";
	String ename ="";
	String referredto ="";
	String referredto1 ="";
	
	if(escort.equals("Y"))
	   {
	      escorta="Yes";
	   }
	else 
	   {
	      escorta="No";
       }

    String dataSourceName = "hosp";
    String dbURL = "jdbc:odbc:"+ dataSourceName;
				
    Connection conn  = null;    
    try 
        {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           conn = DriverManager.getConnection(dbURL,"","");
           Statement stmt=conn.createStatement();
           
           ResultSet rs1 = stmt.executeQuery("select empname from opd where srno="+refno);
           while(rs1.next())
	             {
                     ename = rs1.getString("empname");
                     
                     if(ename==null)
                       {
                          ename="-";
                       }  
	             }
	       ResultSet rs2 = stmt.executeQuery("select hname,city from OUTSTATIONHOSPITAL where hcode='"+referto+"'");
           while(rs2.next())
                 {
                     referredto=rs2.getString(1); 
                     referredto1=rs2.getString(2);   
                 } 

           ResultSet rs = stmt.executeQuery("insert into outrefdetail(REFNO, PATIENTNAME, EMPN, REL, AGE, REFDATE, SEX, HOSPITAL, DISEASE, DOC, ESCORT) values('"+refno+"','"+name+"','"+empn+"','"+relation+"','"+age+"','"+refdt+"','"+sex+"','"+referto+"','"+disease+"','"+referby+"','"+escort+"')");
           
           while(rs.next())
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

<div align="center">
  <table border="0" width="80%" height="80%" style="border-style: solid; border-width: 1">
    <tr>
	 <center>
      <td width="100%" height="7" style="border-style: solid; border-width: 1">
        <p align="center">
        <font face="Kruti Dev 011" size="5">us'kuy
        QfVZykbZtlZ fyfeVsM</font><font face="Kruti Dev 011"> </font>
 
        <p align="center" style="line-height: 100%; margin-top: 0; margin-bottom: 0">
        <font face="Kruti Dev 011" size="3">ikuhir
        bdkbZ % fpfdRlk foHkkx</font></p>
        <p align="center" style="line-height: 100%; margin-top: 0; margin-bottom: 0">
        <font face="Kruti Dev 011" size="4">funsZ'k&amp;iphZ</font></p>
      </td>
	  </center>
    </tr>
    <tr>
      <td width="100%" style="vertical-align: top;">
        <p style="text-align:left;"><font face="Kruti Dev 011">dze la0 </font><font face="Arial" size="2">:&nbsp;<%= refno%></font>
		<span style="float:right;">
        <font face="Kruti Dev 011">&nbsp; fnukad </font><font face="Arial" size="2">:&nbsp;&nbsp; <%= refdt%></font>&nbsp;&nbsp;&nbsp; </span></p>
        <p style="line-height: 150%"><font face="Arial" size="2">&nbsp;&nbsp;Sh/Smt/Mr/Ms :&nbsp;<b><%= name%></b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </b> </font>&nbsp;<font face="Arial" size="2">Relation&nbsp;<B><%=relation%></b>&nbsp;&nbsp;Employee 
        Name&nbsp;<b><%=ename%></b>&nbsp;&nbsp;<font face="Arial"><font size="2">
        E.Code :&nbsp;<b><%=empn%></b></font>&nbsp;&nbsp;referred to &nbsp;&nbsp;</font>
        <b><%=referredto%>,<%=referredto1%></b>&nbsp;&nbsp;for&nbsp;&nbsp;<b><%=disease%></b>&nbsp;&nbsp;&nbsp;.</font></p>
        <p style="line-height: 150%"><font face="Arial" size="2">&nbsp; Escort Allowed:&nbsp;<b><%=escort%></b></p> <br/><br/><br/>
        <p align="right"> <b>Sr. Chief Medical Officer / Medical Officer &nbsp;&nbsp;&nbsp;</b></p>
        
        
  
        </td>
    </tr>
	<tr> 
<td><left> <font face="Kruti Dev 010" size="3">uksV%& <br/> 1- jsQj gLirky@MkWDVj ds ikl bZykt ds fy, tkus ls igys gLirky lsjsVl ,oa fMLdkmaV dh tkudkjh vo”; ysysosA
<br/>
2- gLirky@fDyfud ds dkmaVj ij ,u,Q,y dk vkbZ Mh dkMZ@gLirky dh esfMdy cqd fn[kkuk vfuok; ZgSA
<br/>
3- bl jsQj fLyi ds tkjh gksus ds 10 fnu ds vUnj ijke”kZ ysuk t:jh gSA
</font></center> </td>	
	</tr>
  </table>
</div>
<p align="center"><script>
document.write("<input type='button' " +
"onClick='window.print()' " +
"class='printbutton' " +
"value='Print This Page'/>");

</script>
</p></body>

</html>