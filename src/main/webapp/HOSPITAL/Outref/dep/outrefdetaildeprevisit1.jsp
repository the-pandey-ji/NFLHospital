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
    
    if(escort.equals("Y"))
	   {
	      escorta="Yes";
	   }
	else 
	   {
	      escorta="No";
       }
   %>
  <!-- alert(<%=refno%>, <%=name%>, <%=refno%>, <%=empn%>, <%=relation%>, <%=age%>, <%=refdt%>, <%=sex%>, <%=disease%>, <%=referto%>, <%=referby%>, <%=escort%> );-->
   
   <%
   String dataSourceName = "hosp";
    String dbURL = "jdbc:odbc:"+ dataSourceName;
				
    Connection conn  = null;    
    try 
        {
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           conn = DriverManager.getConnection(dbURL,"","");
           Statement stmt=conn.createStatement();

           ResultSet rs1 = stmt.executeQuery("select a.ename, a.DESIGNATION, c.DISCIPLINENAME from employeemaster a, FURNITUREDEPT b, FURNITUREDISCIPLINE c where a.DEPTCODE=b.DEPTCODE and b.SECTIONCODE=c.DISCIPLINECODE and a.empn="+empn+"");
            while(rs1.next())
	             {
	                 ename=rs1.getString(1);
	                 desg= rs1.getString(2);
	                 dept= rs1.getString(3);
	             }
       
           ResultSet rs2 = stmt.executeQuery("select hname from OUTSTATIONHOSPITAL where hcode='"+referto+"'");
             while(rs2.next())
                 {
                     referredto=rs2.getString(1);   
                 } 
           ResultSet rs3 = stmt.executeQuery("insert into outrefdetail(REFNO, PATIENTNAME, EMPN, REL, AGE, REFDATE, SEX, HOSPITAL, DISEASE, DOC, ESCORT) values ('"+refno+"','"+name+"','"+empn+"','"+relation+"','"+age+"','"+refdt+"','"+sex+"','"+referto+"','"+disease+"','"+referby+"','"+escort+"')");
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
<div align="center">
  <center>
  <table border="0" width="59%" height="491" style="border-style: solid; border-width: 1">
    <tr>
      <td width="100%" height="7" style="border-style: solid; border-width: 1">
      <p align="center">
        <font face="Kruti Dev 011" size="5">us'kuy QfVZykbZtlZ fyfeVsM</font></p>
        <p align="center" style="line-height: 100%; margin-top: 0; margin-bottom: 0">
        <font face="Kruti Dev 011" size="3">ikuhir bdkbZ % fpfdRlk foHkkx</font></p>
        <p align="center" style="line-height: 100%; margin-top: 0; margin-bottom: 0">
        <font face="Kruti Dev 011" size="4">funsZ'k&amp;iphZ</font></p>
      </td>
    </tr>
    <tr>
      <td width="100%" height="510">
        <p><font face="Kruti Dev 010">&nbsp;&nbsp;</font><font face="Kruti Dev 011">dze la0</font><font face="Kruti Dev 010"> </font><font face="Arial" size="2">: &nbsp;<%= refno%></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <font face="Kruti Dev 010">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font>
        <font face="Kruti Dev 011">fnukad </font><font face="Arial" size="2">: <%=refdt%></font></p>
        <p style="line-height: 150%"><font face="Arial" size="2">&nbsp;&nbsp;Sh/Smt/Mr/Ms :&nbsp;<b><%= name%></b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <font face="Arial" size="2"><b><%=relation%></b>&nbsp;&nbsp;&nbsp;&nbsp;of Mr/Ms
        :<b>&nbsp;<%=ename%> </b> </font>&nbsp;
        <font face="Arial" size="2">Designation :&nbsp;<b><%= desg%></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Deptt :&nbsp;<b><%=dept%></b>&nbsp;&nbsp;
        <font face="Arial"><font size="2">E.Code :&nbsp;<b><%=empn%></b></font>&nbsp;&nbsp;referred to &nbsp;&nbsp;</font>
        <b><%=referredto%>&nbsp;</b>for&nbsp;&nbsp;<b><%=disease%></b>&nbsp;&nbsp;&nbsp;.</p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </font>
        <font face="Arial">&nbsp;</font></p>
        <p><font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        Sr. Chief Medical Officer / Medical Officer</p>
        </font>
        <font face="Arial" size="2">
        <p><font face="Kruti Dev 011" size="3">fVIi.kh %</font></p>
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
            iqu % funsZ'k dh vko';drk ugh&nbsp; gS A</font></li>
          <li><font face="Kruti Dev 011">ikuhir ls ckgj ds izkbZosV gLirkyksa ls
            ;fn dksbZ ySc VSLV@,Dljs djok;k tkrk gS&nbsp;&nbsp; pkgs og bykt dj jgs
            vuqeksfnr gLirky ds MkDVj dh lykg ij gh D;ksa u gks] bldh izfriwfrZ
            ugha dh tk,xhA blds fy, eq[; fpfdRlk vf/kdkjh dh iwoZ vuqefr ysuh
            gksxhA</font></li>
          <li>
            <p align="left"><font face="Kruti Dev 011">,u- ,Q- ,y- Vkmuf'ki ls ckgj jgus okys
            deZpkfj;ksa ;k mu ij vkfJr ifjokj ds lnL;ksa dh ;fn ikuhir ds ckgj
            ls gLirkyksa esa fo'ks&quot;kK mipkj dh vko';drk iM+rh&nbsp; gSA rks os
            viuk dsl dEiuh ls jSQj djok dj tk,axsA</font></li>
           </ol>
              </td>
            </tr>
          </table>
        </div>
      </center>
        </td>
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