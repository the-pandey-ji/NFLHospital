<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.* "%>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.DB.DBConnect" %>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Reference No</title>
<style type="text/css" media="print">
 @media print {
    @page {
      size: A5;
      margin: 5mm;
    }

    body {
      zoom: 0.7; /* 70% scale */
    }

    .printbutton {
      display: none !important; /* Hide print button during printing */
    }
  }
.printbutton 
  {
    visibility: hidden;
    display: none;
  }
</style>
</head>

<body>
<%-- <%@include file="/navbar.jsp" %> --%>
<%
    String yr = "";
    String refno = request.getParameter("refno");
    String name = request.getParameter("name");
    String empn = request.getParameter("empn");
    String relation = request.getParameter("relation");
    String age = request.getParameter("age");
    String refdt = request.getParameter("refdt");
    String refdt1 = "";
    String sex = request.getParameter("sex");
    String disease = request.getParameter("disease");
    String referto = request.getParameter("referto");
    String referby = request.getParameter("referby");
    String hcode = request.getParameter("hcode");

    String desg = "";
    String dept = "";
    String ename = "";
    String referredto = "";

    Connection conn = null;
    Connection conn1 = null;

    try {
        conn = DBConnect.getConnection();
        conn1 = DBConnect.getConnection1();

        // Get employee details
        String empQuery = "SELECT a.ename, a.DESIGNATION, c.DISCIPLINENAME " +
                          "FROM employeemaster a, FURNITUREDEPT b, FURNITUREDISCIPLINE c " +
                          "WHERE a.DEPTCODE = b.DEPTCODE AND b.SECTIONCODE = c.DISCIPLINECODE AND a.empn = ?";
        PreparedStatement empStmt = conn1.prepareStatement(empQuery);
        empStmt.setString(1, empn);
        ResultSet rs1 = empStmt.executeQuery();

        if (rs1.next()) {
            ename = rs1.getString(1);
            desg = rs1.getString(2);
            dept = rs1.getString(3);
        }

        // Get hospital name and year
        String hospQuery = "SELECT hname, TO_CHAR(SYSDATE, 'yyyy'), TO_CHAR(SYSDATE, 'dd-mm-yyyy') FROM LOCALHOSPITAL WHERE hcode = ?";
        PreparedStatement hospStmt = conn.prepareStatement(hospQuery);
        hospStmt.setString(1, hcode);
        ResultSet rs2 = hospStmt.executeQuery();

        if (rs2.next()) {
            referredto = rs2.getString(1);
            yr = rs2.getString(2);
            refdt1 = rs2.getString(3);
        }

        // Build insert query using PreparedStatement
        String tableName = "LOACALREFDETAIL" + yr;

        String insertQuery = "INSERT INTO " + tableName +
                " (REFNO, PATIENTNAME, EMPN, REL, AGE, REFDATE, SEX, DISEASE, DOC, specialist, REVISITFLAG) " +
                "VALUES (?, ?, ?, ?, ?, TO_DATE(?, 'DD-MM-YYYY'), ?, ?, ?, ?, ?)";

        PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
        insertStmt.setString(1, refno);
        insertStmt.setString(2, name);
        insertStmt.setString(3, empn);
        insertStmt.setString(4, relation);
        insertStmt.setString(5, age);
        insertStmt.setString(6, refdt1); // Today's date
        insertStmt.setString(7, sex);
        insertStmt.setString(8, disease);
        insertStmt.setString(9, referby);
        insertStmt.setString(10, hcode);
        insertStmt.setString(11, "Y");

        int rowsInserted = insertStmt.executeUpdate();

        if (rowsInserted == 0) {
            out.println("<p style='color:red;'>Record not inserted. Please check your data.</p>");
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Log server-side
        out.println("<p style='color:red;'>Database Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (conn != null) conn.close();
            if (conn1 != null) conn1.close();
        } catch (Exception ignored) {
        }
    }
%>

<div align="center">
  
  <p>&nbsp;</p>
  <table border="0" width="100%" height="78%" style="border-style: solid; border-width: 1">
    <tr>
	<center>
      <td width="100%" height="101" style="border-style: solid; border-width: 1">
      <p align="center">&nbsp;&nbsp;&nbsp;&nbsp;
        <font face="Arial"  size="5"><b>&#2344;&#2375;&#2358;&#2344;&#2354; &#2347;&#2352;&#2381;&#2335;&#2367;&#2354;&#2366;&#2311;&#2332;&#2352;&#2381;&#2360; &#2354;&#2367;&#2350;&#2367;&#2335;&#2375;&#2337; </b></font> <br/><font face="Arial" size="4">&#2319;&#2344;.&#2319;&#2347;.&#2319;&#2354;. &#2330;&#2367;&#2325;&#2367;&#2340;&#2381;&#2360;&#2366;&#2354;&#2351;, &#2346;&#2366;&#2344;&#2368;&#2346;&#2340; </font> </p>
        <p align="center" >
        <font  face="Arial" size="3">&#2346;&#2366;&#2344;&#2368;&#2346;&#2340;  &#2311;&#2325;&#2366;&#2312;: &#2330;&#2367;&#2325;&#2367;&#2340;&#2381;&#2360;&#2366; &#2357;&#2367;&#2349;&#2366;&#2327;</font></p>
        <p align="center" >
        <font  face="Arial" size="4">&#2344;&#2367;&#2352;&#2381;&#2342;&#2375;&#2358;-&#2346;&#2352;&#2381;&#2330;&#2368;</font></p>
      </td>
	  </center>
    </tr>
    <tr>
      <td width="100%" style="vertical-align: top;">
	   <p align="center"><u><b><font face="Kruti Dev 010" size="5">&#2352;&#2368;-&#2357;&#2367;&#2332;&#2367;&#2335;</font></b></u></p>
	   <p style="text-align:left;">
<font font face="Arial"  size="2">&nbsp;&nbsp;&#2310;&#2352;&#2306;&#2349;&#2367;&#2325; &#2325;&#2381;&#2352;&#2350; &#2360;&#2306;</font><font face="Arial" size="2">:&nbsp;<%= refno%></font>&nbsp;&nbsp;&nbsp;&nbsp;
        <font font face="Arial"  size="2">&#2342;&#2367;&#2344;&#2366;&#2306;&#2325;</font><font face="Arial" size="2">: <%=refdt%></font>
<span style="float:right;"><font font face="Arial"  size="2">&#2352;&#2368;-&#2357;&#2367;&#2332;&#2367;&#2335; &#2342;&#2367;&#2344;&#2366;&#2306;&#2325;:</font><%=refdt1%>&nbsp;&nbsp;&nbsp;</span>
</p>
	   
        
        
		
        <p style="line-height: 150%"><font face="Arial" size="2">&#2358;&#2381;&#2352;&#2368;/&#2358;&#2381;&#2352;&#2368;&#2350;&#2340;&#2368;/&#2358;&#2381;&#2352;&#2368;&#2350;&#2366;&#2344;/&#2360;&#2369;&#2358;&#2381;&#2352;&#2368;&#2358;&#2381;&#2352;&#2368;</font><font face="Arial" size="2">&nbsp;Sh/Smt/Mr/Ms :&nbsp;<%= name%></font>&nbsp;&nbsp;&nbsp;
        <font face="Arial" size="2">&#2360;&#2306;&#2348;&#2306;&#2343;</font>&nbsp;<font face="Arial" size="2"> Relation :&nbsp;<%=relation%> &nbsp;&nbsp; of &nbsp;&nbsp;<font face="Arial" size="2">&#2358;&#2381;&#2352;&#2368;&#2350;&#2366;&#2344;/&#2358;&#2381;&#2352;&#2368;&#2350;&#2340;&#2368;</font>&nbsp; Mr/Ms
        :&nbsp;<%=ename%>  </font>&nbsp;<font face="Arial" size="2">&#2346;&#2342;&#2344;&#2366;&#2350;</font>&nbsp;&nbsp;<font face="Arial" size="2">Designation :&nbsp;<%= desg%>&nbsp;&nbsp;<font face="Arial" size="2">&#2357;&#2367;&#2349;&#2366;&#2327;</font>&nbsp;&nbsp;Deptt :&nbsp;<%=dept%>&nbsp;<font face="Arial" size="2">&#2325;&#2352;&#2381;&#2350;&#2330;&#2366;&#2352;&#2368; &#2360;&#2306;&#2326;&#2381;&#2351;&#2366;</font>&nbsp;<font face="Arial"><font size="2">
        E.Code :&nbsp;<%=empn%></font>&nbsp;<font face="Arial" size="2">&#2325;&#2379; &#2352;&#2375;&#2347;&#2352;</font>&nbsp;referred to &nbsp;&nbsp;</font>&nbsp;<%=referredto%>&nbsp;for&nbsp;&nbsp;<%=disease%>&nbsp;&nbsp;<font face="Arial" size="2">&#2325;&#2367;&#2351;&#2366; &#2332;&#2366;&#2340;&#2366; &#2361;&#2376;</font>.</p>
        <br/>
		<br/>
                <p align="right"> 
<!-- <b> Senior Chief Medical Officer / Medical Officer </b> -->
<font face="Arial" size="2">&#2357;&#2352;&#2367;&#2359;&#2381;&#2336; &#2350;&#2369;&#2326;&#2381;&#2351; &#2330;&#2367;&#2325;&#2367;&#2340;&#2381;&#2360;&#2366; &#2309;&#2343;&#2367;&#2325;&#2366;&#2352;&#2368; / &#2330;&#2367;&#2325;&#2367;&#2340;&#2381;&#2360;&#2366; &#2309;&#2343;&#2367;&#2325;&#2366;&#2352;&#2368;</font>
&nbsp;&nbsp;&nbsp;<br><b> Senior Chief Medical Officer / Medical Officer </b></p>
        
        </td>
    </tr>
	<tr> 
<td colspan="2"><left> <font face="Arial"  size="2">&#2344;&#2379;&#2335;&#2307;- <br/> 1. &#2352;&#2375;&#2347;&#2352; &#2361;&#2360;&#2381;&#2346;&#2340;&#2366;&#2354;/&#2337;&#2377;&#2325;&#2381;&#2335;&#2352; &#2325;&#2375; &#2346;&#2366;&#2360; &#2311;&#2354;&#2366;&#2332; &#2325;&#2375; &#2354;&#2367;&#2319; &#2332;&#2366;&#2344;&#2375; &#2360;&#2375; &#2346;&#2361;&#2354;&#2375; &#2361;&#2360;&#2381;&#2346;&#2340;&#2366;&#2354; &#2360;&#2375; &#2352;&#2375;&#2335;&#2381;&#2360; &#2319;&#2357;&#2306; &#2337;&#2367;&#2360;&#2381;&#2325;&#2366;&#2313;&#2306;&#2335; &#2325;&#2368; &#2332;&#2366;&#2344;&#2325;&#2366;&#2352;&#2368; &#2309;&#2357;&#2358;&#2381;&#2351; &#2354;&#2375; &#2354;&#2375;&#2306;&#2357;&#2375;&#2404;
<br>
2. &#2361;&#2360;&#2381;&#2346;&#2340;&#2366;&#2354;/&#2325;&#2381;&#2354;&#2367;&#2344;&#2367;&#2325; &#2325;&#2375; &#2325;&#2366;&#2313;&#2306;&#2335;&#2352; &#2346;&#2352; &#2319;&#2344;.&#2319;&#2347;.&#2319;&#2354;. &#2325;&#2366; &#2310;&#2312; &#2337;&#2368; &#2325;&#2366;&#2352;&#2381;&#2337;/&#2361;&#2360;&#2381;&#2346;&#2340;&#2366;&#2354; &#2325;&#2368; &#2350;&#2375;&#2337;&#2367;&#2325;&#2354; &#2348;&#2369;&#2325;  &#2342;&#2367;&#2326;&#2366;&#2344;&#2366; &#2309;&#2344;&#2367;&#2357;&#2366;&#2352;&#2381;&#2351; &#2361;&#2376;&#2404;
<br>
3. &#2311;&#2360; &#2352;&#2375;&#2347;&#2352; &#2360;&#2381;&#2354;&#2367;&#2346; &#2325;&#2375; &#2332;&#2366;&#2352;&#2368; &#2361;&#2379;&#2344;&#2375; &#2325;&#2375; 10 &#2342;&#2367;&#2344; &#2325;&#2375; &#2309;&#2344;&#2381;&#2342;&#2352; &#2346;&#2352;&#2366;&#2350;&#2352;&#2381;&#2358; &#2354;&#2375;&#2344;&#2366; &#2332;&#2352;&#2369;&#2352;&#2368; &#2361;&#2376;&#2404;
</font></center> </td>	
	</tr>
  </table>
</div>
<p align="center"><script>
document.write("<input type='button' " +
"onClick='window.print()' " +
"class='printbutton' " +
"value='&#2346;&#2381;&#2352;&#2367;&#2306;&#2335; &#2325;&#2352;&#2375;&#2306;  Print This Page'/>");
</script>
</p>

</body>

</html>