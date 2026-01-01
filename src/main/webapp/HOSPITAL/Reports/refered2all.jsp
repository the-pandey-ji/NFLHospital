<%@ page language="java" session="true" contentType="text/html; charset=windows-1252" %>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<%@ page import="com.DB.DBConnect" %>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Reports</title>
<style type="text/css" media="print">
.printbutton { visibility: hidden; display: none; }
</style>
</head>
<body>
<%@include file="/navbar.jsp" %>

<%
String fromDate = request.getParameter("fromDate");
String toDate = request.getParameter("toDate");

if (fromDate == null || toDate == null || fromDate.trim().isEmpty() || toDate.trim().isEmpty()) {
    out.println("<h3 style='color:red;text-align:center;'>Date range is missing. Please select both From and To dates.</h3>");
    return;
}

// Parse dates
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
java.util.Date fromDateUtil = sdf.parse(fromDate);
java.util.Date toDateUtil = sdf.parse(toDate);
int fromYear = Integer.parseInt(fromDate.substring(0,4));
int toYear = Integer.parseInt(toDate.substring(0,4));

// --- Lists to collect all Local and Outstation records ---
List<Map<String,Object>> localRefs = new ArrayList<Map<String,Object>>();
List<Map<String,Object>> outstationRefs = new ArrayList<Map<String,Object>>();

Connection conn = null, conn1 = null;
PreparedStatement pstmt = null, pstmt1 = null;
ResultSet rs = null, rs1 = null;

try {
    conn = DBConnect.getConnection();
    conn1 = DBConnect.getConnection();

    // --- Loop through all years ---
    for(int yr = fromYear; yr <= toYear; yr++){

        // --- Determine date range for this year ---
        java.sql.Date startDate = (yr == fromYear) ? new java.sql.Date(fromDateUtil.getTime()) : java.sql.Date.valueOf(yr + "-01-01");
        java.sql.Date endDate = (yr == toYear) ? new java.sql.Date(toDateUtil.getTime()) : java.sql.Date.valueOf(yr + "-12-31");

        String localTable = "LOACALREFDETAIL" + yr;
        String outTable = "OUTREFDETAIL" + yr;

        // --- Local References ---
        String localQuery = "SELECT a.REFNO, a.PATIENTNAME, a.EMPN, a.REL, a.AGE, " +
            "TO_CHAR(a.REFDATE,'DD-MM-YYYY') AS REFDATE_FORMATTED, a.doc, c.hname, " +
            "CASE WHEN a.revisitflag='N' THEN 'Refer' WHEN a.revisitflag='Y' THEN 'Revisit' ELSE 'Refer' END AS revisit_status " +
            "FROM " + localTable + " a JOIN LOCALHOSPITAL c ON a.SPECIALIST = c.hcode " +
            "WHERE TRUNC(a.refdate) BETWEEN ? AND ? ORDER BY a.REFDATE DESC";

        pstmt = conn.prepareStatement(localQuery);
        pstmt.setDate(1, startDate);
        pstmt.setDate(2, endDate);
        rs = pstmt.executeQuery();

        while(rs.next()){
            Map<String,Object> row = new HashMap<String,Object>();
            row.put("REFNO", rs.getInt("REFNO"));
            row.put("PATIENTNAME", rs.getString("PATIENTNAME"));
            row.put("EMPN", rs.getInt("EMPN"));
            row.put("REL", rs.getString("REL"));
            row.put("AGE", rs.getString("AGE"));
            row.put("REFDATE", rs.getString("REFDATE_FORMATTED"));
            row.put("DOC", rs.getString("doc"));
            row.put("HNAME", rs.getString("hname"));
            row.put("REVIST", rs.getString("revisit_status"));
            localRefs.add(row);
        }
        if(rs != null){ rs.close(); rs=null;}
        if(pstmt != null){ pstmt.close(); pstmt=null;}

        // --- Outstation References ---
        String outQuery = "SELECT a.REFNO, a.PATIENTNAME, a.EMPN, a.REL, a.AGE, " +
                          "TO_CHAR(a.REFDATE,'DD-MM-YYYY') AS REFDATE_FORMATTED, b.hname, b.city, a.doc, a.ESCORT, " +
                          "CASE WHEN a.revisitflag='N' THEN 'Refer' WHEN a.revisitflag='Y' THEN 'Revisit' ELSE 'Refer' END AS revisit_status " +
                          "FROM " + outTable + " a JOIN OUTSTATIONHOSPITAL b ON a.hospital = b.HCODE " +
                          "WHERE a.refdate BETWEEN ? AND ? ORDER BY a.refno";

        pstmt1 = conn1.prepareStatement(outQuery);
        pstmt1.setDate(1, startDate);
        pstmt1.setDate(2, endDate);
        rs1 = pstmt1.executeQuery();

        while(rs1.next()){
            Map<String,Object> row = new HashMap<String,Object>();
            row.put("REFNO", rs1.getInt("REFNO"));
            row.put("PATIENTNAME", rs1.getString("PATIENTNAME"));
            row.put("EMPN", rs1.getInt("EMPN"));
            row.put("REL", rs1.getString("REL"));
            row.put("AGE", rs1.getString("AGE"));
            row.put("REFDATE", rs1.getString("REFDATE_FORMATTED"));
            row.put("HNAME", rs1.getString("hname")+" - "+rs1.getString("city"));
            row.put("DOC", rs1.getString("doc"));
            row.put("ESCORT", rs1.getString("ESCORT"));
            row.put("REVIST", rs1.getString("revisit_status"));
            outstationRefs.add(row);
        }

        if(rs1 != null){ rs1.close(); rs1=null;}
        if(pstmt1 != null){ pstmt1.close(); pstmt1=null;}
    }

%>

<!-- Display Local References Table -->
<p align="center"><font color="#800000" size="3" face="Tahoma"><b>Local References</b></font></p>
<table border="1" align="center" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="75%">
<tr>
    <td bgcolor="#FFCCCC"><b>REF.NO</b></td>
    <td bgcolor="#FFCCCC"><b>PATIENTNAME</b></td>
    <td bgcolor="#FFCCCC"><b>EMPN</b></td>
    <td bgcolor="#FFCCCC"><b>RELATION</b></td>
    <td bgcolor="#FFCCCC"><b>AGE</b></td>
    <td bgcolor="#FFCCCC"><b>REFDATE</b></td>
    <td bgcolor="#FFCCCC"><b>DOCTOR</b></td>
    <td bgcolor="#FFCCCC"><b>SPECIALIST</b></td>
    <td bgcolor="#FFCCCC"><b>REFER / REVISIT</b></td>
</tr>
<%
for(Map<String,Object> row : localRefs){
%>
<tr>
    <td><%= row.get("REFNO") %></td>
    <td><%= row.get("PATIENTNAME") %></td>
    <td><%= row.get("EMPN") %></td>
    <td><%= row.get("REL") %></td>
    <td><%= row.get("AGE") %></td>
    <td><%= row.get("REFDATE") %></td>
    <td><%= row.get("DOC") %></td>
    <td><%= row.get("HNAME") %></td>
    <td><%= row.get("REVIST") %></td>
</tr>
<%
}
%>
</table>

<!-- Similarly, display Outstation References -->
<p align="center"><font color="#800000" size="3" face="Tahoma"><b>Outstation References</b></font></p>
<table border="1" style="border-collapse: collapse" bordercolor="#111111" width="89%">
<tr>
    <td bgcolor="#FFCCCC"><b>REF.NO</b></td>
    <td bgcolor="#FFCCCC"><b>PATIENTNAME</b></td>
    <td bgcolor="#FFCCCC"><b>EMPN</b></td>
    <td bgcolor="#FFCCCC"><b>REL</b></td>
    <td bgcolor="#FFCCCC"><b>AGE</b></td>
    <td bgcolor="#FFCCCC"><b>REFDATE</b></td>
    <td bgcolor="#FFCCCC"><b>HOSPITAL</b></td>
    <td bgcolor="#FFCCCC"><b>DOCTOR</b></td>
    <td bgcolor="#FFCCCC"><b>ESCORT</b></td>
    <td bgcolor="#FFCCCC"><b>REFER / REVISIT</b></td>
</tr>
<%
for(Map<String,Object> row : outstationRefs){
%>
<tr>
    <td><%= row.get("REFNO") %></td>
    <td><%= row.get("PATIENTNAME") %></td>
    <td><%= row.get("EMPN") %></td>
    <td><%= row.get("REL") %></td>
    <td><%= row.get("AGE") %></td>
    <td><%= row.get("REFDATE") %></td>
    <td><%= row.get("HNAME") %></td>
    <td><%= row.get("DOC") %></td>
    <td><%= row.get("ESCORT") %></td>
    <td><%= row.get("REVIST") %></td>
</tr>
<%
}
%>
</table>

<%
// --- Doctor-wise Summary (Local + Outstation)
Map<String,Integer> doctorSummary = new TreeMap<String,Integer>();

for(Map<String,Object> row : localRefs){
    String doc = row.get("DOC") != null ? row.get("DOC").toString().toUpperCase() : "UNKNOWN";
    doctorSummary.put(doc, doctorSummary.getOrDefault(doc,0)+1);
}
for(Map<String,Object> row : outstationRefs){
    String doc = row.get("DOC") != null ? row.get("DOC").toString().toUpperCase() : "UNKNOWN";
    doctorSummary.put(doc, doctorSummary.getOrDefault(doc,0)+1);
}
%>

<p align="center"><font color="#800000" size="3" face="Tahoma"><b>Doctor-wise Reference Summary</b></font></p>
<table border="1" width="40%" align="center">
<tr>
    <td bgcolor="#FFCCCC"><b>Doctor</b></td>
    <td bgcolor="#FFCCCC" align="center"><b>No of Cases</b></td>
</tr>
<%
for(Map.Entry<String,Integer> entry : doctorSummary.entrySet()){
%>
<tr>
    <td><%= entry.getKey() %></td>
    <td align="center"><%= entry.getValue() %></td>
</tr>
<%
}
%>
</table>

<%
} catch(Exception e){
    out.println("<pre style='color:red;'>Error: "+e.getMessage()+"</pre>");
} finally {
    if(rs != null) try{ rs.close(); } catch(Exception ignored){}
    if(rs1 != null) try{ rs1.close(); } catch(Exception ignored){}
    if(pstmt != null) try{ pstmt.close(); } catch(Exception ignored){}
    if(pstmt1 != null) try{ pstmt1.close(); } catch(Exception ignored){}
    if(conn != null) try{ conn.close(); } catch(Exception ignored){}
    if(conn1 != null) try{ conn1.close(); } catch(Exception ignored){}
}
%>

</body>
</html>
