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

</head>
<body>
<%
String opdIdParam = request.getParameter("opdId");
	int opdId = (opdIdParam != null) ? Integer.parseInt(opdIdParam) : 0;
	String empn = "";
	String name = "";
	String relation = "Self";
	String age = "";
	String sex = "";
	String dt = "";
	String typ = "N";

	 List<Map<String, String>> prescriptionList = new ArrayList<Map<String, String>>();
    //String dataSourceName = "hosp";
    // String dbURL = "jdbc:oracle:thin:@10.3.126.84:1521:ORCL";
    
  
    
    Connection conn=DBConnect.getConnection(); 

    try 
        {
  
    	 String query = "select PATIENTNAME,RELATION,AGE, to_char(sysdate,'dd-MON-yyyy') as opddate,SEX,EMPN FROM opd where srno=?";           
         
    	 



        PreparedStatement pstmt = conn.prepareStatement(query);
	pstmt.setInt(1, opdId);
	ResultSet rs = pstmt.executeQuery();


        while(rs.next())
	          {
        	     
	             name = rs.getString("PATIENTNAME");
				relation = rs.getString("RELATION");
				empn = rs.getString("EMPN");
				age = rs.getString("AGE");
				
				dt = rs.getString("opddate");
				sex = rs.getString("SEX");
		}
        rs.close();
		pstmt.close();
/* System.out.println("OPD ID: " + opdId);
        System.out.println("Patient Name: " + name);
        System.out.println("Relation: " + relation);
        System.out.println("Age: " + age);
        System.out.println("Date: " + dt);
        System.out.println("Sex " + sex); */
        
        
       

      
        String query2 = 
        "SELECT NVL(mm.MEDICINENAME, 'Unknown Medicine') AS MEDICINE, " +
        "p.DOSAGE, p.FREQUENCY, p.TIMING, p.DAYS " +
        "FROM HOSPITAL.PRESCRIPTION p " +
        "LEFT JOIN HOSPITAL.MEDICINEMASTER mm ON TO_CHAR(p.MEDICINECODE) = TO_CHAR(mm.MEDICINECODE) " +
        "WHERE p.OPD_ID = ?";

    PreparedStatement pstmt2 = conn.prepareStatement(query2);
    pstmt2.setInt(1, opdId);
    ResultSet rs2 = pstmt2.executeQuery();

    while (rs2.next()) {
        Map<String, String> presc = new HashMap<String, String>();
        presc.put("medicine", rs2.getString("MEDICINE"));  // now it's the name
        presc.put("dosage", rs2.getString("DOSAGE"));
        presc.put("frequency", rs2.getString("FREQUENCY"));
        presc.put("timing", rs2.getString("TIMING"));
        presc.put("days", rs2.getString("DAYS"));
        prescriptionList.add(presc);
    }

            rs2.close();
            pstmt2.close();
           
      
	}

	catch (SQLException e) {
		while ((e = e.getNextException()) != null)
	out.println(e.getMessage() + "<BR>");
	}

	finally {
		if (conn != null) {
	try {
		conn.close();
	} catch (Exception ignored) {
	}
		}
	}
   
%>
<p style="margin-bottom: -1">&nbsp;</p>
<div align="center">
  <center>
  <table border="1" width="80%" height="70%" style="border-style: solid; border-width: 1">
    <tr >
<td width="5%" height="19" style="border-bottom-style: solid" align="Center">
<img src="/hosp1/HOSPITAL/OPD/NFL.jpg" alt="NFL" width="88" height="65" >
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
  	 <td width="25%" height="1"><font size="1" face="Arial">&nbsp;<%=opdId%></font></td>
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
  	 <td width="30%" height="1"><font size="1" face="Arial"><maxlength="2">&nbsp;<%=age%></font></td>
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


<% if (!prescriptionList.isEmpty()) { %>
  <br/>
  <h3 align="center">Prescribed Medicines</h3>
  <table border="1" width="80%" align="center" cellpadding="5">
    <thead>
      <tr>
        <th>Medicine</th>
        <th>Dosage</th>
        <th>Frequency</th>
        <th>Timing</th>
        <th>No. of Days</th>
      </tr>
    </thead>
    <tbody>
    <% for (Map<String, String> row : prescriptionList) { %>
      <tr>
        <td><%= row.get("medicine") %></td>
        <td><%= row.get("dosage") %></td>
        <td><%= row.get("frequency") %></td>
        <td><%= row.get("timing") %></td>
        <td><%= row.get("days") %></td>
      </tr>
    <% } %>
    </tbody>
  </table>
<% } else { %>
  <p align="center">No prescriptions found for this OPD ID.</p>
<% } %>


<p align="center"><script>
document.write("<input type='button' " +
"onClick='window.print()' " +
"class='printbutton' " +
"value='Print This Page'/>");
</script>
</p></body>
</html>