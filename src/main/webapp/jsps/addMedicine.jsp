<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>

<%
    String medicineName = request.getParameter("medicineName").trim();
    int newMedicineCode = 1;

    try {
        Connection conn = DBConnect.getConnection();

        // Case-insensitive check for existing medicine name
        PreparedStatement checkStmt = conn.prepareStatement(
            "SELECT COUNT(*) FROM medicinemaster WHERE LOWER(medicinename) = LOWER(?)"
        );
        checkStmt.setString(1, medicineName);
        ResultSet checkRs = checkStmt.executeQuery();
        if (checkRs.next() && checkRs.getInt(1) > 0) {
            out.print("EXISTS");
            checkRs.close();
            checkStmt.close();
            conn.close();
            return;
        }
        checkRs.close();
        checkStmt.close();

        // Get the max medicinecode
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT MAX(medicinecode) FROM medicinemaster");
        if (rs.next() && rs.getInt(1) != 0) {
            newMedicineCode = rs.getInt(1) + 1;
        }
        rs.close();
        st.close();

        // Insert new medicine
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO medicinemaster (medicinename, medicinecode) VALUES (?, ?)"
        );
        ps.setString(1, medicineName);
        ps.setInt(2, newMedicineCode);
        int rows = ps.executeUpdate();

        if (rows > 0) {
          
            out.print(newMedicineCode);
        } else {
            out.print("FAIL1");
        }

        ps.close();
        conn.close();
    } catch (Exception e) {
        out.print("FAIL2");
    }
%>
