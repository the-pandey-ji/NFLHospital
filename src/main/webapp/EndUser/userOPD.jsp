<%@ page language="java" session="true"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.entity.EndUser" %> 

<%
    // --- 1. SECURITY & AUTHENTICATION CHECK (End User) ---
    EndUser user5 = (EndUser) session.getAttribute("EndUserObj");
    if (user5 == null) {
        response.sendRedirect("/hosp1/index.jsp");
        return;
    }
    
    // Employee number MUST come from the secure session object
    String loggedInEmpn = user5.getEmpn(); 
    
    // --- Get OPD ID from URL parameter ---
    String opdIdParam = request.getParameter("opdId");
    int opdId = 0;
    if (opdIdParam != null) {
        try {
            opdId = Integer.parseInt(opdIdParam);
        } catch (NumberFormatException nfe) {
            opdId = 0;
        }
    }
    
    // --- Initialize Display Variables ---
    String patientName = "";
    String relation = "";
    String age = "";
    String sex = "";
    String opdDate = "";
    String employeeName = "";
    String doctorName = "";

    List<Map<String, String>> prescriptionList = new ArrayList<Map<String, String>>();
    Set<String> diseaseCodesSet = new HashSet<String>();
    String note =""; 
    Map<String, String> diseaseMap = new HashMap<String, String>();
    boolean accessAllowed = false;

    Connection conn = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt2 = null;
    Statement stmt = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    ResultSet rsDiseases = null;

    try {
        conn = DBConnect.getConnection();

        // --- 2. SECURED FETCH: Fetch patient details only if SRNO and EMPN match ---
        String query = "select PATIENTNAME, RELATION, AGE, to_char(opddate,'dd-MON-yyyy') as opddate, SEX, EMPN, EMPNAME, doctor from opd where srno=? AND EMPN=?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, opdId);
        pstmt.setString(2, loggedInEmpn); // SECURITY: Enforce ownership check
        rs = pstmt.executeQuery();

        if (rs.next()) {
            accessAllowed = true; // Data is found and belongs to the user
            patientName = rs.getString("PATIENTNAME");
            relation = rs.getString("RELATION");
            age = rs.getString("AGE");
            opdDate = rs.getString("opddate");
            sex = rs.getString("SEX");
            employeeName = rs.getString("EMPNAME");
            doctorName = rs.getString("doctor");
            
            // Format Sex for display
            sex = sex.trim();
            if (sex.equalsIgnoreCase("M")) {
                sex = "MALE";
            } else if(sex.equalsIgnoreCase("F")) {
                sex = "FEMALE";
            } else {
                sex = "Unknown";
            }
            
            rs.close();
            pstmt.close();

            // --- Fetch prescriptions and collect disease codes and notes ---
            String query2 = 
                "SELECT NVL(mm.MEDICINENAME, 'Unknown Medicine') AS MEDICINE, " +
                "p.DOSAGE, p.FREQUENCY, p.TIMING, p.DAYS, p.NOTES, p.DISEASECODE " +
                "FROM HOSPITAL.PRESCRIPTION p " +
                "LEFT JOIN HOSPITAL.MEDICINEMASTER mm ON TO_CHAR(p.MEDICINECODE) = TO_CHAR(mm.MEDICINECODE) " +
                "WHERE p.OPD_ID = ?";

            pstmt2 = conn.prepareStatement(query2);
            pstmt2.setInt(1, opdId);
            rs2 = pstmt2.executeQuery();

            while (rs2.next()) {
                Map<String, String> presc = new HashMap<String, String>();
                presc.put("medicine", rs2.getString("MEDICINE"));
                presc.put("dosage", rs2.getString("DOSAGE"));
                presc.put("frequency", rs2.getString("FREQUENCY"));
                presc.put("timing", rs2.getString("TIMING"));
                presc.put("days", rs2.getString("DAYS"));
                prescriptionList.add(presc);

                // Collect notes
                if (note == null || note.trim().length() == 0) {
                    String tempNote = rs2.getString("NOTES");
                    if (tempNote != null && tempNote.trim().length() > 0) {
                        note = tempNote.trim();
                    }
                }

                // Collect disease codes
                String diseaseCodesStr = rs2.getString("DISEASECODE");
                if (diseaseCodesStr != null && diseaseCodesStr.trim().length() > 0) {
                    String[] codes = diseaseCodesStr.split(",");
                    for (int i = 0; i < codes.length; i++) {
                        diseaseCodesSet.add(codes[i].trim());
                    }
                }
            }
            rs2.close();
            pstmt2.close();

            // --- Fetch disease names for collected codes ---
            if (!diseaseCodesSet.isEmpty()) {
                StringBuffer codeList = new StringBuffer();
                Iterator<String> iter = diseaseCodesSet.iterator();
                while (iter.hasNext()) {
                    if (codeList.length() > 0) {
                        codeList.append(",");
                    }
                    codeList.append("'" + iter.next() + "'"); // Wrap codes in single quotes
                }

                String diseaseQuery = "SELECT DISEASE_CODE, DISEASE_NAME FROM HOSPITAL.DISEASES WHERE DISEASE_CODE IN (" + codeList.toString() + ")";
                stmt = conn.createStatement();
                rsDiseases = stmt.executeQuery(diseaseQuery);

                while (rsDiseases.next()) {
                    diseaseMap.put(rsDiseases.getString("DISEASE_CODE"), rsDiseases.getString("DISEASE_NAME"));
                }
                rsDiseases.close();
                stmt.close();
            }

        } // End of if (rs.next()) { accessAllowed = true; ... }

    } catch (SQLException e) {
        while ((e = e.getNextException()) != null)
            out.println("<p style='color:red;'>SQL Error: " + e.getMessage() + "</p>");
    } finally {
        // Safe resource closing
        if (conn != null) { try { conn.close(); } catch (Exception ignored) {} }
    }
%>

<html>
<head>
    <title>OPD Record Details</title>
    <%@include file="/allCss.jsp"%> <%-- Assumes allCss.jsp includes Bootstrap --%>
    
    <style>
        .detail-card {
            margin-top: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .header-box {
            background-color: #007bff;
            color: white;
            padding: 15px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .info-label {
            font-weight: bold;
            color: #555;
        }
        .info-value {
            color: #333;
        }
        .section-title {
            color: #303f9f;
            border-bottom: 2px solid #303f9f;
            padding-bottom: 5px;
            margin-top: 20px;
            margin-bottom: 15px;
        }
        .medicine-table th {
            background-color: #303f9f;
            color: white;
        }
        .medicine-table td {
            font-size: 0.95em;
        }
    </style>
</head>
<body>

    <%@include file="/EndUser/endUserNavbar.jsp"%> 

    <div class="container mt-5">
        <h2 class="text-center mb-4 text-secondary">
            <i class="fa fa-notes-medical"></i> Your Detailed OPD Record
        </h2>

        <% if (!accessAllowed) { %>
            <div class="alert alert-danger text-center detail-card">
                <h4 class="alert-heading">🚫 Access Denied</h4>
                <p>The requested record (OPD ID: **<%= opdId %>**) was **not found** or **does not belong** to your employee ID (**<%= loggedInEmpn %>**).</p>
                <hr>
                <a href="/hosp1/EndUser/EndUserOPDdetails.jsp" class="btn btn-primary">
                    <i class="fa fa-arrow-left"></i> View My History
                </a>
            </div>
        <% } else { %>
            
            <div class="card detail-card">
                <div class="header-box">
                    <h4 class="mb-0">OPD No: <%= opdId %></h4>
                    <span class="text-white-50"><i class="fa fa-calendar"></i> Date: <%= opdDate %></span>
                </div>
                <div class="card-body">

                    <h3 class="section-title">Patient Details</h3>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <span class="info-label">Employee Code:</span> <span class="info-value"><%= loggedInEmpn %></span>
                        </div>
                        <div class="col-md-6">
                            <span class="info-label">Employee Name:</span> <span class="info-value"><%= employeeName %></span>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <span class="info-label">Patient Name:</span> <span class="info-value"><%= patientName %></span>
                        </div>
                        <div class="col-md-6">
                            <span class="info-label">Relation:</span> <span class="info-value"><%= relation %></span>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <span class="info-label">Sex/Age:</span> <span class="info-value"><%= sex %> / <%= age %></span>
                        </div>
                        <div class="col-md-6">
                            <span class="info-label">Attending Doctor:</span> <span class="info-value text-info"><%= doctorName %></span>
                        </div>
                    </div>

                    <h3 class="section-title">Diagnosis</h3>
                    <% if (!diseaseMap.isEmpty()) { %>
                        <div class="alert alert-light border">
                            <ul class="list-unstyled mb-0">
                            <% 
                                Iterator<String> iter = diseaseCodesSet.iterator();
                                while (iter.hasNext()) {
                                    String code = iter.next();
                                    String dName = diseaseMap.get(code);
                                    if (dName == null) {
                                        dName = "Unknown Disease (" + code + ")";
                                    }
                            %>
                                <li><i class="fa fa-tag text-success mr-2"></i> <%= dName %></li>
                            <% } %>
                            </ul>
                        </div>
                    <% } else { %>
                        <p class="text-muted">No formal disease diagnosis recorded for this visit.</p>
                    <% } %>

                    <h3 class="section-title">Prescribed Medicines</h3>
                    <% 
                    List<Map<String, String>> validPrescriptionList = new ArrayList<Map<String, String>>();
                    for (Map<String, String> row : prescriptionList) {
                        String medicine = row.get("medicine");
                        if (medicine != null && !medicine.trim().equalsIgnoreCase("Unknown Medicine")) {
                            validPrescriptionList.add(row);
                        }
                    }
                    %>
                    
                    <% if (!validPrescriptionList.isEmpty()) { %>
                        <table class="table table-bordered medicine-table">
                            <thead>
                                <tr>
                                    <th width="50%">Medicine</th>
                                    <th width="30%" class="text-center">Dose / Frequency</th>
                                    <th width="20%" class="text-center">Days</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% for (Map<String, String> row : validPrescriptionList) { %>
                                <tr>
                                    <td><%= row.get("medicine") %></td>
                                    <td class="text-center"><%= row.get("dosage") %> <%= row.get("frequency") != null ? "(" + row.get("frequency") + ")" : "" %></td>
                                    <td class="text-center">
                                        <%
                                            String days = row.get("days");
                                            if (days == null || days.trim().isEmpty() || days.trim().equals("0")) {
                                                out.print("-");
                                            } else {
                                                out.print(days);
                                            }
                                        %>
                                    </td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    <% } else { %>
                        <p class="text-muted">No medicines were prescribed during this visit.</p>
                    <% } %>
                    
                    <h3 class="section-title">Doctor Notes</h3>
                    <div class="alert alert-secondary border">
                        <p class="mb-0"><%= note.isEmpty() ? "No additional notes recorded by the doctor." : note %></p>
                    </div>
                </div>
                
                <div class="card-footer text-right">
                    <a href="/hosp1/EndUser/EndUserOPDdetails.jsp" class="btn btn-secondary mr-2">
                        <i class="fa fa-arrow-left"></i> Back to History
                    </a>
                    <a href="/hosp1/EndUser/EndUserOPDDetailPrint.jsp?opdId=<%= opdId %>" target="_blank" class="btn btn-success">
                        <i class="fa fa-print"></i> Print OPD Slip
                    </a>
                </div>
            </div>

        <% } %>
    </div>
</body>
</html>