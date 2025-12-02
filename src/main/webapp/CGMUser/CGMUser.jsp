<%@ page language="java" session="true"%>
<%@ page import="java.sql.*,java.util.*,java.text.*" %>
<%@ page import="com.DB.DBConnect"%>

<html>

<head>
<title>NFL Hospital Dashboard</title>

<!-- Chart.js only (Rest of CSS is already in navbar) -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<style>
/* --- 70% Layout --- */
.dashboard-container {
    width: 70%;
    margin: auto;
}

/* --- Card Style --- */
.menu-card {
    height: 180px;
    border-radius: 15px;
    padding: 25px;
    color: white !important;
    text-decoration: none !important;
    display: flex;
    flex-direction: column;
    justify-content: center;
    text-align: center;
    transition: 0.3s ease;
    font-size: 18px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}
.menu-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 25px rgba(0,0,0,0.25);
}

/* Gradient Themes */
.bg-grad-blue { background: linear-gradient(135deg, #007bff, #0056d2); }
.bg-grad-green { background: linear-gradient(135deg, #28a745, #1e7e34); }
.bg-grad-yellow { background: linear-gradient(135deg, #ffc107, #d39e00); }
.bg-grad-red { background: linear-gradient(135deg, #dc3545, #b21f2d); }
.bg-grad-purple { background: linear-gradient(135deg, #6f42c1, #5a32a3); }
.bg-grad-teal { background: linear-gradient(135deg, #20c997, #138f75); }

.menu-card i {
    font-size: 45px;
    margin-bottom: 15px;
}

/* Analytics Card */
.analytics-card {
    background: white;
    border-radius: 15px;
    padding: 25px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
    margin-bottom: 30px;
}

.chart-box {
    height: 300px !important;
    max-height: 300px;
    width: 100%;
}
</style>
</head>

<body>

<!-- Include Navbar -->
<%@ include file="/CGMUser/CGMUserNavbar.jsp" %>

<div class="dashboard-container mt-5">

    <h2 class="text-center mb-4">
        <i class="fa fa-dashboard"></i> Master Dashboard
    </h2>

<%-- ======================= Fetch Live Data ======================= --%>
<%
    // Today OPD
    String todayOPDCount = "0";
    try {
        Connection con = DBConnect.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(
           "SELECT COUNT(*) FROM opd WHERE TRUNC(opddate)=TRUNC(SYSDATE)"
        );
        if(rs.next()) todayOPDCount = rs.getString(1);
        con.close();
    } catch(Exception e){ todayOPDCount="0"; }

    // Today Referred Cases
    String localRefCount="0";
    String year = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
    try {
        Connection con = DBConnect.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(
           "SELECT COUNT(*) FROM LOACALREFDETAIL"+year+" WHERE TRUNC(refdate)=TRUNC(SYSDATE)"
        );
        if(rs.next()) localRefCount = rs.getString(1);
        con.close();
    } catch(Exception e){ localRefCount="0"; }

    // Today Med Certificates
    String todayMedCert="0";
    try {
        Connection con = DBConnect.getConnection1();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(
           "SELECT COUNT(*) FROM HOSPITAL.MEDICALCRT WHERE TRUNC(MDATE)=TRUNC(SYSDATE)"
        );
        if(rs.next()) todayMedCert = rs.getString(1);
        con.close();
    } catch(Exception e){ todayMedCert="0"; }

    // Monthly OPD Data
    String opdDataString = "";
    try {
        Connection con = DBConnect.getConnection();
        Statement stmt = con.createStatement();
        String sql = "SELECT TO_CHAR(opddate,'MM'), COUNT(*) FROM opd " +
                     "WHERE TO_CHAR(opddate,'YYYY')=TO_CHAR(SYSDATE,'YYYY') " +
                     "GROUP BY TO_CHAR(opddate,'MM') ORDER BY TO_CHAR(opddate,'MM')";
        ResultSet rs = stmt.executeQuery(sql);
        int[] opdCounts = new int[12];
        while(rs.next()){
            int month = Integer.parseInt(rs.getString(1))-1;
            opdCounts[month] = rs.getInt(2);
        }
        opdDataString = Arrays.toString(opdCounts);
        con.close();
    } catch(Exception e){ opdDataString = "[0,0,0,0,0,0,0,0,0,0,0,0]"; }

    // Monthly Referred Data
    String refDataString = "";
    try {
        Connection con = DBConnect.getConnection();
        Statement stmt = con.createStatement();
        String sql = "SELECT TO_CHAR(refdate,'MM'), COUNT(*) FROM LOACALREFDETAIL"+year+" " +
                     "GROUP BY TO_CHAR(refdate,'MM') ORDER BY TO_CHAR(refdate,'MM')";
        ResultSet rs = stmt.executeQuery(sql);
        int[] refCounts = new int[12];
        while(rs.next()){
            int month = Integer.parseInt(rs.getString(1))-1;
            refCounts[month] = rs.getInt(2);
        }
        refDataString = Arrays.toString(refCounts);
        con.close();
    } catch(Exception e){ refDataString = "[0,0,0,0,0,0,0,0,0,0,0,0]"; }

    // Medical Exam Completed/Pending
    int medCompleted=0, medPending=0;
    try {
        Connection con = DBConnect.getConnection1();
        Statement stmt = con.createStatement();

        ResultSet rsC = stmt.executeQuery(
            "SELECT COUNT(*) FROM personnel.employeemaster m " +
            "WHERE m.oldnewdata='N' AND m.onpayroll='A' " +
            "AND EXISTS (SELECT 1 FROM hospital.medexam em " +
            "WHERE m.empn = em.empn AND SYSDATE - em.dated <= 365)"
        );
        if(rsC.next()) medCompleted = rsC.getInt(1);

        ResultSet rsP = stmt.executeQuery(
            "SELECT COUNT(*) FROM personnel.employeemaster m " +
            "WHERE m.oldnewdata='N' AND m.onpayroll='A' " +
            "AND NOT EXISTS (SELECT 1 FROM hospital.medexam em " +
            "WHERE m.empn = em.empn AND SYSDATE - em.dated <= 365)"
        );
        if(rsP.next()) medPending = rsP.getInt(1);

        con.close();
    } catch(Exception e){ medCompleted=0; medPending=0; }
%>

<%-- ======================= 6-MENU CARDS ======================= --%>
<div class="row">

    <div class="col-md-4 mb-4">
        <a href="/hosp1/CGMUser/Reports/noopd.jsp" class="menu-card bg-grad-blue">
            <i class="fa fa-stethoscope"></i>
            Today's OPD
            <p class="h3"><%= todayOPDCount %></p>
        </a>
    </div>

    <div class="col-md-4 mb-4">
        <a href="/hosp1/CGMUser/Reports/todayrefered.jsp" class="menu-card bg-grad-yellow">
            <i class="fa fa-share"></i>
            Today's Referred cases
            <p class="h3"><%= localRefCount %></p>
        </a>
    </div>

    <div class="col-md-4 mb-4">
        <a href="/hosp1/CGMUser/Reports/medcert.htm" class="menu-card bg-grad-purple">
            <i class="fa fa-medkit"></i>
            Medical Certificates
            <p class="h3"><%= todayMedCert %></p>
        </a>
    </div>

    <div class="col-md-4 mb-4">
        <a href="/hosp1/CGMUser/Reports/opdhome.jsp" class="menu-card bg-grad-green">
            <i class="fa fa-book"></i>
            OPD in Range
        </a>
    </div>

    <div class="col-md-4 mb-4">
        <a href="/hosp1/CGMUser/Reports/noref.jsp" class="menu-card bg-grad-red">
            <i class="fa fa-calendar"></i>
            Date Wise Refer
        </a>
    </div>

    <div class="col-md-4 mb-4">
        <a href="/hosp1/CGMUser/Reports/alert.jsp" class="menu-card bg-grad-teal">
            <i class="fa fa-bell"></i>
            Employees Due for Med. Examination
        </a>
    </div>

</div>

<%-- ======================= ANALYTICS ======================= --%>
<h3 class="mt-5 mb-3">
    <i class="fa fa-bar-chart"></i> Analytics
</h3>

<div class="analytics-card">
    <div class="row">

        <div class="col-md-6 mb-4">
            <h5 class="text-center">OPD Monthly Trend</h5>
            <canvas id="opdChart" class="chart-box"></canvas>
        </div>

        <div class="col-md-6 mb-4">
            <h5 class="text-center">Referred Cases Trend</h5>
            <canvas id="refChart" class="chart-box"></canvas>
        </div>

        <div class="col-md-12">
            <h5 class="text-center">Medical Exam Status</h5>
            <canvas id="medChart" class="chart-box"></canvas>
        </div>

    </div>
</div>

<%-- ======================= CHART SCRIPTS ======================= --%>
<script>
const opdChart = new Chart(document.getElementById("opdChart"), {
    type: "line",
    data: {
        labels: ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
        datasets: [{
            label: "OPD Cases",
            data: <%= opdDataString %>,
            borderColor: "#007bff",
            borderWidth: 3,
            fill: false
        }]
    },
    options: { responsive: true }
});

const refChart = new Chart(document.getElementById("refChart"), {
    type: "bar",
    data: {
        labels: ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
        datasets: [{
            label: "Referred Cases",
            data: <%= refDataString %>,
            backgroundColor: "#ffc107"
        }]
    },
    options: { responsive: true }
});

const medChart = new Chart(document.getElementById("medChart"), {
    type: "pie",
    data: {
        labels: ["Completed", "Pending"],
        datasets: [{
            data: [<%= medCompleted %>, <%= medPending %>],
            backgroundColor: ["#28a745", "#dc3545"]
        }]
    },
    options: { responsive: true, maintainAspectRatio: false }
});
</script>


<div class="row mt-5">
            <div class="col-12">
                <h3><i class="fa fa-bell" style="font-size:25px;color:red"></i> Announcements & Alerts</h3>
                <div class="list-group">
                 <%
						    // Variable to hold the count
						    String examsDueCount = "N/A";
						     Connection con = null;
						    Statement stmt = null;
						    ResultSet rs = null; 
						
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
          Master Dashboard
        </button>
      </div>

    </div>
  </div>
</div>





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