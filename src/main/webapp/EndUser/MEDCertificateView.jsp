<%@ page language="java" session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.EndUser" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.SimpleDateFormat" %>


<% 
EndUser user8 = (EndUser) session.getAttribute("EndUserObj");
if (user8 == null) {
    response.sendRedirect("/hosp1/index.jsp");
    return;
}
%>

<%! 
    /**
     * Fetches a single Medical Certificate record, secured by both SRNO and EMPN.
     * Uses Try-with-Resources for automatic resource closure (Java 7+).
     *
     * @param srno The certificate ID.
     * @param loggedInEmpn The authenticated user's employee number.
     * @return A map containing certificate details, or empty if not found/denied.
     */
     public Map<String, String> getSecuredCertificateDetails(int srno, String loggedInEmpn) {
    	    Map<String, String> certData = new HashMap<String, String>();
    	    Connection conn = null;
    	    PreparedStatement ps = null;
    	    ResultSet rs = null;

    	    String query = "SELECT srno, patientname, relation, fathername, empn, desg, dept, disease, "
    	                 + "TO_CHAR(sdate, 'DD-MM-YYYY') as sdate_fmt, "
    	                 + "TO_CHAR(edate, 'DD-MM-YYYY') as edate_fmt, "
    	                 + "ldays, TO_CHAR(mdate, 'DD-MM-YYYY') as mdate_fmt, "
    	                 + "TO_CHAR(fit, 'DD-MM-YYYY') as fit_fmt, DOCTOR "
    	                 + "FROM medicalcrt WHERE srno = ? AND empn = ?";

    	    try {
    	        conn = DBConnect.getConnection();
    	        ps = conn.prepareStatement(query);

    	        ps.setInt(1, srno);
    	        ps.setString(2, loggedInEmpn);

    	        rs = ps.executeQuery();

    	        if (rs.next()) {
    	            certData.put("recordFound", "true");
    	            certData.put("srno", rs.getString("srno"));
    	            certData.put("patientname", rs.getString("patientname"));
    	            certData.put("relation", rs.getString("relation"));
    	            certData.put("fathername", rs.getString("fathername"));
    	            certData.put("empn", rs.getString("empn"));
    	            certData.put("desg", rs.getString("desg"));
    	            certData.put("dept", rs.getString("dept"));
    	            certData.put("disease", rs.getString("disease"));
    	            certData.put("sdate", rs.getString("sdate_fmt"));
    	            certData.put("edate", rs.getString("edate_fmt"));
    	            certData.put("ldays", rs.getString("ldays"));
    	            certData.put("mdate", rs.getString("mdate_fmt"));
    	            certData.put("fit", rs.getString("fit_fmt"));
    	            certData.put("doctor", rs.getString("DOCTOR"));

    	            String relation = rs.getString("relation").trim();
    	            certData.put("relationDisplay",
    	                (relation.equalsIgnoreCase("SELF") || relation.isEmpty()) ? "Self" : relation);
    	        } else {
    	            certData.put("recordFound", "false");
    	        }

    	    } catch (SQLException e) {
    	        System.err.println("SQL Error fetching certificate: " + e.getMessage());
    	        certData.put("errorMessage", "A database error occurred.");
    	        certData.put("recordFound", "false");

    	    } finally {
    	        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    	        try { if (ps != null) ps.close(); } catch (Exception ignored) {}
    	        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
    	    }

    	    return certData;
    	
    }
%>

<%
    // ==========================================================
    // MAIN EXECUTION BLOCK
    // ==========================================================
   

    String loggedInEmpn = user8.getEmpn(); 
    String srnoParam = request.getParameter("srno");
    int srno = 0;
    
    try {
        if (srnoParam != null) {
             srno = Integer.parseInt(srnoParam);
        }
    } catch (NumberFormatException nfe) {
        // srno remains 0, handled below
    }
    
    Map<String, String> certData = getSecuredCertificateDetails(srno, loggedInEmpn);

    boolean recordFound = "true".equals(certData.get("recordFound"));
    String errorMessage = certData.get("errorMessage");

%>

<html>
<head>
    <title>Certificate No. #<%= srno %></title>
    <%@include file="/allCss.jsp"%> 


<style>
/* ~20% total height reduction for certificate */
.cert-container{
    max-width:780px;
    margin:25px auto;           /* was 30px → 25px */
    border:2px solid #007bff;
    border-radius:12px;
    padding:18px;               /* was 22px → 18px */
    background:#fff;
}

/* Header compact */
.cert-header{
    background:#e9ecef;
    padding:8px;                /* was 10px → 8px */
    border-radius:6px;
    margin-bottom:12px;         /* was 16px → 12px */
}
.cert-header h3{ font-size:18px; }
.cert-header p{ font-size:13px; margin:0; }
.cert-header h4{ font-size:15px; margin-top:3px; }

/* Info box reduced */
.info-box{
    background:#f8f9fa;
    border:1px dashed #ced4da;
    padding:8px;                /* was 10px → 8px */
    border-radius:6px;
    margin-top:10px;            /* was 12px → 10px */
}

.data-label{ font-weight:bold; color:#444; }

/* Reduce text spacing */
p{ margin-bottom:5px!important; font-size:13px; }
.row{ margin-bottom:5px; }

/* Alerts slightly compressed */
.alert{
    padding:6px 8px;            /* reduced more */
    font-size:13px;
    margin:8px 0;
}
.lead{ font-size:15px; }

/* Section titles */
h5{ margin-top:10px!important; font-size:15px; }

/* Buttons compact */
.btn{
    padding:5px 10px;
    font-size:13px;
}
</style>



</head>
<body>
    
    <%@include file="/EndUser/endUserNavbar.jsp" %>

    <div class="container">
        <% if (recordFound) { %>
            <div class="cert-container">
                <div class="cert-header text-center">
                    <h3 class="mb-0 text-primary">NATIONAL FERTILIZERS LIMITED</h3>
                    <p class="mb-0">PANIPAT UNIT - MEDICAL DEPARTMENT</p>
                    <h4 class="mt-2 text-dark">FITNESS CERTIFICATE DETAILS</h4>
                </div>

                <div class="d-flex justify-content-between mb-4">
                    <p class="mb-0"><strong>Ref No:</strong> NFL/PNP/HOS/<%= certData.get("srno") %></p>
                    <p class="mb-0"><strong>Date Issued:</strong> <%= certData.get("mdate") %></p>
                </div>
                
                <hr>
                
                <div class="alert alert-info text-center">
                    <span class="data-label">Attending Doctor:</span> <%= certData.get("doctor") %>
                </div>

                <div class="info-box">
                    <h5 class="text-primary mb-3">Employee & Patient Details</h5>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <p class="mb-1"><span class="data-label">Employee Code:</span> <%= certData.get("empn") %></p>
                            <p class="mb-1"><span class="data-label">Patient Name:</span> <%= certData.get("patientname") %></p>
                            <p class="mb-1"><span class="data-label">Relation:</span> <%= certData.get("relationDisplay") %></p>
                        </div>
                        <div class="col-md-6 mb-3">
                            <p class="mb-1"><span class="data-label">Designation:</span> <%= certData.get("desg") %></p>
                            <p class="mb-1"><span class="data-label">Department:</span> <%= certData.get("dept") %></p>
                            <p class="mb-1"><span class="data-label">Father/Guardian:</span> <%= certData.get("fathername") %></p>
                        </div>
                    </div>
                </div>

                <h5 class="mt-4 text-primary">Diagnosed Condition</h5>
                <hr>
                <div class="alert alert-warning text-center lead">
                    **<%= certData.get("disease") %>**
                </div>
                
                <h5 class="mt-4 text-success">Leave & Fitness Information</h5>
                <hr>
                
                <div class="row mb-4">
                    <div class="col-md-4">
                        <p class="mb-0"><span class="data-label">Leave Days:</span> <strong><%= certData.get("ldays") %></strong></p>
                    </div>
                    <div class="col-md-4">
                        <p class="mb-0"><span class="data-label">Leave Start:</span> <%= certData.get("sdate") %></p>
                    </div>
                    <div class="col-md-4">
                        <p class="mb-0"><span class="data-label">Leave End:</span> <%= certData.get("edate") %> </p>
                    </div>
                </div>

                <div class="alert alert-success text-center mt-3">
                    **FIT** to resume duty w.e.f. <strong><%= certData.get("fit") %></strong>.
                </div>

                <div class="text-center mt-4">
                    <a href="/hosp1/EndUser/EndUserMEDCerti.jsp" class="btn btn-secondary mr-2">
                        <i class="fa fa-arrow-left"></i> Back to History
                    </a>
                     <%-- <a href="/hosp1/jsps/printMedicalCert.jsp?srno=<%= certData.get("srno") %>" target="_blank" class="btn btn-success">
                        <i class="fa fa-print"></i> View Print Copy
                    </a> --%>
                </div>
            </div>
        <% } else { %>
            <div class="alert alert-danger text-center mt-5">
                <h4 class="alert-heading">Certificate Not Found</h4>
                <p><%= errorMessage != null ? errorMessage : "The requested Medical Certificate ID is invalid or not associated with your employee account." %></p>
                <a href="/hosp1/EndUser/EndUserMedCertDetails.jsp" class="btn btn-primary">View My History</a>
            </div>
        <% } %>
    </div>

</body>
</html>