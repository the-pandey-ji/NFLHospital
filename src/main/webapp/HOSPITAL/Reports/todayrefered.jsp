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
<title>References</title>
<title>Print Test</title>
<style type="text/css" media="print">
.printbutton 
   {
      visibility: hidden;
      display: none;
   }
</style>
</head>
<body>
<p align="center"><u><b>Details of Local References</b></u></p>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="89%" height="38">
  <tr>
    <td width="5%" height="18"><font SIZE="2">REFNO </font></td>
    <td width="16%" height="18"><font SIZE="2">PATIENTNAME</font></td>
    <td width="6%" height="18"><font SIZE="2">EMPN</font></td>
    <td width="6%" height="18"><font SIZE="2">RELATION</font></td>
    <td width="12%" height="18"><font SIZE="2">REFDATE</font></td>
    <td width="16%" height="18"><font SIZE="2">DOC</font></td>
    <td width="16%" height="18"><font SIZE="2">SPECIALIST</font></td>
    <td width="16%" height="18"><font size="2">REFER / REVISIT</font></td>
  </tr>

<%
int refno=0;
String pname="";
int empn=0;
String relation="";
String age="";
String refdt="";
String sex="";
String disease="";
String doctor="";
String spc="";
String yr="";
String revisit="";

   
				
    Connection conn  = null;    
    try 
        {
           conn = DBConnect.getConnection();
           Statement stmt=conn.createStatement();
	       
	       ResultSet rsyr = stmt.executeQuery("select to_char(sysdate,'yyyy') from opd");
            if(rsyr.next())
	            {
	                yr = rsyr.getString(1);
	                                   
                }
	       
	       ResultSet rs = stmt.executeQuery("SELECT a.REFNO, a.PATIENTNAME,a.EMPN, a.REL, a.AGE, TO_CHAR(a.REFDATE, 'DD-MM-YYYY'), a.doc, c.hname, CASE WHEN a.revisitflag = 'N' THEN 'Refer' WHEN a.revisitflag = 'Y' THEN 'Revisit' WHEN a.revisitflag IS NULL THEN 'Refer' ELSE NULL END AS revisit_status FROM LOACALREFDETAIL"+yr+" a JOIN LOCALHOSPITAL c ON a.SPECIALIST = c.hcode WHERE TO_CHAR(a.refdate, 'DD-MM-YYYY') = TO_CHAR(SYSDATE, 'DD-MM-YYYY') ORDER BY a.refno");
	       
	     
	       
	       if (rs == null) {
	    	    System.out.println("No records found for today.");
	    	} else {
	    	    while (rs.next()) {
	    	        refno = rs.getInt(1);
	    	        pname = rs.getString(2);
	    	        empn = rs.getInt(3);
	    	        relation = rs.getString(4);
	    	        age = rs.getString(5);
	    	        refdt = rs.getString(6);
	    	        doctor = rs.getString(7);
	    	        spc = rs.getString(8); 
	    	        revisit = rs.getString(9);

                    
 %>	
  <tr>
    <td width="5%" height="19"><%=refno%></td>
    <td width="16%" height="19"><%=pname%></td>
    <td width="6%" height="19"><%=empn%></td>
    <td width="6%" height="19"><%=relation%></td>
    <td width="12%" height="19"><%=refdt%></td>
    <td width="16%" height="19"><%=doctor%></td>
    <td width="16%" height="19"><%=spc%></td>
    <td width="16%" height="19"><%=revisit%></td>
  </tr>
  
<%
        }           
    }
%>
  </table>
<p align="center"><b>Local Referred Summary</b></p>
<%
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
                 }
             catch (Exception ignored) {}
         }
   }

%>
  <center>	
  
  <table border="1" width="38%" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20%" align="center"><font face="Tahoma"><b>Specialist</b></font></td>
    <td width="18%" align="center"><font face="Tahoma"><b>No of cases</b></font></td>
  </tr>
<%				
    String hname="";
	String no="";
	String total="";
	
      Connection conn1  = null;    
      try 
         {
           conn1 = DBConnect.getConnection();
           Statement stmt=conn1.createStatement();
           
	       ResultSet rs = stmt.executeQuery("select b.hname, count(*) from LOACALREFDETAIL"+yr+" a, LOCALHOSPITAL b where a.specialist=b.hcode and to_char(a.refdate,'dd-mm-yyyy')= to_char(sysdate,'dd-mm-yyyy') group by b.hname");
            while(rs.next())
	           {
	               hname = rs.getString(1);
	               no = rs.getString(2);
%>	
   <tr>
    <td width="20%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=hname%></span></font>&nbsp;</td>
    <td width="18%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=no%></span></font>&nbsp;</td>
    </tr>
<%	
              }
          ResultSet rs1 = stmt.executeQuery("select count(*) from LOACALREFDETAIL"+yr+" where to_char(refdate,'dd-mm-yyyy')= to_char(sysdate,'dd-mm-yyyy')");
            while(rs1.next())
	          {
	              total = rs1.getString(1);
              }
%>
   <tr>
    <td width="20%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase">Total</span></font></td>
    <td width="18%" align="center"><font face="Tahoma" size="2"><span style="text-transform: uppercase"><%=total%></span></font>&nbsp;</td>
    </tr>
</table>
    </center>
  
</div>
<%	
      }	
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
 <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="91%">
  <p align="center">&nbsp;</p>
  <p align="center"><b>Details of Outstation References</b></p>
  <tr>
    <td width="6%"><font SIZE="2">REFNO</font></td>
    <td width="15%"><font SIZE="2">PATIENTNAME</font></td>
    <td width="7%"><font SIZE="2">EMPN</font></td>
    <td width="9%"><font SIZE="2">RELATION</font></td>
    <td width="5%"><font SIZE="2">AGE</font></td>
    <td width="10%"><font SIZE="2">REFDATE</font></td>
    <td width="17%"><font SIZE="2">HOSPITAL</font></td>
    <td width="15%"><font SIZE="2">DOC</font></td>
    <td width="7%"><font SIZE="2">ESCORT</font></td>
    <td width="16%"><font size="2">REFER / REVISIT</font></td>
  </tr>
<%
String refno1="";
String pname1="";
int empn1=0;
String relation1="";
String age1="";
String refdt1="";
String place1="";
String escort1="";
String doctor1="";
String hospital1="";
String city1="";
String revisit1="";

 Connection conn2  = null;    
      try 
         {
           conn2 = DBConnect.getConnection();
           Statement stmt=conn2.createStatement();
           
           String query = "SELECT a.REFNO, " +
                   "a.PATIENTNAME, " +
                   "a.EMPN, " +
                   "a.REL, " +
                   "a.AGE, " +
                   "TO_CHAR(a.REFDATE, 'DD-MM-YYYY'), " +
                   "a.doc, " +
                   "b.hname, " +
                   "b.city, " +
                   "a.ESCORT, " +
                   "CASE " +
                   "WHEN a.revisitflag = 'N' THEN 'Refer' " +
                   "WHEN a.revisitflag = 'Y' THEN 'Revisit' " +
                   "WHEN a.revisitflag IS NULL THEN 'Refer' " +
                   "ELSE NULL " +
                   "END AS revisit_status " +
                   "FROM OUTREFDETAIL" + yr + " a " +
                   "JOIN OUTSTATIONHOSPITAL b ON a.hospital = b.HCODE " +
                   "WHERE TO_CHAR(a.refdate, 'DD-MM-YYYY') = TO_CHAR(SYSDATE, 'DD-MM-YYYY') " +
                   "ORDER BY a.refno";

    ResultSet rs = stmt.executeQuery(query);
    
    while(rs.next())
	            {
                     refno1 = rs.getString(1);
                     pname1 = rs.getString(2);
                     empn1 = rs.getInt(3);
                     relation1 = rs.getString(4);
                     age1 = rs.getString(5);
                     refdt1 = rs.getString(6);
                     doctor1 = rs.getString(7);
                     hospital1= rs.getString(8);
                     city1= rs.getString(9);
                     escort1 = rs.getString(10);
                     revisit1 = rs.getString(11);
  
 %>	 
  <tr>
    <td width="6%"><%=refno1%>&nbsp;</td>
    <td width="15%"><%=pname1%>&nbsp;</td>
    <td width="7%"><%=empn1%>&nbsp;</td>
    <td width="9%"><%=relation1%>&nbsp;</td>
    <td width="5%"><%=age1%>&nbsp;</td>
    <td width="10%"><%=refdt1%>&nbsp;</td>
    <td width="17%"><%=hospital1%>,<%=city1%>&nbsp;</td>
    <td width="15%"><%=doctor1%>&nbsp;</td>
    <td width="7%"><%=escort1%>&nbsp;</td>
    <td width="16%"><%=revisit1%>&nbsp;</td>
  </tr>
<%	
               }
%>
</table>
<%
     }	
catch(SQLException e) 
   {
      while((e = e.getNextException()) != null)
      out.println(e.getMessage() + "<BR>");
   }

finally
   {
       if(conn2 != null) 
         {
             try
                 {
                    conn2.close();
                 }
             catch (Exception ignored) {}
         }
   }
   
%>
</body>
</html>