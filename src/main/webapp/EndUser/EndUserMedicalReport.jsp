<%@ page language="java" session="true"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.EndUser" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
// --- SECURITY & AUTHENTICATION SETUP ---
EndUser user10 = (EndUser) session.getAttribute("EndUserObj");
if (user10 == null) {
	response.sendRedirect("/hosp1/index.jsp");
	return;
}

// MANDATORY SECURITY FILTER: Get the logged-in user's EMPN
String loggedInEmpn = user10.getEmpn();

// --- Data Variables ---
List<Map<String, String>> reports = new ArrayList<Map<String, String>>();
boolean recordsFound = false;

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try {
    conn = DBConnect.getConnection();
    stmt = conn.createStatement();
    
    // SECURED SQL QUERY: Filters records by the logged-in user's EMPN.
    // The CASE/DECODE logic handles displaying the dependent name or the employee name.
    String query = "SELECT a.report_no, " +
                   "CASE a.self_dep WHEN 'S' THEN b.ename ELSE a.patientname END AS patient_name, " +
                   "TO_CHAR(a.date_of_test, 'DD-MON-YYYY') AS test_date " +
                   "FROM TESTREPORT a " +
                   "JOIN personnel.employeemaster b ON a.empn = b.empn " +
                   "WHERE b.oldnewdata='N' AND a.empn = '" + loggedInEmpn + "' " +
                   "ORDER BY a.date_of_test DESC, a.report_no DESC";
                   
    rs = stmt.executeQuery(query);
    
    while (rs.next()) {
        recordsFound = true;
        Map<String, String> row = new HashMap<String, String>();
        row.put("reportno", rs.getString("report_no"));
        row.put("pname", rs.getString("patient_name"));
        row.put("testdate", rs.getString("test_date"));
        reports.add(row);
    }
    
} catch (SQLException e) {
    out.println("<p style='color:red; text-align:center;'>Database Error: Failed to fetch test reports: " + e.getMessage() + "</p>");
} finally {
    // Java 1.6/pre-1.7 resource closing pattern
    if (rs != null) try { rs.close(); } catch (Exception ignored) {}
    if (stmt != null) try { stmt.close(); } catch (Exception ignored) {}
    if (conn != null) try { conn.close(); } catch (Exception ignored) {}
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>My Path Lab Reports</title>
<%@include file="/allCss.jsp"%> 
<style>

/* 🌈 Modern Gradient Header */
.page-header-box {
    text-align: center;
    padding: 20px 15px;         /* originally ~40px → reduced 50% */
    border-radius: 12px;
    background: linear-gradient(135deg, #1e3c72, #2a5298);
    color: white;
    margin-bottom: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.12);
}

/* Image height reduced 50% */
.page-header-box img {
    width: 68px;               /* originally ~136px → 50% */
    height: auto;
    margin-bottom: 6px;        /* originally ~12px → 50% */
}

/* Title reduced 50% */
.page-header-box h2 {
    font-size: 20px;           /* originally ~40px → 50% */
    margin-top: 8px;           /* originally ~16px → 50% */
    margin-bottom: 4px;
}

/* Subtitle reduced 50% */
.page-header-box p {
    font-size: 13px;           /* originally ~26px → 50% */
    margin: 0;
    opacity: 0.9;
}
/* 🔵 Premium Glass Card */
.glass-card {
    background: rgba(255, 255, 255, 0.85);
    backdrop-filter: blur(8px);
    border-radius: 12px;
    padding: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.10);
}

/* ✨ Table Styling */
.modern-table {
    width: 100%;
    border-radius: 12px;
    overflow: hidden;
}

.modern-table thead {
    background: #1e3c72;
    color: #fff;
}

.modern-table th {
    padding: 14px;
    font-size: 16px;
    letter-spacing: 0.5px;
}

.modern-table td {
    padding: 12px;
    background: #ffffff;
}

.modern-table tbody tr {
    transition: 0.25s;
}

.modern-table tbody tr:hover {
    background-color: #eef5ff;
    transform: scale(1.01);
    box-shadow: 0 3px 10px rgba(0,0,0,0.07);
}

/* 🟢 Stylish Buttons */
.btn-view {
    padding: 6px 14px;
    border-radius: 6px;
    background: #1e3c72;
    color: white;
    transition: 0.3s;
}

.btn-view:hover {
    background: #2a5298;
    transform: translateY(-2px);
}

/* 🟩 Home Button */
.btn-home {
    padding: 10px 25px;
    border-radius: 8px;
    background: #28a745;
    color: white;
    font-size: 18px;
    transition: 0.3s;
}

.btn-home:hover {
    background: #218838;
    transform: translateY(-2px);
}
</style>
</head>

<body bgcolor="#CCFFFF">
<%@include file="/EndUser/endUserNavbar.jsp" %> 

<div class="container py-4">

    <!-- 🌈 Beautiful Page Header -->
    <div class="page-header-box" >
        <img src="/hosp1/HOSPITAL/testreport/path4.jpg" 
             alt="Lab Icon"
             style="width:110px; height:auto; margin-bottom:10px; filter: drop-shadow(0 3px 5px rgba(0,0,0,0.2));">

        <h2 class="fw-bold mt-3">MY PATH LAB REPORTS HISTORY</h2>
        <p class="text-light">Employee Code: <b><%= loggedInEmpn %></b></p>
    </div>

    <!-- 🔵 Glass Card Content -->
    <div class="glass-card mx-auto" style="max-width: 950px;">
        <div class="table-responsive modern-table-container">

            <table class="table modern-table">
                <thead>
                    <tr>
                        <th>Report No.</th>
                        <th>Patient Name</th>
                        <th>Report Date</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>
                <% if (recordsFound) { 
                        for (Map<String, String> row : reports) { %>

                    <tr>
                        <td class="fw-bold"><%= row.get("reportno") %></td>
                        <td class="text-start"><%= row.get("pname") %></td>
                        <td><%= row.get("testdate") %></td>
                        <td>
                            <a href="ReportView.jsp?q=<%= row.get("reportno") %>" 
                               target="_blank" 
                               class="btn-view">
                               View
                            </a>
                        </td>
                    </tr>

                <% } } else { %>

                    <tr>
                        <td colspan="4" class="text-center py-4 text-muted">
                            No Path Lab Reports found for your employee ID.
                        </td>
                    </tr>

                <% } %>
                </tbody>
            </table>

        </div>
    </div>

    <!-- 🏠 Home Button -->
    <div class="text-center mt-4 mb-4">
        <a href="/hosp1/EndUser/endUser.jsp" class="btn-home">
            <i class="fa fa-home"></i> Back to Home Page
        </a>
    </div>
</div>
</body>
</html>