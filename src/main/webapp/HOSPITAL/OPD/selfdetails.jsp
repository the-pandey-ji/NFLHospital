<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
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
<title>OPD Slip</title>
<style type="text/css" media="print">
.printbutton 
  {
     visibility: hidden;
     display: none;
  }
  
  #body{
  height: 200px;
  }
</style>
</head>
<body>
<% 
	String empn = session.getAttribute("nm").toString();
	String name = "";
	String relation = "Self";
	String age = "";
	String age1 = "";
	String sex = "";
	String dt = "";
	String srno ="";
	String srno1 ="";
	String typ = "N";
	int sr1=0,sr2=0;
					
    //String dataSourceName = "hosp";
    // String dbURL = "jdbc:oracle:thin:@10.3.126.84:1521:ORCL";
    
  
    
    Connection con=DBConnect.getConnection(); 
    Connection con1=DBConnect.getConnection1(); 

    try 
        {
  
           String query = "select ename,to_char(sysdate,'yyyy') - to_char(birthdate,'yyyy'), sex,  to_char(sysdate,'dd-mon-yyyy') FROM employeemaster where empn=?";           
           
           
            Statement stmt=con.createStatement();
  

           PreparedStatement pstmt = con1.prepareStatement(query);
			pstmt.setString(1, empn);
			ResultSet rs = pstmt.executeQuery();


           while(rs.next())
	          {
	             name = rs.getString(1);
	             age1 = rs.getString(2);
                     sex = rs.getString(3);
                     dt=rs.getString(4);
	          }

           
          ResultSet rs1 = stmt.executeQuery("SELECT NVL(MAX(srno), 0) + 1 FROM OPD");
        	 while(rs1.next())
	          {
	             srno = rs1.getString(1);

	          }
        	
	      ResultSet rs3 = stmt.executeQuery("insert into opd(SRNO, PATIENTNAME,RELATION, AGE, OPDDATE, SEX, EMPN,TYP,EMPNAME) values ('"+srno+"','"+name+"','SELF','"+age1+"',SYSDATE,'"+sex+"','"+empn+"','"+typ+"','"+name+"')");
	        

	
	

	    }
	    
catch(SQLException e) 
   {
      while((e = e.getNextException()) != null)
      out.println(e.getMessage() + "<BR>");
   }

finally
   {
       if(con != null) 
         {
             try
                 {
                    con.close();
                 }
             catch (Exception ignored) {}
         }
   }
%>
<p style="margin-bottom: -1">&nbsp;</p>
<div align="center">
  <center>
  <table border="1" width="80%" height="70%" style="border-style: solid; border-width: 1">
    <tr >
<td width="5%" height="19" style="border-bottom-style: solid" align="Center">
<img src="NFL.jpg" alt="NFL" width="88" height="65" >
</td>
     <td width="95%" height="19" colspan="3" style="border-bottom-style: solid">
     <!-- <p align="center"><b><font size="3" color="#003300">NFL Hospital, Panipat </font><font size="3">OPD SLIP</font></b> -->

<p align="center" >
        <font face="Kruti Dev 011" size="5"><b>us'kuy QfVZykbtlZ fyfeVsM </b></font> <br/><font face="Kruti Dev 011" size="4">,u-,Q-,y- fpfdRlky;] ikuhir </font>
<br/><font face="Kruti Dev 011" size="3">cká jksxh foHkkx ¼vksihMh½ & iphZ</font> </p>
<!--      
  <p align="center" style="line-height: 100%; margin-top: 0; margin-bottom: 0">
        <font face="Kruti Dev 011" size="3">cká jksxh foHkkx ¼vksihMh½ & iphZ</font></p> -->

	</td>

    </tr>
    <tr >
     <td width="15%" height="1">
     <font face="Kruti Dev 011" size="2"> Øe la[;k </font><font size="1" face="Arial"><b>Sr. No.</b></font>  :  </td>
  	 <td width="25%" height="1"><font size="1" face="Arial">&nbsp;<%=srno%></font></td>
   	 <td width="30%" height="1" align="left"> 
<font face="Kruti Dev 011" size="2"> rkjh[k</font> <font size="1" face="Arial"><b>Date</b></font> : </td>
  	 <td width="30%" height="1" align="left"><font size="1" face="Arial">&nbsp;<%=dt%></font></td>
    </tr>
    <tr>
     <td width="15%" height="1" align="left">
<font face="Kruti Dev 011" size="2"> uke</font>&nbsp;<b><font face="Arial" size="1">Name</font></b> :</td>
  </center>
   	 <td width="25%" height="1">
      <p align="left"><font size="1" face="Arial">&nbsp;<%=name%></font></td>
   <center>
     <td width="30%" height="1" align="left">
<font face="Kruti Dev 011" size="2"> laca/k</font>&nbsp;<b><font face="Arial" size="1">Relation</font></b> :</td>
     <td width="30%" height="1" align="left"><font face="Arial" size="1">&nbsp;<%=relation%></font></td>
    </tr>
     <tr>
  	 <td width="25%" height="1">
<font face="Kruti Dev 011" size="2"> deZpkjh la[;k</font>&nbsp;<b><font face="Arial" size="1">E.Code</font></b> :</td>
  	 <td width="15%" height="1"><font size="1" face="Arial">&nbsp;<%=empn%></font></td>
  	 <td width="30%" height="1">
<font face="Kruti Dev 011" size="2"> deZpkjh uke</font>&nbsp;<b><font face="Arial" size="1">E.Name</font></b>:</td>
  	 <td width="30%" height="1"><font size="1" face="Arial">&nbsp;<%=name%></font></td>
    </tr>
     <tr>
  	 <td width="20%" height="1">
<font face="Kruti Dev 011" size="2"> fyax</font>&nbsp;<b><font face="Arial" size="1">Sex</font></b>:</td>
  	 <td width="20%" height="1"><font size="1" face="Arial">&nbsp;<%=sex%></font></td>
  	 <td width="30%" height="1">
<font face="Kruti Dev 011" size="2"> vk;q</font>&nbsp;<b><font face="Arial" size="1">Age</font></b>:</td>
  	 <td width="30%" height="1"><font size="1" face="Arial"><maxlength="2">&nbsp;<%=age1%></font></td>
   </tr>
     <tr>
  	 <td width="100%" height="11" colspan="4" style="border-top-style: solid">
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;
      <p>&nbsp;<p>&nbsp;<p>&nbsp;<p>&nbsp; &nbsp;
      <p>&nbsp;</td>
    </tr>
<!-- <tr><td colspan="4" align="Center"> </td>  </tr> -->

	</table>
<font size="2" face="Arial"><b>Prevention is better than cure</b></font> <font face="Kruti Dev 011" size="3">¼ bykt ls csgrj gS jksdFkke ½</font>
  </center>
</div>
<p align="center"><script>
document.write("<input type='button' " +
"onClick='window.print()' " +
"class='printbutton' " +
"value='Print This Page'/>");
</script>
</p></body>
</html>