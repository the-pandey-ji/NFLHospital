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
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">

<script language="JavaScript" src="../javascript/checkbr.js"></script>
<script language="JavaScript" src="../javascript/selectEmployee.js"></script>
<script language="JavaScript" src="../javascript/validate.js"></script>


<title>Test Report</title>
<style type="text/css" media="print">
</style>
</head>
<body bgcolor="#E6FFFF">
<p><img border="0" src="path1.jpg" align="left" width="236" height="161"></p>
<% 
	int report_no =0;
	String dt ="";
	String doctor_code ="";
    String doctor_name ="";
					
 Connection conn  = null;    
  try 
     {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	     conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.111.112:1521:orcl","hospital","hospital");
	     Statement stmt=conn.createStatement();
	     Statement stmt1=conn.createStatement();
	     ResultSet rs = stmt.executeQuery("select max(report_no),to_char(sysdate,'dd/mm/yy hh:mi PM') from testreport");
          while(rs.next())  
            {
               report_no = rs.getInt(1);
               dt= rs.getString(2);
               
            }
           if (report_no <1)
              {
                report_no=1;
              }
           else
              {
                report_no=report_no + 1;
              }
          
      
%>
 <p style="line-height: 70%; margin-top: -3; margin-bottom: -10" align="center"><font face="Arial">National Fertilizers Limited</font></p>
 <p style="line-height: 70%; margin-bottom: -10" align="center"><font face="Arial">Panipat Unit: Medical department</font></p>
 <p style="line-height: 70%" align="center"><b><font face="Arial">TEST REPORT DATA ENTRY</font></b></p>
 <p style="line-height: 70%" align="center">&nbsp;</p>
 <p style="line-height: 70%" align="center">&nbsp;</p>
 <div align="center">
  <form name="testreport" action="/hosp/HOSPITAL/jsps/savereport.jsp" method="post" >
      <p align="left"><font face="Arial">Report No.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font> <font face="Arial" size="2"> 
      <input name="reportno" type="text" value="<%=report_no%>" disabled="true" size="9" /></font>
      <font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date of Test</font>
      <font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      &nbsp;<input name="dt" type="text" value="<%=dt%>" disabled="true" size="16" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
      <font face="Arial">Medical Officer </font>
      <font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;
      <select size="1" name="doctor" id="doctor">
      <option value="0">--Select--</option>
  <%       
             ResultSet rs2 = stmt1.executeQuery("select code, doctor_name from doctor where status='A'");
               while(rs2.next())
                    {
  %>
                       <option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option>
  <%
                    }
           } //end of try block
      
       

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
      </select></font></p>
      <p align="left"><font face="Arial">Empn</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <font face="Arial" size="2"> &nbsp;&nbsp;&nbsp; 
      <input name="empn" id="empn" type="text" size="9" onblur="getdata();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font>
      <font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp; Name</font><font face="Arial" size="2"> 
      <input name="ename" id="ename"  type="text" value="" size="28" disabled="true"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font>
      <font face="Arial">Designation</font><font face="Arial" size="2">&nbsp; 
      <input name="edesig" id="edesig"  type="text" value="" size="23" disabled="true"/></font></p>
      <p align="left"><font face="Arial">Self / Dependent</font>&nbsp; 
      <font face="Arial" size="2"> &nbsp;</font>
      <select size="1" name="relation" onchange="getdatadep();">
      <option value="S">Self</option>
      <option value="D">Dependent</option>
      </select>
      <font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dependent Name</font><font face="Arial" size="2">&nbsp;&nbsp;
      <select size="1" name="dname" id="dname"></select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></p>
      <p align="left">&nbsp;</p>
      <p><b><font face="Arial">URINE TEST</font></b></p>
   <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="48%" height="300">
    <tr>
      <td width="36%" height="19">&nbsp;</td>
      <td width="37%" height="19">&nbsp;</td>
      <td width="78%" height="19"><font face="Arial" size="2">Normal Range</font></td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Sugar</font></td>
      <td width="37%" height="22"><font face="Arial" size="2"> 
      <input name="urinesugar" type="text" value="" size="10" maxlength="10" /></font></td>
      <td width="78%" height="22">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Alb</font></td>
      <td width="37%" height="22"><font face="Arial" size="2"> 
      <input name="alb" type="text" value="" size="10" maxlength="9" /></font></td>
      <td width="78%" height="22">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="20"><font face="Arial">Bile Salt</font></td>
      <td width="37%" height="20"><font face="Arial" size="2"> 
      <input name="bilesalt" type="text" value="" size="10" maxlength="1" /></font></td>
      <td width="78%" height="20">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="23"><font face="Arial">Bile Pig</font></td>
      <td width="37%" height="23"><font face="Arial" size="2"> 
      <input name="bilepig" type="text" value="" size="10" maxlength="1" /></font></td>
      <td width="78%" height="23">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Acetone</font></td>
      <td width="37%" height="22"><font face="Arial" size="2"> 
      <input name="acetone" type="text" value="" size="10" maxlength="1" /></font></td>
      <td width="78%" height="22">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">M.E.</font></td>
      <td width="37%" height="22"><font face="Arial" size="2"> 
      <input name="me" type="text" value="" size="10" maxlength="10" /></font></td>
      <td width="78%" height="22">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="23"><font face="Arial">Pus Cell</font></td>
      <td width="37%" height="23"><font face="Arial" size="2"><input name="urinepuscell" type="text" value="" size="20" maxlength="20"/></font>/hpf</td>
      <td width="78%" height="23">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="23"><font face="Arial">R.B.C.</font></td>
      <td width="37%" height="23"><font face="Arial" size="2"><input name="urinerbc" type="text" value="" size="20" maxlength="20" /></font>/hpf</td>
      <td width="78%" height="23">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="23"><font face="Arial">CAST</font></td>
      <td width="37%" height="23"><font face="Arial" size="2"><input name="castt" type="text" value="" size="20" maxlength="20" /></font>/hpf</td>
      <td width="78%" height="23">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="23"><font face="Arial">Epl. Cell</font></td>
      <td width="37%" height="23"><font face="Arial" size="2"><input name="eplcell" type="text" value="" size="20" maxlength="20" /></font>/hpf</td>
      <td width="78%" height="23">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="23"><font face="Arial">Crystal</font></td>
      <td width="37%" height="23"><font face="Arial" size="2"><input name="crystal" type="text" value="" size="20" maxlength="20" /></font>/hpf</td>
      <td width="78%" height="23">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="23"><font face="Arial">Any other</font></td>
      <td width="37%" height="23"><font face="Arial" size="2"><input name="other" type="text" value="" size="20" maxlength="20" /></font>/hpf</td>
      <td width="78%" height="23">&nbsp;</td>
    </tr>
  </table>
  <p><b><font face="Arial">STOOL TEST</font></b></p>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="48%" height="50">
    <tr>
      <td width="36%" height="19">&nbsp;</td>
      <td width="35%" height="19">&nbsp;</td>
      <td width="80%" height="19"><font face="Arial" size="2">Normal Range</font></td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">OVA</font></td>
      <td width="37%" height="22"><font face="Arial" size="2"> 
      <input name="ova" type="text" value="" size="20" maxlength="20" /></font>/hpf</td>
      <td width="78%" height="22">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">CYST</font></td>
      <td width="37%" height="22"><font face="Arial" size="2"> 
      <input name="cyst" type="text" value="" size="20" maxlength="20" /></font>/hpf</td>
      <td width="78%" height="22">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Pus Cell</font></td>
      <td width="37%" height="22"><font face="Arial" size="2"> 
      <input name="stoolpuscell" type="text" value="" size="20" maxlength="20" /></font>/hpf</td>
      <td width="78%" height="22">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">R.B.C.</font></td>
      <td width="37%" height="22"><font face="Arial" size="2"> 
      <input name="stoolrbc" type="text" value="" size="20" maxlength="20" /></font>/hpf</td>
      <td width="78%" height="22">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Trophozoltes</font></td>
      <td width="37%" height="22"><font face="Arial" size="2"> 
      <input name="tropho" type="text" value="" size="20" maxlength="20" /></font>/hpf</td>
      <td width="78%" height="22">&nbsp;</td>
    </tr>
  </table>
  <p><b><font face="Arial">HAEMATOLOGY TEST</font></b></p>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="48%" height="50">
    <tr>
      <td width="36%" height="19">&nbsp;</td>
      <td width="37%" height="19">&nbsp;</td>
      <td width="78%" height="19"><font face="Arial" size="2">Normal Range</font></td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Hb</font></td>
      <td width="37%" height="22"><font face="Arial" size="2"> 
      <input name="hb" type="text" value="" size="9" maxlength="6" /> </font>Gm %</td>
      <td width="78%" height="22">11.0 - 16.0</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">TLC</font></td>
      <td width="37%" height="22"><font face="Arial" size="2"> 
      <input name="tlc" type="text" value="" size="9" maxlength="5" /> /cu.mm</font></td>
      <td width="78%" height="22">4000 - 11000</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">DLC</font></td>
      <td width="37%" height="22"><font face="Arial" size="2"> 
      <input name="dlc" type="text" value="" size="9" maxlength="6" /></font></td>
      <td width="78%" height="22">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Poly</font></td>
      <td width="37%" height="22"><font face="Arial" size="2"> 
      <input name="poly" type="text" value="" size="9" maxlength="6" /> %</font></td>
      <td width="78%" height="22">50 - 70</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Lympho</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="lympho" type="text" value="" size="9" maxlength="6" /> %</font></td>
      <td width="80%" height="22">20 - 45</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Eosino</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="eosino" type="text" value="" size="9" maxlength="5" /> %</font></td>
      <td width="80%" height="22">1 - 5</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Mono</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="mono" type="text" value="" size="9" maxlength="5" /> %</font></td>
      <td width="80%" height="22">2 - 10</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Baso</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="baso" type="text" value="" size="9" maxlength="6" /> %</font></td>
      <td width="80%" height="22">0 - 1</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">M.P.</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="mp" type="text" value="" size="9" maxlength="1" /></font></td>
      <td width="80%" height="22">&nbsp;</td>
    </tr>
  </table>
  <p><b><font face="Arial">BIOCHEMISTRY TEST</font></b></p>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="48%" height="50">
    <tr>
      <td width="36%" height="19">&nbsp;</td>
      <td width="35%" height="19">&nbsp;</td>
      <td width="80%" height="19"><font face="Arial" size="2">Normal Range</font></td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">FBS</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="fbs" type="text" value="" size="9" maxlength="5" /> </font>
      mg/dl</td>
      <td width="80%" height="22">60 - 100</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">PPBS</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="ppbs" type="text" value="" size="9" maxlength="7" /> </font>
      mg/dl</td>
      <td width="80%" height="22">upto 140</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Blood Urea</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="bloodurea" type="text" value="" size="9" maxlength="6" /> </font>
      mg/dl</td>
      <td width="80%" height="22">10 - 50</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">S.Cholestrol</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="chol" type="text" value="" size="9" maxlength="7" /> </font>
      mg/dl</td>
      <td width="80%" height="22">130 - 200</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">S.Triglyceride</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="trigly" type="text" value="" size="9" maxlength="7"/> </font>
      mg/dl</td>
      <td width="80%" height="22">40 - 150</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">S.HDL</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="hdl" type="text" value="" size="9" maxlength="6" /> </font>
      mg/dl</td>
      <td width="80%" height="22">30 - 70</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">S.LDL</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="ldl" type="text" value="" size="9" maxlength="6" /> </font>
      mg/dl</td>
      <td width="80%" height="22">&lt; 100</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">S.Creatinine</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="creatine" type="text" value="" size="9" maxlength="6" /> </font>
      mg/dl</td>
      <td width="80%" height="22">0.6 - 1.1</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">S.Uric Acid</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="uricacid" type="text" value="" size="9" maxlength="6"/> </font>
      mg/dl</td>
      <td width="80%" height="22">2.4 - 7.0</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">S.Calcium</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="calcium" type="text" value="" size="9"  maxlength="6"/> </font>
      mg/dl</td>
      <td width="80%" height="22">8.5 - 10.5</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">S.Billirubin</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="billirubin" type="text" value="" size="9"  maxlength="6"/> </font>
      mg/dl</td>
      <td width="80%" height="22">0.2 - 1.0</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">SGOT</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="sgot" type="text" value="" size="9"  maxlength="6" /> </font>IU/L</td>
      <td width="80%" height="22">5 - 45</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">SGPT</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="sgpt" type="text" value="" size="9"  maxlength="6" /> </font>IU/L</td>
      <td width="80%" height="22">5 - 45</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Total Protein</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="protein" type="text" value="" size="9"  maxlength="6" /> </font>g/dL</td>
      <td width="80%" height="22">6.5 - 8.5</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Albumin</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="albumin" type="text" value="" size="9"  maxlength="6" /> </font>g/dL</td>
      <td width="80%" height="22">3.5 - 5.0</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">Globulin</font></td>
      <td width="35%" height="22"><font face="Arial" size="2"> 
      <input name="globulin" type="text" value="" size="9"  maxlength="6" /> </font>g/dL</td>
      <td width="80%" height="22">3.0 - 3.5</td>
    </tr>
    <tr>
      <td width="36%" style="text-indent: 0; line-height: 100%; margin-top: 0; margin-bottom: 0" height="0">
      <font face="Arial">S.Alkaline Phos</font></td>
      <td width="35%" style="text-indent: 0; line-height: 100%; margin-top: 0; margin-bottom: 0" height="0"><font face="Arial" size="2"> 
      <input name="alkaline" type="text" value="" size="9"  maxlength="7" /> </font>IU/L</td>
      <td width="80%" style="text-indent: 0; line-height: 100%; margin-top: 0; margin-bottom: 0" height="0">Adult 60 - 170<p>Child 151 - 471</td>
    </tr>
  </table>
  <p><b><font face="Arial">BLOOD GROUP TEST</font></b></p>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="32%" height="50">
    <tr>
      <td width="36%" height="22"><font face="Arial">Blood Group</font></td>
      <td width="32%" height="22"><font face="Arial" size="2"> 
      <input name="bloodgroup" type="text" value="" size="9"  maxlength="2" /> </font>
      </td>
      <td width="83%" height="22">&nbsp;</td>
    </tr>
    <tr>
      <td width="36%" height="22"><font face="Arial">RH</font></td>
      <td width="32%" height="22"><input type="radio" value="P" name="rh">Positive</td>
      <td width="83%" height="22"><input type="radio" value="N" name="rh">Negative</td>
    </tr>
  </table>
  <p><b><font face="Arial">PREGNANCY TEST</font></b></p>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="20%" height="28">
    <tr>
      <td width="47%" height="1"><input type="radio" value="P" name="preg">Positive</td>
      <td width="68%" height="1"><input type="radio" value="N" name="preg">Negative</td>
    </tr>
  </table>
  <p><b><font face="Arial">VDRL TEST</font></b></p>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="20%" height="28">
    <tr>
      <td width="48%" height="1"><input type="radio" value="P" name="vdrl">Positive</td>
      <td width="67%" height="1"><input type="radio" value="N" name="vdrl">Negative</td>
    </tr>
  </table>
  <p><b><font face="Arial">AUST. ANTIGEN TEST</font></b></p>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="21%" height="28">
    <tr>
      <td width="47%" height="1"><input type="radio" value="P" name="antigen">Positive</td>
      <td width="68%" height="1"><input type="radio" value="N" name="antigen">Negative</td>
    </tr>
  </table>
  <p><b><font face="Arial">R.A.FACTOR TEST</font></b></p>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="21%" height="28">
    <tr>
      <td width="48%" height="1"><input type="radio" value="P" name="ra">Positive</td>
      <td width="67%" height="1"><input type="radio" value="N" name="ra">Negative</td>
    </tr>
  </table>
  <p><b><font face="Arial">WIDAL TEST</font></b></p>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="34%" height="79">
    <tr>
      <td width="16%" height="19">&nbsp;</td>
      <td width="16%" height="19">1/20</td>
      <td width="17%" height="19">1/40</td>
      <td width="17%" height="19">1/80</td>
      <td width="17%" height="19">1/160</td>
      <td width="17%" height="19">1/320</td>
    </tr>
    <tr>
      <td width="16%" height="20">TO</td>
      <td width="16%" height="20"><input type="checkbox" name="to20" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="to40" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="to80" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="to160" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="to320" value="P"></td>
    </tr>
    <tr>
      <td width="16%" height="20">TH</td>
      <td width="16%" height="20"><input type="checkbox" name="th20" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="th40" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="th80" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="th160" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="th320" value="P"></td>
    </tr>
    <tr>
      <td width="16%" height="20">AH</td>
      <td width="16%" height="20"><input type="checkbox" name="ah20" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="ah40" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="ah80" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="ah160" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="ah320" value="P"></td>
    </tr>
    <tr>
      <td width="16%" height="20">BH</td>
      <td width="16%" height="20"><input type="checkbox" name="bh20" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="bh40" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="bh80" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="bh160" value="P"></td>
      <td width="17%" height="20"><input type="checkbox" name="bh320" value="P"></td>
    </tr>
  </table>
  <p><b><font face="Arial">MALARIA ANTIGEN TEST</font></b></p>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="21%" height="28">
    <tr>
      <td width="48%" height="1">
      <input type="radio" value="P" name="malaria" >Positive</td>
      <td width="67%" height="1">
      <input type="radio" value="N" name="malaria" >Negative</td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="48%" height="50">
    <tr>
      <td width="23%" height="19">&nbsp;</td>
      <td width="48%" height="19">&nbsp;</td>
      <td width="80%" height="19"><font face="Arial" size="2">Normal Range</font></td>
    </tr>
    <tr>
      <td width="23%" height="22"><font face="Arial">ESR</font></td>
      <td width="48%" height="22"><font face="Arial" size="2"> 
      <input name="esr" type="text" value="" size="9" maxlength="6" /> </font>mm 1st hr</td>
      <td width="80%" height="22">0 - 20</td>
    </tr>
    <tr>
      <td width="23%" height="22"><font face="Arial">BT</font></td>
      <td width="48%" height="22"><font face="Arial" size="2"> 
      <input name="btmts" type="text" value="" size="9" maxlength="6"/> </font>mts <font face="Arial" size="2"> 
      <input name="btsec" type="text" value="" size="7" maxlength="6" /> Sec</font></td>
      <td width="80%" height="22">&nbsp;</td>
    </tr>
    <tr>
      <td width="23%" height="22"><font face="Arial">CT</font></td>
      <td width="48%" height="22"><font face="Arial" size="2"> 
      <input name="ctmts" type="text" value="" size="9" maxlength="6" /> </font>mts <font face="Arial" size="2"> 
      <input name="ctsec" type="text" value="" size="7" maxlength="6" /> Sec</font></td>
      <td width="80%" height="22">&nbsp;</td>
    </tr>
  </table>
    &nbsp;
  <p>
  <input type="button" value="Save" onclick="checkFields();" />&nbsp;&nbsp;&nbsp; 
  <input type="Reset" value="Clear" />
  </p>
 </form> 
  </center>
 </div>
 <p style="margin-top: 0; margin-bottom: 0"> </p>
 </body>
</html>