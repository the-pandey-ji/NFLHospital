<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.entity.User" %>

<%
User user4 = (User) session.getAttribute("Docobj");


String empnParam = request.getParameter("ovcode");
  String notes = request.getParameter("notes");
  if (notes == null) {
		notes = " ";
	}
	String[] diseaseCodes = request.getParameterValues("diseaseSelect");
	String diseaseCodeList = (diseaseCodes != null) ? String.join(",", diseaseCodes) : "";
	/*   out.println("Disease Codes: " + diseaseCodeList);
	  
	  out.print("Saving medicine for : " +diseaseCodes); */

	if (empnParam == null || empnParam.trim().isEmpty()) {
		out.println("Employee number is missing.");
		return;
	}

	int empn = 0;
	try {
		empn = Integer.parseInt(empnParam.trim());
	} catch (NumberFormatException e) {
		out.println("Invalid employee number.");
		return;
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
		String pname = "", name = "", relation = "SELF", age = "", sex = "", typ = "N", dt = "",ename="";

		/* String empQuery = "SELECT ename, TO_CHAR(SYSDATE, 'yyyy') - TO_CHAR(birthdate, 'yyyy'), sex, TO_CHAR(SYSDATE, 'dd-mon-yyyy') FROM employeemaster WHERE empn = ?";
		psEmp = con1.prepareStatement(empQuery);
		psEmp.setInt(1, empn);
		rsEmp = psEmp.executeQuery();
		if (rsEmp.next()) {
	name = rsEmp.getString(1);
	age = rsEmp.getString(2);
	sex = rsEmp.getString(3);
	dt = rsEmp.getString(4);
	pname = rsEmp.getString(1);
		}
		rsEmp.close();
		psEmp.close();
		 */
		
		 pname = request.getParameter("opname");
	 	age = request.getParameter("oage");


		 sex = request.getParameter("osex");
		 ename = request.getParameter("oename");
		relation= request.getParameter("orelation");
		 typ = request.getParameter("ocategory");

	/*	String dname = request.getParameter("Oname")
		String drel = session.getAttribute("drel") != null ? session.getAttribute("drel").toString() : "";
		String dage = session.getAttribute("dage") != null ? session.getAttribute("dage").toString() : ""; */

/* 		if (drel != null && !drel.isEmpty()) {
	relation = drel;
	pname = dname;
	age = dage;
	sex = session.getAttribute("dsex") != null ? session.getAttribute("dsex").toString() : "";
		} */
/* 
		 	System.out.println("Employee Name: " + ename);
		    System.out.println("Employee Age: " + age);
		    System.out.println("Patient Name: " + pname); 
		    System.out.println("Patient Name sex: " + sex); 
		    System.out.println("Patient Name typ: " + typ); 
		    System.out.println("Patient Name revl: " + relation); 
 */
		/* session.removeAttribute("depname");
		session.removeAttribute("drel");
		session.removeAttribute("dage");
		session.removeAttribute("dsex"); */

		// Insert into OPD
		String opdSql = "INSERT INTO OPD (SRNO, PATIENTNAME, RELATION, AGE, OPDDATE, SEX, EMPN, TYP, EMPNAME,doctor) "
		+ "VALUES (?, ?, ?, ?, SYSDATE, ?, ?, ?, ?,?)";
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
		if (dosage == null || dosage.isEmpty()) dosage = " ";
	
	// Similarly for timing and days:
	String timing = request.getParameter("timing_" + medCode);
		if (timing == null||timing.isEmpty()) timing = " ";
		
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
		days = Integer.parseInt(daysStr.trim());
	} catch (NumberFormatException e) {
		continue; // skip this medicine if days are invalid
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


    