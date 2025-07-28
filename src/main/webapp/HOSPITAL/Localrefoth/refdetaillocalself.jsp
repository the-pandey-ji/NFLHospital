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
	String yr = "";
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
	String ename="";
	String referredto ="";
	
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
	       ResultSet rs2 = stmt.executeQuery("select hname,format(Now(),'yyyy') from LOCALHOSPITAL where hcode='"+referto+"'");
           while(rs2.next())
                    {
                        referredto=rs2.getString(1);
                        yr=rs2.getString(2);
                    } 
     
           ResultSet rs = stmt.executeQuery("insert into LOACALREFDETAIL"+yr+"(REFNO,PATIENTNAME,EMPN,REL,AGE,REFDATE,SEX,DISEASE,DOC,specialist,REVISITFLAG) values('"+refno+"','"+name+"','"+empn+"','"+relation+"','"+age+"','"+refdt+"','"+sex+"','"+disease+"','"+referby+"','"+referto+"','N')");
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
        QfVZykbZtlZ fyfeVsM</font><font face="Kruti Dev 011"> </font></p>
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
        <p style="text-align:left;"><font face="Kruti Dev 011">dze la0</font><font face="Arial" size="2">: &nbsp;<%=refno%></font>
		<span style="float:right;">
        <font face="Kruti Dev 011">fnukad</font><font face="Arial" size="2">: <%=refdt%></font>&nbsp;&nbsp;&nbsp; </span></p>
        <p style="line-height: 150%"><font face="Arial" size="2">&nbsp;&nbsp;</font>Sh/Smt/Mr/Ms<font face="Arial" size="2"> 
        &nbsp;<b><%= name%></b></font>&nbsp;&nbsp;&nbsp;Relation <b>&nbsp;<%=relation%></b>&nbsp;&nbsp;Employee Name&nbsp; <b>&nbsp;<b><%=ename%></b>&nbsp;&nbsp;<font face="Arial"><font size="2"> </font></font>
        </b>
        E.Code<font size="2" face="Arial"> :<b>&nbsp;<b><%=empn%></b></b></font>
        <font face="Arial">&nbsp;&nbsp;</font>referred<font face="Arial"> to&nbsp;</font>
        <b><%=referredto%></b>&nbsp;for&nbsp;<%=disease%></b>&nbsp;&nbsp;&nbsp;.</p><br/><br/><br/>
        <p align="right"> <b>Senior Chief Medical Officer / Medical Officer &nbsp;&nbsp;&nbsp;</b></p>
       
<!--
	   <p><font face="Kruti Dev 011" size="3"><b>fVIi.kh %</b></font></p>
        <font face="Arial" size="2">
        <div align="center">
          <table border="0" width="101%">
            <tr>
              <td width="100%">
        <ol>
          <li><font face="Kruti Dev 011">bl Kkiu ds tkjh gksus ds 4 fnuksa ds
            vUnj ijke'kZ ds fy, tkuk pkfg, A</font></li>
          <li><font face="Kruti Dev 011">ikuhir ds fo'ks&quot;kKksa ds ikl tkus
            ds fy, Kkiu ds tkjh gksus dh frfFk ls 4 fnuksa rd iqu% funsZ'k dh
            vko';drk ugh gS A</font></li>
          <li><font face="Kruti Dev 011">ikuhir ls ckgj tkus ds fy, 30 fnuks rd
            iqu % funsZ'k dh vko';drk ugh gS A</font></li>
          <li>
            <p align="left"><font face="Kruti Dev 011">,u- ,Q- ,y- Vkmuf'ki ls ckgj jgus okys
            deZpkfj;ksa ;k mu ij vkfJr ifjokj ds lnL;ksa dh ;fn ikuhir ds ckgj
            ls gLirkyksa esa fo'ks&quot;kK mipkj dh vko';drk iM+rh&nbsp;&nbsp; gSA rks os
            viuk dsl dEiuh ls jSQj djok dj tk,axsA</font></li>
        </ol>
              </td>
            </tr>
          </table>
        </div>   
  
        </font>    
		-->
		
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