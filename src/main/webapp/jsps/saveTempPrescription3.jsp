<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.DB.DBConnect" %>

<%
    try {
    	String empnParam = request.getParameter("empn");
    	String empn = (empnParam != null && !empnParam.trim().isEmpty()) ? empnParam.trim() : "1";
    	
        String[] diseases = request.getParameterValues("diseaseSelect");
        String[] medicines = request.getParameterValues("medicineSelect");

        String diseaseCodes = (diseases != null) ? String.join(",", diseases) : "";
        String medicineCodes = (medicines != null) ? String.join(",", medicines) : "";
        
        System.out.println("EMP Number: " + empn);
        System.out.println("Selected Diseases: " + diseaseCodes);
        System.out.println("Selected Medicines: " + medicineCodes);
        

        Connection conn = DBConnect.getConnection();

        // Optional: delete old temp data for same EMPN
        PreparedStatement del = conn.prepareStatement("DELETE FROM HOSPITAL.TEMP_PRESCRIPTION WHERE EMPN = ?");
        del.setInt(1, Integer.parseInt(empn));
        del.executeUpdate();
        del.close();

        // Insert into TEMP_PRESCRIPTION
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO HOSPITAL.TEMP_PRESCRIPTION (EMPN, DISEASES_CODE, MEDICINES_CODE, TIMESTAMP) VALUES (?, ?, ?, SYSTIMESTAMP)"
        );
        ps.setInt(1, Integer.parseInt(empn));
        ps.setString(2, diseaseCodes);
        ps.setString(3, medicineCodes);

        int result = ps.executeUpdate();
        if (result > 0) {
            out.print("TEMP_SAVED_OK");
        } else {
            out.print("TEMP_SAVE_FAILED");
        }

        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.print("ERROR: " + e.getMessage());
    }
%>
