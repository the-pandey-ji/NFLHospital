<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
  String opdIdStr = request.getParameter("opdId");
  String diseaseCodes = request.getParameter("diseaseCodes");
  String notes = request.getParameter("notes");

  int opdId = Integer.parseInt(opdIdStr);

  // First: delete existing rows for this OPD in PRESCRIPTION
  // Then: insert fresh rows based on updated data

  Connection conn = null;
  PreparedStatement psDel = null;
  PreparedStatement psIns = null;

  try {
    conn = DBConnect.getConnection();
    psDel = conn.prepareStatement("DELETE FROM HOSPITAL.PRESCRIPTION WHERE OPD_ID = ?");
    psDel.setInt(1, opdId);
    psDel.executeUpdate();
    psDel.close();

    // Now insert new rows by iterating through submitted params
    // Find the max index of medicineCode_i if possible
    int idx = 0;
    while (true) {
      String med = request.getParameter("medicineCode_" + idx);
      if (med == null) break;
      String dosage = request.getParameter("dosage_" + idx);
      String timing = request.getParameter("timing_" + idx);
      String daysStr = request.getParameter("days_" + idx);
      int days = 0;
      try { days = Integer.parseInt(daysStr.trim()); } catch (Exception e) { days = 0; }

      if (med != null && !med.trim().isEmpty()) {
        psIns = conn.prepareStatement(
          "INSERT INTO HOSPITAL.PRESCRIPTION (OPD_ID, EMPN, DISEASECODE, MEDICINECODE, DOSAGE, TIMING, DAYS, NOTES) " +
          "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
        );
        psIns.setInt(1, opdId);
        // You might need EMPN from OPD table or store hidden field in form
        // Suppose we fetch it from OPD:
        String empn = ""; // fetch or include as hidden
        psIns.setInt(2, Integer.parseInt(request.getParameter("empn"))); 
        psIns.setString(3, diseaseCodes);
        psIns.setString(4, med.trim());
        psIns.setString(5, (dosage != null) ? dosage.trim() : "");
        psIns.setString(6, (timing != null) ? timing.trim() : "");
        psIns.setInt(7, days);
        psIns.setString(8, (notes != null) ? notes.trim() : "");
        psIns.executeUpdate();
        psIns.close();
      }
      idx++;
    }

    response.sendRedirect("printSelfOPD.jsp?opdId=" + opdId);

  } catch (Exception e) {
    out.println("<p style='color:red;'>Error updating: " + e.getMessage() + "</p>");
    e.printStackTrace();
  } finally {
    if (conn != null) try { conn.close(); } catch (Exception ignored) {}
  }
%>
