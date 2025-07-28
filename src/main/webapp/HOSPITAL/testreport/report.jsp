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

<title>Test Report</title>
<style type="text/css" media="print">
</style>
</head>
<body bgcolor="#EAFFFF">
<% 
	//String reportnumber="";
	String reportnumber=request.getParameter("q");
	//String empno = session.getAttribute("").toString();
	
	String reportno="";
	String empn = "";
	String ename = "";
    String designation = "";
    String relation= "";
	String patient = "";
	String dt = "";
    String doctor = "";
    String urinesugar= "";
    String alb= "";
    String bilesalt= "";
    String bilepig= "";
    String acetone= "";
    String me= "";
    String urinepuscell= "";
    String urinerbc= "";
    String castt = "";
    String eplcell= "";
    String crystal= "";
    String other= "";
    String ova= "";
    String cyst= "";
    String stoolpuscell= "";
    String stoolrbc= "";
    String tropho= "";
    String hb= "";
    String tlc= "";
    String dlc= "";
    String poly= "";
    String lympho= "";
    String eosino= "";
    String mono="";
    String baso= "";
    String mp = "";
    String fbs= "";
    String ppbs= "";
    String bloodurea= "";
    String chol= "";
    String trigly="";
    String hdl= "";
    String ldl= "";
    String creatine= "";
    String uricacid= "";
    String calcium= "";
    String billirubin= "";
    String sgot="";
    String sgpt= "";
    String protein= "";
    String albumin= "";
    String globulin= "";
    String alkaline= "";
    String bloodgroup= "";
    String rh= "";
    String preg="";
    String vdrl= "";
    String antigen= "";
    String ra= "";
    String to20= "";
    String to40= "";
    String to80= "";
    String to160="";
    String to320="";
    String th20="";
    String th40= "";
    String th80="";
    String th160= "";
    String th320="";
    String ah20= "";
    String ah40= "";
    String ah80= "";
    String ah160= "";
    String ah320= "";
    String bh20= "";
    String bh40= "";
    String bh80= "";
    String bh160= "";
    String bh320= "";
    String malaria= "";
    String esr= "";
    String btmts= "";
    String btsec= "";
    String ctmts= "";
    String ctsec= "";
  

 Connection conn  = null;    
  try 
     {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	     conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.111.112:1521:orcl","hospital","hospital");
	     Statement stmt=conn.createStatement();
	     ResultSet rs = stmt.executeQuery("SELECT A.REPORT_NO, A.EMPN, C.ENAME, C.DESIGNATION, DECODE(A.SELF_DEP,'S', 'SELF', 'D', 'DEPENDENT') SELF_DEP, A.PATIENTNAME, TO_CHAR(A.DATE_OF_TEST,'DD-MON-YYYY') DATE_OF_TEST, B.DOCTOR_NAME, A.URINE_SUGAR, A.ALB, A.BILE_SALT, A.BILE_PIG, A.ACETONE, A.ME, A.URINE_PUSCELL, A.URINE_RBC, A.CASTT, A.EPI_CELL, A.CRYSTAL, A.ANY_OTHER, A.OVA, A.CYST, A.STOOL_PUSCELL, A.STOOL_RBC, A.TROPHO, A.HB, A.TLC, A.DLC, A.POLY, A.LYMPHO, A.EOSINO, A.MONO, A.BASO, A.MP, A.FBS, A.PPBS, A.BLOOD_UREA, A.S_CHOLESTROL, A.S_TRIGLYCERIDE, A.S_HDL, A.S_LDL, A.S_CREATININE, A.S_URICACID, A.S_CALCIUM, A.S_BILRUBIN, A.SGOT, A.SGPT, A.TOTAL_PROTEIN, A.ALBUMIN, A.GLOBULIN, A.S_ALKALI_PHOS, A.BLOOD_GROUP, A.RH_FACTOR, A.PREGNANCY, A.VDRL, A.AUS_ANTIGEN, A.RA_FACTOR, A.TO_1_20, A.TO_1_40, A.TO_1_80, A.TO_1_160, A.TO_1_320, A.TH_1_20, A.TH_1_40, A.TH_1_80, A.TH_1_160, A.TH_1_320, A.AH_1_20, A.AH_1_40, A.AH_1_80, A.AH_1_160, A.AH_1_320, A.BH_1_20, A.BH_1_40, A.BH_1_80, A.BH_1_160, A.BH_1_320, A.MALARIA_ANTIGEN, A.ESR, A.BT_MTS, A.BT_SEC, A.CT_MTS, A.CT_SEC FROM TESTREPORT A, DOCTOR B, PERSONNEL.EMPLOYEEMASTER C WHERE A.DOCTOR=B.CODE AND B.STATUS='A' AND C.OLDNEWDATA='N' AND A.EMPN=C.EMPN and a.report_no='"+reportnumber+"'");
           while(rs.next())  
            {
                reportno= rs.getString(1);
                empn= rs.getString(2);
                ename= rs.getString(3);
                designation= rs.getString(4);
                relation= rs.getString(5);
                patient= rs.getString(6);
                dt= rs.getString(7);
                doctor= rs.getString(8);
                urinesugar= rs.getString(9);
                alb= rs.getString(10);
                bilesalt= rs.getString(11);
                bilepig= rs.getString(12);
                acetone= rs.getString(13);
                me= rs.getString(14);
                urinepuscell= rs.getString(15);
                urinerbc= rs.getString(16);
                castt = rs.getString(17);
                eplcell= rs.getString(18);
                crystal= rs.getString(19);
                other= rs.getString(20);
                ova= rs.getString(21);
                cyst= rs.getString(22);
                stoolpuscell= rs.getString(23);
                stoolrbc= rs.getString(24);
                tropho= rs.getString(25);
                hb= rs.getString(26);
                tlc= rs.getString(27);
                dlc= rs.getString(28);
                creatine= rs.getString(29);
                poly= rs.getString(30);
                lympho= rs.getString(31);
                eosino= rs.getString(32);
                mono= rs.getString(33);
                baso= rs.getString(34);
                mp = rs.getString(35);
                fbs= rs.getString(36);
                ppbs= rs.getString(37);
                bloodurea= rs.getString(38);
                chol= rs.getString(39);
                trigly= rs.getString(40);
                hdl= rs.getString(41);
                ldl= rs.getString(42);
                uricacid= rs.getString(43);
                calcium= rs.getString(44);
                billirubin= rs.getString(45);
                sgot= rs.getString(46);
                sgpt= rs.getString(47);
                protein= rs.getString(48);
                albumin= rs.getString(49);
                globulin= rs.getString(50);
                alkaline= rs.getString(51);
                bloodgroup= rs.getString(52);
                rh= rs.getString(53);
                preg= rs.getString(54);
                vdrl= rs.getString(55);
                antigen= rs.getString(56);
                ra= rs.getString(57);
                to20= rs.getString(58);
                to40= rs.getString(59);
                to80= rs.getString(60);
                to160= rs.getString(61);
                to320= rs.getString(62);
                th20= rs.getString(63);
                th40= rs.getString(64);
                th80= rs.getString(65);
                th160= rs.getString(66);
                th320= rs.getString(67);
                ah20= rs.getString(68);
                ah40= rs.getString(69);
                ah80= rs.getString(70);
                ah160= rs.getString(71);
                ah320= rs.getString(72);
                bh20= rs.getString(73);
                bh40= rs.getString(74);
                bh80= rs.getString(75);
                bh160= rs.getString(76);
                bh320= rs.getString(77);
                malaria= rs.getString(78);
                esr= rs.getString(79);
                btmts= rs.getString(80);
                btsec= rs.getString(81);
                ctmts= rs.getString(82);
                ctsec= rs.getString(83);
              
            }
           
%>
 <p style="line-height: 70%; margin-top: -3; margin-bottom: -10" align="center">
 <font face="Arial">National Fertilizers Limited</font></p>
 <p style="line-height: 70%; margin-bottom: -10" align="center"><font face="Arial">Panipat Unit: Medical Department</font></p>
 <p style="line-height: 70%" align="center"><b><font face="Arial">PATHOLOGICAL TEST&nbsp; REPORT </font></b></p>
 <div align="center">
 
      <p align="left" style="margin-top: 0; margin-bottom: 0"><font face="Arial">Report No.: <%=reportno%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font> &nbsp;<font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date of Test : <%=dt%></font>
      <font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
      <font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Medical Officer: <%=doctor%> </font>
      <font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp; </font></p>
      <p align="left" style="margin-top: 0; margin-bottom: 0"><font face="Arial">Empn : <%=empn%></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <font face="Arial" size="2"> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font>
      <font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name : <%=ename%></font><font face="Arial" size="2"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font>
      <font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Designation: <%=designation%></font><font face="Arial" size="2">&nbsp; </font></p>
      <p align="left" style="margin-top: 0; margin-bottom: 0"><font face="Arial">Self / Dependent:</font>&nbsp; <%=relation%>
      <font face="Arial" size="2"> &nbsp;</font>&nbsp;
      <font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dependent Name:</font><font face="Arial" size="2" > <%=patient%> </font></p>
      <p align="left" style="margin-top: 0; margin-bottom: 0">- - - - - - - - - 
      - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
      - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
      - - - - - </p>
      <div align="left">
      <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="67%">
        <tr>
          <td width="37%" colspan="2" align="center" style="border-top-color: #111111">
          <p align="center"><b><font face="Arial">URINE TEST</font></b></td>
          <td width="5%" style="border-top: 1px solid #111111; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="58%" colspan="3" style="border-left-style: solid; border-left-width: 1; border-right-style: solid; border-right-width: 1; border-top-color: #111111">
          <p align="center"><b><font face="Arial">HAEMATOLOGY TEST</font></b></td>
        </tr>
        <tr>
          <td width="17%"><font face="Arial">Sugar</font> </td>
          <td width="20%"><%=urinesugar%> Gm %&nbsp;</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="15%" style="border-left-style: solid; border-left-width: 1">&nbsp;</td>
          <td width="24%" style="border-top-style: solid; border-top-width: 1"></td>
          <td width="19%" style="border-right-style: solid; border-right-width: 1; border-top-style: solid; border-top-width: 1"><font face="Arial" size="2">Normal Range</font></td>
        </tr>
        <tr>
          <td width="17%"><font face="Arial">Alb</font> </td>
          <td width="20%"><%=hb%>&nbsp;</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="15%" style="border-left-style: solid; border-left-width: 1"><font face="Arial">Hb</font> </td>
          <td width="24%"><font face="Arial" size="2"><%=hb%> /cu.mm</font></td>
          <td width="19%" style="border-right-style: solid; border-right-width: 1">11.0 - 16.0</td>
        </tr>
        <tr>
          <td width="17%"><font face="Arial">Bile Salt</font></td>
          <td width="20%"><%=bilesalt%>&nbsp;</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="15%" style="border-left-style: solid; border-left-width: 1"><font face="Arial">TLC</font></td>
          <td width="24%"><%=tlc%>&nbsp;</td>
          <td width="19%" style="border-right-style: solid; border-right-width: 1">4000 - 11000</td>
        </tr>
        <tr>
          <td width="17%"><font face="Arial">Bile Pig</font></td>
          <td width="20%"><%=bilepig%>&nbsp;</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="15%" style="border-left-style: solid; border-left-width: 1"><font face="Arial">DLC</font></td>
          <td width="24%"><%=dlc%>&nbsp;</td>
          <td width="19%" style="border-right-style: solid; border-right-width: 1">&nbsp;</td>
        </tr>
        <tr>
          <td width="17%"><font face="Arial">Acetone</font></td>
          <td width="20%"><%=acetone%>&nbsp;</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="15%" style="border-left-style: solid; border-left-width: 1"><font face="Arial">Poly</font></td>
          <td width="24%"><font face="Arial" size="2"><%=poly%> %</font></td>
          <td width="19%" style="border-right-style: solid; border-right-width: 1">50 - 70</td>
        </tr>
        <tr>
          <td width="17%"><font face="Arial">M.E.</font></td>
          <td width="20%"><%=me%>&nbsp;</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="15%" style="border-left-style: solid; border-left-width: 1"><font face="Arial">Lympho</font></td>
          <td width="24%"><font face="Arial" size="2"> 
          <%=lympho%> %</font></td>
          <td width="19%" style="border-right-style: solid; border-right-width: 1">20 - 45</td>
        </tr>
        <tr>
          <td width="17%"><font face="Arial">Pus Cell</font></td>
          <td width="20%" align="left"> 
          <%=urinepuscell%> /hpf</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="15%" style="border-left-style: solid; border-left-width: 1"><font face="Arial">Eosino</font></td>
          <td width="24%"><font face="Arial" size="2"> 
          <%=eosino%> %</font></td>
          <td width="19%" style="border-right-style: solid; border-right-width: 1">1 - 5</td>
        </tr>
        <tr>
          <td width="17%"><font face="Arial">R.B.C.</font></td>
          <td width="20%" align="left">
          <%=urinerbc%> /hpf</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="15%" style="border-left-style: solid; border-left-width: 1"><font face="Arial">Mono</font></td>
          <td width="24%"><font face="Arial" size="2"> 
          <%=mono%> %</font></td>
          <td width="19%" style="border-right-style: solid; border-right-width: 1">2 - 10</td>
        </tr>
        <tr>
          <td width="17%"><font face="Arial">CAST</font></td>
          <td width="20%" align="left"> 
          <%=castt%> /hpf</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="15%" style="border-left-style: solid; border-left-width: 1"><font face="Arial">Baso</font></td>
          <td width="24%"><font face="Arial" size="2"> 
          <%=baso%> %</font></td>
          <td width="19%" style="border-right-style: solid; border-right-width: 1">0 - 1</td>
        </tr>
        <tr>
          <td width="17%"><font face="Arial">Epl. Cell</font></td>
          <td width="20%" align="left">
          <%=eplcell%> /hpf</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="15%" style="border-left-style: solid; border-left-width: 1"><font face="Arial">M.P.</font></td>
          <td width="24%"><%=mp%> &nbsp;</td>
          <td width="19%" style="border-right-style: solid; border-right-width: 1">&nbsp;</td>
        </tr>
        <tr>
          <td width="17%"><font face="Arial">Crystal</font></td>
          <td width="20%" align="left"> 
          <%=crystal%> /hpf</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="15%" style="border-left-style: solid; border-left-width: 1">&nbsp;</td>
          <td width="24%">&nbsp;</td>
          <td width="19%" style="border-right-style: solid; border-right-width: 1">&nbsp;</td>
        </tr>
        <tr>
          <td width="17%" style="border-bottom-color: #111111"><font face="Arial">Any other</font></td>
          <td width="20%" align="left" style="border-bottom-color: #111111"> 
          <%=other%> /hpf</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom: 1px solid #111111">&nbsp;</td>
          <td width="15%" style="border-left-style: solid; border-left-width: 1; border-bottom-color: #111111">&nbsp;</td>
          <td width="24%" style="border-bottom-color: #111111">&nbsp;</td>
          <td width="19%" style="border-right-style: solid; border-right-width: 1; border-bottom-color: #111111">&nbsp;</td>
        </tr>
      </table>
      </div>
  <p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
      <div align="left">
      <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="84%" height="331">
        <tr>
          <td width="32%" colspan="2" height="19" style="border-top-color: #111111">
          <p align="center"><b><font face="Arial">STOOL TEST</font></b></td>
          <td width="5%" height="19" style="border-top-style: solid; border-top-width: 1; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="63%" colspan="4" height="19" style="border-top-color: #111111">
          <p align="center"><b><font face="Arial">BIOCHEMISTRY TEST</font></b></td>
        </tr>
        <tr>
          <td width="17%" height="19"><font face="Arial">OVA</font></td>
          <td width="15%" height="19"> <%=ova%> /hpf</td>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19">&nbsp;</td>
          <td width="17%" height="19">&nbsp;</td>
          <td width="17%" height="19">&nbsp;</td>
          <td width="17%" height="19"><font face="Arial" size="2">Normal Range</font></td>
        </tr>
        <tr>
          <td width="17%" height="19"><font face="Arial">CYST</font></td>
          <td width="15%" height="19"> <%=cyst%> /hpf</td>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">FBS</font></td>
          <td width="17%" height="19" align="center">&nbsp;</td>
          <td width="17%" height="19"><%=fbs%> mg/dl</td>
          <td width="17%" height="19">60 - 100</td>
        </tr>
        <tr>
          <td width="17%" height="19"><font face="Arial">Pus Cell</font></td>
          <td width="15%" height="19"><%=stoolpuscell%> /hpf</td>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">PPBS</font></td>
          <td width="17%" height="19" align="center">&nbsp;</td>
          <td width="17%" height="19"><%=ppbs%> mg/dl</td>
          <td width="17%" height="19">upto 140</td>
        </tr>
        <tr>
          <td width="17%" height="19"><font face="Arial">R.B.C.</font></td>
          <td width="15%" height="19"><%=stoolrbc%> /hpf</td>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">Blood Urea</font></td>
          <td width="17%" height="19" align="center"><%=bloodurea%> &nbsp;</td>
          <td width="17%" height="19">mg/dl</td>
          <td width="17%" height="19">10 - 50</td>
        </tr>
        <tr>
          <td width="17%" height="19"><font face="Arial">Trophozoltes</font></td>
          <td width="15%" height="19"><%=tropho%> /hpf</td>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">S.Cholestrol</font></td>
          <td width="17%" height="19" align="center"><%=chol%> &nbsp;</td>
          <td width="17%" height="19">mg/dl</td>
          <td width="17%" height="19">130 - 200</td>
        </tr>
        <tr>
          <td width="17%" height="19">&nbsp;</td>
          <td width="15%" height="19">&nbsp;</td>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">S.Triglyceride</font></td>
          <td width="17%" height="19" align="center"><%=trigly%> &nbsp;</td>
          <td width="17%" height="19">mg/dl</td>
          <td width="17%" height="19">40 - 150</td>
        </tr>
        <tr>
          <td width="17%" height="38" rowspan="2"><b><font face="Arial">AUST. ANTIGEN TEST</font></b></td>
          <td width="15%" height="38" rowspan="2"><%=antigen%> &nbsp;</td>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">S.HDL</font></td>
          <td width="17%" height="19" align="center"><%=hdl%> &nbsp;</td>
          <td width="17%" height="19">mg/dl</td>
          <td width="17%" height="19">30 - 70</td>
        </tr>
        <tr>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">S.LDL</font></td>
          <td width="17%" height="19" align="center"><%=ldl%> &nbsp;</td>
          <td width="17%" height="19">mg/dl</td>
          <td width="17%" height="19">&lt; 100</td>
        </tr>
        <tr>
          <td width="17%" height="38" rowspan="2"><b><font face="Arial">MALARIA ANTIGEN TEST</font></b></td>
          <td width="15%" height="38" rowspan="2"><%=malaria%> &nbsp;</td>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">S.Creatinine</font></td>
          <td width="17%" height="19" align="center"><%=creatine%> &nbsp;</td>
          <td width="17%" height="19">mg/dl</td>
          <td width="17%" height="19">0.6 - 1.1</td>
        </tr>
        <tr>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">S.Uric Acid</font></td>
          <td width="17%" height="19" align="center"><%=uricacid%> &nbsp;</td>
          <td width="17%" height="19">mg/dl</td>
          <td width="17%" height="19">2.4 - 7.0</td>
        </tr>
        <tr>
          <td width="17%" height="38" rowspan="2"><b><font face="Arial">R.A.FACTOR TEST</font></b></td>
          <td width="15%" height="38" rowspan="2"><%=ra%> &nbsp;</td>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">S.Calcium</font></td>
          <td width="17%" height="19" align="center"><%=calcium%> &nbsp;</td>
          <td width="17%" height="19">mg/dl</td>
          <td width="17%" height="19">8.5 - 10.5</td>
        </tr>
        <tr>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">S.Billirubin</font></td>
          <td width="17%" height="19" align="center"><%=billirubin%> &nbsp;</td>
          <td width="17%" height="19">mg/dl</td>
          <td width="17%" height="19">0.2 - 1.0</td>
        </tr>
        <tr>
          <td width="17%" height="38" rowspan="2"><b><font face="Arial">VDRL TEST</font></b></td>
          <td width="15%" height="38" rowspan="2"><%=vdrl%> &nbsp;</td>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">SGOT</font></td>
          <td width="17%" height="19" align="center"><%=sgot%> &nbsp;</td>
          <td width="17%" height="19">IU/L</td>
          <td width="17%" height="19">5 - 45</td>
        </tr>
        <tr>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">SGPT</font></td>
          <td width="17%" height="19" align="center"><%=sgpt%> &nbsp;</td>
          <td width="17%" height="19">IU/L</td>
          <td width="17%" height="19">5 - 45</td>
        </tr>
        <tr>
          <td width="17%" height="38" rowspan="2"><b><font face="Arial">PREGNANCY TEST</font></b></td>
          <td width="15%" height="38" rowspan="2"><%=preg%> &nbsp;</td>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">Total Protein</font></td>
          <td width="17%" height="19" align="center"><%=protein%> &nbsp;</td>
          <td width="17%" height="19">g/dL</td>
          <td width="17%" height="19">6.5 - 8.5</td>
        </tr>
        <tr>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">Albumin</font></td>
          <td width="17%" height="19" align="center"><%=albumin%> &nbsp;</td>
          <td width="17%" height="19">g/dL</td>
          <td width="17%" height="19">3.5 - 5.0</td>
        </tr>
        <tr>
          <td width="17%" height="19">&nbsp;</td>
          <td width="15%" height="19">&nbsp;</td>
          <td width="5%" height="19" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="12%" height="19"><font face="Arial">Globulin</font></td>
          <td width="17%" height="19" align="center"><%=globulin%> &nbsp;</td>
          <td width="17%" height="19">g/dL</td>
          <td width="17%" height="19">3.0 - 3.5</td>
        </tr>
        <tr>
          <td width="17%" height="1" style="border-bottom-color: #111111"><b><font face="Arial">BLOOD GROUP &amp; RH TEST</font></b></td>
          <td width="15%" height="1" style="border-bottom-color: #111111"> <%=bloodgroup%> &nbsp;</td>
          <td width="5%" height="1" style="border-top-style: none; border-top-width: medium; border-bottom-style: solid; border-bottom-width: 1"></td>
          <td width="12%" height="1" style="border-bottom-color: #111111">
      <font face="Arial">S.Alkaline&nbsp; Phosphate</font></td>
          <td width="17%" height="1" style="border-bottom-color: #111111" align="center"><%=alkaline%> &nbsp;</td>
          <td width="17%" height="1" style="border-bottom-color: #111111">IU/L</td>
          <td width="17%" height="1" style="border-bottom-color: #111111">
          <p style="margin-top: 0; margin-bottom: 0">Adult 60 - 170</p>
          <p style="margin-top: 0; margin-bottom: 0">Child 151 - 471</td>
        </tr>
      </table>
      </div>
      <p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
      <div align="left">
      <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="84%">
        <tr>
          <td width="31%" colspan="3" style="border-top-color: #111111">
          <p align="center"><b><font face="Arial">ESR BT CT TEST</font></b></td>
          <td width="5%" style="border-top-style: solid; border-top-width: 1; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="64%" colspan="6" style="border-top-color: #111111">
          <p align="center"><b><font face="Arial">WIDAL TEST</font></b></td>
        </tr>
        <tr>
          <td width="6%">&nbsp;</td>
          <td width="18%">&nbsp;</td>
          <td width="7%"><font face="Arial" size="2">Normal Range</font></td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="14%">&nbsp;</td>
          <td width="9%">1/20</td>
          <td width="10%">1/40</td>
          <td width="10%">1/80</td>
          <td width="11%">1/160</td>
          <td width="10%">1/320</td>
        </tr>
        <tr>
          <td width="6%"><font face="Arial">ESR</font></td>
          <td width="18%">&nbsp; <%=esr%>    mm 1st hr</td>
          <td width="7%">0 - 20</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="14%">TO</td>
          <td width="9%"><%=to20%>&nbsp;</td>
          <td width="10%"><%=to40%>&nbsp;</td>
          <td width="10%"><%=to80%>&nbsp;</td>
          <td width="11%"><%=to160%>&nbsp;</td>
          <td width="10%"><%=to320%>&nbsp;</td>
        </tr>
        <tr>
          <td width="6%"><font face="Arial">BT</font></td>
          <td width="18%">&nbsp; <%=btmts%> mts <font face="Arial" size="2"> 
      &nbsp; <%=btmts%> Sec</font></td>
          <td width="7%">&nbsp;</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="14%">TH</td>
          <td width="9%"><%=th20%>&nbsp;</td>
          <td width="10%"><%=th40%>&nbsp;</td>
          <td width="10%"><%=th80%>&nbsp;</td>
          <td width="11%"><%=th160%>&nbsp;</td>
          <td width="10%"><%=th320%>&nbsp;</td>
        </tr>
        <tr>
          <td width="6%"><font face="Arial">CT</font></td>
          <td width="18%">&nbsp; <%=ctmts%> mts <font face="Arial" size="2"> 
      &nbsp; <%=ctmts%> Sec</font></td>
          <td width="7%">&nbsp;</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: none; border-bottom-width: medium">&nbsp;</td>
          <td width="14%">AH</td>
          <td width="9%"><%=ah20%>&nbsp;</td>
          <td width="10%"><%=ah40%>&nbsp;</td>
          <td width="10%"><%=ah80%>&nbsp;</td>
          <td width="11%"><%=ah160%>&nbsp;</td>
          <td width="10%"><%=ah320%>&nbsp;</td>
        </tr>
        <tr>
          <td width="6%" style="border-bottom-color: #111111">&nbsp;</td>
          <td width="18%" style="border-bottom-color: #111111">&nbsp;</td>
          <td width="7%" style="border-bottom-color: #111111">&nbsp;</td>
          <td width="5%" style="border-top-style: none; border-top-width: medium; border-bottom-style: solid; border-bottom-width: 1">&nbsp;</td>
          <td width="14%" style="border-bottom-color: #111111">BH</td>
          <td width="9%" style="border-bottom-color: #111111"><%=bh20%>&nbsp;</td>
          <td width="10%" style="border-bottom-color: #111111"><%=bh40%>&nbsp;</td>
          <td width="10%" style="border-bottom-color: #111111"><%=bh80%>&nbsp;</td>
          <td width="11%" style="border-bottom-color: #111111"><%=bh160%>&nbsp;</td>
          <td width="10%" style="border-bottom-color: #111111"><%=bh320%>&nbsp;</td>
        </tr>
      </table>
      </div>
            
 <% 
 }//end of try block
        
catch(SQLException e) 
     {
        out.println("SQLException :" + e.getMessage() + "<BR>");
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
      
  
 <p style="margin-top: 0; margin-bottom: 0" ><input type="button" value="Button" name="Back"></p>
 </body>
</html>