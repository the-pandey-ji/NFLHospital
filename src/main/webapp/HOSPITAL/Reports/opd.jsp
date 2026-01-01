<%@ page language="java" session="true"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.DB.DBConnect" %>
<html>
<head>
    <meta http-equiv="Content-Language" content="en-us">
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>OPD Report (Date Range)</title>
    <style type="text/css" media="print">
        .printbutton { visibility: hidden; display: none; }
    </style>
</head>
<body>
<%@include file="/navbar.jsp" %>

<%
String fromDate = request.getParameter("fromDate");
String toDate = request.getParameter("toDate");

if (fromDate == null || toDate == null || fromDate.trim().isEmpty() || toDate.trim().isEmpty()) {
    out.println("<h3 style='color:red;text-align:center;'>Date range is missing. Please go back and select both From and To dates.</h3>");
    return;
}

// Parse the input dates
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
java.util.Date fromDateUtil = sdf.parse(fromDate);
java.util.Date toDateUtil = sdf.parse(toDate);

int fromYear = Integer.parseInt(fromDate.substring(0,4));
int toYear = Integer.parseInt(toDate.substring(0,4));

// List to store all OPD records across years
List<Map<String,Object>> allOPDs = new ArrayList<Map<String,Object>>();

Connection con = null, con1 = null;
PreparedStatement pstmt = null, pstmt2 = null;
ResultSet rs = null, rs2 = null;

try {
    con = DBConnect.getConnection();
    con1 = DBConnect.getConnection1();

    // Loop through all years in the range
    for(int yr = fromYear; yr <= toYear; yr++) {

        String opdTable = (yr == Calendar.getInstance().get(Calendar.YEAR)) ? "opd" : "opd" + yr;

        // Set start and end date for this year
        java.sql.Date startDate = (yr == fromYear) ? new java.sql.Date(fromDateUtil.getTime())
                                                   : java.sql.Date.valueOf(yr + "-01-01");
        java.sql.Date endDate = (yr == toYear) ? new java.sql.Date(toDateUtil.getTime())
                                               : java.sql.Date.valueOf(yr + "-12-31");

        String query = "SELECT patientname, relation, age, sex, empn, srno, typ, empname, doctor " +
                       "FROM " + opdTable + " WHERE trunc(opddate) BETWEEN ? AND ? ORDER BY opddate, srno";

        pstmt = con.prepareStatement(query);
        pstmt.setDate(1, startDate);
        pstmt.setDate(2, endDate);
        rs = pstmt.executeQuery();

        while(rs.next()) {
            Map<String,Object> opd = new HashMap<String,Object>();
            opd.put("patientname", rs.getString("patientname"));
            opd.put("relation", rs.getString("relation"));
            opd.put("age", rs.getString("age"));
            opd.put("sex", rs.getString("sex"));
            opd.put("empn", rs.getLong("empn"));
            opd.put("srno", rs.getString("srno"));
            opd.put("typ", rs.getString("typ"));
            opd.put("empname", rs.getString("empname"));
            opd.put("doctor", rs.getString("doctor"));
            allOPDs.add(opd);
        }

        if(rs != null){ rs.close(); rs=null;}
        if(pstmt != null){ pstmt.close(); pstmt=null;}
    }

    // Display OPD Table
    int totalCount = 0;
%>

<p align="center"><b><font size="4" face="Tahoma" color="#800000">
OPD Details from <%= fromDate %> to <%= toDate %>
</font></b></p>

<table border="1" width="88%" align="center" style="border-collapse: collapse" bordercolor="#111111">
<tr>
    <td align="center"><b>OPD No</b></td>
    <td><b>Patient Name</b></td>
    <td><b>Employee Name</b></td>
    <td align="center"><b>E.Code</b></td>
    <td align="center"><b>Relation</b></td>
    <td align="center"><b>Age</b></td>
    <td align="center"><b>Sex</b></td>
    <td align="center"><b>Doctor</b></td>
</tr>

<%
for(Map<String,Object> opd : allOPDs) {
    totalCount++;
    String pname = opd.get("patientname") != null ? opd.get("patientname").toString() : "UNKNOWN";
    String relation = opd.get("relation") != null ? opd.get("relation").toString() : "N/A";
    String age = opd.get("age") != null ? opd.get("age").toString() : "Unknown";
    String sex = opd.get("sex") != null ? opd.get("sex").toString() : "Unknown";
    String srno = opd.get("srno") != null ? opd.get("srno").toString() : "N/A";
    String ename = opd.get("empname") != null ? opd.get("empname").toString() : "Unknown";
    String doc = opd.get("doctor") != null ? opd.get("doctor").toString() : "Not Assigned";
    long empn = opd.get("empn") != null ? (Long)opd.get("empn") : 0;
    String typ = opd.get("typ") != null ? opd.get("typ").toString() : "";

    // If type is 'N', fetch empname from employeemaster
    if("N".equalsIgnoreCase(typ)) {
        pstmt2 = con1.prepareStatement("SELECT ename FROM employeemaster WHERE empn = ?");
        pstmt2.setLong(1, empn);
        rs2 = pstmt2.executeQuery();
        if(rs2.next()){
            ename = rs2.getString("ename");
        }
        if(rs2 != null){ rs2.close(); rs2=null; }
        if(pstmt2 != null){ pstmt2.close(); pstmt2=null; }
    }
%>
<tr>
    <td align="center"><%= srno %></td>
    <td><%= pname.toUpperCase() %></td>
    <td><%= ename.toUpperCase() %></td>
    <td align="center"><%= empn %></td>
    <td align="center"><%= relation %></td>
    <td align="center"><%= age %></td>
    <td align="center"><%= sex %></td>
    <td align="center"><%= doc.toUpperCase() %></td>
</tr>
<%
}
%>
</table>

<p align="center"><b>Total Number of OPD Cases: <%= totalCount %></b></p>

<p align="center"><font face="Tahoma" size="3" color="#800000"><b>Doctor-wise OPD Summary</b></font></p>

<div align="center">
  <table border="1" width="30%" style="border-collapse: collapse" bordercolor="#111111">
    <tr>
      <td bgcolor="#FFCCCC"><b><font face="Tahoma" size="2">Doctor</font></b></td>
      <td bgcolor="#FFCCCC" align="center"><b><font face="Tahoma" size="2">No of OPD Cases</font></b></td>
    </tr>
<%
Map<String,Integer> doctorSummary = new TreeMap<String,Integer>();

// Build doctor-wise summary across all years
for(Map<String,Object> opd : allOPDs) {
    String doc = opd.get("doctor") != null ? opd.get("doctor").toString().toUpperCase() : "UNKNOWN";
    if(!doctorSummary.containsKey(doc)){
        doctorSummary.put(doc, 1);
    } else {
        doctorSummary.put(doc, doctorSummary.get(doc)+1);
    }
}

for(Map.Entry<String,Integer> entry : doctorSummary.entrySet()){
%>
<tr>
    <td><font face="Tahoma" size="2"><%= entry.getKey() %></font></td>
    <td align="center"><font face="Tahoma" size="2"><%= entry.getValue() %></font></td>
</tr>
<%
}
%>
  </table>
</div>

<%
} catch(Exception e){
    out.println("<pre style='color:red;'>Error: "+e.getMessage()+"</pre>");
} finally {
    if(rs!=null) try{ rs.close(); } catch(Exception ignored){}
    if(rs2!=null) try{ rs2.close(); } catch(Exception ignored){}
    if(pstmt!=null) try{ pstmt.close(); } catch(Exception ignored){}
    if(pstmt2!=null) try{ pstmt2.close(); } catch(Exception ignored){}
    if(con!=null) try{ con.close(); } catch(Exception ignored){}
    if(con1!=null) try{ con1.close(); } catch(Exception ignored){}
}
%>

</body>
</html>
