<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>

<%
    String diseaseName = request.getParameter("diseaseName").trim();
    int newDiseaseCode = 1;

    try {
        Connection conn = DBConnect.getConnection();

        // Case-insensitive check for existing disease name
        PreparedStatement checkStmt = conn.prepareStatement(
            "SELECT COUNT(*) FROM diseases WHERE LOWER(disease_name) = LOWER(?)"
        );
        checkStmt.setString(1, diseaseName);
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

        // Get the max disease_code
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT MAX(disease_code) FROM diseases");
        if (rs.next() && rs.getInt(1) != 0) {
            newDiseaseCode = rs.getInt(1) + 1;
        }
        rs.close();
        st.close();

        // Insert new disease
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO diseases (disease_code, disease_name) VALUES (?, ?)"
        );
        ps.setInt(1, newDiseaseCode);
        ps.setString(2, diseaseName);
        int rows = ps.executeUpdate();

        if (rows > 0) {

            out.print(newDiseaseCode);
        } else {
            out.print("FAIL1");
        }

        ps.close();
        conn.close();
    } catch (Exception e) {
        out.print("FAIL2");
    }
%>
