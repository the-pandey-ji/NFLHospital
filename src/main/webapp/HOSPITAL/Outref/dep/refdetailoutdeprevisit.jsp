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
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Reference No</title>
</head>
<body>

<%@ include file="/navbar.jsp" %>

<%
	String yr = "";
	String refno = request.getParameter("refno");
	String name = request.getParameter("name");
	String empn = request.getParameter("empn");
	String relation = request.getParameter("relation");
	String age = request.getParameter("age");
	String refdt = request.getParameter("refdt");
	String refdt1 = "";
	String sex = request.getParameter("sex");
	String disease = request.getParameter("disease");
	String referto = request.getParameter("referto");
	String referby = request.getParameter("referby");
	String escort = request.getParameter("escort");
	String hcode = request.getParameter("hcode");
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
 
   
   <%
      Connection conn  = null; //for hospital
         Connection conn1  = null; //for employee
         
         
         try 
             {
         	conn = DBConnect.getConnection();
         	conn1 = DBConnect.getConnection1();
 
      	Statement stmt = conn.createStatement();
      	Statement stmt1 = conn1.createStatement();
      	


      	/* ResultSet rs1 = stmt1.executeQuery("select a.ename, a.DESIGNATION, c.DISCIPLINENAME from employeemaster a, FURNITUREDEPT b, FURNITUREDISCIPLINE c where a.DEPTCODE=b.DEPTCODE and b.SECTIONCODE=c.DISCIPLINECODE and a.empn="+empn); */
    	ResultSet rs1 = stmt1.executeQuery("select a.ename, a.DESIGNATION, c.DISCIPLINENAME from employeemaster a, FURNITUREDEPT b, FURNITUREDISCIPLINE c where a.DEPTCODE=b.DEPTCODE and b.SECTIONCODE=c.DISCIPLINECODE and a.empn='" + empn + "'");
   
      	while (rs1.next()) {
      		ename = rs1.getString(1);
      		desg = rs1.getString(2);
      		dept = rs1.getString(3);
      	}

      	System.out.println("Refer to:"+hcode);

		ResultSet rs2 = stmt.executeQuery("select hname, to_char(sysdate,'yyyy'), to_char(sysdate,'dd-mm-yyyy') from OUTSTATIONHOSPITAL where hcode='" + hcode + "'");

      	while (rs2.next()) {
      		referredto = rs2.getString(1);
      		yr = rs2.getString(2);
      		refdt1 = rs2.getString(3);
      	}
      	
      	System.out.println("date:"+refdt1);
      	System.out.println("year:"+yr);
      	System.out.println("referred to:"+referredto);
      	
      	ResultSet rs3 = stmt.executeQuery("insert into outrefdetail"+yr+"(REFNO, PATIENTNAME, EMPN, REL, AGE, REFDATE, SEX, HOSPITAL, DISEASE, DOC, ESCORT,REVISITFLAG) values ('"+refno+"','"+name+"','"+empn+"','"+relation+"','"+age+"',to_char(sysdate,'dd-mm-yyyy'),'"+sex+"','"+referto+"','"+disease+"','"+referby+"','"+escort+"','Y')");

		

      	//ResultSet rs3 = stmt.executeQuery("insert into outrefdetail"+yr+"(REFNO, PATIENTNAME,EMPN,REL,AGE,REFDATE, SEX, HOSPITAL, DISEASE, DOC,ESCORT,REVISITFLAG) values ('"+refno+"','"+name+"','"+empn+"','"+relation+"','"+age+"',to_char(sysdate,'dd-mm-yyyy'),'"+sex+"','"+disease+"','"+referby+"','"+hcode+"','"+escort+"','Y')");

      	while (rs3.next()) {
      	}

      } catch (SQLException e) {
      	while ((e = e.getNextException()) != null)
      		out.println(e.getMessage() + "<BR>");
      }  finally {
      	if (conn != null) {
      		try {
      	conn.close();
      		} catch (Exception ignored) {
      		}
      	}
      }
      %>
<p>&nbsp;</p>
<div align="center">
  
 <table border="0" width="80%" height="78%" style="border-style: solid; border-width: 1">
    <tr>
	<center>
      <td width="100%" height="7" style="border-style: solid; border-width: 1">
      <p align="center">
        <font face="Kruti Dev 011" size="5">us'kuy QfVZykbZtlZ fyfeVsM</font></p>
        <p align="center" style="line-height: 100%; margin-top: 0; margin-bottom: 0">
        <font face="Kruti Dev 011" size="3">ikuhir bdkbZ % fpfdRlk foHkkx</font></p>
        <p align="center" style="line-height: 100%; margin-top: 0; margin-bottom: 0">
        <font face="Kruti Dev 011" size="4">funsZ'k&amp;iphZ</font></p>
      </td>
	  </center>
    </tr>
    <tr>
      <td width="100%" style="vertical-align: top;">
        <p align="center"><u><b><font face="Kruti Dev 010" size="5">jh&amp;foftV</font></b></u></p>
        <p style="text-align:left;"><font face="Kruti Dev 010">&nbsp;&nbsp;vkjafHkd dze la0</font><font face="Arial" size="2">:&nbsp;<%= refno%></font>&nbsp;&nbsp;&nbsp;&nbsp;
        <font face="Kruti Dev 010">fnukad</font><font face="Arial" size="2">: <%=refdt%>&nbsp;&nbsp;&nbsp; </font>
			<span style="float:right;">
        <font face="Kruti Dev 010">jh&amp;foftV fnukad %</font><%=refdt1%> &nbsp;&nbsp;&nbsp;</span></p>
        <p style="line-height: 150%"><font face="Arial" size="2">&nbsp;&nbsp;Sh/Smt/Mr/Ms :&nbsp;<b><%= name%></b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <font face="Arial" size="2"><b><%=relation%></b>&nbsp;&nbsp;&nbsp;&nbsp;of Mr/Ms
        :<b>&nbsp;<%=ename%> </b> </font>&nbsp;
        <font face="Arial" size="2">Designation :&nbsp;<b><%= desg%></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Deptt :&nbsp;<b><%=dept%></b>&nbsp;&nbsp;
        <font face="Arial"><font size="2">E.Code :&nbsp;<b><%=empn%></b></font>&nbsp;&nbsp;referred to &nbsp;&nbsp;</font>
        <b><%=referredto%>&nbsp;</b>for&nbsp;&nbsp;<b><%=disease%></b>&nbsp;&nbsp;&nbsp;.</p>
              </font>
      
        <br/>
		<br/>
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