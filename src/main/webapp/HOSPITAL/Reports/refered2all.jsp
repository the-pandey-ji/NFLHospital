<%@ page language="java" session="true" contentType="text/html; charset=windows-1252" %>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<%@ page import="com.DB.DBConnect" %>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Reports</title>
<style type="text/css" media="print">
.printbutton {
    visibility: hidden;
    display: none;
}
</style>
</head>
<body>

<%
String fromDate = request.getParameter("fromDate");
String toDate = request.getParameter("toDate");

if (fromDate == null || toDate == null || fromDate.trim().isEmpty() || toDate.trim().isEmpty()) {
    out.println("<h3 style='color:red;text-align:center;'>Date range is missing. Please go back and select both From and To dates.</h3>");
    return;
}

int refno;
String pname;
int empn;
String relation;
String age;
String refdt;
String doctor;
String spc;
String yr = "";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    conn = DBConnect.getConnection();

    // Get current year
    pstmt = conn.prepareStatement("SELECT TO_CHAR(SYSDATE, 'YYYY') FROM dual");
    rs = pstmt.executeQuery();
    if (rs.next()) {
        yr = rs.getString(1);
    }
    rs.close();
    pstmt.close();

    // Query local references
    String localQuery = "SELECT a.REFNO, a.PATIENTNAME, a.EMPN, a.REL, a.AGE, " +
        "TO_CHAR(a.REFDATE, 'DD-MM-YYYY') AS REFDATE_FORMATTED, a.doc, c.hname, " +
        "CASE WHEN a.revisitflag = 'N' THEN 'Refer' WHEN a.revisitflag = 'Y' THEN 'Revisit' ELSE 'Refer' END AS revisit_status " +
        "FROM LOACALREFDETAIL" + yr + " a " +
        "JOIN LOCALHOSPITAL c ON a.SPECIALIST = c.hcode " +
        "WHERE a.refdate BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
        "ORDER BY a.REFDATE DESC";

    pstmt = conn.prepareStatement(localQuery);
    pstmt.setString(1, fromDate);
    pstmt.setString(2, toDate);
    rs = pstmt.executeQuery();
%>

<p align="center"><font color="#800000" size="3" face="Tahoma"><b>Details of Local References</b></font></p>
<table border="1" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse" bordercolor="#111111" width="75%" height="38">
  <tr>
    <td bgcolor="#FFCCCC"><b><font SIZE="2">REF.NO</font></b></td>
    <td bgcolor="#FFCCCC"><b><font SIZE="2">PATIENTNAME</font></b></td>
    <td bgcolor="#FFCCCC"><b><font SIZE="2">EMPN</font></b></td>
    <td bgcolor="#FFCCCC"><b><font SIZE="2">RELATION</font></b></td>
    <td bgcolor="#FFCCCC"><b><font SIZE="2">REF.DATE</font></b></td>
    <td bgcolor="#FFCCCC"><b><font SIZE="2">DOCTOR</font></b></td>
    <td bgcolor="#FFCCCC"><b><font SIZE="2">SPECIALIST</font></b></td>
    <td bgcolor="#FFCCCC"><font size="2"><b>REFER / REVISIT</b></font></td>
  </tr>

<%
    while (rs.next()) {
        refno = rs.getInt("REFNO");
        pname = rs.getString("PATIENTNAME");
        empn = rs.getInt("EMPN");
        relation = rs.getString("REL");
        age = rs.getString("AGE");
        refdt = rs.getString("REFDATE_FORMATTED");
        doctor = rs.getString("doc");
        spc = rs.getString("hname");
        String revisit = rs.getString("revisit_status");
%>
  <tr>
    <td><%= refno %></td>
    <td><%= pname %></td>
    <td><%= empn %></td>
    <td><%= relation %></td>
    <td><%= refdt %></td>
    <td><%= doctor %></td>
    <td><%= spc %></td>
    <td><%= revisit %></td>
  </tr>
<%
    }
    rs.close();
    pstmt.close();
} catch (SQLException e) {
    out.println("<pre style='color:red;'>SQL Error: " + e.getMessage() + "</pre>");
} finally {
    if (rs != null) try { rs.close(); } catch (Exception ignored) {}
    if (pstmt != null) try { pstmt.close(); } catch (Exception ignored) {}
    if (conn != null) try { conn.close(); } catch (Exception ignored) {}
}
%>
</table>

<!-- Specialist Summary -->
<p align="center"><font color="#800000" size="3" face="Tahoma"><b>Referred Detail</b></font></p>
<div align="center">
  <center>
    <table border="1" width="29%">
      <tr>
        <td bgcolor="#FFCCCC"><font face="Tahoma"><b>Specialist</b></font></td>
        <td bgcolor="#FFCCCC" align="center"><font face="Tahoma"><b>No of cases</b></font></td>
      </tr>

<%
Connection conn1 = null;
PreparedStatement pstmt1 = null;
ResultSet rs1 = null;
try {
    conn1 = DBConnect.getConnection();

    String specialistQuery = "SELECT b.hname, COUNT(*) FROM LOACALREFDETAIL" + yr + " a, LOCALHOSPITAL b " +
                             "WHERE a.SPECIALIST = b.hcode AND a.refdate BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
                             "GROUP BY b.hname";

    pstmt1 = conn1.prepareStatement(specialistQuery);
    pstmt1.setString(1, fromDate);
    pstmt1.setString(2, toDate);
    rs1 = pstmt1.executeQuery();

    while (rs1.next()) {
        String special = rs1.getString(1);
        String nos = rs1.getString(2);
%>
      <tr>
        <td><font face="Tahoma" size="2"><%= special.toUpperCase() %></font></td>
        <td align="center"><font face="Tahoma" size="2"><%= nos %></font></td>
      </tr>
<%
    }
    rs1.close();

    pstmt1.close();

    pstmt1 = conn1.prepareStatement(
        "SELECT COUNT(*) FROM LOACALREFDETAIL" + yr + " WHERE refdate BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')"
    );
    pstmt1.setString(1, fromDate);
    pstmt1.setString(2, toDate);
    rs1 = pstmt1.executeQuery();
    String total = "0";
    if (rs1.next()) {
        total = rs1.getString(1);
    }
%>
      <tr>
        <td><font face="Tahoma" size="2">Total</font></td>
        <td align="center"><font face="Tahoma" size="2"><%= total %></font></td>
      </tr>
<%
} catch (SQLException e) {
    out.println("<pre style='color:red;'>SQL Error: " + e.getMessage() + "</pre>");
} finally {
    if (rs1 != null) try { rs1.close(); } catch (Exception ignored) {}
    if (pstmt1 != null) try { pstmt1.close(); } catch (Exception ignored) {}
    if (conn1 != null) try { conn1.close(); } catch (Exception ignored) {}
}
%>
    </table>
  </center>
</div>



<!-- Outstation References -->
<p align="center"><b><font color="#800000" face="Tahoma" size="3">Out Station References</font></b></p>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="89%">
  <tr>
    <td bgcolor="#FFCCCC"><font SIZE="2"><b>REFNO</b></font></td>
    <td bgcolor="#FFCCCC"><font SIZE="2"><b>PATIENTNAME</b></font></td>
    <td bgcolor="#FFCCCC"><font SIZE="2"><b>EMPN</b></font></td>
    <td bgcolor="#FFCCCC"><font SIZE="2"><b>REL</b></font></td>
    <td bgcolor="#FFCCCC"><font SIZE="2"><b>AGE</b></font></td>
    <td bgcolor="#FFCCCC"><font SIZE="2"><b>REFDATE</b></font></td>
    <td bgcolor="#FFCCCC"><font SIZE="2"><b>HOSPITAL</b></font></td>
    <td bgcolor="#FFCCCC"><font SIZE="2"><b>DOC</b></font></td>
    <td bgcolor="#FFCCCC"><font SIZE="2"><b>ESCORT</b></font></td>
    <td bgcolor="#FFCCCC"><font SIZE="2"><b>REFER / REVISIT</b></font></td>
  </tr>

<%
Connection conn2 = null;
PreparedStatement pstmt2 = null;
ResultSet rs2 = null;
try {
    conn2 = DBConnect.getConnection();

    String outstationQuery = "SELECT a.REFNO, a.PATIENTNAME, a.EMPN, a.REL, a.AGE, " +
                            "TO_CHAR(a.REFDATE, 'DD-MM-YYYY') AS REFDATE_FORMATTED, b.hname, b.city, a.doc, a.ESCORT, " +
                            "CASE WHEN a.revisitflag = 'N' THEN 'Refer' WHEN a.revisitflag = 'Y' THEN 'Revisit' ELSE 'Refer' END AS revisit_status " +
                            "FROM OUTREFDETAIL" + yr + " a " +
                            "JOIN OUTSTATIONHOSPITAL b ON a.hospital = b.HCODE " +
                            "WHERE a.refdate BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
                            "ORDER BY a.refno";

    pstmt2 = conn2.prepareStatement(outstationQuery);
    pstmt2.setString(1, fromDate);
    pstmt2.setString(2, toDate);
    rs2 = pstmt2.executeQuery();

    while (rs2.next()) {
%>
  <tr>
    <td><%= rs2.getInt("REFNO") %></td>
    <td><%= rs2.getString("PATIENTNAME") %></td>
    <td><%= rs2.getInt("EMPN") %></td>
    <td><%= rs2.getString("REL") %></td>
    <td><%= rs2.getString("AGE") %></td>
    <td><%= rs2.getString("REFDATE_FORMATTED") %></td>
    <td><%= rs2.getString("hname") %> - <%= rs2.getString("city") %></td>
    <td><%= rs2.getString("doc") %></td>
    <td><%= rs2.getString("ESCORT") %></td>
    <td><%= rs2.getString("revisit_status") %></td>
  </tr>
<%
    }
} catch (SQLException e) {
    out.println("<pre style='color:red;'>SQL Error: " + e.getMessage() + "</pre>");
} finally {
    if (rs2 != null) try { rs2.close(); } catch (Exception ignored) {}
    if (pstmt2 != null) try { pstmt2.close(); } catch (Exception ignored) {}
    if (conn2 != null) try { conn2.close(); } catch (Exception ignored) {}
}
%>
</table>

<p align="center"><font color="#800000" size="3" face="Tahoma"><b>Outstation Specialist Summary</b></font></p>
<div align="center">
  <center>
    <table border="1" width="29%">
      <tr>
        <td bgcolor="#FFCCCC"><font face="Tahoma"><b>Specialist</b></font></td>
        <td bgcolor="#FFCCCC" align="center"><font face="Tahoma"><b>No of cases</b></font></td>
      </tr>

<%
Connection conn3 = null;
PreparedStatement pstmt3 = null;
ResultSet rs3 = null;
try {
    conn3 = DBConnect.getConnection();

    // Query for specialist-wise count
    String outstationSpecialistQuery = "SELECT b.hname, COUNT(*) " +
                                       "FROM OUTREFDETAIL" + yr + " a, OUTSTATIONHOSPITAL b " +
                                       "WHERE a.hospital = b.hcode AND a.refdate BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
                                       "GROUP BY b.hname";

    pstmt3 = conn3.prepareStatement(outstationSpecialistQuery);
    pstmt3.setString(1, fromDate);
    pstmt3.setString(2, toDate);
    rs3 = pstmt3.executeQuery();

    while (rs3.next()) {
        String specialist = rs3.getString(1);
        String count = rs3.getString(2);
%>
      <tr>
        <td><font face="Tahoma" size="2"><%= specialist.toUpperCase() %></font></td>
        <td align="center"><font face="Tahoma" size="2"><%= count %></font></td>
      </tr>
<%
    }
    rs3.close();
    pstmt3.close();

    // Query for total count
    pstmt3 = conn3.prepareStatement(
        "SELECT COUNT(*) FROM OUTREFDETAIL" + yr + " WHERE refdate BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')"
    );
    pstmt3.setString(1, fromDate);
    pstmt3.setString(2, toDate);
    rs3 = pstmt3.executeQuery();

    String total = "0";
    if (rs3.next()) {
        total = rs3.getString(1);
    }
%>
      <tr>
        <td><font face="Tahoma" size="2">Total</font></td>
        <td align="center"><font face="Tahoma" size="2"><%= total %></font></td>
      </tr>
<%
} catch (SQLException e) {
    out.println("<pre style='color:red;'>SQL Error: " + e.getMessage() + "</pre>");
} finally {
    if (rs3 != null) try { rs3.close(); } catch (Exception ignored) {}
    if (pstmt3 != null) try { pstmt3.close(); } catch (Exception ignored) {}
    if (conn3 != null) try { conn3.close(); } catch (Exception ignored) {}
}
%>
    </table>
  </center>
</div>



<p align="center"><font color="#800000" size="3" face="Tahoma"><b>Doctor-wise Reference Summary (Local + Outstation)</b></font></p>
<div align="center">
  <table border="1" width="40%">
    <tr>
      <td bgcolor="#FFCCCC"><font face="Tahoma"><b>Doctor</b></font></td>
      <td bgcolor="#FFCCCC" align="center"><font face="Tahoma"><b>No of Cases</b></font></td>
      <td bgcolor="#FFCCCC" align="center"><font face="Tahoma"><b>Reference Type</b></font></td>
    </tr>

<%
Connection connDoc = null;
PreparedStatement pstmtDoc = null;
ResultSet rsDoc = null;

try {
    connDoc = DBConnect.getConnection();

    // LOCAL references: doctor-wise summary
    // LOCAL references: doctor-wise summary (case-insensitive)
String localDoctorQuery = "SELECT UPPER(a.doc) AS doc, COUNT(*) FROM LOACALREFDETAIL" + yr + " a " +
                          "WHERE a.refdate BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
                          "GROUP BY UPPER(a.doc) ORDER BY UPPER(a.doc)";


    pstmtDoc = connDoc.prepareStatement(localDoctorQuery);
    pstmtDoc.setString(1, fromDate);
    pstmtDoc.setString(2, toDate);
    rsDoc = pstmtDoc.executeQuery();

    while (rsDoc.next()) {
       doctor = rsDoc.getString(1);
        String count = rsDoc.getString(2);
%>
    <tr>
      <td><font face="Tahoma" size="2"><%= doctor != null ? doctor.toUpperCase() : "UNKNOWN" %></font></td>
      <td align="center"><font face="Tahoma" size="2"><%= count %></font></td>
      <td align="center"><font face="Tahoma" size="2">Local</font></td>
    </tr>
<%
    }
    rsDoc.close();
    pstmtDoc.close();

    // OUTSTATION references: doctor-wise summary
    String outDoctorQuery = "SELECT a.doc, COUNT(*) FROM OUTREFDETAIL" + yr + " a " +
                            "WHERE a.refdate BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
                            "GROUP BY a.doc ORDER BY a.doc";

    pstmtDoc = connDoc.prepareStatement(outDoctorQuery);
    pstmtDoc.setString(1, fromDate);
    pstmtDoc.setString(2, toDate);
    rsDoc = pstmtDoc.executeQuery();

    while (rsDoc.next()) {
         doctor = rsDoc.getString(1);
        String count = rsDoc.getString(2);
%>
    <tr>
      <td><font face="Tahoma" size="2"><%= doctor != null ? doctor.toUpperCase() : "UNKNOWN" %></font></td>
      <td align="center"><font face="Tahoma" size="2"><%= count %></font></td>
      <td align="center"><font face="Tahoma" size="2">Outstation</font></td>
    </tr>
<%
    }

} catch (SQLException e) {
    out.println("<pre style='color:red;'>SQL Error: " + e.getMessage() + "</pre>");
} finally {
    if (rsDoc != null) try { rsDoc.close(); } catch (Exception ignored) {}
    if (pstmtDoc != null) try { pstmtDoc.close(); } catch (Exception ignored) {}
    if (connDoc != null) try { connDoc.close(); } catch (Exception ignored) {}
}
%>

  </table>
</div>


</body>
</html>
