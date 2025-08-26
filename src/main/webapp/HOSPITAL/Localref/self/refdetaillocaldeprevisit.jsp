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
<style type="text/css" media="print">
.printbutton 
  {
    visibility: hidden;
    display: none;
  }
</style>
</head>
<body>
<%@include file="/navbar.jsp" %>
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
	String hcode =request.getParameter("hcode");
	String desg ="";
	String dept ="";
	String ename ="";
	String referredto ="";
		
	
	
	
	
	 Connection conn  = null; 
	    Connection conn1  = null;    
	    try 
	        {
	    	conn = DBConnect.getConnection();
	    	conn1 = DBConnect.getConnection1();
	    	
	    	
           Statement stmt=conn.createStatement();
           Statement stmt1=conn1.createStatement();
           
	       ResultSet rs1 = stmt1.executeQuery("select a.ename, a.DESIGNATION, c.DISCIPLINENAME from employeemaster a, FURNITUREDEPT b, FURNITUREDISCIPLINE c where a.DEPTCODE=b.DEPTCODE and b.SECTIONCODE=c.DISCIPLINECODE and a.empn="+empn+"");
              while(rs1.next())
	             {
	                 ename=rs1.getString(1);
	                 desg= rs1.getString(2);
	                 dept= rs1.getString(3);
	                
	             }
	   
	        ResultSet rs2 = stmt.executeQuery("select hname,to_char(sysdate,'yyyy'),to_char(sysdate,'dd-mm-yyyy') from LOCALHOSPITAL where hcode='"+hcode+"'");
               while(rs2.next())
                    {
                        referredto=rs2.getString(1);
                        yr=rs2.getString(2);
                        refdt1=rs2.getString(3);
                    }  
                    
                  /*   System.out.println("refno .................................................... current="+refno);
                	System.out.println("name="+name);
                	System.out.println("empn="+empn);
                	System.out.println("relation="+relation);
                	System.out.println("age="+age);
                	System.out.println("refdt="+refdt);
                	System.out.println("sex: " +sex);
                	System.out.println("disease="+disease);
                	System.out.println("referto="+referto);
                	System.out.println("referby="+referby);
                	System.out.println("ename="+ename);
                	System.out.println("desg="+desg);
                	System.out.println("dept="+dept);
                	System.out.println("referredto="+referredto);
                	System.out.println("yr="+yr);
                	System.out.println("refdt1="+refdt1); */
     
           ResultSet rs = stmt.executeQuery("insert into LOACALREFDETAIL"+yr+"(REFNO,PATIENTNAME,EMPN,REL,AGE,REFDATE,SEX,DISEASE,DOC,specialist,REVISITFLAG) values ('"+refno+"','"+name+"','"+empn+"','"+relation+"','"+age+"',to_char(sysdate,'dd-mm-yyyy'),'"+sex+"','"+disease+"','"+referby+"','"+hcode+"','Y')");
               while(rs.next())
	                {
	                }
               
              
               
          /* System.out.println("insert into LOACALREFDETAIL"+yr+"(REFNO,PATIENTNAME,EMPN,REL,AGE,REFDATE,SEX,DISEASE,DOC,specialist,REVISITFLAG) values ('"+refno+"','"+name+"','"+empn+"','"+relation+"','"+age+"',sysdate,'"+sex+"','"+disease+"','"+referby+"','"+referto+"','Y')"); */
	              
	   }
	  
     catch(SQLException e) 
        {
             while((e = e.getNextException()) != null)
             out.println(e.getMessage() + "<BR>");
        }
     
     finally
        {
             if(conn != null) 
               {
                   try
                        {
                             conn.close();
                             conn1.close();
                        }
                   catch (Exception ignored) {}
               }
        }
       //out.print("result is: "+ename); 
%>
<div align="center">
  
  <p>&nbsp;</p>
  <table border="0" width="80%" height="78%" style="border-style: solid; border-width: 1">
    <tr>
	<center>
      <td width="100%" height="101" style="border-style: solid; border-width: 1">
      <p align="center">&nbsp;&nbsp;&nbsp;&nbsp;
        <font face="Kruti Dev 011" size="5">us'kuy
        QfVZykbZtlZ fyfeVsM</font> </p>
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
	   <p align="center"><u><b><font face="Kruti Dev 010" size="5">jh&amp;foftV</font></b></u></p>
	   <p style="text-align:left;">
<font face="Kruti Dev 010">&nbsp;&nbsp;vkjafHkd dze la0</font><font face="Arial" size="2">:&nbsp;<%= refno%></font>&nbsp;&nbsp;&nbsp;&nbsp;
        <font face="Kruti Dev 010">fnukad</font><font face="Arial" size="2">: <%=refdt%></font>
<span style="float:right;"><font face="Kruti Dev 010">jh&amp;foftV fnukad %</font><%=refdt1%>&nbsp;&nbsp;&nbsp;</span>
</p>
	   
        
        
		
        <p style="line-height: 150%"><font face="Arial" size="2">&nbsp;&nbsp;Sh/Smt/Mr/Ms :&nbsp;<b><%= name%></b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <font face="Arial" size="2"><b><%=relation%></b>&nbsp;&nbsp;&nbsp;&nbsp;of Mr/Ms
        :<b>&nbsp;<%=ename%> </b> </font>&nbsp;<font face="Arial" size="2">Designation :&nbsp;<b><%= desg%></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Deptt :&nbsp;<b><%=dept%></b>&nbsp;&nbsp;<font face="Arial"><font size="2">
        E.Code :&nbsp;<b><%=empn%></b></font>&nbsp;&nbsp;referred to &nbsp;&nbsp;</font><b><%=referredto%>&nbsp;</b>for&nbsp;&nbsp;<b><%=disease%></b>&nbsp;&nbsp;&nbsp;.</p>
        <br/>
		<br/>
        <p align="right"> <b>Senior Chief Medical Officer / Medical Officer &nbsp;&nbsp;&nbsp;</b></p>
        
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
</p>

</body>

</html>