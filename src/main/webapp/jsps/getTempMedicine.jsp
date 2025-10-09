<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
  String empnParam = request.getParameter("ovcode");
  if (empnParam == null || empnParam.trim().isEmpty()) {
    return;
  }
  int empn = 0;
  try {
    empn = Integer.parseInt(empnParam);
  } catch (NumberFormatException e) {
    out.println("<tr><td colspan='5'>Invalid Employee Code</td></tr>");
    return;
  }

  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;

  try {
    conn = DBConnect.getConnection();
    ps = conn.prepareStatement(
    					"WITH codes AS ( " +
    				    "  SELECT TRIM( " +
    				    "           SUBSTR( " +
    				    "             t.MEDICINES_CODE, " +
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
    				    "SELECT c.med_code, m.MEDICINENAME AS medicine_name " +
    				    "FROM codes c " +
    				    "INNER JOIN HOSPITAL.MEDICINEMASTER m ON TO_CHAR(m.MEDICINECODE) = c.med_code");
    		
    
    
    
   /*  ps = conn.prepareStatement(
    		  "WITH codes AS ( " +
    		  "  SELECT TRIM( " +
    		  "           SUBSTR( " +
    		  "             t.MEDICINES_CODE, " +
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
    		  "SELECT c.med_code, NVL(m.MEDICINENAME, 'Unknown Medicine') AS medicine_name " +
    		  "FROM codes c " +
    		  "LEFT JOIN HOSPITAL.MEDICINEMASTER m ON TO_CHAR(m.MEDICINECODE) = c.med_code"
    		); */
    ps.setInt(1, empn);

    rs = ps.executeQuery();
    boolean hasRows = false;
    while (rs.next()) {
      hasRows = true;
      String medCode = rs.getString("med_code");
      String medName = rs.getString("medicine_name");
%>
<tr>
  <td><%= medName %><input type="hidden" name="medicineCodes" value="<%= medCode %>" /></td>
  <td><input type="text" name="dosage_<%= medCode %>" placeholder=""  /></td>
  
   <td><input type="text" name="timing_<%= medCode %>" placeholder=""   required /></td>
<%--   <td>
    <select name="frequency_<%= medCode %>" required>
      <option value="">Select</option>
      <option value="once">Once</option>
      <option value="twice">Twice</option>
      <option value="thrice">Thrice</option>
    </select>
  </td>
  <td>
    <select name="timing_<%= medCode %>" required>
      <option value="">Select</option>
      <option value="before food">Before Food</option>
      <option value="after food">After Food</option>
    </select>
  </td> --%>
  <td><input type="number" name="days_<%= medCode %>" min="1" required  /></td>
</tr>
<%
    }
    
   
    if (!hasRows) {
%>

	<tr>
		<td colspan="5" style="color: red;">No medicines found for this
			Employee Code.</td>
	</tr>
	<%
    }
    %>
    <tr>
    <td colspan="5" style="text-align: center;">
	<label for="notes">Additional Notes:</label><br>
<textarea name="notes" id="notes" rows="3" placeholder="Enter additional details if any" style="width: 100%;"></textarea>
    </td>
		</tr>

	<%  
  } catch (Exception e) {
    out.println("<tr><td colspan='5' style='color:red;'>Error fetching medicines: " + e.getMessage() + "</td></tr>");
  } finally {
    if (rs != null) try { rs.close(); } catch (Exception e) {}
    if (ps != null) try { ps.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
  }
%>