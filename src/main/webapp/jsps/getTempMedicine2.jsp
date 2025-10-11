<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
  String empnParam = request.getParameter("ovcode"); // Employee or patient code
  String opdParam = request.getParameter("opdno");   // Current OPD number

  if (empnParam == null || empnParam.trim().isEmpty()) {
    out.println("<tr><td colspan='5'>No Employee code provided.</td></tr>");
    return;
  }
  if (opdParam == null || opdParam.trim().isEmpty()) {
    out.println("<tr><td colspan='5'>No OPD number provided.</td></tr>");
    return;
  }

  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;

  try {
    conn = DBConnect.getConnection();

    // ✅ Get temp medicines (from EMPN) + join dosage/days (from PRESCRIPTION by OPD only)
    String sql =
        "WITH temp_med AS ( " +
        "  SELECT TRIM( " +
        "           SUBSTR(t.MEDICINES_CODE, " +
        "             CASE WHEN LEVEL = 1 THEN 1 ELSE INSTR(t.MEDICINES_CODE, ',', 1, LEVEL - 1) + 1 END, " +
        "             CASE WHEN INSTR(t.MEDICINES_CODE, ',', 1, LEVEL) = 0 " +
        "                  THEN LENGTH(t.MEDICINES_CODE) + 1 " +
        "                  ELSE INSTR(t.MEDICINES_CODE, ',', 1, LEVEL) " +
        "             END - " +
        "             CASE WHEN LEVEL = 1 THEN 1 ELSE INSTR(t.MEDICINES_CODE, ',', 1, LEVEL - 1) + 1 END " +
        "           ) " +
        "         ) AS med_code " +
        "  FROM HOSPITAL.TEMP_PRESCRIPTION t " +
        "  WHERE t.EMPN = ? " +
        "  CONNECT BY LEVEL <= LENGTH(t.MEDICINES_CODE) - LENGTH(REPLACE(t.MEDICINES_CODE, ',', '')) + 1 " +
        "    AND PRIOR EMPN = EMPN " +
        "    AND PRIOR SYS_GUID() IS NOT NULL " +
        ") " +
        "SELECT m.MEDICINECODE, m.MEDICINENAME, p.DOSAGE, p.TIMING, p.DAYS " +
        "FROM temp_med tm " +
        "LEFT JOIN HOSPITAL.MEDICINEMASTER m ON TO_CHAR(m.MEDICINECODE) = tm.med_code " +
        "LEFT JOIN HOSPITAL.PRESCRIPTION p ON p.MEDICINECODE = tm.med_code AND p.OPD_ID = ? " + // 🔹 OPD filter only
        "ORDER BY m.MEDICINENAME";

    ps = conn.prepareStatement(sql);
    ps.setInt(1, Integer.parseInt(empnParam)); // for temp_prescription
    ps.setString(2, opdParam);                 // for prescription dose/days

    rs = ps.executeQuery();

    boolean found = false;
    while (rs.next()) {
      found = true;
      String medCode = rs.getString("MEDICINECODE");
      String medName = rs.getString("MEDICINENAME");
      String dosage = rs.getString("DOSAGE");
      String timing = rs.getString("TIMING");
      String days = rs.getString("DAYS");
%>
<tr>
  <td>
    <%= (medName != null ? medName : "Unknown Medicine") %>
    <input type="hidden" name="medicineCodes" value="<%= medCode %>" />
  </td>
  <td>
    <input type="text" name="dosage_<%= medCode %>" value="<%= (dosage != null ? dosage : "") %>" placeholder="Enter dosage" />
  </td>
  <td>
    <input type="number" name="days_<%= medCode %>" value="<%= (days != null ? days : "") %>" min="1" placeholder="Days" />
  </td>
</tr>
<%
    }
    if (!found) {
%>
<tr><td colspan="4" style="color:red;">No medicines found for this OPD.</td></tr>
<%
    }
%>

<tr>
  <td colspan="4" style="text-align:center;">
    <label for="notes">Additional Notes:</label><br>
    <textarea name="notes" id="notes" rows="3" style="width:100%;" placeholder="Enter additional details if any"></textarea>
  </td>
</tr>

<%
  } catch (Exception e) {
    e.printStackTrace();
    out.println("<tr><td colspan='4' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
  } finally {
    if (rs != null) try { rs.close(); } catch (Exception e) {}
    if (ps != null) try { ps.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
  }
%>
