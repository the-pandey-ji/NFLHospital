<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.* "%>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.User" %>

<%

    // Check if the user is logged in
    User user = (User) session.getAttribute("Docobj");
    if (user == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("/hosp1/index.jsp");
        
        return;
    }
%>


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
String relation = "";
String age = "";
String sex = "";
String dt = "";
String empname = "";

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
    String query = "select PATIENTNAME, RELATION, AGE, to_char(sysdate,'dd-MON-yyyy') as opddate, SEX, EMPN, EMPNAME from opd where srno=?";
    pstmt = conn.prepareStatement(query);
    pstmt.setInt(1, opdId);
    rs = pstmt.executeQuery();
    System.out.println("gabbar is here1");
    if (rs.next()) {
        name = rs.getString("PATIENTNAME");
        relation = rs.getString("RELATION");
        empn = rs.getString("EMPN");
        age = rs.getString("AGE");
        dt = rs.getString("opddate");
        sex = rs.getString("SEX");
        empname = rs.getString("EMPNAME");
        
    }
    rs.close();
    pstmt.close();
    
    
    if (sex != null) {
        if (sex.equalsIgnoreCase("M")) {
            sex = "MALE";
        } else if(sex.equalsIgnoreCase("F")) {
            sex = "FEMALE";
        }
    } else {
        // Handle the case where 'sex' is null, maybe set a default value or show an error
        sex = "UNKNOWN";  // Example fallback
    }


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
  <table border="1" width="100%" height="70%" style="border-style: solid; border-width: 1">
    <tr >
<td width="5%" height="19" style="border-bottom-style: solid" align="Center">
<img src="/hosp1/HOSPITAL/OPD/NFL.jpg" alt="NFL" width="88" height="65" >
</td>
     <td width="95%" height="19" colspan="3" style="border-bottom-style: solid">
     <!-- <p align="center"><b><font size="3" color="#003300">NFL Hospital, Panipat </font><font size="3">OPD SLIP</font></b> -->

<p align="center" >
        <font  size="5"><b>&#2344;&#2375;&#2358;&#2344;&#2354; &#2347;&#2352;&#2381;&#2335;&#2367;&#2354;&#2366;&#2311;&#2332;&#2352;&#2381;&#2360; &#2354;&#2367;&#2350;&#2367;&#2335;&#2375;&#2337; </b></font> <br/><font  size="4">&#2319;&#2344;.&#2319;&#2347;.&#2319;&#2354;. &#2330;&#2367;&#2325;&#2367;&#2340;&#2381;&#2360;&#2366;&#2354;&#2351;, &#2346;&#2366;&#2344;&#2368;&#2346;&#2340;   </font>
<br/><font  size="3">&#2348;&#2366;&#2361;&#2381;&#2351; &#2352;&#2379;&#2327;&#2368; &#2357;&#2367;&#2349;&#2366;&#2327; (&#2323;&#2346;&#2368;&#2337;&#2368;) - &#2346;&#2352;&#2381;&#2330;&#2368;</font> </p>
		
<!--      
  <p align="center" style="line-height: 100%; margin-top: 0; margin-bottom: 0">
        <font size="3">ck� jksxh foHkkx �vksihMh� & iphZ</font></p> -->

	</td>

    </tr>
    <tr >
     <td width="15%" height="1">
     <font  size="2"> &#2325;&#2381;&#2352;&#2350; &#2360;&#2306;&#2326;&#2381;&#2351;&#2366; </font><font size="1" face="Arial"><b>Sr. No.</b></font>  :  </td>
  	 <td width="25%" height="1"><font size="1" face="Arial">&nbsp;<%=opdId%></font></td>
   	 <td width="30%" height="1" align="left"> 
<font  size="2"> &#2340;&#2366;&#2352;&#2368;&#2326;</font> <font size="1" face="Arial"><b>Date</b></font> : </td>
  	 <td width="30%" height="1" align="left"><font size="1" face="Arial">&nbsp;<%=dt%></font></td>
    </tr>
    <tr>
     <td width="15%" height="1" align="left">
<font  size="2">  &#2344;&#2366;&#2350;</font>&nbsp;<b><font face="Arial" size="1">Name</font></b> :</td>
  </center>
   	 <td width="25%" height="1">
      <p align="left"><font size="1" face="Arial">&nbsp;<%=name%></font></td>
   <center>
     <td width="30%" height="1" align="left">
<font  size="2">   &#2360;&#2306;&#2348;&#2306;&#2343;</font>&nbsp;<b><font face="Arial" size="1">Relation</font></b> :</td>
     <td width="30%" height="1" align="left"><font face="Arial" size="1">&nbsp;<%=relation%></font></td>
    </tr>
     <tr>
  	 <td width="25%" height="1">
<font  size="2"> &#2325;&#2352;&#2381;&#2350;&#2330;&#2366;&#2352;&#2368; &#2360;&#2306;&#2326;&#2381;&#2351;&#2366;</font>&nbsp;<b><font face="Arial" size="1">E.Code</font></b> :</td>
  	 <td width="15%" height="1"><font size="1" face="Arial">&nbsp;<%=empn%></font></td>
  	 <td width="30%" height="1">
<font  size="2"> &#2325;&#2352;&#2381;&#2350;&#2330;&#2366;&#2352;&#2368; &#2344;&#2366;&#2350;</font>&nbsp;<b><font face="Arial" size="1">E.Name</font></b>:</td>
  	 <td width="30%" height="1"><font size="1" face="Arial">&nbsp;<%=empname%></font></td>
    </tr>
     <tr>
  	 <td width="20%" height="1">
<font  size="2"> &#2354;&#2367;&#2306;&#2327;</font>&nbsp;<b><font face="Arial" size="1">Sex</font></b>:</td>
  	 <td width="20%" height="1"><font size="1" face="Arial">&nbsp;<%=sex%></font></td>
  	 <td width="30%" height="1">
<font  size="2"> &#2310;&#2351;&#2369;</font>&nbsp;<b><font face="Arial" size="1">Age</font></b>:</td>
  	 <td width="30%" height="1"><font size="1" face="Arial"><maxlength="2">&nbsp;<%=age%></font></td>
   </tr>
     <tr>
  	 <td align=center width="100%" height="11" colspan="4" style="border-top-style: solid">
     
     
     
     
     
     <div style="margin: 2px; padding: 1px; width: 80%; box-sizing: border-box; display: flex; justify-content: space-between; align-items: flex-start;">
  <% if (!diseaseMap.isEmpty()) { %>
    <!-- Left side: Heading -->
    <h3 style="margin-right: 20px;margin-top:0; width: 45%; text-align: right;padding-right:20px"><font face="Arial" size="2.5"> &#2348;&#2368;&#2350;&#2366;&#2352;&#2367;&#2351;&#2366;&#2305;</font>&nbsp; Diseases</h3>

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
<div align="center" style=" border: 1px solid #000;width:90%;"></div>

<!-- Prescriptions List -->
<% if (!prescriptionList.isEmpty()) { %>
    <h3 align="center"><font face="Arial" size="2.5">&#2344;&#2367;&#2351;&#2369;&#2325;&#2381;&#2340; &#2325;&#2368; &#2327;&#2312; &#2342;&#2357;&#2366;&#2311;&#2351;&#2366;&#2305;</font>&nbsp; Prescribed Medicines</h3>
    <table border="1" width="90%" align="center" cellpadding="5">
      <thead>
        <tr>
          <th><font face="Arial" size="2.5">&#2342;&#2357;&#2366;</font> Medicine</th>
          <th><font face="Arial" size="2.5"> &#2326;&#2369;&#2352;&#2366;&#2325;</font> Dosage</th>
          <th><font face="Arial" size="2.5">&#2310;&#2357;&#2371;&#2340;&#2381;&#2340;&#2367;</font> Frequency</th>
          <th><font face="Arial" size="2.5">&#2360;&#2350;&#2351;</font> Timing</th>
          <th><font face="Arial" size="2.5">&#2342;&#2367;&#2344;</font> No. of Days</th>
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

<p align="right" style="margin-bottom:30px; margin-top:80px;margin-right:150px;"><font face="Arial" size="2.5">&#2337;&#2377;&#2325;&#2381;&#2335;&#2352; &#2325;&#2375;  &#2361;&#2360;&#2381;&#2340;&#2366;&#2325;&#2381;&#2359;&#2352;</font>&nbsp; Doctor's Signarure    _____________</p>
 <%
		   
	        User user1 = (User) session.getAttribute("Docobj");
	        
	    %>
   
<p align="right" style="margin-bottom:50px; margin-right:140px;"><font face="Arial" size="2.5">&#2337;&#2377;&#2325;&#2381;&#2335;&#2352; &#2325;&#2366; &#2344;&#2366;&#2350;</font>&nbsp; Doctor's Name : <%=user1.getUsername() %></p>
 

     
      </td>
    </tr>

	</table>
<font size="2" face="Arial"><b>Prevention is better than cure</b></font> <font  size="3">( &#2311;&#2354;&#2366;&#2332; &#2360;&#2375; &#2348;&#2375;&#2361;&#2340;&#2352; &#2361;&#2376; &#2352;&#2379;&#2325;&#2341;&#2366;&#2350; )</font>
  </center>
</div>


<script>
function printAndHide(btn) {
  btn.style.display = 'none';
  window.print();
  btn.style.display = 'inline';
}
</script>

<p align="center">
  <input type="button" class="printbutton" value="&#2346;&#2381;&#2352;&#2367;&#2306;&#2335; &#2325;&#2352;&#2375;&#2306; Print This Page" onclick="printAndHide(this)" />
</p>

</body>
</html>