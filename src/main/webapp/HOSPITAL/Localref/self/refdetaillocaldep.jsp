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
 <%
	String yr = "";
	String refno = request.getParameter("refno");
	String name = request.getParameter("name");
	String empn = request.getParameter("empn");
	String relation = request.getParameter("relation");
	String age = request.getParameter("age");
	String refdt = request.getParameter("refdt");
	String refdt1 = request.getParameter("refdt1");
	String sex = request.getParameter("sex");
	String disease = request.getParameter("disease");
	String referto = request.getParameter("referto");
	String referby = request.getParameter("referby");
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
           
           Statement stmt1=conn1.createStatement(); //for employeemaster
    
	       ResultSet rs1 = stmt1.executeQuery("select a.ename, a.DESIGNATION, c.DISCIPLINENAME from employeemaster a, FURNITUREDEPT b, FURNITUREDISCIPLINE c where a.DEPTCODE=b.DEPTCODE and b.SECTIONCODE=c.DISCIPLINECODE  and a.oldnewdata='N' and onpayroll='A' and a.empn="+empn+"");
            while(rs1.next())
	             {
	                 ename=rs1.getString(1);
	                 desg= rs1.getString(2);
	                 dept= rs1.getString(3);
	             }
            
           /*  System.out.println("ename: " + ename);
            System.out.println("desg: " + desg);
            System.out.println("dept: " + dept); */
	   
            Statement stmt2=conn.createStatement();  //for localhospital
	       ResultSet rs2 = stmt2.executeQuery("select hname,to_char(sysdate,'yyyy') from LOCALHOSPITAL where hcode='"+referto+"'");
               while(rs2.next())
                    {
                        referredto=rs2.getString(1);
                        yr=rs2.getString(2);

                    } 
               
        System.out.println("referredto: " + referredto);
     
           ResultSet rs = stmt2.executeQuery("insert into LOACALREFDETAIL"+yr+"(REFNO,PATIENTNAME,EMPN,REL,AGE,REFDATE,SEX,DISEASE,DOC,specialist,REVISITFLAG) values ('"+refno+"','"+name+"','"+empn+"','"+relation+"','"+age+"',sysdate,'"+sex+"','"+disease+"','"+referby+"','"+referto+"','N')");
               while(rs.next())
	                {
	                }
	              
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
  <center>
  <p style="margin-bottom: -1">&nbsp;</p>
  <table border="0" width="80%" height="70%" style="border-style: solid; border-width: 1">

<!--   
 <tr>
      <td width="100%" height="7" style="border-style: solid; border-width: 1">
      <p align="center">&nbsp;&nbsp;&nbsp;&nbsp;
        <font face="Kruti Dev 011" size="5">us'kuy
        QfVZykbZtlZ fyfeVsM</font> </p>
        <p align="center" style="line-height: 100%; margin-top: 0; margin-bottom: 0">
        <font face="Kruti Dev 011" size="3">ikuhir
        bdkbZ % fpfdRlk foHkkx</font></p>
        <p align="center" style="line-height: 100%; margin-top: 0; margin-bottom: 0">
        <font face="Kruti Dev 011" size="4">funsZ'k&amp;iphZ</font></p>
      </td>
    </tr>
-->
<tr>
<td width="5%" height="7" style="border-style: solid; border-width: 1">
<img src="NFL.jpg" alt="NFL" >
</td>
     <td width="95%" height="19" style="border-bottom-style: solid">
     <!-- <p align="center"><b><font size="3" color="#003300">NFL Hospital, Panipat </font><font size="3">OPD SLIP</font></b> -->

<p align="center" >
        <font face="Kruti Dev 011" size="5"><b>us'kuy QfVZykbtlZ fyfeVsM </b></font> <br/><font face="Kruti Dev 011" size="4">,u-,Q-,y- fpfdRlky;] ikuhir </font>
<br/><font face="Kruti Dev 011" size="3">funsZ'k&amp;iphZ</font>&nbsp;(<font face="Arial" size="1.5"><b>REFERRAL-SLIP</b>&nbsp;</font>) </p>
</td>
</tr>
    <tr>
     <td width="100%" style="border-style: solid; border-width: 0; vertical-align: top;" colspan="2">
	 
	 <p style="text-align:left;">
<font face="Kruti Dev 010">&nbsp;&nbsp;dze la0</font><font face="Arial" size="2">:&nbsp;<%= refno%></font>
<span style="float:right;"><font face="Kruti Dev 010">&nbsp;fnukad</font><font face="Arial" size="2">: <%=refdt%> &nbsp;&nbsp;&nbsp;</font></span>
</p>	 
        
        <p style="line-height: 150%"><font face="Kruti Dev 010" size="3">Jh@Jherh@Jheku@lqJh</font><font face="Arial" size="2">&nbsp;Sh/Smt/Mr/Ms :&nbsp;<%= name%></font>&nbsp;&nbsp;&nbsp;
        <font face="Kruti Dev 010" size="3">laca/k</font>:&nbsp;<font face="Arial" size="2"> relation :&nbsp;<%=relation%> &nbsp;&nbsp; of &nbsp;&nbsp;<font face="Kruti Dev 010" size="3">Jheku@Jherh</font>:&nbsp; Mr/Ms
        :&nbsp;<%=ename%>  </font>&nbsp;<font face="Kruti Dev 010" size="3">inuke</font>&nbsp;&nbsp;<font face="Arial" size="2">Designation :&nbsp;<%= desg%>&nbsp;&nbsp;<font face="Kruti Dev 010" size="3">foHkkx</font>&nbsp;&nbsp;Deptt :&nbsp;<%=dept%>&nbsp;<font face="Kruti Dev 010" size="3">deZpkjh la[;k</font>&nbsp;<font face="Arial"><font size="2">
        E.Code :&nbsp;<%=empn%></font>&nbsp;<font face="Kruti Dev 010" size="3">dks jsQj</font>&nbsp;referred to &nbsp;&nbsp;</font>&nbsp;<%=referredto%>&nbsp;for&nbsp;&nbsp;<%=disease%>&nbsp;&nbsp;<font face="Kruti Dev 010" size="3">fd;k tkrk gS</font>.</p>
        <br/>
		<br/>
		<br/>
        <p align="right"> 
<!-- <b> Senior Chief Medical Officer / Medical Officer </b> -->
<font face="Kruti Dev 010" size="4">ofj"B eq[; fpfdRlk vf/kdkjh @ fpfdRlk vf/kdkjh</font>
&nbsp;&nbsp;&nbsp;</p>
      
        </td>
    </tr>
<tr>
  	 <td width="100%" height="11" colspan="2" >
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>  
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
      </td>
    </tr>
	<tr> 
<td colspan="2"><left> <font face="Kruti Dev 010" size="3">uksV%& <br/> 1- jsQj gLirky@M‚DVj ds ikl bykt ds fy, tkus ls igys gLirky ls jsV~l ,oa fMLdkmaV dh tkudkjh vo'; ys ysaosA
<br/>
2- gLirky@fDyfud ds dkmaVj ij ,u-,Q-,y- dk vkbZ Mh dkMZ@gLirky dh esfMdy cqd &nbsp; fn[kkuk vfuok;Z gSA
<br/>
3- bl jsQj fLyi ds tkjh gksus ds 10 fnu ds vUnj ijke'kZ ysuk t#jh gSA
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