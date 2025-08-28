<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
String empnParam = request.getParameter("ovcode");
String opname = request.getParameter("opname");
String oename = request.getParameter("oename");
String orelation = request.getParameter("orelation");
String oage = request.getParameter("oage");
String osex = request.getParameter("osex");
String category = request.getParameter("category");

  String notes = request.getParameter("notes");
  String[] diseaseCodes = request.getParameterValues("diseaseSelect");
  String diseaseCodeList = (diseaseCodes != null) ? String.join(",", diseaseCodes) : "";
/*   out.println("Disease Codes: " + diseaseCodeList);
  
  out.print("Saving medicine for : " +diseaseCodes); */
  
  if (empnParam == null || empnParam.trim().isEmpty()) {
    out.println("Employee number is missing.");
    return;
  }

  

  Connection conn = null,con1 = null;
  PreparedStatement ps = null, psEmp = null, psOpd = null;
  ResultSet rsEmp = null;
  Statement stmt = null;

  try {
    conn = DBConnect.getConnection();
    con1 = DBConnect.getConnection1();
    
 // Generate OPD ID
    stmt = conn.createStatement();
    ResultSet rs1 = stmt.executeQuery("SELECT NVL(MAX(srno), 0) + 1 FROM OPD");
    int opdId = 1;
    if (rs1.next()) {
      opdId = rs1.getInt(1);
     
    }
    rs1.close();
    stmt.close();
    
    
   

	// Get patient details
	String dt = "";
	
	
int empn = Integer.parseInt(empnParam.trim());

System.out.println("opname "+ opname); 
	
	
	
	
	

    
	
	
	// Insert into OPD
	String opdSql = "INSERT INTO OPD (SRNO, PATIENTNAME, RELATION, AGE, OPDDATE, SEX, EMPN, TYP, EMPNAME) "
	+ "VALUES (?, ?, ?, ?, SYSDATE, ?, ?, ?, ?)";
	psOpd = conn.prepareStatement(opdSql);
	psOpd.setInt(1, opdId);
	psOpd.setString(2, opname);
	psOpd.setString(3, orelation);
	psOpd.setString(4, oage);
	psOpd.setString(5, osex);
	psOpd.setInt(6, empn);
	psOpd.setString(7, category);
	psOpd.setString(8, oename);
	psOpd.executeUpdate();
	psOpd.close();

	// Step 1: Get all medicineCodes from the request
	String[] medCodes = request.getParameterValues("medicineCodes");

	if (medCodes == null || medCodes.length == 0) {
		out.println("No medicines found to save.");
		return;
	}

	for (int i = 0; i < medCodes.length; i++) {
		String medCode = medCodes[i];

		// Fetch details for this medicine
		String dosage = request.getParameter("dosage_" + medCode);
		String frequency = request.getParameter("frequency_" + medCode);
		String timing = request.getParameter("timing_" + medCode);
		String daysStr = request.getParameter("days_" + medCode);

		/*  if (dosage == null || frequency == null || timing == null || daysStr == null) {
		   continue; // skip if any detail is missing
		 } */

		int days = 0;
		try {
	days = Integer.parseInt(daysStr.trim());
		} catch (NumberFormatException e) {
	continue; // skip this medicine if days are invalid
		}

		// Now insert into the PRESCRIPTION table
		ps = conn.prepareStatement(
		"INSERT INTO HOSPITAL.PRESCRIPTION (OPD_ID,EMPN,DISEASECODE, MEDICINECODE, DOSAGE, FREQUENCY, TIMING, DAYS, NOTES) VALUES (?,?,?, ?, ?, ?, ?, ?, ?)");
		/*       ps.setInt(1, empn);
		      ps.setString(2, medCode);
		      ps.setString(3, dosage);
		      ps.setString(4, frequency);
		      ps.setString(5, timing);
		      ps.setInt(6, days);
		      ps.setString(7, notes);
		      ps.executeUpdate();
		      ps.close(); */
		ps.setInt(1, opdId);
		ps.setInt(2, empn);
		ps.setString(3, diseaseCodeList);
		ps.setString(4, medCode);
		ps.setString(5, dosage);
		ps.setString(6, frequency);
		ps.setString(7, timing);
		ps.setInt(8, days);
		ps.setString(9, notes);
		ps.executeUpdate();
		/*  ps.addBatch(); */
		ps.close();
	}

	out.println("Prescription saved successfully.");

	response.sendRedirect(response.encodeRedirectURL("printSelfOPD.jsp?opdId=" + opdId));

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
%>


    