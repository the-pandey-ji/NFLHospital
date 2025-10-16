<%@ page language="java" session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.entity.User" %>

<%

    // Check if the user is logged in
    User user = (User) session.getAttribute("Docobj");
    if (user == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("/hosp1/index.jsp");
        
        return;
    }
%>


<html>
<head>
    <title>Medical Fitness Certificate</title>
    <style type="text/css" media="print">
        .printbutton {
            visibility: hidden;
            display: none;
        }
    </style>
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");

    String relationType = request.getParameter("relationType");
    String empn         = request.getParameter("empn");
    String ename        = request.getParameter("ename");
    String desg         = request.getParameter("desg");
    String dept         = request.getParameter("dept");
    String disease      = request.getParameter("disease");
    String fromdt       = request.getParameter("fromdt");
    String todt         = request.getParameter("todt");
    String fitdt        = request.getParameter("fitdt");

    // Dependent specific
    String pname = ename; // default (self)
    String relation = "Self";
    //String father = "";

    if ("dependent".equalsIgnoreCase(relationType)) {
        pname = request.getParameter("dependentName");
        relation = request.getParameter("relation");
        //father = ename; // if dependent, show employee name as father/guardian
    }

    // Calculate leave duration in days
    long days = 0;
    try {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date from = sdf.parse(fromdt);
        java.util.Date to = sdf.parse(todt);
        long diff = to.getTime() - from.getTime();
        days = (diff / (1000 * 60 * 60 * 24)) + 1;
    } catch (Exception e) {
        out.println("<p style='color:red'>Date parsing error: " + e.getMessage() + "</p>");
    }

    int srno = 0;
    String dt = "";

    Connection conn = null;

    try {
        conn = DBConnect.getConnection();
        Statement stmt = conn.createStatement();

        ResultSet rs = stmt.executeQuery("SELECT NVL(MAX(srno), 0) + 1, TO_CHAR(SYSDATE, 'dd-mm-yyyy') FROM medicalcrt");
        if (rs.next()) {
            srno = rs.getInt(1);
            dt = rs.getString(2);
        }
        rs.close();

        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO medicalcrt " +
            "(srno, patientname, relation, fathername, empn, desg, dept, disease, sdate, edate, ldays, mdate, fit) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), TO_DATE(?, 'YYYY-MM-DD'), ?, SYSDATE, TO_DATE(?, 'YYYY-MM-DD'))"
        );

        ps.setInt(1, srno);
        ps.setString(2, pname);
        ps.setString(3, relation);
        ps.setString(4, ename);
        ps.setString(5, empn);
        ps.setString(6, desg);
        ps.setString(7, dept);
        ps.setString(8, disease);
        ps.setString(9, fromdt);
        ps.setString(10, todt);
        ps.setLong(11, days);
        ps.setString(12, fitdt);

        ps.executeUpdate();
        ps.close();

    } catch (SQLException e) {
        out.println("<p style='color:red'>Database error: " + e.getMessage() + "</p>");
    } finally {
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>

<div align="center">
    <table border="0" width="70%">
        <tr>
            <td style="border: 1px solid black; padding: 10px;">
                <h3 style="text-align:center; font-family: Arial Black;">NATIONAL FERTILIZERS LIMITED</h3>
                <p style="text-align:center; font-family: Arial;">PANIPAT UNIT</p>
                <p style="text-align:center;"><b>MEDICAL DEPARTMENT</b></p>
                <p style="text-align:center;"><b>FITNESS CERTIFICATE</b></p>
                <hr>
                <p><b>Ref No:</b> NFL/PNP/HOS/<%= srno %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Date:</b> <%= dt %></p>

                <p style="line-height: 1.8; font-size: 16px;">
                    Certified that Mr./Mrs. <b><%= pname %></b>,
                    <b><%= relation %></b> of Sh. <b><%= ename %></b>,
                    Employee Code No. <b><%= empn %></b>,
                    Designation <b><%= desg %></b>,
                    Department <b><%= dept %></b>,
                    was suffering from <b><%= disease %></b>.
                    He/She was on medical leave for <b><%= days %></b> days w.e.f. <b><%= fromdt %></b> to <b><%= todt %></b>.
                </p>

                <p style="font-size: 16px;">
                    He/She is fit to resume duty w.e.f. <b><%= fitdt %></b>.
                </p>

                <br><br>
                <table width="100%">
                    <tr>
                        <td><b>Signature of the Patient</b></td>
                        <td style="text-align:right;"><b>Authorized Medical Officer</b></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>

<br>
<div align="center">
    <input type="button" class="printbutton" value="Print This Page" onclick="window.print();" />
</div>

</body>
</html>
