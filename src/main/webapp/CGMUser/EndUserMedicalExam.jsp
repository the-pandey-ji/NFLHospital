<%@ page language="java" session="true"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.EndUser" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%!
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd-MM-yyyy");
    private static final int DAYS_OVERDUE_THRESHOLD = 365;

    public Map<String, String> getLatestExamDetails(String loggedInEmpn) {

        Map<String, String> data = new HashMap<String, String>();
        data.put("isOverdue", "true");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = 
            "SELECT * FROM ( " +
            "SELECT TO_CHAR(DATED, 'DD-MM-YYYY') AS dated_fmt, DATED, name, empn, sex, age, dept, " +
            "HB, ALB, SUGAR, BLOODGRP, XRAY, ECG, OTHERINV, PULSE, BP, HEART, LUNG, ABDOMEN, " +
            "OTHERMED, HERNIA, HYDROCELE, PILES, OTHERSUR, NEARVI, DISTANTVI, COLORVI, ENT, " +
            "GYOBFEMALE, REMARKS, STATUS, HEIGHT, WEIGHT, meno " +
            "FROM MEDEXAM WHERE EMPN = ? ORDER BY DATED DESC ) WHERE ROWNUM = 1";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, loggedInEmpn);
            rs = ps.executeQuery();

            if (rs.next()) {
                data.put("recordFound", "true");

                Date examDate = rs.getDate("DATED");
                long diff = new Date().getTime() - examDate.getTime();
                long diffDays = diff / (1000 * 60 * 60 * 24); // Manual days conversion

                if (diffDays <= DAYS_OVERDUE_THRESHOLD) {
                    data.put("isOverdue", "false");
                }

                data.put("meno", rs.getString("meno"));
                data.put("dated", rs.getString("dated_fmt"));
                data.put("name", rs.getString("name"));
                data.put("empn", rs.getString("empn"));
                data.put("sex", rs.getString("sex") != null ? rs.getString("sex").trim() : "");
                data.put("age", rs.getString("age"));
                data.put("dept", rs.getString("dept"));
                data.put("hb", rs.getString("HB"));
                data.put("alb", rs.getString("ALB"));
                data.put("sugar", rs.getString("SUGAR"));
                data.put("bloodgrp", rs.getString("BLOODGRP"));
                data.put("xray", rs.getString("XRAY"));
                data.put("ecg", rs.getString("ECG"));
                data.put("otherinv", rs.getString("OTHERINV"));
                data.put("pulse", rs.getString("PULSE"));
                data.put("bp", rs.getString("BP"));
                data.put("heart", rs.getString("HEART"));
                data.put("lung", rs.getString("LUNG"));
                data.put("abdomen", rs.getString("ABDomen"));
                data.put("othermed", rs.getString("OTHERMED"));
                data.put("hernia", rs.getString("HERNIA"));
                data.put("hydrocele", rs.getString("HYDROCELE"));
                data.put("piles", rs.getString("PILES"));
                data.put("othersur", rs.getString("OTHERSUR"));
                data.put("nearvi", rs.getString("NEARVI"));
                data.put("distantvi", rs.getString("DISTANTVI"));
                data.put("colorvi", rs.getString("COLORVI"));
                data.put("ent", rs.getString("ENT"));
                data.put("gynae", rs.getString("GYOBFEMALE"));
                data.put("remarks", rs.getString("REMARKS"));
                data.put("status", rs.getString("STATUS"));
                data.put("ht", rs.getString("HEIGHT"));
                data.put("wt", rs.getString("WEIGHT"));

            } else {
                data.put("recordFound", "false");
            }

        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            data.put("recordFound", "false");
            data.put("errorMessage", "Database error");
        } finally {
            if (rs != null) { try { rs.close(); } catch (Exception e) {} }
            if (ps != null) { try { ps.close(); } catch (Exception e) {} }
            if (conn != null) { try { conn.close(); } catch (Exception e) {} }
        }

        return data;
    }
%>


<%
    // ==========================================================
    // MAIN EXECUTION BLOCK
    // ==========================================================
    EndUser user9 = (EndUser) session.getAttribute("EndUserObj");
    if (user9 == null) {
        response.sendRedirect("/hosp1/index.jsp");
        return;
    }

    String loggedInEmpn = user9.getEmpn(); 
    Map<String, String> examData = getLatestExamDetails(loggedInEmpn);
    
    boolean recordFound = "true".equals(examData.get("recordFound"));
    boolean isOverdue = "true".equals(examData.get("isOverdue"));
%>

<html>
<head>
    <title>My Latest Medical Exam</title>
    <%@include file="/allCss.jsp"%> 
    <style>
        .report-container {
            max-width: 900px;
            margin: 30px auto;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .report-header {
            border-bottom: 3px solid #1e3c72;
            margin-bottom: 25px;
            padding-bottom: 10px;
        }
        .section-box {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            background-color: #f8f9fa;
        }
        .section-title {
            color: #1e3c72;
            font-weight: bold;
            border-left: 4px solid #007bff;
            padding-left: 10px;
            margin-bottom: 15px;
        }
        .data-item {
            margin-bottom: 8px;
        }
        .data-label {
            font-weight: 600;
            color: #555;
            min-width: 150px;
            display: inline-block;
        }
        .alert-overdue {
            animation: pulse-red 1.5s infinite;
        }
        @keyframes pulse-red {
            0% { box-shadow: 0 0 0 0 rgba(255, 0, 0, 0.4); }
            70% { box-shadow: 0 0 0 10px rgba(255, 0, 0, 0); }
            100% { box-shadow: 0 0 0 0 rgba(255, 0, 0, 0); }
        }
    </style>
</head>
<body>
    
    <%@include file="/EndUser/endUserNavbar.jsp" %> 

    <div class="container">
        
        <h2 class="text-center mt-4 text-primary">My Latest Medical Examination Report</h2>

        <% if (isOverdue) { %>
            <div class="alert alert-danger text-center alert-overdue mb-4">
                <h4><i class="fa fa-warning"></i> ACTION REQUIRED: Medical Examination Overdue!</h4>
                <p class="mb-0">Your last medical examination was over a year ago. Please contact the hospital office to schedule your annual check-up.</p>
            </div>
        <% } else if (recordFound) { %>
            <div class="alert alert-success text-center mb-4">
                <i class="fa fa-check-circle"></i> Your Medical Examination status is **COMPLETED**. (Last Exam: <%= examData.get("dated") %>)
            </div>
        <% } %>

        <% if (recordFound) { %>
            <div class="report-container">
                <div class="report-header">
                    <h4 class="mb-0">Employee: <%= examData.get("name") %> (E. Code: <%= examData.get("empn") %>)</h4>
                    <small class="text-muted">Exam Date: <%= examData.get("dated") %> | Exam No: <%= examData.get("meno") %></small>
                </div>
                
                <div class="section-box">
                    <h5 class="section-title">Basic Profile</h5>
                    <div class="row">
                        <div class="col-md-6 data-item"><span class="data-label">Department:</span> <%= examData.get("dept") %></div>
                        <div class="col-md-6 data-item"><span class="data-label">Age/Sex:</span> <%= examData.get("age") %> / <%= examData.get("sex") %></div>
                        <div class="col-md-6 data-item"><span class="data-label">Height:</span> <%= examData.get("ht") %></div>
                        <div class="col-md-6 data-item"><span class="data-label">Weight:</span> <%= examData.get("wt") %></div>
                    </div>
                </div>

                <div class="section-box">
                    <h5 class="section-title">Investigations & Labs</h5>
                    <div class="row">
                        <div class="col-md-4 data-item"><span class="data-label">HB:</span> **<%= examData.get("hb") %>**</div>
                        <div class="col-md-4 data-item"><span class="data-label">Urine Alb:</span> <%= examData.get("alb") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">Urine Sugar:</span> <%= examData.get("sugar") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">Blood Group:</span> <%= examData.get("bloodgrp") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">X-Ray Chest:</span> <%= examData.get("xray") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">ECG:</span> <%= examData.get("ecg") %></div>
                        <div class="col-md-12 data-item"><span class="data-label">Other Inv.:</span> <%= examData.get("otherinv") %></div>
                    </div>
                </div>

                <div class="section-box">
                    <h5 class="section-title">Physical/Systemic Exam</h5>
                    <div class="row">
                        <div class="col-md-4 data-item"><span class="data-label">Pulse:</span> <%= examData.get("pulse") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">B.P.:</span> **<%= examData.get("bp") %>**</div>
                        <div class="col-md-4 data-item"><span class="data-label">Heart:</span> <%= examData.get("heart") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">Lung:</span> <%= examData.get("lung") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">Abdomen:</span> <%= examData.get("abdomen") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">Other Med. Prob:</span> <%= examData.get("othermed") %></div>
                    </div>
                </div>

                <div class="section-box">
                    <h5 class="section-title">Surgical/Specialist Check</h5>
                    <div class="row">
                        <div class="col-md-4 data-item"><span class="data-label">Hernia:</span> <%= examData.get("hernia") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">Hydrocele:</span> <%= examData.get("hydrocele") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">Piles:</span> <%= examData.get("piles") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">Other Sur. Prob:</span> <%= examData.get("othersur") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">E.N.T.:</span> <%= examData.get("ent") %></div>
                        <% if ("F".equalsIgnoreCase(examData.get("sex"))) { %>
                            <div class="col-md-4 data-item"><span class="data-label">Gynae/Ob.:</span> <%= examData.get("gynae") %></div>
                        <% } %>
                    </div>
                </div>
                
                <div class="section-box">
                    <h5 class="section-title">Vision Check</h5>
                    <div class="row">
                        <div class="col-md-4 data-item"><span class="data-label">Near Vision:</span> <%= examData.get("nearvi") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">Distant Vision:</span> <%= examData.get("distantvi") %></div>
                        <div class="col-md-4 data-item"><span class="data-label">Colour Vision:</span> <%= examData.get("colorvi") %></div>
                    </div>
                </div>

                <div class="mt-4">
                    <h5 class="section-title">Final Status</h5>
                    <p class="data-item"><span class="data-label">Remarks:</span> 
                        <div class="alert alert-secondary mt-2"><%= examData.get("remarks") %></div>
                    </p>
                    <p class="data-item text-center lead">
                        <span class="data-label">Result:</span>
                        <strong class="text-<%= "FIT".equalsIgnoreCase(examData.get("status")) ? "success" : "danger" %>">
                            <%= examData.get("status") %>
                        </strong>
                    </p>
                </div>
                
                <div class="text-center mt-5">
                    
                    <a href="/hosp1/EndUser/endUser.jsp" class="btn btn-secondary mr-2">
                        <i class="fa fa-arrow-left"></i> Back to Home Page
                    </a>
                </div>

            </div>
        <% } else { %>
            <div class="alert alert-warning text-center mt-5">
                <h4 class="alert-heading">No Medical Examination Record Found</h4>
                <p>No past medical examination records were found for your employee ID (**<%= loggedInEmpn %>**).</p>
                <p>Please contact the Medical Department for assistance.</p>
            </div>
        <% } %>
    </div>
</body>
</html>