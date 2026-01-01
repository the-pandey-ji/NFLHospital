<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" session="true" %>

<%
    String empn = request.getParameter("empn");
    String opdId = request.getParameter("opdId");

    // ===== YEAR LOGIC =====
    String currentYear = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
    String selectedYear = request.getParameter("year");

    if (selectedYear == null || selectedYear.trim().isEmpty()) {
        selectedYear = currentYear;
    }

    String opdTable;
    if (selectedYear.equals(currentYear)) {
        opdTable = "OPD";
    } else {
        opdTable = "OPD" + selectedYear;
    }
    // ===== END YEAR LOGIC =====

    // ===== SEARCH FLAG (ONLY ADDITION) =====
    boolean searchClicked =
        (empn != null && !empn.trim().isEmpty()) ||
        (opdId != null && !opdId.trim().isEmpty());
    // ===== END SEARCH FLAG =====

    List<Map<String, String>> results = new ArrayList<Map<String, String>>();

    if (searchClicked) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();

            StringBuilder query = new StringBuilder(
                "SELECT SRNO, PATIENTNAME, RELATION, AGE, " +
                "TO_CHAR(OPDDATE, 'DD-MON-YYYY') AS OPDDATE, " +
                "SEX, EMPN, EMPNAME FROM " + opdTable + " WHERE 1=1"
            );

            if (empn != null && !empn.trim().isEmpty()) {
                query.append(" AND EMPN = ?");
            }

            if (opdId != null && !opdId.trim().isEmpty()) {
                query.append(" AND SRNO = ?");
            }

            query.append(" ORDER BY SRNO DESC");

            ps = conn.prepareStatement(query.toString());

            int paramIndex = 1;
            if (empn != null && !empn.trim().isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(empn.trim()));
            }

            if (opdId != null && !opdId.trim().isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(opdId.trim()));
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

            rs.close();
            ps.close();
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    }
%>

<html>
<head>
    <title>OPD Search Report</title>
</head>
<body>
<%@include file="/navbar.jsp" %>

<h2 style="text-align:center;">OPD HISTORY</h2>

<form method="get" style="text-align: center; margin-bottom: 20px;">

    <label>Year:</label>
    <select name="year" onchange="this.form.submit()" style="margin-right: 20px; padding:5px;">
        <%
            int yr = Integer.parseInt(currentYear);
            for (int y = yr; y >= 2025; y--) {
        %>
            <option value="<%=y%>" <%= String.valueOf(y).equals(selectedYear) ? "selected" : "" %>>
                <%=y%>
            </option>
        <%
            }
        %>
    </select>

    <label style="margin-right: 10px;">Employee Code (EMPN):</label>
    <input type="text" name="empn" value="<%= (empn != null) ? empn : "" %>" style="margin-right: 20px; padding:5px;"/>

    <label style="margin-right: 10px;">OPD Number:</label>
    <input type="text" name="opdId" value="<%= (opdId != null) ? opdId : "" %>" style="margin-right: 20px; padding:5px;"/>

    <input type="submit" value="Search" style="padding: 5px 15px;"/>
</form>

<% if (!results.isEmpty()) { %>
<table border="1" cellpadding="8" cellspacing="0" style="width: 100%; border-collapse: collapse;">
    <thead style="background-color: #f0f0f0;">
        <tr>
            <th>OPD No.</th>
            <th>Patient Name</th>
            <th>Relation</th>
            <th>Age</th>
            <th>Sex</th>
            <th>OPD Date</th>
            <th>Employee Code</th>
            <th>Employee Name</th>
            <th>Edit OPD</th>
        </tr>
    </thead>
    <tbody>
    <% for (Map<String, String> row : results) { %>
        <tr>
            <td>
                <a href="/hosp1/jsps/printSelfOPD.jsp?opdId=<%= row.get("srno") %>&year=<%= selectedYear %>" target="_blank">
                    <%= row.get("srno") %>
                </a>
            </td>
            <td><%= row.get("patientname") %></td>
            <td><%= row.get("relation") %></td>
            <td><%= row.get("age") %></td>
            <td><%= row.get("sex") %></td>
            <td><%= row.get("opddate") %></td>
            <td><%= row.get("empn") %></td>
            <td><%= row.get("empname") %></td>
            <td>
                <a href="/hosp1/jsps/Edit_OPD.jsp?opdId=<%= row.get("srno") %>&year=<%= selectedYear %>"
   style="padding: 4px 10px; background-color: #f0ad4e; color: white; text-decoration: none; border-radius: 3px;">
    Edit
</a>
            </td>
        </tr>
    <% } %>
    </tbody>
</table>
<% } else if (searchClicked) { %>
<p style="text-align: center; color: red;">No records found.</p>
<% } %>

</body>
</html>
