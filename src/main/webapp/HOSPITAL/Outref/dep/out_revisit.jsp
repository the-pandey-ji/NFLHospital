<%@ page language="java" session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=windows-1252" %>
<html>
<head>
<title>Search Outstation Reference</title>

<script>
function validateSearch() {
    let empn = document.MyForm.empn.value.trim();
    let refno = document.MyForm.refno.value.trim();
    if (empn === "" && refno === "") {
        alert("Please enter either Employee Number or Reference Number to search.");
        return false;
    }
    if (empn !== "" && isNaN(empn)) {
        alert("Employee Number must be numeric.");
        return false;
    }
    if (refno !== "" && isNaN(refno)) {
        alert("Reference Number must be numeric.");
        return false;
    }
    return true;
}
</script>
</head>

<body >
<%@ include file="/navbar.jsp" %>
<!-- <h2 style="text-align:center;">OUTSTATION HOSPITAL REVISIT</h2> -->

<h2 align="center" style="color:#0000FF; text-transform:uppercase;">Search Outstation Reference</h2>

<form name="MyForm" method="get" onsubmit="return validateSearch();" style="text-align:center; margin-bottom:20px;">
    <label style="font-weight:bold;">Year:</label>
    <select name="D1" style="padding:3px;">
        <%
            int currentYear = java.time.Year.now().getValue();
            for(int y = currentYear; y >= 2015; y--) {
        %>
            <option value="<%=y%>" <%= (""+y).equals(request.getParameter("D1")) ? "selected" : "" %>><%=y%></option>
        <% } %>
    </select>
    &nbsp;&nbsp;

    <label style="font-weight:bold;">Employee No:</label>
    <input type="text" name="empn" value="<%= request.getParameter("empn") != null ? request.getParameter("empn") : "" %>" 
           style="padding:3px; width:120px;">
           
           &nbsp;&nbsp;
    <label style="font-weight:bold;">OR</label>

    &nbsp;&nbsp;
    <label style="font-weight:bold;">Reference No:</label>
    <input type="text" name="refno" value="<%= request.getParameter("refno") != null ? request.getParameter("refno") : "" %>" 
           style="padding:3px; width:120px;">
    &nbsp;&nbsp;

    <input type="submit" value="Search" style="padding:5px 10px; font-weight:bold;">
</form>

<hr style="width:80%;">

<%
String yr = request.getParameter("D1");
String empn = request.getParameter("empn");
String refno = request.getParameter("refno");

if (yr != null && (empn != null || refno != null) && (!yr.isEmpty())) {
    Connection conn = null;
    try {
        conn = DBConnect.getConnection();
        StringBuilder query = new StringBuilder();
        query.append("SELECT a.REFNO, TO_CHAR(a.REFDATE,'dd-mm-yyyy') REFDATE, a.EMPN, a.PATIENTNAME, a.REL, ")
             .append("b.HNAME AS HOSPITALNAME, a.DOC, a.ESCORT, ")
             .append("CASE WHEN NVL(a.REVISITFLAG,'N')='Y' THEN 'Revisit' ELSE 'Refer' END reftype ")
             .append("FROM OUTREFDETAIL").append(yr).append(" a ")
             .append("JOIN OUTSTATIONHOSPITAL b ON a.HOSPITAL = b.HCODE WHERE 1=1 ");

        if (empn != null && !empn.trim().equals("")) {
            query.append("AND a.EMPN = ").append(empn.trim()).append(" ");
        }
        if (refno != null && !refno.trim().equals("")) {
            query.append("AND a.REFNO = ").append(refno.trim()).append(" ");
        }
        query.append("ORDER BY a.REFDATE DESC");

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query.toString());

        boolean hasResults = false;
%>

<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse; width:95%; margin:auto; border-color:#666;">
<tr style="background-color:#dce6f1; font-weight:bold;">
    <th style="width:6%;">Ref.No</th>
    <th style="width:10%;">Ref.Date</th>
    <th style="width:8%;">Empn</th>
    <th style="width:16%;">Patient Name</th>
    <th style="width:10%;">Relation</th>
    <th style="width:18%;">Hospital</th>
    <th style="width:10%;">Escort</th>
    <th style="width:15%;">Referred By</th>
    <th style="width:8%;">Type</th>
    <th style="width:7%;">Action</th>
</tr>

<%
while (rs.next()) {
    hasResults = true;
    String escortVal = rs.getString("ESCORT");
    if (escortVal == null || escortVal.trim().isEmpty()) escortVal = "N";
    String escortDisplay = escortVal.equalsIgnoreCase("Y") ? "Yes" : "No";
%>
<tr style="background-color:#ffffff;">
    <td><%= rs.getInt("REFNO") %></td>
    <td><%= rs.getString("REFDATE") %></td>
    <td><%= rs.getInt("EMPN") %></td>
    <td><%= rs.getString("PATIENTNAME") %></td>
    <td><%= rs.getString("REL") %></td>
    <td><%= rs.getString("HOSPITALNAME") %></td>
    <td><%= escortDisplay %></td>
    <td><%= rs.getString("DOC") %></td>
    <td><%= rs.getString("reftype") %></td>
    <td>
        <form method="post" action="/hosp1/HOSPITAL/Outref/dep/out_revisit_second.jsp" style="margin:0;">
            <input type="hidden" name="D1" value="<%= yr %>">
            <input type="hidden" name="refno" value="<%= rs.getInt("REFNO") %>">
            <input type="submit" value="Revisit" 
                   style="padding:3px 6px; background-color:#0078d7; color:white; border:none; cursor:pointer;">
        </form>
    </td>
</tr>
<%
}
if (!hasResults) {
%>
<tr><td colspan="10" style="text-align:center; background-color:#fff3cd;">No records found.</td></tr>
<%
}
rs.close();
stmt.close();
conn.close();
} catch (Exception e) {
    out.println("<p style='color:red; text-align:center;'>Error: "+ e.getMessage() +"</p>");
} finally {
    if (conn != null) try { conn.close(); } catch (Exception ignored) {}
}
}
%>

</table>

<hr style="width:80%; margin-top:30px;">
</body>
</html>
