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

<body>

 <%@include file="/CGMUser/CGMUserNavbar.jsp"%> 



    
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
                        <h5 class="card-title">Med Exams Due This Month</h5>
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
    
    
    
    
    
    
    
   <!-- Dashboard Selection Popup -->
<div class="modal fade" id="dashboardPopup" tabindex="-1" aria-labelledby="dashboardPopupLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="dashboardPopupLabel">Choose Dashboard</h5>
      </div>

      <div class="modal-body text-center">
        <p class="mb-3">Which dashboard would you like to view?</p>

        <!-- Self Dashboard button -->
        <button id="selfBtn" class="btn btn-success btn-lg w-100 mb-3">
           Self Dashboard
        </button>

        <!-- Plant Dashboard button -->
        <button id="plantBtn" class="btn btn-warning btn-lg w-100">
          Plant Dashboard
        </button>
      </div>

    </div>
  </div>
</div>


<!-- ===================== CHART SCRIPT ===================== -->
<%-- <script>
console.log("<%= opdDataString.toString() %>");

document.addEventListener("DOMContentLoaded", function () {

    const opdData = [<%= opdDataString.toString() %>];
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

    const ctx = document.getElementById('opdChart').getContext('2d');

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: months,
            datasets: [{
                label: 'OPD Visits in <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %>',
                data: opdData,
                borderColor: 'rgba(0, 123, 255, 1)',
                borderWidth: 2,
                fill: false,
                tension: 0.2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    ticks: {
                        precision: 0   // ⭐ Force whole numbers only
                    }
                }
            }
        }
    });

});
</script> --%>


<!-- ===================== DASHBOARD POPUP SCRIPT ===================== -->
<script>
document.addEventListener("DOMContentLoaded", function () {

    // Show popup ONLY if not shown earlier in this session
    if (!sessionStorage.getItem("dashboardSelected")) {
        var popup = new bootstrap.Modal(document.getElementById('dashboardPopup'));
        popup.show();
    }

    // Self Dashboard
    document.getElementById("selfBtn").addEventListener("click", function () {
        sessionStorage.setItem("dashboardSelected", "self");
        window.location.href = "/hosp1/EndUser/endUser.jsp";
    });

    // Plant Dashboard
    document.getElementById("plantBtn").addEventListener("click", function () {
        sessionStorage.setItem("dashboardSelected", "plant");
        window.location.href = "/hosp1/CGMUser/CGMUser.jsp";
    });

});
</script>
    
</body>
</html>
 