<%@ page language="java" session="true"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.entity.User" %>
<%@ page import="java.text.SimpleDateFormat" %>


<%
System.out.println("Loading CGMUser.jsp for user dashboard.");

    // --- 1. Authentication Check ---
    // Assuming the User object retrieved contains the USERID/EMPN
   // Check if the user is logged in
    User user3 = (User) session.getAttribute("Docobj");
    if (user3 == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("/hosp1/index.jsp");
        
        return;
    }
    
    long empn = user3.getEmpn();
    
    // Initialize variables for the chart data
    //List<Integer> opdVisitCounts = new ArrayList<Integer>();
    List<Integer> opdVisitCounts = new ArrayList<Integer>(Collections.nCopies(12, 0)); // 12 months, all initialized to 0
    List<String> months = Arrays.asList("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");

    // Initialize variables for personal metrics
    String totalOPDVisits = "N/A";
    String totalReferrals = "N/A";
    String lastMedicalExamDate = "N/A";
    boolean isMedicalExamDue = false;
    
    StringBuilder opdDataString = new StringBuilder();

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

        // --- 3. Fetch OPD Visits for Each Month ---
        String currentYear = new SimpleDateFormat("yyyy").format(new java.util.Date());
        String opdVisitSql = "SELECT TO_CHAR(OPDDATE, 'MM') AS MONTH, COUNT(*) AS VISITS " +
                             "FROM OPD WHERE EMPN = '" + empn + "' AND TO_CHAR(OPDDATE, 'YYYY') = '" + currentYear + "' " +
                             "GROUP BY TO_CHAR(OPDDATE, 'MM') ORDER BY MONTH";
        
        rs = stmt.executeQuery(opdVisitSql);

        // Initialize the list with zeros for each month
        for (int i = 0; i < 12; i++) {
            opdVisitCounts.add(0); // Initialize all months with zero visits
        }

        // Fill in the actual visit counts for the months
        while (rs.next()) {
            String month = rs.getString("MONTH");
            int visitCount = rs.getInt("VISITS");

            // Convert month (1-12) to index (0-11)
            int monthIndex = Integer.parseInt(month) - 1;
            opdVisitCounts.set(monthIndex, visitCount);
        }

        // Convert the opdVisitCounts list to a JavaScript array to use in the Chart.js
       
        for (Integer count : opdVisitCounts) {
            opdDataString.append(count).append(",");
        }

        // Remove the last comma to format correctly for JavaScript array
        if (opdDataString.length() > 0) {
            opdDataString.setLength(opdDataString.length() - 1); // remove trailing comma
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
 
         /* Stylish Greeting Section */
        .greeting {
            text-align: center;
            padding: 20px; /* Reduced padding to decrease height */
           background: linear-gradient(120deg, rgba(255, 106, 0, 0.7), rgba(238, 9, 121, 0.7));
            color: white;
            font-family: 'Roboto', sans-serif;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            animation: gradientShift 5s ease-in-out infinite;
            transition: all 0.3s ease;
            height: auto; /* Ensure height adjusts based on content */
        }

        /* Hover effect for the greeting */
        .greeting:hover {
            background: linear-gradient(120deg, #ee0979, #ff6a00);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
            transform: translateY(-5px);
        }

        /* Greeting message styling */
        .greeting h2 {
            font-size: 2.2rem; /* Reduced font size */
            font-weight: 600;
            margin-bottom: 10px; /* Reduced margin */
            text-transform: uppercase;
            letter-spacing: 1.5px; /* Reduced letter spacing */
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
        }

        /* Styling for the smaller subheading */
        .greeting .time-greeting {
            font-size: 1.2rem; /* Reduced font size */
            font-weight: 400;
            color: #f2f2f2;
        }

        /* Font Awesome icon styling */
        .greeting i {
            font-size: 50px; /* Reduced icon size */
            color: #ffffff;
            margin-bottom: 10px; /* Reduced margin */
        }

        /* Smooth background gradient transition */
        @keyframes gradientShift {
            0% { background: linear-gradient(120deg, #ff6a00, #ee0979); }
            50% { background: linear-gradient(120deg, #ff9e00, #d90571); }
            100% { background: linear-gradient(120deg, #ff6a00, #ee0979); }
        }

        /* Add smooth fade-in animation */
        .greeting {
            animation: fadeIn 1.5s ease-in-out;
        }

        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }

   
    
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
        
        /* Add some styles to the chart */
        #opdChart {
            width: 100%;  /* Ensure full width */
           /*  height: 100px;  Fixed height */
        }
        
        
    </style>
    

</head>

<body >

    <%-- Include the user-specific navigation bar --%>
    <%@include file="/CGMUser/CGMUserNavbar.jsp"%> 
     <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Include Chart.js -->

    <div class="container mt-5">
      
        
            <%-- Personalized Greeting Based on Time --%>
        <div class="greeting">
            <% 
                Calendar calendar = Calendar.getInstance();
                int hourOfDay = calendar.get(Calendar.HOUR_OF_DAY);
                String greeting = "";

                if (hourOfDay < 12) {
                    greeting = "Good Morning";
                } else if (hourOfDay < 17) {
                    greeting = "Good Afternoon";
                } else {
                    greeting = "Good Evening";
                }
            %>
            <h2>
                <%= greeting %>, <span style="font-weight: 700; font-size: 2.5rem;"><%= user3.getUsername() %></span>!
            </h2>
            <div class="time-greeting">
               <h3> <i class="fa fa-user-md"></i> Welcome to your Personal Health Dashboard.</h3>
            </div>
        </div>
        
        
        
       <div class="row mb-5">
    <!-- Alerts Column (Left) -->
    <div class="col-md-6">
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
                    Your Medical Examination status is **COMPLETED**.<BR> 
                    (Last Exam: <%= lastMedicalExamDate %>)
                </div>
            <% } %>
            
            <a href="#" class="list-group-item list-group-item-info">
                <i class="fa fa-info-circle"></i> Total OPD Visits: <%= totalOPDVisits %>
            </a>
        </div>
    </div>

    <!-- Graph Column (Right) -->
    <div class="col-md-6">
        <div class="chart-container" style="height:200px;">
            <canvas id="opdChart"></canvas>
        </div>
    </div>
</div>







        <%-- Display Personal Metrics --%>
        <div class="row d-flex">
    <div class="col-md-4 mb-3 d-flex">
        <div class="user-dashboard-card bg-primary pt-2 w-100">
            <i class="fa fa-book" style="font-size:40px;"></i>
            <div class="card-body text-center">
                <h5 class="card-title">Total OPD Visits</h5>
                <p class="h1"><%= totalOPDVisits %></p>
                <small>Since Record Start</small>
            </div>
        </div>
    </div>

    <div class="col-md-4 mb-3 d-flex">
        <div class="user-dashboard-card bg-warning pt-2 w-100">
            <i class="fa fa-share-square-o card-icon" style="font-size:40px;"></i>
            <div class="card-body text-center">
                <h5 class="card-title">Total Referrals</h5>
                <p class="h1"><%= totalReferrals %></p>
                <small>Local & Outstation (Current Year)</small>
            </div>
        </div>
    </div>

    <div class="col-md-4 mb-3 d-flex">
        <div class="user-dashboard-card bg-success pt-2 w-100">
            <i class="fa fa-calendar-check-o" style="font-size:40px;"></i>
            <div class="card-body text-center">
                <h5 class="card-title">Last Medical Exam</h5>
                <p class="h2"><%= lastMedicalExamDate %></p>
                <small>Status: <%= isMedicalExamDue ? "DUE" : "COMPLETED" %></small>
            </div>
        </div>
    </div>
</div>

        
        <%-- Action Links for the User --%>
        <div class="row mt-5">
            <div class="col-md-6">
                <a href="/hosp1/EndUser/EndUserOPDdetails.jsp" class="btn btn-info btn-block py-3">
                    <i class="fa fa-history"></i> View Detailed OPD History
                </a>
            </div>
             <div class="col-md-6">
                <a href="/hosp1/EndUser/EndUserReferDetails.jsp" class="btn btn-secondary btn-block py-3">
                    <i class="fa fa-clipboard-list"></i> View Referral History
                </a>
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
<script>
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
</script>


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