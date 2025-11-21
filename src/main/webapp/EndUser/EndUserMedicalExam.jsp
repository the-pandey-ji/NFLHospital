<%@ page language="java" session="true"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.EndUser" %> 
<%@ page import="java.util.Calendar" %>

<%
// ==========================================================
// 1. AUTHENTICATION & SECURITY SETUP
// ==========================================================
EndUser user6 = (EndUser) session.getAttribute("EndUserObj");
if (user6 == null) {
	response.sendRedirect("/hosp1/index.jsp");
	return;
}

// The logged-in employee's number (MANDATORY security filter)
String loggedInEmpn = user6.getEmpn();

// --- 2. YEAR SELECTION LOGIC ---
String currentYear = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
String selectedYear = request.getParameter("year");

// If no year is selected in the URL, default to the current year.
if (selectedYear == null || selectedYear.isEmpty()) {
    selectedYear = currentYear;
}

// Initialize variables
String yr = selectedYear;
Connection conn = null;
Connection conn1 = null;
Connection conn2 = null;
%>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>My Referral History</title>
<style type="text/css">
.data-table {
    border-collapse: collapse;
    width: 100%;
    margin-top: 15px;
    font-size: 13px;
}
.data-table th, .data-table td {
    border: 1px solid #ccc;
    padding: 8px;
    text-align: left;
}
.data-table th {
    background-color: #303f9f;
    color: white;
}
.summary-table {
    width: 40%;
    margin: 20px auto;
}
.summary-table th {
    background-color: #f0f0f0;
}
.year-form-container {
    text-align: right;
    margin-bottom: 20px;
    padding-right: 20px;
}
</style>
</head>
<body>
<%@include file="/EndUser/endUserNavbar.jsp" %>

<div class="container" style="padding: 20px;">
    <p align="center"><u><b><font size="4">My Referral History</font></b></u></p>
    
    <div class="year-form-container">
        <form method="GET" action="EndUserReferDetails.jsp" style="display:inline-block;">
            <label for="yearSelect" style="font-weight:bold; margin-right: 10px;">Select Year:</label>
            <select name="year" id="yearSelect" onchange="this.form.submit()" class="form-control" style="width:100px; display:inline-block;">
                <% 
                    int yearInt = Integer.parseInt(currentYear);
                    // Generate options for the last 10 years, adjust range as needed
                    for (int y = yearInt; y >= yearInt - 9; y--) { 
                        String yearStr = String.valueOf(y);
                %>
                        <option value="<%=yearStr%>" <%=yearStr.equals(selectedYear) ? "selected" : "" %>><%=yearStr%></option>
                <%
                    }
                %>
            </select>
            <noscript><button type="submit" class="btn btn-sm btn-primary">Go</button></noscript>
        </form>
    </div>
    
    <h4 align="center">Records for Year: **<%=selectedYear%>**</h4>
    <hr>

    <p align="left"><b><font size="3">1. Local References</font></b></p>
    <table border="1" cellpadding="0" cellspacing="0" class="data-table">
        <thead>
            <tr>
                <th width="5%">REFNO</th>
                <th width="16%">PATIENTNAME</th>
                <th width="6%">EMPN</th>
                <th width="6%">RELATION</th>
                <th width="12%">REFDATE</th>
                <th width="16%">DOC</th>
                <th width="16%">HOSPITAL NAME</th>
                <th width="16%">REFER / REVISIT</th>
            </tr>
        </thead>
        <tbody>
<%
    String refno="";
    String pname="";
    String relation="";
    String refdt="";
    String doctor="";
    String spc="";
    String revisit="";
    
    try {
        conn1 = DBConnect.getConnection();
        Statement stmt1 = conn1.createStatement();
        
        // SQL using the selected year (yr) for the dynamic table name
        String localQuery = "SELECT a.REFNO, a.PATIENTNAME, a.EMPN, a.REL, TO_CHAR(a.REFDATE, 'DD-MM-YYYY'), a.doc, c.hname, " +
                            "CASE WHEN a.revisitflag = 'N' THEN 'Refer' WHEN a.revisitflag = 'Y' THEN 'Revisit' WHEN a.revisitflag IS NULL THEN 'Refer' ELSE NULL END AS revisit_status " +
                            "FROM LOACALREFDETAIL"+yr+" a JOIN LOCALHOSPITAL c ON a.SPECIALIST = c.hcode " +
                            "WHERE a.EMPN = '"+loggedInEmpn+"' ORDER BY a.refno DESC";
                            
        ResultSet rs = stmt1.executeQuery(localQuery);
        
        boolean localRecordsFound = false;

        while (rs.next()) {
            localRecordsFound = true;
            refno = rs.getString(1);
            pname = rs.getString(2);
            relation = rs.getString(4);
            refdt = rs.getString(5);
            doctor = rs.getString(6);
            spc = rs.getString(7);  
            revisit = rs.getString(8);
%>	
            <tr>
                <td><%=refno%></td>
                <td><%=pname%></td>
                <td><%=loggedInEmpn%></td>
                <td><%=relation%></td>
                <td><%=refdt%></td>
                <td><%=doctor%></td>
                <td><%=spc%></td>
                <td><%=revisit%></td>
            </tr>
<%
        }
        if (!localRecordsFound) {
            
            out.println("<tr><td colspan='8' align='center'>No local referral records found for the year "
            + selectedYear + ".</td></tr>");
        }
        rs.close();
        stmt1.close();
        
    } catch(SQLException e) {
        out.println("<tr><td colspan='8' align='center' style='color:red;'>Local Reference Database Error (Table for "+ selectedYear + " might not exist): " + e.getMessage() + "</td></tr>");
    } finally {
        if(conn1 != null) try { conn1.close(); } catch (Exception ignored) {}
    }
%>
        </tbody>
    </table>

    <p align="left" style="margin-top: 30px;"><b><font size="3">2. Outstation References</font></b></p>
    <table border="1" cellpadding="0" cellspacing="0" class="data-table">
        <thead>
            <tr>
                <td width="6%">REFNO</td>
                <td width="15%">PATIENTNAME</td>
                <td width="7%">EMPN</td>
                <td width="9%">RELATION</td>
                <td width="5%">AGE</td>
                <td width="10%">REFDATE</td>
                <td width="17%">HOSPITAL / CITY</td>
                <td width="15%">DOC</td>
                <td width="7%">ESCORT</td>
                <td width="16%">REFER / REVISIT</td>
            </tr>
        </thead>
        <tbody>
<%
    String refno1="";
    String pname1="";
    String relation1="";
    String age1="";
    String refdt1="";
    String escort1="";
    String doctor1="";
    String hospital1="";
    String city1="";
    String revisit1="";

    try {
        conn2 = DBConnect.getConnection();
        Statement stmt2 = conn2.createStatement();
        
        // SQL using the selected year (yr) for the dynamic table name
        String outQuery = "SELECT a.REFNO, a.PATIENTNAME, a.EMPN, a.REL, a.AGE, TO_CHAR(a.REFDATE, 'DD-MM-YYYY'), a.doc, b.hname, b.city, a.ESCORT, " +
                            "CASE WHEN a.revisitflag = 'N' THEN 'Refer' WHEN a.revisitflag = 'Y' THEN 'Revisit' WHEN a.revisitflag IS NULL THEN 'Refer' ELSE NULL END AS revisit_status " +
                            "FROM OUTREFDETAIL" + yr + " a JOIN OUTSTATIONHOSPITAL b ON a.hospital = b.HCODE " +
                            "WHERE a.EMPN = '"+loggedInEmpn+"' ORDER BY a.refno DESC";

        ResultSet rs1 = stmt2.executeQuery(outQuery);
        
        boolean outRecordsFound = false;
        
        while(rs1.next()) {
            outRecordsFound = true;
            refno1 = rs1.getString(1);
            pname1 = rs1.getString(2);
            relation1 = rs1.getString(4);
            age1 = rs1.getString(5);
            refdt1 = rs1.getString(6);
            doctor1 = rs1.getString(7);
            hospital1 = rs1.getString(8);
            city1 = rs1.getString(9);
            escort1 = rs1.getString(10);
            revisit1 = rs1.getString(11);
%>	 
            <tr>
                <td><%=refno1%>&nbsp;</td>
                <td><%=pname1%>&nbsp;</td>
                <td><%=loggedInEmpn%>&nbsp;</td>
                <td><%=relation1%>&nbsp;</td>
                <td><%=age1%>&nbsp;</td>
                <td><%=refdt1%>&nbsp;</td>
                <td><%=hospital1%>, <%=city1%>&nbsp;</td>
                <td><%=doctor1%>&nbsp;</td>
                <td><%=escort1%>&nbsp;</td>
                <td><%=revisit1%>&nbsp;</td>
            </tr>
<%	
        }
        if (!outRecordsFound) {
            out.println("<tr><td colspan='10' align='center'>No outstation referral records found for the year " + selectedYear+".</td></tr>");
        }
        rs1.close();
        stmt2.close();

    } catch(SQLException e) {
        out.println("<tr><td colspan='10' align='center' style='color:red;'>Outstation Reference Database Error (Table for"+ selectedYear+" might not exist): " + e.getMessage() + "</td></tr>");
    } finally {
        if(conn2 != null) try { conn2.close(); } catch (Exception ignored) {}
    }
%>
        </tbody>
    </table>

    <p align="center" style="margin-top: 30px;">
        Viewing records for <%=selectedYear%>. Change the year above to view historical data.
    </p>

</div>
</body>
</html>