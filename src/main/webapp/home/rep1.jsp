<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.* "%>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.*" %>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>NFL Hospital</title>
<script language="JavaScript1.2">
function alert()
{
}
 </script>
 <style>
    /* Custom styles for the dashboard cards */
    .dashboard-card {
        transition: transform 0.3s ease-in-out;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        border-radius: 10px;
        min-height: 150px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        margin-bottom: 20px;
        text-decoration: none !important;
        color: inherit;
    }
    .dashboard-card:hover {
        transform: scale(1.03);
        box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.3);
    }
    .card-title {
        font-weight: bold;
        margin-top: 10px;
    }
    .card-icon {
        font-size: 40px;
    }
</style>

</head>

<body background="/hosp1/Stationery/Clear%20Day%20Bkgrd.jpg">

<%@include file="/navbar.jsp" %>



    
    <div class="container mt-5">
        <h2 class="text-center mb-4"> <i class="fa fa-stethoscope card-icon" style="font-size: 40px"></i> Doctor Dashboard</h2>
        <div class="row">
        
            <div class="col-md-4">
                <a href="/hosp1/HOSPITAL/Reports/noopd.jsp" class="dashboard-card bg-primary text-white">
                    <i class="fa fa-stethoscope card-icon" style="font-size: 40px"></i>
                    <div class="card-body text-center">
                        <h5 class="card-title">Today's OPD</h5>

						
						<%
						    // Initialize count variable
						    String todayOPDCount = "N/A";
						    Connection con = null;
						    Statement stmt = null;
						    ResultSet rs = null;
						
						    try {
						        // Use the connection you usually use for OPD data
						        con = DBConnect.getConnection(); 
						        stmt = con.createStatement();
						        
						        // SQL to get today's OPD count
						        // String sql = "SELECT COUNT(*) FROM opd WHERE TO_CHAR(opddate, 'DD-MM-YYYY') = TO_CHAR(SYSDATE, 'DD-MM-YYYY') and doctor = '" + session.getAttribute("username") + "'";
						        String sql = "SELECT COUNT(*) FROM opd WHERE TO_CHAR(opddate, 'DD-MM-YYYY') = TO_CHAR(SYSDATE, 'DD-MM-YYYY') ";
						        rs = stmt.executeQuery(sql);
						        
						        if (rs.next()) {
						            todayOPDCount = rs.getString(1);
						        }
						    } catch (SQLException e) {
						        System.out.println("Error fetching OPD count: " + e.getMessage());
						        todayOPDCount = "Error"; // Indicate failure on dashboard
						    } finally {
						        // Clean up resources
						        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
						        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
						        if (con != null) try { con.close(); } catch (SQLException ignore) {}
						    }
						
						    // The variable 'todayOPDCount' now holds the value and can be used on the dashboard.
						%>
                        <p class="h3"><%=todayOPDCount %></p> 
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="/hosp1/HOSPITAL/Reports/todayrefered.jsp" class="dashboard-card bg-warning text-dark">
                    <i class="fa fa-share card-icon" style="font-size: 40px"></i>
                    <div class="card-body text-center">
                        <h5 class="card-title">Today's Local Referrals</h5>
                       
							<%
							    String localRefCount = "N/A";
							    String localRefYear = "";
							    Connection conLocal = null;
							    Statement stmtLocal = null;
							    ResultSet rsLocal = null;
							
							    try {
							        conLocal = DBConnect.getConnection();
							        stmtLocal = conLocal.createStatement();
							        
							        // 1. Get the current year (required for your dynamic table names)
							        ResultSet rsYr = stmtLocal.executeQuery("SELECT TO_CHAR(SYSDATE, 'YYYY') FROM DUAL");
							        if(rsYr.next()){
							            localRefYear = rsYr.getString(1);
							        }
							        
							        // 2. Execute the count query using the fetched year
							        String sql = "SELECT COUNT(*) FROM LOACALREFDETAIL" + localRefYear + 
							                     " WHERE TO_CHAR(refdate, 'DD-MM-YYYY') = TO_CHAR(SYSDATE, 'DD-MM-YYYY')";
							                     
							        rsLocal = stmtLocal.executeQuery(sql);
							        
							        if (rsLocal.next()) {
							            localRefCount = rsLocal.getString(1);
							        }
							    } catch (SQLException e) {
							        System.out.println("Error fetching Local Ref count: " + e.getMessage());
							        localRefCount = "Error";
							    } 
							%>
                        <p class="h3"><%=localRefCount %></p>
                    </div>
                </a>
            </div>
            
            <div class="col-md-4">
                <a href="/hosp1/HOSPITAL/Medical Examination/alert.jsp" class="dashboard-card bg-danger text-white">
                    <i class="fa fa-medkit card-icon" style="font-size: 40px"></i>
                    <div class="card-body text-center">
                        <h5 class="card-title">Exams Due This Month</h5>
						   <%
						    // Variable to hold the count
						    String examsDueCount = "N/A";
						    /* Connection con = null;
						    Statement stmt = null;
						    ResultSet rs = null; */
						
						    try {
						        // Use getConnection1() as seen in the provided alert.jsp
						        con = DBConnect.getConnection1(); 
						        stmt = con.createStatement();
						        
						        // --- ACTUAL SQL QUERY FROM alert.jsp, converted to COUNT(*) ---
						        // This query counts employees who are 'oldnewdata='N'', 'onpayroll='A'', 
						        // AND have NOT had a medical exam in the last 365 days.
						        String sql = "SELECT COUNT(*) " +
						                     "FROM personnel.employeemaster m " +
						                     "WHERE m.oldnewdata='N' AND m.onpayroll='A' " +
						                     "AND NOT EXISTS ( " +
						                     "    SELECT 1 FROM hospital.medexam em " +
						                     "    WHERE m.empn = em.empn " +
						                     "    AND TO_DATE(SYSDATE, 'YYYY-MM-DD') - TO_DATE(em.dated, 'YYYY-MM-DD') <= 365 " +
						                     ")";
						                     
						        rs = stmt.executeQuery(sql);
						        
						        if (rs.next()) {
						            examsDueCount = rs.getString(1);
						        }
						    } catch (SQLException e) {
						        System.out.println("Error fetching Exams Due count: " + e.getMessage());
						        // You might log this error instead of showing it to the user
						        examsDueCount = "Error"; 
						    } finally {
						        // Clean up resources
						        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
						        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
						        if (con != null) try { con.close(); } catch (SQLException ignore) {}
						    }
						
						    // The variable 'examsDueCount' is now ready for use in the dashboard.
						%>
                        <p class="h3"><%=examsDueCount %></p>
                    </div>
                </a>
            </div>

        </div>

<div class="row mt-4">
    <div class="col-md-4">
        <div class="card" style="min-height: 200px;">
            <div class="card-body text-center">
                <h4 class="card-title">Start New Consultation</h4>
                <p class="card-text">Quickly register a patient for an OPD visit.</p>
                <a href="/hosp1/HOSPITAL/OPD/self3.jsp" class="btn btn-success btn-lg mt-auto"><i class="fa fa-plus-circle"></i> New OPD Entry</a>
            </div>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="card" style="min-height: 200px;">
            <div class="card-body text-center">
                <h4 class="card-title">New Local Refer</h4>
                <p class="card-text">Quickly refer a patient for a Local Hospital.</p>
                <a href="/hosp1/HOSPITAL/Localref/self/local_refer_revisit.jsp" class="btn btn-success btn-lg mt-auto"><i class="fa fa-share card-icon"></i> New Refer Entry</a>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card" style="min-height: 200px;">
            <div class="card-body text-center">
                <h4 class="card-title">View Patient History</h4>
                <p class="card-text">Search and view past OPD records.</p>
                <a href="/hosp1/HOSPITAL/OPD/opdReport.jsp" class="btn btn-info text-white btn-lg mt-auto"><i class="fa fa-book"></i> OPD History</a>
            </div>
        </div>
    </div>
</div>
        <div class="row mt-5">
            <div class="col-12">
                <h3><i class="fa fa-bell" style="font-size:25px;color:red"></i> Announcements & Alerts</h3>
                <div class="list-group">
                    <a href="#" class="list-group-item list-group-item-action list-group-item-danger"><i class="fa fa-warning"></i> <%=examsDueCount %> Employees due for Medical Examination this week.</a>
                    <!-- <a href="#" class="list-group-item list-group-item-action list-group-item-info"><i class="fa fa-info-circle"></i> New policy updated if Anything requir.</a> -->
                    <a href="#" class="list-group-item list-group-item-action list-group-item-success"><i class="fa fa-check"></i> System update completed successfully.</a>
                </div>
            </div>
        </div>
    </div>
    
</body>
</html>
 