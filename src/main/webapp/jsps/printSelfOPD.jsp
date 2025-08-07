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
int opdId = 0;
if (opdIdParam != null) {
    try {
        opdId = Integer.parseInt(opdIdParam);
    } catch (NumberFormatException nfe) {
        opdId = 0;
    }
}

String empn = "";
String name = "";
String relation = "Self";
String age = "";
String sex = "";
String dt = "";

List<Map<String, String>> prescriptionList = new ArrayList<Map<String, String>>();
Set<String> diseaseCodesSet = new HashSet<String>();
String note = null;  // Single note
Map<String, String> diseaseMap = new HashMap<String, String>();

Connection conn = null;
PreparedStatement pstmt = null;
PreparedStatement pstmt2 = null;
Statement stmt = null;
ResultSet rs = null;
ResultSet rs2 = null;
ResultSet rsDiseases = null;

try {
    conn = DBConnect.getConnection();

    // Fetch patient details
    String query = "select PATIENTNAME, RELATION, AGE, to_char(sysdate,'dd-MON-yyyy') as opddate, SEX, EMPN from opd where srno=?";
    pstmt = conn.prepareStatement(query);
    pstmt.setInt(1, opdId);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        name = rs.getString("PATIENTNAME");
        relation = rs.getString("RELATION");
        empn = rs.getString("EMPN");
        age = rs.getString("AGE");
        dt = rs.getString("opddate");
        sex = rs.getString("SEX");
    }
    rs.close();
    pstmt.close();

    // Fetch prescriptions and collect disease codes and notes
    String query2 = 
        "SELECT NVL(mm.MEDICINENAME, 'Unknown Medicine') AS MEDICINE, " +
        "p.DOSAGE, p.FREQUENCY, p.TIMING, p.DAYS, p.NOTES, p.DISEASECODE " +
        "FROM HOSPITAL.PRESCRIPTION p " +
        "LEFT JOIN HOSPITAL.MEDICINEMASTER mm ON TO_CHAR(p.MEDICINECODE) = TO_CHAR(mm.MEDICINECODE) " +
        "WHERE p.OPD_ID = ?";

    pstmt2 = conn.prepareStatement(query2);
    pstmt2.setInt(1, opdId);
    rs2 = pstmt2.executeQuery();

    while (rs2.next()) {
        Map<String, String> presc = new HashMap<String, String>();
        presc.put("medicine", rs2.getString("MEDICINE"));
        presc.put("dosage", rs2.getString("DOSAGE"));
        presc.put("frequency", rs2.getString("FREQUENCY"));
        presc.put("timing", rs2.getString("TIMING"));
        presc.put("days", rs2.getString("DAYS"));
        prescriptionList.add(presc);

        // Set note if not already set
        if (note == null || note.trim().length() == 0) {
            String tempNote = rs2.getString("NOTES");
            if (tempNote != null && tempNote.trim().length() > 0) {
                note = tempNote.trim();
            }
        }

        // Collect disease codes (comma separated)
        String diseaseCodesStr = rs2.getString("DISEASECODE");
        if (diseaseCodesStr != null && diseaseCodesStr.trim().length() > 0) {
            String[] codes = diseaseCodesStr.split(",");
            for (int i = 0; i < codes.length; i++) {
                diseaseCodesSet.add(codes[i].trim());
            }
        }
    }
    rs2.close();
    pstmt2.close();

    // Fetch disease names for collected codes
   //    Map<String, String> diseaseMap = new HashMap<String, String>();
    if (!diseaseCodesSet.isEmpty()) {
        StringBuffer codeList = new StringBuffer();
        Iterator<String> iter = diseaseCodesSet.iterator();
        while (iter.hasNext()) {
            if (codeList.length() > 0) {
                codeList.append(",");
            }
            codeList.append(iter.next());
        }

        String diseaseQuery = "SELECT DISEASE_CODE, DISEASE_NAME FROM HOSPITAL.DISEASES WHERE DISEASE_CODE IN (" + codeList.toString() + ")";
        stmt = conn.createStatement();
        rsDiseases = stmt.executeQuery(diseaseQuery);

        while (rsDiseases.next()) {
            diseaseMap.put(rsDiseases.getString("DISEASE_CODE"), rsDiseases.getString("DISEASE_NAME"));
        }
        rsDiseases.close();
        stmt.close();
    }
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
  	 <td align=center width="100%" height="11" colspan="4" style="border-top-style: solid">
     
     
     
     
     
     <div style="margin: 20px; padding: 10px; width: 80%; box-sizing: border-box; display: flex; justify-content: space-between; align-items: flex-start;">
  <% if (!diseaseMap.isEmpty()) { %>
    <!-- Left side: Heading -->
    <h3 style="margin-right: 20px;margin-top:0; width: 45%; text-align: right;padding-right:20px">Diseases</h3>

    <!-- Right side: Disease list -->
    <div style="width: 50%; text-align: left;">
      <ul style="margin-top: 0; padding-left: 0; list-style-position: inside;">
        <%
          Iterator<String> iter = diseaseCodesSet.iterator();
          while (iter.hasNext()) {
              String code = iter.next();
              String dName = diseaseMap.get(code);
              if (dName == null) {
                  dName = "Unknown Disease (" + code + ")";
              }
        %>
          <li style="font-size:20px;"><%= dName %></li>
        <% } %>
      </ul>
    </div>
  <% } else { %>
    <p style="text-align: center;">No diseases found for this OPD ID.</p>
  <% } %>
</div>


<!-- adding horizontal line -->
<div align="center" style="margin: 20px; border: 1px solid #000;width:80%;"></div>

<!-- Prescriptions List -->
<% if (!prescriptionList.isEmpty()) { %>
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
      <% for (int i = 0; i < prescriptionList.size(); i++) {
            Map<String, String> row = prescriptionList.get(i);
      %>
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


<!-- Additional Notes -->
<% if (note != null && note.length() > 0) { %>
	<h3 align="center">Additional Notes</h3>
<div align="center" style="margin: 20px; border: 1px solid #000; padding: 10px; width: 80%; box-sizing: border-box;">
   
    <p align="center"><%= note %></p>
    </div>
<% } %>


<!-- Doctors name -->

<p align="right" style="margin-bottom:30px; margin-top:80px;margin-right:150px;">Doctor's Signarure     _______________________________</p>

   
<p align="right" style="margin-bottom:50px; margin-right:410px;"><%= (request.getAttribute("doctorName") != null) ? request.getAttribute("doctorName") : "Doctor's Name" %>:-</p>
 

     
      </td>
    </tr>

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