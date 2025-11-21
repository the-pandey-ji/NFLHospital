<%@ page language="java" session="true"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.EndUser" %> 

<%
// ==========================================================
// 1. AUTHENTICATION & SECURITY SETUP
// ==========================================================
EndUser user7 = (EndUser) session.getAttribute("EndUserObj");
if (user7 == null) {
	response.sendRedirect("/hosp1/index.jsp");
	return;
}

// The logged-in employee's number (MANDATORY security filter)
String loggedInEmpn = user7.getEmpn();

// Initialize variables
String pname = "";
String ldays = "";
String rel = "";
String mdate = "";
int srno = 0;
int totalRecords = 0;

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ResultSet rsCount = null;
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>My Medical Certificates</title>
<%@include file="/allCss.jsp"%> 
<style type="text/css">
.data-table {
    border-collapse: collapse;
    width: 90%;
    margin: 20px auto;
    font-size: 14px;
}
.data-table th, .data-table td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: left;
}
.data-table th {
    background-color: #303f9f;
    color: white;
}
</style>
</head>
<body>
<%@include file="/EndUser/endUserNavbar.jsp" %>

<div class="container" style="padding: 20px;">
    <p align="center"><u><b><font size="5">My Medical Certificate History</font></b></u></p>
    <p align="center">Viewing records for Employee Code: <b><%=loggedInEmpn%></b></p>
    
    <table border="1" cellpadding="0" cellspacing="0" class="data-table" align="center">
        <thead>
            <tr>
                <th width="10%" align="center">Med. Cert. No.</th>
                <th width="25%">Patient Name</th>
                <th width="15%" align="center">Relation</th>
                <th width="15%" align="center">Date Issued</th>
                <th width="15%" align="center">Total Leave Days</th>
                <th width="15%" align="center">Action</th>
            </tr>
        </thead>
        <tbody>
<%				
    try {
        conn = DBConnect.getConnection();
        stmt = conn.createStatement();
        
        // --- 2. SQL QUERY with MANDATORY EMPN FILTER ---
        // Fetches all medical certificates related to the logged-in employee, sorted by date (newest first).
        String dataQuery = "SELECT srno, patientname, relation, ldays, to_char(mdate,'DD-MM-YYYY') as mdate, empn " +
                           "FROM MEDICALCRT WHERE empn = '"+loggedInEmpn+"' ORDER BY mdate DESC";
        
        rs = stmt.executeQuery(dataQuery);
        boolean recordsFound = false;

        while(rs.next()) {
            recordsFound = true;
            pname = rs.getString("patientname");
            ldays = rs.getString("ldays");
            rel = rs.getString("relation");
            mdate = rs.getString("mdate");
            srno = rs.getInt("srno");
            totalRecords++;
%>	
            <tr>
                <td align="center">
                  
                        <%=srno%>
                    
                </td>
                <td><%=pname%></td>
                <td align="center"><%=rel%></td>
                <td align="center"><%=mdate%></td>
                <td align="center"><%=ldays%></td>
                <td align="center">
                    <a href="/hosp1/EndUser/MEDCertificateView.jsp?srno=<%=srno%>" target="_blank" class="btn btn-sm btn-primary">
                        View Certificate
                    </a>
                </td>
            </tr>

<%	
        } // End of while loop
        
        if (!recordsFound) {
             out.println("<tr><td colspan='6' align='center'>No medical certificate records found for your employee ID.</td></tr>");
        }
        
    } catch(SQLException e) {
        out.println("<tr><td colspan='6' align='center' style='color:red;'>Database Error: Failed to fetch certificate history: " + e.getMessage() + "</td></tr>");
    } finally {
        if(rs != null) try { rs.close(); } catch (Exception ignored) {}
        if(stmt != null) try { stmt.close(); } catch (Exception ignored) {}
        if(conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>
        </tbody>
    </table>

    <p align="center">
        Total Medical Certificates Found: <b><%=totalRecords%></b>
    </p>
</div>

</body>
</html>