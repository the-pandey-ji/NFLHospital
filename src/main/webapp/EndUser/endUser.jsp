<%@ page language="java" session="true"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.entity.EndUser" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // --- 1. Authentication Check ---
    // Assuming the User object retrieved contains the USERID/EMPN
    EndUser user3 = (EndUser) session.getAttribute("EndUserObj"); // Still using Docobj from the previous code, but it represents the logged-in User
    if (user3 == null) {
        response.sendRedirect("/hosp1/index.jsp");
        return;
    }
    
    // The key identifier for the user's data
    String empn = user3.getEmpn(); 
    
    // Initialize variables for personal metrics
    String totalOPDVisits = "N/A";
    String totalReferrals = "N/A";
    String lastMedicalExamDate = "N/A";
    boolean isMedicalExamDue = false;
    
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        con = DBConnect.getConnection();
        stmt = con.createStatement();
        
        // --- 2. Fetch Total OPD Visits for the User ---
        String opdSql = "SELECT COUNT(*) FROM opd WHERE empn = '" + empn + "'";
        rs = stmt.executeQuery(opdSql);
        if (rs.next()) {
            totalOPDVisits = rs.getString(1);
        }
        rs.close(); // Close the first ResultSet

        // --- 3. Fetch Total Referrals for the User (Local & Outstation) ---
        // This is complex due to dynamic year tables, simplifying for a total count placeholder
        // In a real application, you'd iterate through years or use a view/partitioned table.
        // For this example, we'll only count from the current year's table as a placeholder
        
        // First get the current year for the dynamic table name
        String currentYear = "";
ResultSet rsYr = null;
try {
    rsYr = stmt.executeQuery("SELECT TO_CHAR(SYSDATE, 'YYYY') FROM DUAL");
    if (rsYr.next()) {
        currentYear = rsYr.getString(1);
    }
} catch (SQLException e) {
    System.out.println("Error getting current year: " + e.getMessage());
} finally {
    if (rsYr != null) try { rsYr.close(); } catch (SQLException ignore) {}
}
        
        // Count Local Referrals (assuming table name LOACALREFDETAILYYYY)
        String localRefSql = "SELECT COUNT(*) FROM LOACALREFDETAIL" + currentYear + " WHERE empn = '" + empn + "'";
        rs = stmt.executeQuery(localRefSql);
        int localCount = 0;
        if (rs.next()) {
            localCount = rs.getInt(1);
        }
        rs.close();
        
        // Count Outstation Referrals (assuming table name OUTREFDETAILYYYY)
        String outRefSql = "SELECT COUNT(*) FROM OUTREFDETAIL" + currentYear + " WHERE empn = '" + empn + "'";
        rs = stmt.executeQuery(outRefSql);
        int outCount = 0;
        if (rs.next()) {
            outCount = rs.getInt(1);
        }
        rs.close();
        
        totalReferrals = String.valueOf(localCount + outCount);


        // --- 4. Fetch Last Medical Examination Date and Check Due Status ---
        // Retrieves the latest exam date for the user
        String medExamSql = "SELECT dated FROM hospital.medexam WHERE empn = '" + empn + "' ORDER BY dated DESC";
        rs = stmt.executeQuery(medExamSql);
        
        if (rs.next()) {
            java.util.Date lastExamDate = rs.getDate("dated");
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            lastMedicalExamDate = sdf.format(lastExamDate);

            // Check if exam is due (more than 365 days ago)
            long diff = new java.util.Date().getTime() - lastExamDate.getTime();
            long diffDays = diff / (24 * 60 * 60 * 1000);
            
            if (diffDays > 365) {
                isMedicalExamDue = true;
            }
        } else {
             // User has never had an exam recorded, assumed due
             isMedicalExamDue = true; 
        }

    } catch (SQLException e) {
        System.out.println("Error fetching user dashboard data: " + e.getMessage());
        totalOPDVisits = totalReferrals = lastMedicalExamDate = "Error";
        isMedicalExamDue = true; // Assume due/error is safest
    } finally {
        // Clean up resources
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (con != null) try { con.close(); } catch (SQLException ignore) {}
    }
%>


<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>User Health Dashboard</title>
    <%@include file="/allCss.jsp"%>
    <style>
        .user-dashboard-card {
            transition: transform 0.3s ease-in-out;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            min-height: 180px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
            color: white;
        }

        .user-dashboard-card:hover {
            transform: scale(1.03);
            box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.3);
        }

        .card-title {
            font-weight: bold;
            font-size: 1.25rem;
        }

        .card-icon {
            font-size: 50px;
            margin-bottom: 10px;
        }
        
        .alert-due {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(255, 0, 0, 0.4); }
            70% { box-shadow: 0 0 0 10px rgba(255, 0, 0, 0); }
            100% { box-shadow: 0 0 0 0 rgba(255, 0, 0, 0); }
        }
    </style>
</head>

<body >

    <%-- Include the user-specific navigation bar --%>
    <%@include file="/EndUser/endUserNavbar.jsp"%> 

    <div class="container mt-5">
        <h2 class="text-center mb-5">
            <i class="fa fa-user-md" style="font-size: 40px; color: #303f9f;"></i>
            Your Personal Health Dashboard
        </h2>
        
        <%-- Display Personal Alerts --%>
        <div class="row mb-5">
            <div class="col-12">
                <h3><i class="fa fa-bell" style="font-size: 25px; color: orange"></i> Health Alerts</h3>
                <div class="list-group">
                
                    <% if (isMedicalExamDue) { %>
                        <div class="list-group-item list-group-item-danger alert-due">
                            <i class="fa fa-warning"></i> 
                            <strong>URGENT:</strong> Your Annual Medical Examination is **PENDING** or was last done more than a year ago! 
                            Please contact the Hospital administration immediately. 
                            (Last Exam: <%= lastMedicalExamDate %>)
                        </div>
                    <% } else { %>
                        <div class="list-group-item list-group-item-success">
                            <i class="fa fa-check-circle"></i> 
                            Your Medical Examination status is **CURRENT**. 
                            (Last Exam: <%= lastMedicalExamDate %>)
                        </div>
                    <% } %>
                    
                    <a href="#" class="list-group-item list-group-item-info">
                        <i class="fa fa-info-circle"></i> Total OPD Visits: <%= totalOPDVisits %>
                    </a>
                </div>
            </div>
        </div>

        <%-- Display Personal Metrics --%>
        <div class="row">

            <div class="col-md-4">
                <div class="user-dashboard-card bg-primary"> 
                    <i class="fa fa-notes-medical card-icon"></i>
                    <div class="card-body text-center">
                        <h5 class="card-title">Total OPD Visits</h5>
                        <p class="h1"><%= totalOPDVisits %></p>
                        <small>Since Record Start</small>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="user-dashboard-card bg-warning">
                    <i class="fa fa-share-square-o card-icon"></i>
                    <div class="card-body text-center">
                        <h5 class="card-title">Total Referrals</h5>
                        <p class="h1"><%= totalReferrals %></p>
                        <small>Local & Outstation (Current Year)</small>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="user-dashboard-card bg-success"> 
                    <i class="fa fa-calendar-check card-icon"></i>
                    <div class="card-body text-center">
                        <h5 class="card-title">Last Medical Exam</h5>
                        <p class="h2"><%= lastMedicalExamDate %></p>
                        <small>Status: <%= isMedicalExamDue ? "DUE" : "CURRENT" %></small>
                    </div>
                </div>
            </div>
        </div>
        
        <%-- Action Links for the User --%>
        <div class="row mt-5">
            <div class="col-md-6">
                <a href="/hosp1/HOSPITAL/OPD/opdReport.jsp?empn=<%= empn %>" class="btn btn-info btn-block py-3">
                    <i class="fa fa-history"></i> View Detailed OPD History
                </a>
            </div>
             <div class="col-md-6">
                <a href="/hosp1/HOSPITAL/Reports/referralHistory.jsp?empn=<%= empn %>" class="btn btn-secondary btn-block py-3">
                    <i class="fa fa-clipboard-list"></i> View Referral History
                </a>
            </div>
        </div>

    </div>

</body>
</html>