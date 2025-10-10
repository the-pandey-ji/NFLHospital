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

    // Check if the user is logged in comming from session
    User user = (User) session.getAttribute("Docobj");
    if (user == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("/hosp1/index.jsp");
        
        return;
    }
%>


<html>
<head>
  <meta charset="UTF-8">
  <title>OPD Slip</title>
  <style>
    body {
      font-family: 'Noto Sans Devanagari', 'Mangal', Arial, sans-serif;
    }
     @media print {
    @page {
      size: A5;
      margin: 5mm;
    }

    body {
      zoom: 0.7; /* 70% scale */
    }

    .printbutton {
      display: none !important; /* Hide print button during printing */
    }
  }
  </style>
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
String note ="";  // Single note
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
    String query = "select PATIENTNAME, RELATION, AGE, to_char(opddate,'dd-mm-yyyy') as opddate, SEX, EMPN, EMPNAME from opd where srno=?";
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
        empname = rs.getString("EMPNAME");
        
    }
    rs.close();
    pstmt.close();
    
    sex=sex.trim();
    
    if (sex.equalsIgnoreCase("M")) {
    	sex = "MALE";
    		} else if(sex.equalsIgnoreCase("F")) {
    	sex = "FEMALE";}
    		else
    			sex = "Unknown";

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
<div align="center">
  <center>
  <table border="1" width="100%" height="278" style="border-style: solid; border-width: 1">
    <tr >
<td width="10%" height="96" style="border-bottom-style: solid" align="Center">
<img src="/hosp1/HOSPITAL/OPD/NFL.jpg" alt="NFL" width="88" height="65" >
</td>
     <td width="98%" height="96" colspan="3" style="border-bottom-style: solid">
     <!-- <p align="center"><b><font size="3" color="#003300">NFL Hospital, Panipat </font><font size="3">OPD SLIP</font></b> -->

<p align="center" style="margin-top: 0; margin-bottom: 0" >
                <font  size="5"><b>&#2344;&#2375;&#2358;&#2344;&#2354; &#2347;&#2352;&#2381;&#2335;&#2367;&#2354;&#2366;&#2311;&#2332;&#2352;&#2381;&#2360; &#2354;&#2367;&#2350;&#2367;&#2335;&#2375;&#2337; </b></font> </p>

<p align="center" style="margin-top: 0; margin-bottom: 0" >
                <font  size="4">&#2319;&#2344;.&#2319;&#2347;.&#2319;&#2354;. &#2330;&#2367;&#2325;&#2367;&#2340;&#2381;&#2360;&#2366;&#2354;&#2351;, &#2346;&#2366;&#2344;&#2368;&#2346;&#2340;   </font>
     </p>

<p align="center" style="margin-top: 0; margin-bottom: 0" >
                <font  size="3">&#2348;&#2366;&#2361;&#2381;&#2351; &#2352;&#2379;&#2327;&#2368; &#2357;&#2367;&#2349;&#2366;&#2327; (&#2323;&#2346;&#2368;&#2337;&#2368;) - &#2346;&#2352;&#2381;&#2330;&#2368;</font> </p>
<!--      
  <p align="center" style="line-height: 100%; margin-top: 0; margin-bottom: 0">
        <font size="3">cká jksxh foHkkx ¼vksihMh½ & iphZ</font></p> -->

	</td>

    </tr>
    <tr >
     <td width="12%" height="38">
     <font  size="3"> &#2325;&#2381;&#2352;&#2350; &#2360;&#2306;&#2326;&#2381;&#2351;&#2366; </font><font size="3" face="Arial"><b>Sr. No.</b></font>  :  </td>
  	 <td width="28%" height="38"><font size="3" face="Arial">&nbsp;<%=opdId%></font></td>
   	 <td width="21%" height="38" align="left"> 
<font  size="3"> &#2340;&#2366;&#2352;&#2368;&#2326;</font> <font size="3" face="Arial"><b>Date</b></font> : </td>
  	 <td width="39%" height="38" align="left"><font size="3" face="Arial">&nbsp;<%=dt%></font></td>
    </tr>
    <tr>
     <td width="12%" height="38" align="left">
<font  size="3">  &#2344;&#2366;&#2350;</font>&nbsp;<b><font face="Arial" size="2.5">Name</font></b> :</td>
  </center>
   	 <td width="28%" height="38">
      <p align="left"><font size="3" face="Arial">&nbsp;<%=name%></font></td>
   <center>
     <td width="21%" height="38" align="left">
<font  size="3">   &#2360;&#2306;&#2348;&#2306;&#2343;</font>&nbsp;<b><font face="Arial" size="2.5">Relation</font></b> :</td>
     <td width="39%" height="38" align="left"><font face="Arial" size="3">&nbsp;<%=relation%></font></td>
    </tr>
     <tr>
  	 <td width="22%" height="38">
<font  size="3"> &#2325;&#2352;&#2381;&#2350;&#2330;&#2366;&#2352;&#2368; &#2360;&#2306;&#2326;&#2381;&#2351;&#2366;</font>&nbsp;<b><font face="Arial" size="2.5">E.Code</font></b>:</td>
  	 <td width="18%" height="38"><font size="3" face="Arial">&nbsp;<%=empn%></font></td>
  	 <td width="21%" height="38">
<font  size="3"> &#2325;&#2352;&#2381;&#2350;&#2330;&#2366;&#2352;&#2368; &#2344;&#2366;&#2350;</font>&nbsp;<b><font face="Arial" size="2.5">E.Name</font></b>:</td>
  	 <td width="39%" height="38"><font size="3" face="Arial">&nbsp;<%=empname%></font></td>
    </tr>
     <tr>
  	 <td width="17%" height="38">
<font  size="3"> &#2354;&#2367;&#2306;&#2327;</font>&nbsp;<b><font face="Arial" size="2.5">Sex</font></b>:</td>
  	 <td width="23%" height="38"><font size="3" face="Arial">&nbsp;<%=sex%></font></td>
  	 <td width="21%" height="38">
<font  size="3"> &#2310;&#2351;&#2369;</font>&nbsp;<b><font face="Arial" size="2.5">Age</font></b>:</td>
  	 <td width="39%" height="38"><maxlength="2"><font size="3" face="Arial">&nbsp;<%=age%></font></td>
   </tr>
    
	</table>
     
     
     <div style="margin:-15;margin-top: 2px; padding: 0px; width: 100%; box-sizing: border-box; display: flex; justify-content: space-between; align-items: flex-start;">
  <% if (!diseaseMap.isEmpty()) { %>
    <!-- Left side: Heading -->

    <h3 style="margin-right: 0px;margin-top:0; width: 45%; text-align: right;padding-right:20px"><font face="Arial" size="3"> &#2348;&#2368;&#2350;&#2366;&#2352;&#2368; /</font> Disease</h3>

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
    <p style="text-align: center;">No disease found for this OPD .</p>
  <% } %>
</div>


<!-- adding horizontal line -->
<div align="center" style=" border: 1px solid #000;width:80%;margin-bottom:-10px;"></div>

<!-- Prescriptions List -->
<%
List<Map<String, String>> validPrescriptionList = new ArrayList<Map<String, String>>();
for (Map<String, String> row : prescriptionList) {
    String medicine = row.get("medicine");
    if (medicine != null && !medicine.trim().equalsIgnoreCase("Unknown Medicine")) {
        validPrescriptionList.add(row);
    }
}
%>

<% if (!validPrescriptionList.isEmpty()) { %>
    <h3 align="center">
        <font face="Arial" size="3">
            &#x928;&#x93f;&#x930;&#x94d;&#x926;&#x93f;&#x937;&#x94d;&#x91f;&#x20;&#x914;&#x937;&#x927;&#x93f; /
        </font> Prescribed Medicines
    </h3>
    <table border="1" width="100%" align="center" cellpadding="5">
      <thead>
        <tr>
          <th width="40%"><font face="Arial" size="2.5">&#2342;&#2357;&#2366;</font> Medicine</th>
          <th width="40%"><font face="Arial" size="2.5">&#2326;&#2369;&#2352;&#2366;&#2325;</font> Dose</th>
          <!-- <th width="253"><font face="Arial" size="2.5">&#2360;&#2350;&#2351;</font> Timing</th> -->
          <th width="20%"><font face="Arial" size="2.5">&#2342;&#2367;&#2344;</font> Days</th>
        </tr>
      </thead>
      <tbody>
      <% for (Map<String, String> row : validPrescriptionList) { %>
        <tr>
          <td  width="705"><%= row.get("medicine") %></td>
          <td align="center" width="254"><%= row.get("dosage") %></td>
          <%-- <td width="253"><%= row.get("timing") %></td> --%>
          <td align="center" width="165"><%= row.get("days") %></td>
        </tr>
      <% } %>
      </tbody>
    </table>
<% } else { %>
    <p align="center"><b>No medicines prescribed.</b></p>

    <%}User user1 = (User) session.getAttribute("Docobj"); %>
	
<div align="center" style=" margin:10px;  padding: -10px; width: 99%;height:39;box-sizing: border-box; display: flex; align-items: flex-start;">
   <h3 align="left" style="margin-top: 0;width: 35%; margin-bottom: 0">Additional Notes (if any) : </h3>
    <p align="left" style="margin-top: 3px;width: 63%; margin-bottom: 0"><%= note %></p>
    </div>

<p align="right" style="margin-bottom:0; margin-top:0;margin-right:10px">&nbsp;</p>

<p align="right" style="margin-bottom:0; margin-top:0;margin-right:10px"><font face="Arial" size="2.5">&#2337;&#2377;&#2325;&#2381;&#2335;&#2352; &#2325;&#2375;  &#2361;&#2360;&#2381;&#2340;&#2366;&#2325;&#2381;&#2359;&#2352;</font>&nbsp;_____________</p>
   
<p align="right" style="margin-bottom:0; margin-right:10px; margin-top:0"><font face="Arial" size="2.5">&#2337;&#2377;&#2325;&#2381;&#2335;&#2352; &#2325;&#2366; &#2344;&#2366;&#2350;</font>&nbsp;<%=user1.getUsername() %></p>
 
<div align="center" style=" border: 1px solid #000;width:80%;margin-bottom:-5px;"></div>
     
      <font size="2" face="Arial"><b>Prevention is better than cure</b></font> <font  size="3">( &#2311;&#2354;&#2366;&#2332; &#2360;&#2375; &#2348;&#2375;&#2361;&#2340;&#2352; &#2361;&#2376; &#2352;&#2379;&#2325;&#2341;&#2366;&#2350; )</font>
  </center>
</div>



<!-- <p align="center"><script>
document.write("<input type='button' " +
"onClick='window.print()' " +
"class='printbutton' " +
"value='Print This Page'/>");
</script>
</p> -->
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