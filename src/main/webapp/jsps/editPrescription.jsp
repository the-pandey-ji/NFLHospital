<%@ page language="java" session="true"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.User" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // Check login
    User user = (User) session.getAttribute("Docobj");
    if (user == null) {
        response.sendRedirect("/hosp1/index.jsp");
        return;
    }

    String opdIdParam = request.getParameter("opdId");
    if (opdIdParam == null || opdIdParam.trim().isEmpty()) {
        out.println("<p style='color:red;'>OPD ID missing.</p>");
        return;
    }

    int opdId = 0;
    try {
        opdId = Integer.parseInt(opdIdParam.trim());
    } catch (NumberFormatException e) {
        out.println("<p style='color:red;'>Invalid OPD ID.</p>");
        return;
    }

    // Data holders
    String patientName = "", relation = "", age = "", sex = "", empn = "", empName = "", opddate = "";
    String existingDiseaseCodes = "";
    String existingNotes = "";

    List<Map<String, String>> medicineList = new ArrayList<Map<String, String>>();

    Connection conn = null;
    PreparedStatement ps = null;
    PreparedStatement ps2 = null;
    ResultSet rs = null;
    ResultSet rs2 = null;

    try {
        conn = DBConnect.getConnection();

        // Fetch OPD header info (patient, etc.)
        ps = conn.prepareStatement(
            "SELECT PATIENTNAME, RELATION, AGE, SEX, EMPN, EMPNAME, TO_CHAR(OPDDATE, 'DD-MON-YYYY') AS OPDDATE " +
            "FROM OPD WHERE SRNO = ?"
        );
        ps.setInt(1, opdId);
        rs = ps.executeQuery();
        if (rs.next()) {
            patientName = rs.getString("PATIENTNAME");
            relation = rs.getString("RELATION");
            age = rs.getString("AGE");
            sex = rs.getString("SEX");
            empn = rs.getString("EMPN");
            empName = rs.getString("EMPNAME");
            opddate = rs.getString("OPDDATE");
        }
        rs.close();
        ps.close();

        // Fetch existing prescription rows
        ps2 = conn.prepareStatement(
            "SELECT DISEASECODE, MEDICINECODE, DOSAGE, TIMING, DAYS, NOTES " +
            "FROM HOSPITAL.PRESCRIPTION WHERE OPD_ID = ?"
        );
        ps2.setInt(1, opdId);
        rs2 = ps2.executeQuery();

        while (rs2.next()) {
            Map<String, String> row = new HashMap<String, String>();
            row.put("diseaseCode", rs2.getString("DISEASECODE"));
            row.put("medicineCode", rs2.getString("MEDICINECODE"));
            row.put("dosage", rs2.getString("DOSAGE"));
            row.put("timing", rs2.getString("TIMING"));
            row.put("days", rs2.getString("DAYS"));
            row.put("notes", rs2.getString("NOTES"));
            medicineList.add(row);

            if (existingNotes == null || existingNotes.trim().isEmpty()) {
                String n = rs2.getString("NOTES");
                if (n != null && !n.trim().isEmpty()) {
                    existingNotes = n.trim();
                }
            }
        }
        rs2.close();
        ps2.close();

        // If there are multiple prescription rows, disease codes might repeat; you may split that logic.
        if (!medicineList.isEmpty()) {
            existingDiseaseCodes = medicineList.get(0).get("diseaseCode");
        }

    } catch (Exception e) {
        out.println("<p style='color:red;'>Error while loading prescription: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>

<html>
<head>
  <meta charset="UTF-8">
  <title>Edit OPD Prescription</title>
</head>
<body style="font-family: Arial, sans-serif; margin:20px;">

<h2>Edit Prescription for OPD # <%= opdId %></h2>

<div style="margin-bottom: 20px;">
  <strong>Patient: </strong><%= patientName %> &nbsp;|&nbsp;
  <strong>Relation: </strong><%= relation %> &nbsp;|&nbsp;
  <strong>Age: </strong><%= age %> &nbsp;|&nbsp;
  <strong>Sex: </strong><%= sex %> &nbsp;|&nbsp;
  <strong>Emp Code: </strong><%= empn %> &nbsp;|&nbsp;
  <strong>Emp Name: </strong><%= empName %> &nbsp;|&nbsp;
  <strong>Date: </strong><%= opddate %>
</div>

<form method="post" action="updatePrescription.jsp" style="width: 90%;">

  <!-- Hidden OPD ID -->
  <input type="hidden" name="opdId" value="<%= opdId %>" />

  <!-- Disease codes (comma-separated) -->
  <div style="margin-bottom: 15px;">
    <label style="display:inline-block; width: 120px;">Disease Code(s):</label>
    <input type="text" name="diseaseCodes" value="<%= existingDiseaseCodes %>" style="width: 300px; padding:5px;" />
    <span style="color: #555;">(comma separated)</span>
  </div>

  <!-- Notes -->
  <div style="margin-bottom: 20px;">
    <label style="display:inline-block; width: 120px;">Notes:</label>
    <textarea name="notes" rows="3" style="width: 300px; padding:5px;"><%= (existingNotes != null) ? existingNotes : "" %></textarea>
  </div>

  <!-- Medicines Table -->
  <div style="margin-bottom: 20px;">
    <table border="1" cellspacing="0" cellpadding="5"
           style="width: 100%; border-collapse: collapse;">
      <thead style="background-color: #f0f0f0;">
        <tr>
          <th>Medicine Code</th>
          <th>Dosage</th>
          <th>Timing</th>
          <th>Days</th>
        </tr>
      </thead>
      <tbody>
        <% if (medicineList.isEmpty()) { %>
          <tr>
            <td colspan="4" style="text-align: center;">No medicines found, you can add new rows.</td>
          </tr>
        <% } else {
             for (int i = 0; i < medicineList.size(); i++) {
               Map<String, String> row = medicineList.get(i);
        %>
          <tr>
            <td>
              <input type="text" name="medicineCode_<%= i %>" 
                   value="<%= row.get("medicineCode") %>" style="width:100px; padding:4px;" />
            </td>
            <td>
              <input type="text" name="dosage_<%= i %>" 
                   value="<%= row.get("dosage") %>" style="width:100px; padding:4px;" />
            </td>
            <td>
              <input type="text" name="timing_<%= i %>" 
                   value="<%= row.get("timing") %>" style="width:100px; padding:4px;" />
            </td>
            <td>
              <input type="text" name="days_<%= i %>" 
                   value="<%= row.get("days") %>" style="width:60px; padding:4px;" />
            </td>
          </tr>
        <%   }
           }
        %>
      </tbody>
    </table>
  </div>

  <!-- Add option: button to add more rows via JavaScript (if desired) -->
  <div style="margin-bottom: 20px;">
    <button type="button" onclick="addMedicineRow();" style="padding:6px 12px;">Add Medicine Row</button>
  </div>

  <div>
    <button type="submit" style="padding:8px 20px; background-color:#28a745; color:white; border:none; border-radius:4px;">
      Update Prescription
    </button>
  </div>

</form>

<script>
  // JS to dynamically add another medicine row
  function addMedicineRow() {
    const table = document.querySelector("table tbody");
    const rowCount = table.rows.length;
    const newRow = table.insertRow();
    newRow.innerHTML = `
      <td><input type="text" name="medicineCode_${rowCount}" style="width:100px; padding:4px;" /></td>
      <td><input type="text" name="dosage_${rowCount}" style="width:100px; padding:4px;" /></td>
      <td><input type="text" name="timing_${rowCount}" style="width:100px; padding:4px;" /></td>
      <td><input type="text" name="days_${rowCount}" style="width:60px; padding:4px;" /></td>
    `;
  }
</script>

</body>
</html>
