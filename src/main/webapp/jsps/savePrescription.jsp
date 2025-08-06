<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
  String empnParam = request.getParameter("ovcode");
  String notes = request.getParameter("notes");

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

  Connection conn = null;
  PreparedStatement ps = null;

  try {
    conn = DBConnect.getConnection();

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
     ps = conn.prepareStatement("INSERT INTO HOSPITAL.PRESCRIPTION (OPD_ID,EMPN,DISEASECODE, MEDICINECODE, DOSAGE, FREQUENCY, TIMING, DAYS, NOTES) VALUES (1,?,1, ?, ?, ?, ?, ?, ?)");
      ps.setInt(1, empn);
      ps.setString(2, medCode);
      ps.setString(3, dosage);
      ps.setString(4, frequency);
      ps.setString(5, timing);
      ps.setInt(6, days);
      ps.setString(7, notes);
      ps.executeUpdate();
      ps.close();
    }

    out.println("Prescription saved successfully.");

  } catch (Exception e) {
    out.println("Error saving prescription: " + e.getMessage());
    e.printStackTrace();
  } finally {
    if (ps != null) try { ps.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
  }
%>


    