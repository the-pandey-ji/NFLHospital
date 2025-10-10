<%@ page language="java" session="true"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.DB.DBConnect" %>
<html>
<head>
    <meta http-equiv="Content-Language" content="en-us">
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>OPD Report (Date Range)</title>
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

String pname = "", ename = "", relation = "", age = "", srno = "", sex = "", doc = "", typ = "";
long empn = 0;
int totalCount = 0;

Connection con = null, con1 = null;
PreparedStatement pstmt = null, pstmt2 = null;
ResultSet rs = null, rs2 = null;

try {
    con = DBConnect.getConnection();
    con1 = DBConnect.getConnection1();

    String query = "SELECT patientname, relation, age, sex, empn, srno, typ, empname, doctor " +
                   "FROM opd " +
                   "WHERE trunc(opddate) BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
                   "ORDER BY opddate, srno";

    pstmt = con.prepareStatement(query);
    pstmt.setString(1, fromDate);
    pstmt.setString(2, toDate);
    rs = pstmt.executeQuery();
%>

<p align="center"><b><font size="4" face="Tahoma" color="#800000">
OPD Details from <%= fromDate %> to <%= toDate %>
</font></b></p>

<table border="1" width="88%" align="center" style="border-collapse: collapse" bordercolor="#111111">
    <tr>
        <td align="center"><b>OPD No</b></td>
        <td><b>Patient Name</b></td>
        <td><b>Employee Name</b></td>
        <td align="center"><b>E.Code</b></td>
        <td align="center"><b>Relation</b></td>
        <td align="center"><b>Age</b></td>
        <td align="center"><b>Sex</b></td>
        <td align="center"><b>Doctor</b></td>
    </tr>

<%
    while (rs.next()) {
        pname = rs.getString("patientname");
        relation = rs.getString("relation");
        age = rs.getString("age");
        sex = rs.getString("sex");
        empn = rs.getLong("empn");
        srno = rs.getString("srno");
        typ = rs.getString("typ");
        ename = rs.getString("empname");
        doc = rs.getString("doctor");

        // If type is 'N', fetch empname from employeemaster
        if ("N".equalsIgnoreCase(typ)) {
            String empQuery = "SELECT ename FROM employeemaster WHERE empn = ?";
            pstmt2 = con1.prepareStatement(empQuery);
            pstmt2.setLong(1, empn);
            rs2 = pstmt2.executeQuery();
            if (rs2.next()) {
                ename = rs2.getString("ename");
            }
            rs2.close();
            pstmt2.close();
        }

        totalCount++;
%>
    <tr>
        <td align="center"><%= srno %></td>
        <td><%= pname.toUpperCase() %></td>
        <td><%= ename != null ? ename.toUpperCase() : "" %></td>
        <td align="center"><%= empn %></td>
        <td align="center"><%= relation %></td>
        <td align="center"><%= age %></td>
        <td align="center"><%= sex %></td>
        <td align="center"><%= doc != null ? doc.toUpperCase() : "" %></td>
    </tr>
<%
    }
%>
</table>

<p align="center"><b>Total Number of OPD Cases: <%= totalCount %></b></p>





<p align="center"><font face="Tahoma" size="3" color="#800000"><b>Doctor-wise OPD Summary</b></font></p>

<div align="center">
  <table border="1" width="30%" style="border-collapse: collapse" bordercolor="#111111">
    <tr>
      <td bgcolor="#FFCCCC"><b><font face="Tahoma" size="2">Doctor</font></b></td>
      <td bgcolor="#FFCCCC" align="center"><b><font face="Tahoma" size="2">No of OPD Cases</font></b></td>
    </tr>

<%
PreparedStatement pstmtSummary = null;
ResultSet rsSummary = null;

try {
    String summaryQuery = "SELECT UPPER(doctor) AS doc, COUNT(*) AS doc_count " +
                          "FROM opd " +
                          "WHERE trunc(opddate) BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
                          "GROUP BY UPPER(doctor) " +
                          "ORDER BY UPPER(doctor)";

    pstmtSummary = con.prepareStatement(summaryQuery);
    pstmtSummary.setString(1, fromDate);
    pstmtSummary.setString(2, toDate);
    rsSummary = pstmtSummary.executeQuery();

    while (rsSummary.next()) {
        String docName = rsSummary.getString("doc");
        String count = rsSummary.getString("doc_count");
%>
    <tr>
      <td><font face="Tahoma" size="2"><%= docName != null ? docName : "UNKNOWN" %></font></td>
      <td align="center"><font face="Tahoma" size="2"><%= count %></font></td>
    </tr>
<%
    }

} catch (SQLException e) {
    out.println("<pre style='color:red;'>SQL Error (Doctor Summary): " + e.getMessage() + "</pre>");
} finally {
    if (rsSummary != null) try { rsSummary.close(); } catch (Exception ignored) {}
    if (pstmtSummary != null) try { pstmtSummary.close(); } catch (Exception ignored) {}
}
%>

  </table>
</div>


<%
} catch (SQLException e) {
    out.println("<pre style='color:red;'>SQL Error: " + e.getMessage() + "</pre>");
} finally {
    if (rs != null) try { rs.close(); } catch (Exception ignored) {}
    if (pstmt != null) try { pstmt.close(); } catch (Exception ignored) {}
    if (pstmt2 != null) try { pstmt2.close(); } catch (Exception ignored) {}
    if (con != null) try { con.close(); } catch (Exception ignored) {}
    if (con1 != null) try { con1.close(); } catch (Exception ignored) {}
}
%>

</body>
</html>
