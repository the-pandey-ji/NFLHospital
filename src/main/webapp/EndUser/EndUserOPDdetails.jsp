<%@ page language="java" session="true" contentType="text/html; charset=windows-1252" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.DB.DBConnect" %>

<%
    EndUser user4 = (EndUser) session.getAttribute("EndUserObj");
    if (user4 == null) {
        response.sendRedirect("/hosp1/index.jsp");
        return;
    }

    String empn = user4.getEmpn();
    String opdId = request.getParameter("opdId");

    /* ===== YEAR LOGIC ===== */
   String currentYear = new SimpleDateFormat("yyyy").format(new java.util.Date());

    String selectedYear = request.getParameter("year");

    if (selectedYear == null || selectedYear.trim().equals("")) {
        selectedYear = currentYear;
    }

    String opdTable;
    if (selectedYear.equals(currentYear)) {
        opdTable = "OPD";
    } else {
        opdTable = "OPD" + selectedYear;
    }
    /* ===== END YEAR LOGIC ===== */

    List<Map<String, String>> results = new ArrayList<Map<String, String>>();

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = DBConnect.getConnection();

        StringBuilder sql = new StringBuilder(
            "SELECT SRNO, PATIENTNAME, RELATION, AGE, SEX, EMPN, EMPNAME, " +
            "TO_CHAR(OPDDATE,'DD-MON-YYYY') AS OPDDATE " +
            "FROM " + opdTable + " WHERE EMPN = ?"
        );

        if (opdId != null && !opdId.trim().equals("")) {
            sql.append(" AND SRNO = ?");
        }

        sql.append(" ORDER BY SRNO DESC");

        ps = conn.prepareStatement(sql.toString());

        int i = 1;
        ps.setInt(i++, Integer.parseInt(empn));

        if (opdId != null && !opdId.trim().equals("")) {
            ps.setInt(i++, Integer.parseInt(opdId.trim()));
        }

        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, String> row = new HashMap<String, String>();
            row.put("srno", rs.getString("SRNO"));
            row.put("patientname", rs.getString("PATIENTNAME"));
            row.put("relation", rs.getString("RELATION"));
            row.put("age", rs.getString("AGE"));
            row.put("sex", rs.getString("SEX"));
            row.put("opddate", rs.getString("OPDDATE"));
            row.put("empn", rs.getString("EMPN"));
            row.put("empname", rs.getString("EMPNAME"));
            results.add(row);
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error : " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>

<html>
<head>
    <title>OPD History</title>
</head>

<body>
<%@include file="/EndUser/endUserNavbar.jsp" %>

<h2 align="center">OPD HISTORY</h2>

<!-- SEARCH FORM -->
<form method="get" align="center" style="margin-bottom:20px;">

    <label><b>Year:</b></label>
    <select name="year" onchange="this.form.submit()">
        <%
            int yr = Integer.parseInt(currentYear);
            for (int y = yr; y >= 2025; y--) {
        %>
        <option value="<%=y%>" <%= String.valueOf(y).equals(selectedYear) ? "selected" : "" %>>
            <%=y%>
        </option>
        <% } %>
    </select>

    &nbsp;&nbsp;

    <label><b>OPD No:</b></label>
    <input type="text" name="opdId" value="<%= opdId != null ? opdId : "" %>" />

    <input type="submit" value="Search" />
</form>

<% if (!results.isEmpty()) { %>
<table border="1" width="95%" align="center" cellpadding="6" cellspacing="0" style="border-collapse:collapse;">
    <tr bgcolor="#f0f0f0">
        <th>OPD No</th>
        <th>Patient Name</th>
        <th>Relation</th>
        <th>Age</th>
        <th>Sex</th>
        <th>OPD Date</th>
        <th>Employee Code</th>
        <th>Employee Name</th>
        <th>View</th>
    </tr>

<% for (Map<String, String> row : results) { %>
    <tr align="center">
        <td><%= row.get("srno") %></td>
        <td><%= row.get("patientname") %></td>
        <td><%= row.get("relation") %></td>
        <td><%= row.get("age") %></td>
        <td><%= row.get("sex") %></td>
        <td><%= row.get("opddate") %></td>
        <td><%= row.get("empn") %></td>
        <td><%= row.get("empname") %></td>
        <td>
            <a href="/hosp1/EndUser/userOPD.jsp?opdId=<%= row.get("srno") %>&year=<%= selectedYear %>"
               target="_blank">View</a>
        </td>
    </tr>
<% } %>
</table>

<% } else { %>
<p align="center" style="color:red;"><b>No records found.</b></p>
<% } %>

</body>
</html>
