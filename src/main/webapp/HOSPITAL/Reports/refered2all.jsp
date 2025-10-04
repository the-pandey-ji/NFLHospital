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
String fromDate = request.getParameter("fromDateFormatted");
String toDate = request.getParameter("toDateFormatted");

System.out.println("Received fromDate: " + fromDate + ", toDate: " + toDate);

if (fromDate == null || toDate == null || fromDate.equals("") || toDate.equals("")) {
    out.println("<h3 style='color:red;text-align:center;'>Date range is missing. Please go back and select both From and To dates.</h3>");
    return;
}

System.out.println("From Date: " + fromDate + ", To Date: " + toDate);

int refno = 0;
String pname = "";
int empn = 0;
String relation = "";
String age = "";
String refdt = "";
String sex = "";
String disease = "";
String doctor = "";
String spc = "";
String yr = "";
String revisit = "";
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
Connection conn = null;
try {
    conn = DBConnect.getConnection();
    Statement stmt = conn.createStatement();

    ResultSet rsyr = stmt.executeQuery("select to_char(sysdate,'yyyy') from dual");
    if (rsyr.next()) {
        yr = rsyr.getString(1);
    }

    ResultSet rs = stmt.executeQuery(
        "SELECT a.REFNO, a.PATIENTNAME, a.EMPN, a.REL, a.AGE, " +
        "TO_CHAR(a.REFDATE, 'DD-MM-YYYY'), a.doc, c.hname, " +
        "CASE WHEN a.revisitflag = 'N' THEN 'Refer' " +
        "WHEN a.revisitflag = 'Y' THEN 'Revisit' " +
        "ELSE 'Refer' END AS revisit_status " +
        "FROM LOACALREFDETAIL" + yr + " a " +
        "JOIN LOCALHOSPITAL c ON a.SPECIALIST = c.hcode " +
        "WHERE TO_CHAR(a.refdate, 'DDMMYYYY') BETWEEN '" + fromDate + "' AND '" + toDate + "' " +
        "ORDER BY a.REFDATE DESC"
    );

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
    <td><%=refno%></td>
    <td><%=pname%></td>
    <td><%=empn%></td>
    <td><%=relation%></td>
    <td><%=refdt%></td>
    <td><%=doctor%></td>
    <td><%=spc%></td>
    <td><%=revisit%></td>
  </tr>
<%
    }
} catch (SQLException e) {
    while ((e = e.getNextException()) != null) out.println(e.getMessage() + "<BR>");
} finally {
    if (conn != null) try { conn.close(); } catch (Exception ignored) {}
}
%>
</table>

<!-- Specialist Summary -->
<p align="center"><font color="#800000"><font size="3" face="Tahoma"><b>Referred Detail</b></font></font></p>
<div align="center">
  <center>
    <table border="1" width="29%">
      <tr>
        <td bgcolor="#FFCCCC"><font face="Tahoma"><b>Specialist</b></font></td>
        <td bgcolor="#FFCCCC" align="center"><font face="Tahoma"><b>No of cases</b></font></td>
      </tr>

<%
String special = "", nos = "", total = "";
Connection conn1 = null;
try {
    conn1 = DBConnect.getConnection();
    Statement stmt = conn1.createStatement();

    ResultSet rs = stmt.executeQuery(
        "SELECT b.hname, COUNT(*) FROM LOACALREFDETAIL" + yr + " a, LOCALHOSPITAL b " +
        "WHERE a.SPECIALIST = b.hcode AND TO_CHAR(a.refdate,'DDMMYYYY') BETWEEN '" + fromDate + "' AND '" + toDate + "' " +
        "GROUP BY b.hname"
    );

    while (rs.next()) {
        special = rs.getString(1);
        nos = rs.getString(2);
%>
      <tr>
        <td><font face="Tahoma" size="2"><%=special.toUpperCase()%></font></td>
        <td align="center"><font face="Tahoma" size="2"><%=nos%></font></td>
      </tr>
<%
    }

    ResultSet rs1 = stmt.executeQuery(
        "SELECT COUNT(*) FROM LOACALREFDETAIL" + yr + " " +
        "WHERE TO_CHAR(refdate,'DDMMYYYY') BETWEEN '" + fromDate + "' AND '" + toDate + "'"
    );

    if (rs1.next()) total = rs1.getString(1);

} catch (SQLException e) {
    while ((e = e.getNextException()) != null) out.println(e.getMessage() + "<BR>");
} finally {
    if (conn1 != null) try { conn1.close(); } catch (Exception ignored) {}
}
%>
      <tr>
        <td><font face="Tahoma" size="2">Total</font></td>
        <td align="center"><font face="Tahoma" size="2"><%=total%></font></td>
      </tr>
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
try {
    conn2 = DBConnect.getConnection();
    Statement stmt = conn2.createStatement();

    String query = "SELECT a.REFNO, a.PATIENTNAME, a.EMPN, a.REL, a.AGE, " +
                   "TO_CHAR(a.REFDATE, 'DD-MM-YYYY'), b.hname, b.city, a.doc, a.ESCORT, " +
                   "CASE WHEN a.revisitflag = 'N' THEN 'Refer' " +
                   "WHEN a.revisitflag = 'Y' THEN 'Revisit' ELSE 'Refer' END " +
                   "FROM OUTREFDETAIL" + yr + " a " +
                   "JOIN OUTSTATIONHOSPITAL b ON a.hospital = b.HCODE " +
                   "WHERE TO_CHAR(a.refdate, 'DDMMYYYY') BETWEEN '" + fromDate + "' AND '" + toDate + "' " +
                   "ORDER BY a.refno";

    ResultSet rs = stmt.executeQuery(query);

    while (rs.next()) {
%>
  <tr>
    <td><%=rs.getString(1)%></td>
    <td><%=rs.getString(2)%></td>
    <td><%=rs.getInt(3)%></td>
    <td><%=rs.getString(4)%></td>
    <td><%=rs.getString(5)%></td>
    <td><%=rs.getString(6)%></td>
    <td><%=rs.getString(7)%> - <%=rs.getString(8)%></td>
    <td><%=rs.getString(9)%></td>
    <td><%=rs.getString(10)%></td>
    <td><%=rs.getString(11)%></td>
  </tr>
<%
    }

} catch (SQLException e) {
    while ((e = e.getNextException()) != null) out.println(e.getMessage() + "<BR>");
} finally {
    if (conn2 != null) try { conn2.close(); } catch (Exception ignored) {}
}
%>

</table>
</body>
</html>
