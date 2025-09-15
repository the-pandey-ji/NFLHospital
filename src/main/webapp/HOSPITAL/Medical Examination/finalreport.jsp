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
<%@ page import="com.DB.DBConnect" %>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Registration for NFL Employee</title>
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
	    String meno = request.getParameter("meno");
        String hb  = request.getParameter("T1");	
        String alb  = request.getParameter("T2");
        String sugar  = request.getParameter("T3");
        String bloodgrp  = request.getParameter("T4"); 
        String xray  = request.getParameter("T5");
        String ecg  = request.getParameter("T6");
        String other  = request.getParameter("T7");
        String pulse  = request.getParameter("T8");
        String bp  = request.getParameter("T9");
        String heart  = request.getParameter("T10");
        String lung  = request.getParameter("T11");
        String abdomen  = request.getParameter("T12");
        String otherprob  = request.getParameter("T13");
        String hernia  = request.getParameter("T14");
        String hydrocele  = request.getParameter("T15");
        String piles  = request.getParameter("T16");
        String othersur  = request.getParameter("T17");
        String nearvi  = request.getParameter("T18");
        String distantvi  = request.getParameter("T19");
        String colorvi  = request.getParameter("T20");
        String ent  = request.getParameter("T21");
        String gynae  = request.getParameter("T22"); 
        String remarks  = request.getParameter("T24");
        String status  = request.getParameter("T25");
		String dept  = request.getParameter("T26");
		String ht  = request.getParameter("D1");
	 	String wt  = request.getParameter("T28");
        String name = "";
		int empn = 0;
	 	String dt = "";
		String sex = "";
		String age = "";
		
    
    Connection conn  = null;    
    try 
        {
           conn = DBConnect.getConnection();
           Statement stmt=conn.createStatement();
           
	       ResultSet rs = stmt.executeQuery("select Format(dated,'dd-mm-yyyy'), name,empn,sex,age from medexam where meno="+meno);
           while(rs.next())  
              {
                   dt = rs.getString(1);
                   name = rs.getString(2);
                   empn = rs.getInt(3);
                   sex = rs.getString(4);
                   age = rs.getString(5);
              }
         
     }//end of try block

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
                  }
               catch (Exception ignored) {}
            }
      }
  Connection conn1  = null;    
  try 
     {
              conn1 = DBConnect.getConnection();
           Statement stmt=conn1.createStatement();
           ResultSet rs1 = stmt.executeQuery("update MEDEXAM set DEPT='"+dept+"', HB='"+hb+"', ALB='"+alb+"', SUGAR='"+sugar+"', BLOODGRP='"+bloodgrp+"', XRAY='"+xray+"', ECG='"+ecg+"', OTHERINV='"+other+"', PULSE='"+pulse+"', BP='"+bp+"', HEART='"+heart+"', LUNG='"+lung+"', ABDOMEN='"+abdomen+"', OTHERMED='"+otherprob+"', HERNIA='"+hernia+"', HYDROCELE='"+hydrocele+"', PILES='"+piles+"', OTHERSUR='"+othersur+"', NEARVI='"+nearvi+"', DISTANTVI='"+distantvi+"', COLORVI='"+colorvi+"', ENT='"+ent+"', GYOBFEMALE='"+gynae+"', REMARKS='"+remarks+"', STATUS ='"+status+"', HEIGHT='"+ht+"', WEIGHT='"+wt+"' where meno="+meno);
     }//end of try block

 catch(SQLException e) 
   {
       while((e = e.getNextException()) != null)
       out.println(e.getMessage() + "<BR>");
   }

 finally
      {
          if(conn1 != null) 
            {
               try
                  {
                      conn1.close();
                  }
               catch (Exception ignored) {}
            }
      }
      
%>
 <p style="line-height: 70%; margin-top: 0; margin-bottom: -9" align="center">&nbsp;</p>
 <p style="line-height: 70%; margin-top: 0; margin-bottom: -9" align="left"><b>
 <font face="Times New Roman">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; National
 Fertilizers Limited</font></b></p>
 <p style="line-height: 70%; margin-bottom: -8" align="left"><b>
 <font face="Times New Roman">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Panipat
 Unit: Medical department</font></b></p>
 <p style="line-height: 70%; margin-bottom:0" align="left"><b><font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Medical
 Examination Proforma</font></b></p>
 <div align="center" style="width: 724; height: 712">
  
  <table border="1" width="81%" height="53">
    <tr>
      <td width="50%" height="18" align="center" style="border-style: solid; border-width: 1" colspan="2">
        <p align="left">Med. Exam. Date : <%=dt%></td>
  <center>
      <td width="50%" height="18" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Med.Exam. No. :<%=meno%></font></td>
    </tr>
    <tr>
      <td width="5%" height="18" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">1.</font></td>
      <td width="45%" height="18" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Name</font></td>
      <td width="50%" height="18" style="border-style: solid; border-width: 1"><font face="Arial" size="2"><%=name%></font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">2.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">E.
        Code</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2"><%=empn%></font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">3.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Department</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2"><%=dept%></font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">4.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Age&nbsp;&nbsp;</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2"><%=age%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%=sex%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1">
      <font face="Arial" size="2">5.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Height</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><%=ht%><font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Weight &nbsp;&nbsp;
      <%=wt%></font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">
      6.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Investigation</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)
        Hb.</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><%=hb%></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)
        Urine</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">
      <font face="Arial" size="2">Alb.&nbsp;&nbsp;<b><%=alb%></b></font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Sugar&nbsp;&nbsp;<b><%=sugar%></b></font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)
        Blood Group</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=bloodgrp%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">d)
        X-ray Chest</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=xray%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">e)
        E.C.G. above 40 years</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=ecg%></b></td>
    </tr>
    <tr>
      <td width="5%" height="22" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="22" style="border-style: solid; border-width: 1"><font face="Arial" size="2">f)
        Any other investigation if required</font></td>
      <td width="50%" height="22" style="border-style: solid; border-width: 1"><b><%=other%></b></td>
    </tr>
    <tr>
      <td width="5%" height="20" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">
      7.</font></td>
      <td width="45%" height="20" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Medical</font></td>
      <td width="50%" height="20" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)
        Pulse</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=pulse%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)
        B.P.</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=bp%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)
        Heart</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=heart%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">d)
        Lung</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=lung%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">e)
        Abdomen</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=abdomen%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">f)
        Any other Medical Problem</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=otherprob%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">
      8.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Surgical</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)
        Hernia</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=hernia%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)
        Hydrocele</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=hydrocele%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)
        Piles</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=piles%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">d)
        Any other surgical problem</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=othersur%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">
      9.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)
        Near Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=nearvi%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)
        Distant Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=distantvi%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)
        Colour Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=colorvi%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">10.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">E.
        N. T. Check up</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=ent%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">11.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Gynae
        &amp; Obst checkup for females</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><b><%=gynae%></b></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">
      12.</font></td>
      <td width="45%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Remarks :<b><%=remarks%></b></font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Fit/Unfit/Need Treatment/Any other : <b><%=status%></b></font></td>
    </tr>
  </table>
   </center>
 </div>
 <p align="left" style="margin-bottom: 0">&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 (Medical Officer)</p>
 <p style="margin-bottom: -10; margin-top:0">&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NFL Hospital, Panipat Unit</p>
 <p style="margin-bottom: -10; margin-top:0">&nbsp;</p>
 <p style="margin-top: 5; margin-bottom: 0">&nbsp;<i>Note:
 After completion of Med. Exam., this is to be deposited at Hospital
 reception/office for record</i></P>
 <p align="center"><script>
document.write("<input type='button' " +
"onClick='window.print()' " +
"class='printbutton' " +
"value='Print This Page'/>");
 </script>
</p>
</body>
</html>