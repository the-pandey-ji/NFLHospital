<%@ page language="java" session="true"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.EndUser" %>

<%
EndUser user11 = (EndUser) session.getAttribute("EndUserObj");
if (user11 == null) {
	response.sendRedirect("/hosp1/index.jsp");
	return;
}
// --- Data Retrieval Logic (Original structure kept) ---
 String reportnumber = request.getParameter("q");
 
 String reportno = "";
 String empn = "";
 String ename = "";
 String designation = "";
 String relation= "";
 String patient = "";
 String dt = "";
 String doctor = "";
 String urinesugar= "";
 String alb= "";
 String bilesalt= "";
 String bilepig= "";
 String acetone= "";
 String me= "";
 String urinepuscell= "";
 String urinerbc= "";
 String castt = "";
 String eplcell= "";
 String crystal= "";
 String other= "";
 String ova= "";
 String cyst= "";
 String stoolpuscell= "";
 String stoolrbc= "";
 String tropho= "";
 String hb= "";
 String tlc= "";
 String dlc= "";
 String poly= "";
 String lympho= "";
 String eosino= "";
 String mono="";
 String baso= "";
 String mp = "";
 String fbs= "";
 String ppbs= "";
 String bloodurea= "";
 String chol= "";
 String trigly="";
 String hdl= "";
 String ldl= "";
 String creatine= "";
 String uricacid= "";
 String calcium= "";
 String billirubin= "";
 String sgot="";
 String sgpt= "";
 String protein= "";
 String albumin= "";
 String globulin= "";
 String alkaline= "";
 String bloodgroup= "";
 String rh= "";
 String preg="";
 String vdrl= "";
 String antigen= "";
 String ra= "";
 String to20= "";
 String to40= "";
 String to80= "";
 String to160= "";
 String to320= "";
 String th20= "";
 String th40= "";
 String th80= "";
 String th160= "";
 String th320= "";
 String ah20= "";
 String ah40= "";
 String ah80= "";
 String ah160= "";
 String ah320= "";
 String bh20= "";
 String bh40= "";
 String bh80= "";
 String bh160= "";
 String bh320= "";
 String malaria= "";
 String esr= "";
 String btmts= "";
 String btsec= "";
 String ctmts= "";
 String ctsec= "";
 
 Connection conn = DBConnect.getConnection();
 Statement stmt = null;
 ResultSet rs = null;
 boolean reportFound = false;

 try {
    // --- NOTE: Using non-standard connection methods based on user's original code ---
   
    stmt = conn.createStatement();
    
    // Original extensive query (using DBConnect logic for simplicity here, but maintaining 83 columns)
   PreparedStatement ps = conn.prepareStatement( "SELECT A.REPORT_NO, A.EMPN, C.ENAME, C.DESIGNATION, "
    +" DECODE(A.SELF_DEP,'S', 'SELF', 'D', 'DEPENDENT', ' ') SELF_DEP, "
    +" nvl(A.PATIENTNAME,' '), TO_CHAR(A.DATE_OF_TEST,'DD-MON-YYYY') DATE_OF_TEST, B.DOCTOR_NAME, "
    +" nvl(A.URINE_SUGAR,' '), nvl(A.ALB,' '), nvl(A.BILE_SALT,' '), nvl(A.BILE_PIG,' '), nvl(A.ACETONE,' '), "
    +" nvl(A.ME,' '), nvl(A.URINE_PUSCELL,' '), nvl(A.URINE_RBC,' '), nvl(A.CASTT,' '), nvl(A.EPI_CELL,' '), "
    +" nvl(A.CRYSTAL,' '), nvl(A.ANY_OTHER,' '), nvl(A.OVA,' '), nvl(A.CYST,' '), "
    +" nvl(A.STOOL_PUSCELL,' '), nvl(A.STOOL_RBC,' '), nvl(A.TROPHO,' '), nvl(to_char(A.HB),' '), "
    +" nvl(to_char(A.TLC),' '), nvl(to_char(A.DLC),' '), nvl(to_char(A.POLY),' '), nvl(to_char(A.LYMPHO),' '), "
    +" nvl(to_char(A.EOSINO),' '), nvl(to_char(A.MONO),' '), nvl(to_char(A.BASO),' '), nvl(A.MP,' '), "
    +" nvl(to_char(A.FBS),' '), nvl(to_char(A.PPBS),' '), nvl(to_char(A.BLOOD_UREA),' '), "
    +" nvl(to_char(A.S_CHOLESTROL),' '), nvl(to_char(A.S_TRIGLYCERIDE),' '), nvl(to_char(A.S_HDL),' '),"
    +" nvl(to_char(A.S_LDL),' '), nvl(to_char(A.S_CREATININE,'0.0'),' '), nvl(to_char(A.S_URICACID),' '), "
    +" nvl(to_char(A.S_CALCIUM),' '), nvl(to_char(A.S_BILRUBIN,'0.0'),' '), nvl(to_char(A.SGOT),' '), "
    +" nvl(to_char(A.SGPT),' '), nvl(to_char(A.TOTAL_PROTEIN),' '), nvl(to_char(A.ALBUMIN),' '), "
    +" nvl(to_char(A.GLOBULIN),' '), nvl(to_char(A.S_ALKALI_PHOS),' '), "
    +" nvl(A.BLOOD_GROUP,' '), nvl(A.RH_FACTOR,' '), nvl(A.PREGNANCY,' '), nvl(A.VDRL,' '), "
    +" nvl(A.AUS_ANTIGEN,' '), nvl(A.RA_FACTOR,' '), nvl(A.TO_1_20,' '), nvl(A.TO_1_40,' '), "
    +" nvl(A.TO_1_80,' '), nvl(A.TO_1_160,' '), nvl(A.TO_1_320,' '), nvl(A.TH_1_20,' '), nvl(A.TH_1_40,' '), "
    +" nvl(A.TH_1_80,' '), nvl(A.TH_1_160,' '), nvl(A.TH_1_320,' '), nvl(A.AH_1_20,' '), nvl(A.AH_1_40,' '), "
    +" nvl(A.AH_1_80,' '), nvl(A.AH_1_160,' '), nvl(A.AH_1_320,' '), nvl(A.BH_1_20,' '), nvl(A.BH_1_40,' '), "
    +" nvl(A.BH_1_80,' '), nvl(A.BH_1_160,' '), nvl(A.BH_1_320,' '), nvl(A.MALARIA_ANTIGEN,' '), "
    +" nvl(to_char(A.ESR),' '), nvl(to_char(A.BT_MTS),' '), nvl(to_char(A.BT_SEC),' '), "
    +" nvl(to_char(A.CT_MTS),' '), nvl(to_char(A.CT_SEC),' ') "
    +" FROM TESTREPORT A, DOCTOR B, PERSONNEL.EMPLOYEEMASTER C WHERE A.DOCTOR=B.CODE AND B.STATUS='A' "
    +" AND C.OLDNEWDATA='N' AND A.EMPN=C.EMPN and a.report_no=?");
    
   ps.setString(1, reportnumber);
   rs = ps.executeQuery();
    
    if (rs.next()) { 
        reportFound = true;
        // Map all 83 columns
        reportno= rs.getString(1); empn= rs.getString(2); ename= rs.getString(3); designation= rs.getString(4); relation= rs.getString(5);
        patient= rs.getString(6); dt= rs.getString(7); doctor= rs.getString(8); urinesugar= rs.getString(9); alb= rs.getString(10);
        bilesalt= rs.getString(11); bilepig= rs.getString(12); acetone= rs.getString(13); me= rs.getString(14); urinepuscell= rs.getString(15);
        urinerbc= rs.getString(16); castt = rs.getString(17); eplcell= rs.getString(18); crystal= rs.getString(19); other= rs.getString(20);
        ova= rs.getString(21); cyst= rs.getString(22); stoolpuscell= rs.getString(23); stoolrbc= rs.getString(24); tropho= rs.getString(25);
        hb= rs.getString(26); tlc= rs.getString(27); dlc= rs.getString(28); poly= rs.getString(29); lympho= rs.getString(30);
        eosino= rs.getString(31); mono= rs.getString(32); baso= rs.getString(33); mp = rs.getString(34); fbs= rs.getString(35);
        ppbs= rs.getString(36); bloodurea= rs.getString(37); chol= rs.getString(38); trigly= rs.getString(39); hdl= rs.getString(40);
        ldl= rs.getString(41); creatine= rs.getString(42); uricacid= rs.getString(43); calcium= rs.getString(44); billirubin= rs.getString(45);
        sgot= rs.getString(46); sgpt= rs.getString(47); protein= rs.getString(48); albumin= rs.getString(49); globulin= rs.getString(50);
        alkaline= rs.getString(51); bloodgroup= rs.getString(52); rh= rs.getString(53); preg= rs.getString(54); vdrl= rs.getString(55);
        antigen= rs.getString(56); ra= rs.getString(57); to20= rs.getString(58); to40= rs.getString(59); to80= rs.getString(60);
        to160= rs.getString(61); to320= rs.getString(62); th20= rs.getString(63); th40= rs.getString(64); th80= rs.getString(65);
        th160= rs.getString(66); th320= rs.getString(67); ah20= rs.getString(68); ah40= rs.getString(69); ah80= rs.getString(70);
        ah160= rs.getString(71); ah320= rs.getString(72); bh20= rs.getString(73); bh40= rs.getString(74); bh80= rs.getString(75);
        bh160= rs.getString(76); bh320= rs.getString(77); malaria= rs.getString(78); esr= rs.getString(79); btmts= rs.getString(80);
        btsec= rs.getString(81); ctmts= rs.getString(82); ctsec= rs.getString(83);
    }
    
 } catch(SQLException e) {
    out.println("<p style='color:red; text-align:center;'>Database Error: " + e.getMessage() + "</p>");
 
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
<title>Test Report #<%= reportnumber %></title>
<%@include file="/allCss.jsp"%> 
<style>
.report-card {
    max-width: 950px;
    margin: 30px auto;
    padding: 30px;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}
.report-header-info {
    border-bottom: 2px solid #1e3c72;
    padding-bottom: 15px;
    margin-bottom: 25px;
}
.section-title {
    color: #1e3c72;
    font-weight: 700;
    border-left: 5px solid #007bff;
    padding-left: 10px;
    margin-bottom: 15px;
    margin-top: 25px;
}
.test-table {
    width: 100%;
    border-collapse: collapse;
}
.test-table th {
    background-color: #303f9f;
    color: white;
    padding: 8px 12px;
    font-size: 13px;
    text-align: left;
}

.test-table td {
    padding: 6px 12px;
    border: 1px solid #eee;
    font-size: 13px;
    vertical-align: top;
}
.result-value {
    font-weight: bold;
    color: #1e3c72; /* Blue */
}
.normal-range {
    color: #6c757d; /* Gray */
    font-size: 0.9em;
}
.abnormal-flag {
    color: #dc3545; /* Red */
    font-weight: bold;
}


 
@media print {


.sticky-top,
    .sticky-top * {
        display: none !important;
        visibility: hidden !important;
        height: 0 !important;
    }

    /* Hide navbar, buttons, background */
    body, .report-card {
        background: #fff !important;
        box-shadow: none !important;
    }

    nav, .btn, .fa, .fa-print, .fa-arrow-left,
    .container > .btn, .no-print, .navbar {
        display: none !important;
    }

    /* Remove margins for better page fit */
    .report-card {
        margin: 0 !important;
        padding: 10px !important;
        width: 100% !important;
    }

    /* Table styling optimized for printing */
    .test-table th, .test-table td {
        font-size: 12px !important;
        padding: 4px 6px !important;
        border: 1px solid #000 !important;
    }

    .section-title {
        margin-top: 10px !important;
        margin-bottom: 5px !important;
        border-left: 3px solid #000 !important;
        color: #000 !important;
        padding-left: 6px !important;
    }

    /* Remove background colors */
    .test-table th {
        background: #ddd !important;
        color: #000 !important;
    }
    .bg-light {
        background: #eee !important;
    }

    /* Force single-color print */
    * {
        color: #000 !important;
        -webkit-print-color-adjust: exact !important;
        print-color-adjust: exact !important;
    }

    /* Page break rules */
    .page-break {
        page-break-before: always;
    }
}

</style>
</head>
<body bgcolor="#EAFFFF">

<%@include file="/EndUser/endUserNavbar.jsp" %>

<div class="container">
    
    <% if (!reportFound) { %>
        <div class="alert alert-danger text-center mt-5 report-card">
            <h4 class="alert-heading">Report Not Found</h4>
            <p>No Pathological Test Report found for number: <strong><%= reportnumber %></strong>.</p>
            <a href="javascript:history.back()" class="btn btn-primary">Go Back</a>
        </div>
    <% return; } %>

    <div class="report-card">
        <h2 class="text-center text-dark">PATHOLOGICAL TEST REPORT</h2>
        <p class="text-center text-secondary mb-4">National Fertilizers Limited, Panipat Unit: Medical Department</p>

        <div class="report-header-info">
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-1"><strong>Report No.:</strong> <%= reportno %></p>
                    <p class="mb-1"><strong>EMPN:</strong> <%= empn %></p>
                    <p class="mb-1"><strong>Name:</strong> <%= ename %></p>
                    <p class="mb-1"><strong>Designation:</strong> <%= designation %></p>
                </div>
                <div class="col-md-6 text-md-right">
                    <p class="mb-1"><strong>Date of Test:</strong> <%= dt %></p>
                    <p class="mb-1"><strong>Medical Officer:</strong> <%= doctor %></p>
                    <p class="mb-1"><strong>Patient Name:</strong> <%= patient %></p>
                    <p class="mb-1"><strong>Self / Dependent:</strong> <%= relation %></p>
                </div>
            </div>
        </div>
        
        <h3 class="section-title">Hematology</h3>
        <div class="table-responsive">
            <table class="test-table">
                <thead>
                    <tr>
                        <th width="35%">Test Name</th>
                        <th width="20%" class="text-center">Result</th>
                        <th width="20%">Unit</th>
                        <th width="25%">Reference Range (Normal)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td>HB</td><td class="text-center result-value"><%= hb %></td><td class="text-center">Gm %</td><td>11.0 - 16.0</td></tr>
                    <tr><td>TLC</td><td class="text-center result-value"><%= tlc %></td><td class="text-center">/cu.mm</td><td>4000 - 11000</td></tr>
                    <tr><td colspan="4" class="bg-light font-weight-bold">Differential Leukocyte Count (DLC)</td></tr>
                    <tr><td>Poly</td><td class="text-center result-value"><%= poly %>%</td><td class="text-center">%</td><td>50 - 70</td></tr>
                    <tr><td>Lympho</td><td class="text-center result-value"><%= lympho %>%</td><td class="text-center">%</td><td>20 - 45</td></tr>
                    <tr><td>Eosino</td><td class="text-center result-value"><%= eosino %>%</td><td class="text-center">%</td><td>1 - 5</td></tr>
                    <tr><td>Mono</td><td class="text-center result-value"><%= mono %>%</td><td class="text-center">%</td><td>2 - 10</td></tr>
                    <tr><td>Baso</td><td class="text-center result-value"><%= baso %>%</td><td class="text-center">%</td><td>0 - 1</td></tr>
                    <tr><td>M.P. (Malaria Parasite)</td><td class="text-center result-value"><%= mp %></td><td class="text-center">-</td><td>Negative</td></tr>
                    <tr><td>ESR</td><td class="text-center result-value"><%= esr %></td><td class="text-center">mm 1st hr</td><td>0 - 20</td></tr>
                    <tr><td>BT (Mts/Sec)</td><td class="text-center result-value"><%= btmts %> mts <%= btsec %> sec</td><td class="text-center">-</td><td>(Reference needed)</td></tr>
                    <tr><td>CT (Mts/Sec)</td><td class="text-center result-value"><%= ctmts %> mts <%= ctsec %> sec</td><td class="text-center">-</td><td>(Reference needed)</td></tr>
                </tbody>
            </table>
        </div>
        
     
        <div class="row">
            <div class="col-md-6">
                <h3 class="section-title">Urine Examination</h3>
                <table class="test-table">
                    <tr><td>Sugar</td><td class="text-center result-value"><%= urinesugar %></td></tr>
                    <tr><td>Albumin</td><td class="text-center result-value"><%= alb %></td></tr>
                    <tr><td>Bile Salt</td><td class="text-center result-value"><%= bilesalt %></td></tr>
                    <tr><td>Bile Pigment</td><td class="text-center result-value"><%= bilepig %></td></tr>
                    <tr><td>Acetone</td><td class="text-center result-value"><%= acetone %></td></tr>
                    <tr><td>M.E. (Microscopic Exam)</td><td class="text-center result-value"><%= me %></td></tr>
                    <tr><td>Pus Cell (/hpf)</td><td class="text-center result-value"><%= urinepuscell %></td></tr>
                    <tr><td>R.B.C. (/hpf)</td><td class="text-center result-value"><%= urinerbc %></td></tr>
                    <tr><td>CAST (/hpf)</td><td class="text-center result-value"><%= castt %></td></tr>
                    <tr><td>Epl. Cell (/hpf)</td><td class="text-center result-value"><%= eplcell %></td></tr>
                    <tr><td>Crystal (/hpf)</td><td class="text-center result-value"><%= crystal %></td></tr>
                    <tr><td>Any other (/hpf)</td><td class="text-center result-value"><%= other %></td></tr>
                </table>
            </div>
            <div class="col-md-6">
                <h3 class="section-title">Stool Examination</h3>
                <table class="test-table">
                    <tr><td>OVA (/hpf)</td><td class="text-center result-value"><%= ova %></td></tr>
                    <tr><td>CYST (/hpf)</td><td class="text-center result-value"><%= cyst %></td></tr>
                    <tr><td>Pus Cell (/hpf)</td><td class="text-center result-value"><%= stoolpuscell %></td></tr>
                    <tr><td>R.B.C. (/hpf)</td><td class="text-center result-value"><%= stoolrbc %></td></tr>
                    <tr><td>Trophozoltes (/hpf)</td><td class="text-center result-value"><%= tropho %></td></tr>
                </table>
                <h3 class="section-title">Blood Group</h3>
                <table class="test-table">
                    <tr><td>Blood Group</td><td class="text-center result-value"><%= bloodgroup %></td></tr>
                    <tr><td>Rh Factor</td><td class="text-center result-value"><%= rh %></td></tr>
                </table>
            </div>
        </div>


		<div class="page-break"></div>


        <h3 class="section-title">Biochemistry & Liver Function</h3>
        <div class="table-responsive">
            <table class="test-table">
                <thead>
                    <tr>
                        <th width="30%">Test Name</th>
                        <th width="20%" class="text-center">Result</th>
                        <th width="15%">Unit</th>
                        <th width="35%">Reference Range (Normal)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td>FBS</td><td class="text-center result-value"><%= fbs %></td><td class="text-center">mg/dl</td><td>60 - 100</td></tr>
                    <tr><td>PPBS</td><td class="text-center result-value"><%= ppbs %></td><td class="text-center">mg/dl</td><td>upto 140</td></tr>
                    <tr><td>Blood Urea</td><td class="text-center result-value"><%= bloodurea %></td><td class="text-center">mg/dl</td><td>10 - 50</td></tr>
                    <tr><td>S. Cholesterol</td><td class="text-center result-value"><%= chol %></td><td class="text-center">mg/dl</td><td>130 - 200</td></tr>
                    <tr><td>S. Triglyceride</td><td class="text-center result-value"><%= trigly %></td><td class="text-center">mg/dl</td><td>40 - 150</td></tr>
                    <tr><td>S. HDL</td><td class="text-center result-value"><%= hdl %></td><td class="text-center">mg/dl</td><td>30 - 70</td></tr>
                    <tr><td>S. LDL</td><td class="text-center result-value"><%= ldl %></td><td class="text-center">mg/dl</td><td>&lt; 100</td></tr>
                    <tr><td>S. Creatinine</td><td class="text-center result-value"><%= creatine %></td><td class="text-center">mg/dl</td><td>0.6 - 1.1</td></tr>
                    <tr><td>S. Uric Acid</td><td class="text-center result-value"><%= uricacid %></td><td class="text-center">mg/dl</td><td>2.4 - 7.0</td></tr>
                    <tr><td>S. Calcium</td><td class="text-center result-value"><%= calcium %></td><td class="text-center">mg/dl</td><td>8.5 - 10.5</td></tr>
                    <tr><td>S. Billirubin</td><td class="text-center result-value"><%= billirubin %></td><td class="text-center">mg/dl</td><td>0.2 - 1.0</td></tr>
                    <tr><td>SGOT</td><td class="text-center result-value"><%= sgot %></td><td class="text-center">IU/L</td><td>5 - 45</td></tr>
                    <tr><td>SGPT</td><td class="text-center result-value"><%= sgpt %></td><td class="text-center">IU/L</td><td>5 - 45</td></tr>
                    <tr><td>Total Protein</td><td class="text-center result-value"><%= protein %></td><td class="text-center">g/dL</td><td>6.5 - 8.5</td></tr>
                    <tr><td>Albumin</td><td class="text-center result-value"><%= albumin %></td><td class="text-center">g/dL</td><td>3.5 - 5.0</td></tr>
                    <tr><td>Globulin</td><td class="text-center result-value"><%= globulin %></td><td class="text-center">g/dL</td><td>3.0 - 3.5</td></tr>
                    <tr><td>S. Alkaline Phosphate</td><td class="text-center result-value"><%= alkaline %></td><td class="text-center">IU/L</td><td>Adult 60 - 170</td></tr>
                </tbody>
            </table>
        </div>

        <h3 class="section-title">Serology (Infectious & Other Markers)</h3>
        <div class="row">
            <div class="col-md-6">
                <table class="test-table">
                    <tr><th>Test Name</th><th class="text-center">Result</th></tr>
                    <tr><td>Pregnancy Test</td><td class="text-center result-value"><%= preg %></td></tr>
                    <tr><td>VDRL</td><td class="text-center result-value"><%= vdrl %></td></tr>
                    <tr><td>Aust. Antigen (HBsAg)</td><td class="text-center result-value"><%= antigen %></td></tr>
                    <tr><td>R.A. Factor</td><td class="text-center result-value"><%= ra %></td></tr>
                    <tr><td>Malaria Antigen</td><td class="text-center result-value"><%= malaria %></td></tr>
                </table>
            </div>
            <div class="col-md-6">
                <h5 class="section-title" style="margin-top:0;">Widal Test (Typhoid)</h5>
                <table class="test-table">
                    <thead>
                        <tr>
                            <th width="30%">Antigen</th>
                            <th colspan="5" class="text-center">Titre</th>
                        </tr>
                        <tr>
                            <th></th>
                            <th>1/20</th><th>1/40</th><th>1/80</th><th>1/160</th><th>1/320</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td>TO</td><td><%= to20 %></td><td><%= to40 %></td><td><%= to80 %></td><td><%= to160 %></td><td><%= to320 %></td></tr>
                        <tr><td>TH</td><td><%= th20 %></td><td><%= th40 %></td><td><%= th80 %></td><td><%= th160 %></td><td><%= th320 %></td></tr>
                        <tr><td>AH</td><td><%= ah20 %></td><td><%= ah40 %></td><td><%= ah80 %></td><td><%= ah160 %></td><td><%= ah320 %></td></tr>
                        <tr><td>BH</td><td><%= bh20 %></td><td><%= bh40 %></td><td><%= bh80 %></td><td><%= bh160 %></td><td><%= bh320 %></td></tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="text-center mt-5">
            <p>Report prepared and verified by Medical Department.</p>
            <button onclick="window.print()" class="btn btn-lg btn-success">
                <i class="fa fa-print"></i> Print Report
            </button>
            <a href="/hosp1/EndUser/EndUserMedicalReport.jsp" class="btn btn-lg btn-secondary ml-3">
                <i class="fa fa-arrow-left"></i> Back to Report List
            </a>
        </div>

    </div>
</div>

<script>
function Home() {
    window.location.href = "/hosp1/EndUser/endUser.jsp"; // Assuming this is the path to the end user home
}
</script>
</body>
</html>