<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
  // Fetch medical tests
  Connection testCon = null;
  PreparedStatement testPs = null;
  ResultSet testRs = null;
  StringBuilder testOptions = new StringBuilder();

  try {
    testCon = DBConnect.getConnection();
    testPs = testCon.prepareStatement(
        "SELECT TESTNAME FROM HOSPITAL.MEDICALTESTS ORDER BY TESTNAME"
    );
    testRs = testPs.executeQuery();

    while (testRs.next()) {
      String testName = testRs.getString("TESTNAME");
      testOptions.append("<option value='")
                 .append(testName)
                 .append("'>")
                 .append(testName)
                 .append("</option>");
    }
  } catch (Exception e) {
    testOptions.append("<option>Error loading tests</option>");
  } finally {
    if (testRs != null) testRs.close();
    if (testPs != null) testPs.close();
    if (testCon != null) testCon.close();
  }
%>


<%
  String empnParam = request.getParameter("empn");
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
  <td><input type="text" name="dosage_<%= medCode %>" placeholder=""  style="width: 100%;"/></td>
  
   <%-- <td><input type="text" name="timing_<%= medCode %>" placeholder=""   required /></td> --%>
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
  <td><input type="number" name="days_<%= medCode %>" min="1"   /></td>
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
  <td colspan="5" style="text-align:center;">

    <!-- Tests Dropdown -->
    <label><b>Investigations / Tests:</b></label><br>
    <select id="testSelect" multiple style="width: 100%;">
  <%= testOptions.toString() %>
</select>


    <br><br>

    <!-- Notes -->
    <label for="notes"><b>Additional Notes:</b></label><br>
    <textarea name="notes" id="notes" rows="4"
      placeholder="Selected tests will appear here automatically"
      style="width: 100%;"></textarea>

  </td>
</tr>

<script>


  // ✅ Initialize dropdown when table loads
  $(document).ready(function () {
    initTestDropdown();
  });

  function initTestDropdown() {
	  // ✅ options already rendered by JSP from DB
	  $('#testSelect').select2({
	    placeholder: "Search & select tests",
	    allowClear: true,
	    width: 'resolve'
	  });

	  $('#testSelect').on('change', updateNotesWithTests);
	}


  function updateNotesWithTests() {
	  let selectedTests = $('#testSelect').val() || [];
	  let notesBox = $('#notes');

	  let currentText = notesBox.val() || "";

	  const TEST_HEADER = "\n\n--- Tests :  \n";

	  // Split manual notes and test section
	  let parts = currentText.split(/--- Tests :  \n/);
	  let manualNotes = parts[0].trim();

	  if (selectedTests.length === 0) {
	    // Keep whatever doctor has written
	    notesBox.val(manualNotes);
	    return;
	  }

	  // ✅ comma + space separated
	  let testLine = selectedTests.join(", ");

	  let testBlock = TEST_HEADER + testLine;

	  // Append tests BELOW manual notes
	  if (manualNotes.length > 0) {
	    notesBox.val(manualNotes + testBlock);
	  } else {
	    notesBox.val(testBlock.trim());
	  }
	}

</script>


	<%  
  } catch (Exception e) {
    out.println("<tr><td colspan='5' style='color:red;'>Error fetching medicines: " + e.getMessage() + "</td></tr>");
  } finally {
    if (rs != null) try { rs.close(); } catch (Exception e) {}
    if (ps != null) try { ps.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
  }
%>