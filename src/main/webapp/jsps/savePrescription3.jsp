<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.entity.User" %>

<%
User user4 = (User) session.getAttribute("Docobj");

String category = request.getParameter("category"); // self, dependent, other

String empnParam = request.getParameter("empn");
System.out.println("empnParam: " + empnParam);
int empn = 0;

String ename = request.getParameter("ename");
String relationType = request.getParameter("relationType");   //self or dependent
String age = request.getParameter("age");
String sex = request.getParameter("sex");
String dependentName = request.getParameter("dependentName");
String relation = request.getParameter("relation")!=null ? request.getParameter("relation") : "SELF"; // for dependents
String patientName = request.getParameter("patientName")!=null ? request.getParameter("patientName") : ename;      // for others
String patientRelation = request.getParameter("patientRelation")!=null ? request.getParameter("patientRelation") : "SELF";  //for others


  String notes = request.getParameter("notes");
  if (notes == null) {
		notes = " ";
	}
	String[] diseaseCodes = request.getParameterValues("diseaseSelect");
	String diseaseCodeList = (diseaseCodes != null) ? String.join(",", diseaseCodes) : "";
	/*   out.println("Disease Codes: " + diseaseCodeList);
	  
	  out.print("Saving medicine for : " +diseaseCodes); */

	/* if (empnParam == null || empnParam.trim().isEmpty()) {
		out.println("Employee number is missing.");
		return;
	}
 */
	 
	  if (!"Others".equalsIgnoreCase(category)) {
		    if (empnParam != null && !empnParam.trim().isEmpty()) {
		        try {
		            empn = Integer.parseInt(empnParam.trim());
		        } catch (NumberFormatException e) {
		            empn = 0; // fallback if invalid number
		        }
		    } else {
		        empn = 0; // blank or missing -> default 0
		    }
		}
	 
	  

	Connection conn = null, con1 = null;
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
		String pname = "", typ = "N";

		System.out.println("Category: " + category);
		System.out.println("empn: " + empn);
		System.out.println("ename: " + ename);
		System.out.println("relationType: " + relationType);
		System.out.println("age: " + age);
		System.out.println("sex: " + sex);
		System.out.println("dependentName: " + dependentName);
		System.out.println("relation: " + relation);
		System.out.println("patientName: " + patientName);
		System.out.println("patientRelation: " + patientRelation);
		
		if("NFL".equalsIgnoreCase(category)) {
			typ = "N";
			if("self".equalsIgnoreCase(relationType)) {
			pname = ename;
			relation = "SELF";
			} else {
			pname = dependentName;
			// relation is already set from request
			}
	 
		} else if ("CISF".equalsIgnoreCase(category)) {
			typ = "C";
			if("self".equalsIgnoreCase(relationType)) {
				pname = ename;
				relation = "SELF";
				} else {
				pname = dependentName;
				// relation is already set from request
				}
		} else if ("Others".equalsIgnoreCase(category)) {
			typ = "O";
			pname = patientName;
			relation = patientRelation;
		} else {
			out.println("Invalid category.");
		}

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

	// Step 1: Get all medicineCodes from the request
	String[] medCodes = request.getParameterValues("medicineCodes");

	/* 		System.out.println("Raw medicineCodes: " + Arrays.toString(medCodes));
	
	List<String> validMedCodes = new ArrayList<String>();
	if (medCodes != null) {
	    for (String code : medCodes) {
	System.out.println("Checking code: " + code + " | isNull: " + (code == null));
	if (code != null && !code.trim().isEmpty() && !"null".equalsIgnoreCase(code.trim())) {
	    validMedCodes.add(code.trim());
	}
	 else {
	    System.out.println("Skipping invalid code: " + code);
	}
	    }
	}
	
	System.out.println("Valid Medicine Codes: " + validMedCodes);
	
	System.out.println("Medicine Codes: " + Arrays.toString(medCodes));
	System.out.println("medicine Codes length: " + (medCodes != null ? medCodes.length : 0));
	System.out.println("valid Medicine Codes: " + validMedCodes);
	System.out.println("valid Medicine Codes: " + validMedCodes.isEmpty()); */

	if (medCodes == null || medCodes.length == 0 || (medCodes[0] != null && medCodes[0].equalsIgnoreCase("null"))) {
		System.out.println("No medicines selected, saving only diseases.");
		// Save only diseases (no medicines)
		  PreparedStatement psDisease = conn.prepareStatement(
		     "INSERT INTO HOSPITAL.PRESCRIPTION (OPD_ID, EMPN, DISEASECODE, NOTES) VALUES (?, ?, ?, ?)"
		 );
		 psDisease.setInt(1, opdId);
		 psDisease.setInt(2, empn);
		 psDisease.setString(3, diseaseCodeList);
		 psDisease.setString(4, notes);
		 psDisease.executeUpdate();
		 psDisease.close(); 

		out.println("Prescription (disease only) saved successfully.");

		System.out.println("disease Codes2: " + Arrays.toString(diseaseCodes));
		response.sendRedirect(response.encodeRedirectURL("printSelfOPD.jsp?opdId=" + opdId));
		return;
	}

	for (int i = 0; i < medCodes.length; i++) {
		String medCode = medCodes[i];
		/* if (medCode == null || medCode.trim().isEmpty() || medCode.trim().equalsIgnoreCase("null")) {
		    // skip invalid med code
		    continue;
		    } */
		// Fetch details for this medicine
		//temp="dosage_" + medCode;
		String dosage = request.getParameter("dosage_" + medCode);
		if (dosage == null || dosage.isEmpty())
	dosage = " ";

		// Similarly for timing and days:
		String timing = request.getParameter("timing_" + medCode);
		if (timing == null || timing.isEmpty())
	timing = " ";

		String daysStr = request.getParameter("days_" + medCode);
		if (daysStr == null || daysStr.trim().isEmpty()) {
	daysStr = "0"; // Default to 0 days if not provided
	/* out.println("Error: Number of days is required for medicine code: " + medCode);
	return; */ // Stop execution
		}

		//System.out.println("Medicine:" + medCode +"'"+ ", Dosage:" + dosage +"'"+ ", Timing:" +"'"+ timing + ", Days: " + daysStr);

		/*  if (dosage == null || frequency == null || timing == null || daysStr == null) {
		   continue; // skip if any detail is missing
		 } */

		int days = 0;
		try {
			if (daysStr != null)
	days = Integer.parseInt(daysStr.trim());
		} catch (NumberFormatException e) {
		; // default to 0 if parsing fails
		}

		// Now insert into the PRESCRIPTION table
		ps = conn.prepareStatement(
		"INSERT INTO HOSPITAL.PRESCRIPTION (OPD_ID,EMPN,DISEASECODE, MEDICINECODE, DOSAGE, TIMING, DAYS, NOTES) VALUES (?,?,?, ?, ?, ?, ?, ?)");
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

		ps.setString(6, timing);
		ps.setInt(7, days);
		ps.setString(8, notes);
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


    