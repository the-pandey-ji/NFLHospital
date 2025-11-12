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
<%@ page import="com.entity.User" %>

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
      zoom: 1; /* 70% scale */
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
 <%
 String yr = "", refno = "";
  	String ename = request.getParameter("ename");
  	String age = request.getParameter("age");
  	String refdt = request.getParameter("refdt");
  	String refdt1 = "";
  	String sex = request.getParameter("sex");
  	String disease = request.getParameter("disease");
  	String referto = request.getParameter("referto");
  	
  	String desg ="";
  	String dept ="";
  	/*  String name =""; */
  	String referredto ="";
   
      User user4 = (User) session.getAttribute("Docobj");
      String referby = user4.getUsername();

      String category = request.getParameter("category"); // self, dependent, other

      String empnParam = request.getParameter("empn");
      System.out.println("empnParam: " + empnParam);
      int empn = 1;

      String relationType = request.getParameter("relationType");   //self or dependent
      String dependentName = request.getParameter("dependentName");
      String relation = request.getParameter("relation")!=null ? request.getParameter("relation") : "SELF"; // for dependents
      String patientName = request.getParameter("patientName")!=null ? request.getParameter("patientName") : ename;      // for others
      String patientRelation = request.getParameter("patientRelation")!=null ? request.getParameter("patientRelation") : "SELF";  //for others
      
      String notes = "";
      String pname = "", typ = "";
      
      
      
      	 
      	 
      		    if (empnParam != null && !empnParam.trim().isEmpty()) {
      		        try {
      		            empn = Integer.parseInt(empnParam.trim());
      		        } catch (NumberFormatException e) {
      		            empn = 1; // fallback if invalid number
      		        }
      		    } else {
      		        empn = 1; // blank or missing -> default 0
      		    }
      		
     	  

      	Connection conn = null, con1 = null;
      	PreparedStatement ps = null, psEmp = null, psOpd = null;
      	ResultSet rsEmp = null;
      	Statement stmt = null;
      	int opdId = 1;
      	try {
      		conn = DBConnect.getConnection();
      		con1 = DBConnect.getConnection1();

      		// Generate OPD ID
      		stmt = conn.createStatement();
      		ResultSet rs1 = stmt.executeQuery("SELECT NVL(MAX(srno), 0) + 1 FROM OPD");
      		
      		if (rs1.next()) {
      	opdId = rs1.getInt(1);

      		}
      		rs1.close();
      		stmt.close();
      		
      		
      		// Get Hospital details
      		Statement stmt2 = conn.createStatement(); //for localhospital
      	   	ResultSet rs2 = stmt2.executeQuery(
      	   			"select hname,to_char(sysdate,'yyyy'),TO_CHAR(SYSDATE, 'dd-mm-yyyy') from LOCALHOSPITAL where hcode='"
      	   					+ referto + "'");
      	   	while (rs2.next()) {
      	   		referredto = rs2.getString(1);
      	   		yr = rs2.getString(2);
      	   		refdt1 = rs2.getString(3);

      	   	}


      	       notes = "Referred to " + referredto + " for " + disease;
      	        

      		// Get patient details
      		
      	    		   
      		if("NFL".equalsIgnoreCase(category)){
      			typ = "N";
      			if ("self".equalsIgnoreCase(relationType)) {
      	 			pname = ename;
      	 			relation = "SELF";
      	 		} else {
      	 			pname = dependentName;
      	 			// relation is already set from request
      	 		}
      		}
      		else if ("CISF".equalsIgnoreCase(category))
      			
      		{
      			typ = "C";
      			dept = "CISF";
      			if ("self".equalsIgnoreCase(relationType)) {
      	 			pname = ename;
      	 			relation = "SELF";
      	 		} else {
      	 			pname = dependentName;
      	 			// relation is already set from request
      	 			}
      			ResultSet rsEmp1 = null;
      			ps = conn.prepareStatement(
		                "SELECT DESG FROM PRODUCTION.CISFMAST WHERE EMPN = ?"
		            );
      			                ps.setInt(1, empn);
      			                rsEmp1 = ps.executeQuery();
      			  if (rsEmp1.next()) {
      			         desg = rsEmp1.getString("DESG");
      			       }
      		

		        			rsEmp1.close();
      			
      		}
      		
      		
 		 	else if ("Others".equalsIgnoreCase(category)){
 		 		typ = "O";
      			dept = "Others";
      			desg = "N/A";
      			pname = patientName;
      	 		relation = patientRelation;
 		 	}
      		else
 			out.println("Invalid category.");

 	/* System.out.println("Category: " + category);
 	System.out.println("empn: " + empn);
 	System.out.println("ename: " + ename);
 	System.out.println("relationType: " + relationType);
 	System.out.println("age: " + age);
 	System.out.println("sex: " + sex);
 	System.out.println("dependentName: " + dependentName);
 	System.out.println("relation: " + relation);
 	System.out.println("patientName: " + patientName);
 	System.out.println("patientRelation: " + patientRelation); */

 	
 	// Insert into OPD
 	String opdSql = "INSERT INTO OPD (SRNO, PATIENTNAME, RELATION, AGE, OPDDATE, SEX, EMPN, TYP, EMPNAME, doctor) "
 			+ "VALUES (?, ?, ?, ?, SYSDATE, ?, ?, ?, ? , ?)";
 	psOpd = conn.prepareStatement(opdSql);
 	psOpd.setInt(1, opdId);
 	psOpd.setString(2, pname);
 	psOpd.setString(3, relation);
 	psOpd.setString(4, age);
 	psOpd.setString(5, sex);
 	psOpd.setInt(6, empn);
 	psOpd.setString(7, typ);
 	psOpd.setString(8, ename);
 	psOpd.setString(9, user4.getUsername());
 	psOpd.executeUpdate();
 	psOpd.close();

 	// Save only diseases (no medicines)
 	PreparedStatement psDisease = conn
 			.prepareStatement("INSERT INTO HOSPITAL.PRESCRIPTION (OPD_ID, EMPN, NOTES) VALUES (?, ?, ?)");
 	psDisease.setInt(1, opdId);
 	psDisease.setInt(2, empn);

 	psDisease.setString(3, notes);
 	psDisease.executeUpdate();
 	psDisease.close();

 		} catch (Exception e) {
 	out.println("Error saving prescription: " + e.getMessage());
 	e.printStackTrace();
 		} finally {
 	if (ps != null)
 		try {
 			ps.close();
 		} catch (Exception e) {
 		}
 	if (conn != null)
 		try {
 			conn.close();
 		} catch (Exception e) {
 		}
 		}

 		///////////////////////////////////////////////////////////////////////////////////////////////////
 		///////////////////////////////////////////////////////////////////////////////////////////////////
 		///////////////////////////////////////////////////////////////////////////////////////////////////

 		/*     Connection conn  = null;  */
 		Connection conn1 = null;

 		try {
 	conn = DBConnect.getConnection();
 	conn1 = DBConnect.getConnection1();

 	Statement stmt1 = conn1.createStatement(); //for employeemaster
if("NFL".equalsIgnoreCase(category)){
 	ResultSet rs1 = stmt1.executeQuery(
 			"select a.ename, a.DESIGNATION, c.DISCIPLINENAME from employeemaster a, FURNITUREDEPT b, FURNITUREDISCIPLINE c where a.DEPTCODE=b.DEPTCODE and b.SECTIONCODE=c.DISCIPLINECODE  and a.oldnewdata='N' and onpayroll='A' and a.empn="
 					+ empn + "");
 	while (rs1.next()) {
 		ename = rs1.getString(1);
 		desg = rs1.getString(2);
 		dept = rs1.getString(3);
 	}

 	/*  System.out.println("ename: " + ename);
 	 System.out.println("desg: " + desg);
 	 System.out.println("dept: " + dept); */
}
 	
 	    
 	 	
 	    refno = String.valueOf(opdId);
 	    System.out.println("Generated refno: " + refno);
 	   Statement stmt2 = conn.createStatement();   
 	stmt2.executeUpdate("INSERT INTO LOACALREFDETAIL" + yr
 			+ " (REFNO, PATIENTNAME, EMPN, REL, AGE, REFDATE, SEX, DISEASE, DOC, specialist, REVISITFLAG) "
 			+ "VALUES ('" + refno + "','" + pname + "','" + empn + "','" + relation + "','" + age
 			+ "', SYSDATE, '" + sex + "','" + disease + "','" + referby + "','" + referto + "','N')");

 		}

 		catch (SQLException e) {
 	while ((e = e.getNextException()) != null)
 		out.println(e.getMessage() + "<BR>");
 		}

 		finally {
 	if (conn != null) {
 		try {
 			conn.close();
 			conn1.close();
 		} catch (Exception ignored) {
 		}
 	}
 		}
 		//out.print("result is: "+ename);
 		String empnStr = Integer.toString(empn);
 		if(empn==1)
 			empnStr="N/A ";
 %>
<div align="center">
  <center>
  <p style="margin-bottom: -1">&nbsp;</p>
  <table border="0" width="100%" height="70%" style="border-style: solid; border-width: 1">


<tr>
<td width="5%" height="7" style="border-style: solid; border-width: 1">
<img src="NFL.jpg" alt="NFL" >
</td>
     <td width="95%" height="19" style="border-bottom-style: solid">
     <!-- <p align="center"><b><font size="3" color="#003300">NFL Hospital, Panipat </font><font size="3">OPD SLIP</font></b> -->

<p align="center" >
        <font face="Arial"  size="5"><b>&#2344;&#2375;&#2358;&#2344;&#2354; &#2347;&#2352;&#2381;&#2335;&#2367;&#2354;&#2366;&#2311;&#2332;&#2352;&#2381;&#2360; &#2354;&#2367;&#2350;&#2367;&#2335;&#2375;&#2337; </b></font> <br/><font face="Arial" size="4">&#2319;&#2344;.&#2319;&#2347;.&#2319;&#2354;. &#2330;&#2367;&#2325;&#2367;&#2340;&#2381;&#2360;&#2366;&#2354;&#2351;, &#2346;&#2366;&#2344;&#2368;&#2346;&#2340; </font>
<br/><font face="Arial" size="3">&#2344;&#2367;&#2352;&#2381;&#2342;&#2375;&#2358; - &#2346;&#2352;&#2381;&#2330;&#2368;</font>&nbsp;(<font face="Arial" size="2"><b>REFERRAL-SLIP</b>&nbsp;</font>) </p>
</td>
</tr>
    <tr>
     <td width="100%" style="border-style: solid; border-width: 0; vertical-align: top;" colspan="2">
	 
	 <p style="text-align:left;">
<font face="Arial" size="2" >&nbsp;&nbsp;&#2325;&#2381;&#2352;&#2350; &#2360;&#2306;</font><font face="Arial" size="2">:&nbsp;<%= refno%></font>
<span style="float:right;"><font face="Arial">&#2340;&#2366;&#2352;&#2368;&#2326;</font><font face="Arial" size="2">: <%=refdt1%> &nbsp;&nbsp;&nbsp;</font></span>
</p>	 
        
        <p style="line-height: 150%"><font face="Arial" size="2">&#2358;&#2381;&#2352;&#2368;/&#2358;&#2381;&#2352;&#2368;&#2350;&#2340;&#2368;/&#2358;&#2381;&#2352;&#2368;&#2350;&#2366;&#2344;/&#2360;&#2369;&#2358;&#2381;&#2352;&#2368;&#2358;&#2381;&#2352;&#2368;</font><font face="Arial" size="2">&nbsp;Sh/Smt/Mr/Ms :&nbsp;<%= pname%></font>&nbsp;&nbsp;&nbsp;
        <font face="Arial" size="2">&#2360;&#2306;&#2348;&#2306;&#2343;</font>&nbsp;<font face="Arial" size="2"> Relation :&nbsp;<%=relation%> &nbsp;&nbsp; of &nbsp;&nbsp;<font face="Arial" size="2">&#2358;&#2381;&#2352;&#2368;&#2350;&#2366;&#2344;/&#2358;&#2381;&#2352;&#2368;&#2350;&#2340;&#2368;</font>&nbsp; Mr/Ms
        :&nbsp;<%=ename%>  </font>&nbsp;<font face="Arial" size="2">&#2346;&#2342;&#2344;&#2366;&#2350;</font>&nbsp;&nbsp;<font face="Arial" size="2">Designation :&nbsp;<%= desg%>&nbsp;&nbsp;<font face="Arial" size="2">&#2357;&#2367;&#2349;&#2366;&#2327;</font>&nbsp;&nbsp;Deptt :&nbsp;<%=dept%>&nbsp;<font face="Arial" size="2">&#2325;&#2352;&#2381;&#2350;&#2330;&#2366;&#2352;&#2368; &#2360;&#2306;&#2326;&#2381;&#2351;&#2366;</font>&nbsp;<font face="Arial"><font size="2">
        E.Code :&nbsp;<%=empnStr%></font>&nbsp;<font face="Arial" size="2">&#2325;&#2379; &#2352;&#2375;&#2347;&#2352;</font>&nbsp;referred to &nbsp;&nbsp;</font>&nbsp;<%=referredto%>&nbsp;for&nbsp;&nbsp;<%=disease%>&nbsp;&nbsp;<font face="Arial" size="2">&#2325;&#2367;&#2351;&#2366; &#2332;&#2366;&#2340;&#2366; &#2361;&#2376;</font>.</p>
        <br/>
		<br/>
		<br/>
        <p align="right"> 
<!-- <b> Senior Chief Medical Officer / Medical Officer </b> -->
<font face="Arial" size="2">&#2357;&#2352;&#2367;&#2359;&#2381;&#2336; &#2350;&#2369;&#2326;&#2381;&#2351; &#2330;&#2367;&#2325;&#2367;&#2340;&#2381;&#2360;&#2366; &#2309;&#2343;&#2367;&#2325;&#2366;&#2352;&#2368; / &#2330;&#2367;&#2325;&#2367;&#2340;&#2381;&#2360;&#2366; &#2309;&#2343;&#2367;&#2325;&#2366;&#2352;&#2368;</font>
&nbsp;&nbsp;&nbsp;<br><b> Senior Chief Medical Officer / Medical Officer </b></p>
      
        </td>
    </tr>
<tr>
  	 <td width="100%" height="11" colspan="2" >
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>  
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
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