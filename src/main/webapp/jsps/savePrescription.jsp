<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/plain; charset=UTF-8" %>

<%
Enumeration<String> paramNames = request.getParameterNames();
out.println("---- Received Parameters ----<br>");
while (paramNames.hasMoreElements()) {
  String param = paramNames.nextElement();
  out.println(param + " = " + request.getParameter(param) + "<br>");
}
out.println("---- End of Params ----<br>");


  String empnStr = request.getParameter("ovcode");
  String diseaseCodes = request.getParameter("diseaseCodes");
  String medCodesRaw = request.getParameter("medicineCodes");
  String notes = request.getParameter("additionalNotes");

  if (empnStr == null || medCodesRaw == null || diseaseCodes == null) {
    out.print("Missing data.");
    return;
  }

  String[] medicineCodes = medCodesRaw.split(",");
  int empn = Integer.parseInt(empnStr);

  Connection conn = null, con1 = null;
  PreparedStatement ps = null, psOpd = null, psEmp = null;
  ResultSet rsEmp = null;
  Statement stmt = null;

  try {
    conn = DBConnect.getConnection();
    con1 = DBConnect.getConnection1();
    conn.setAutoCommit(false);

    // Generate OPD ID
    stmt = conn.createStatement();
    ResultSet rs1 = stmt.executeQuery("SELECT NVL(MAX(srno), 0) + 1 FROM OPD");
    int opdId = 1;
    if (rs1.next()) {
      opdId = rs1.getInt(1);
    }
    rs1.close();

    // Get patient details
    String name = "", relation = "SELF", age = "", sex = "", typ = "N", dt = "";
    String empQuery = "SELECT ename, TO_CHAR(SYSDATE, 'yyyy') - TO_CHAR(birthdate, 'yyyy'), sex, TO_CHAR(SYSDATE, 'dd-mon-yyyy') FROM employeemaster WHERE empn = ?";
    psEmp = con1.prepareStatement(empQuery);
    psEmp.setInt(1, empn);
    rsEmp = psEmp.executeQuery();
    if (rsEmp.next()) {
      name = rsEmp.getString(1);
      age = rsEmp.getString(2);
      sex = rsEmp.getString(3);
      dt = rsEmp.getString(4);
    }

    // Insert into OPD
    String opdSql = "INSERT INTO OPD (SRNO, PATIENTNAME, RELATION, AGE, OPDDATE, SEX, EMPN, TYP, EMPNAME) " +
                    "VALUES (?, ?, ?, ?, SYSDATE, ?, ?, ?, ?)";
    psOpd = conn.prepareStatement(opdSql);
    psOpd.setInt(1, opdId);
    psOpd.setString(2, name);
    psOpd.setString(3, relation);
    psOpd.setString(4, age);
    psOpd.setString(5, sex);
    psOpd.setInt(6, empn);
    psOpd.setString(7, typ);
    psOpd.setString(8, name);
    psOpd.executeUpdate();

    // Insert into PRESCRIPTION table
    String presql = "INSERT INTO PRESCRIPTION (OPD_ID, EMPN, DISEASECODE, MEDICINECODE, DOSAGE, FREQUENCY, TIMING, DAYS, NOTES) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    ps = conn.prepareStatement(presql);

    for (String medCode : medicineCodes) {
      medCode = medCode.trim(); // Important!
      //out.print("medCode: " + medCode);
      if (medCode.isEmpty()) continue;

      String dosage = request.getParameter("dosage_" + medCode);
      out.print("Dosage: " + dosage);
      String frequency = request.getParameter("frequency_" + medCode);
      String timing = request.getParameter("timing_" + medCode);
      String daysStr = request.getParameter("days_" + medCode);
      int days = (daysStr != null && !daysStr.isEmpty()) ? Integer.parseInt(daysStr) : 0;

      ps.setInt(1, opdId);
      ps.setInt(2, empn);
      ps.setString(3, diseaseCodes);
      ps.setInt(4, Integer.parseInt(medCode));
      ps.setString(5, dosage);
      ps.setString(6, frequency);
      ps.setString(7, timing);
      ps.setInt(8, days);
      ps.setString(9, notes);

      ps.addBatch();
    }

    ps.executeBatch();
    conn.commit();
    out.print("✅ Prescription saved successfully with OPD ID: " + opdId);

  } catch (Exception e) {
    if (conn != null) conn.rollback();
    out.print("❌ Error: " + e.getMessage());
  } finally {
    if (rsEmp != null) try { rsEmp.close(); } catch (Exception ignored) {}
    if (psEmp != null) try { psEmp.close(); } catch (Exception ignored) {}
    if (psOpd != null) try { psOpd.close(); } catch (Exception ignored) {}
    if (ps != null) try { ps.close(); } catch (Exception ignored) {}
    if (stmt != null) try { stmt.close(); } catch (Exception ignored) {}
    if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    if (con1 != null) try { con1.close(); } catch (Exception ignored) {}
  }
%>
