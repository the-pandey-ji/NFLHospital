<%@ page language="java" session="true" %>
<%@ page import="java.sql.*, org.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.DB.DBConnect" %>

<%@ page language="java" session="true" %>
<%@ page import="java.sql.*, org.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.DB.DBConnect" %>


<%
    String action = request.getParameter("action");

    if ("employee".equals(action)) {
        String empn = request.getParameter("empn");
        JSONObject json = new JSONObject();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
       // System.out.println("Fetching details for empn: " + empn);

        try {
            con = DBConnect.getConnection1();
            ps = con.prepareStatement(
                "SELECT TRIM(NAME) AS pname, TRIM(NAME) AS ename, 'SELF' AS relation " +
                " FROM PRODUCTION.CISFMAST WHERE EMPN = ?"
            );
            ps.setString(1, empn);
            rs = ps.executeQuery();

            if (rs.next()) {
                json.put("pname", rs.getString("pname"));
                json.put("ename", rs.getString("ename"));
                json.put("relation", rs.getString("relation"));
                /* json.put("age", rs.getString("age")); */
                /* json.put("sex", rs.getString("SEX")); */
            }
        } catch (Exception e) {
            json.put("error", e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
        out.print(json.toString());
        return;
    }

    if ("dependents".equals(action)) {
        String empn = request.getParameter("empn");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnect.getConnection1();
            ps = con.prepareStatement(
                "SELECT TRIM(DNAME) AS name FROM PRODUCTION.CISFDEPENDENTS WHERE EMPN = ?"
            );
            ps.setString(1, empn);
            rs = ps.executeQuery();

            while (rs.next()) {
                out.println("<option value='" + rs.getString("name") + "'>" + rs.getString("name") + "</option>");
            }
        } catch (Exception e) {
            out.println("<option>Error loading dependents</option>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
        return;
    }

    if ("dependentDetails".equals(action)) {
        String empn = request.getParameter("empn");
        String name = request.getParameter("name");
        JSONObject json = new JSONObject();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnect.getConnection1();
            ps = con.prepareStatement(
                "SELECT RELATION, FLOOR(MONTHS_BETWEEN(SYSDATE, BIRTHYEAR)/12) AS age, SEX " +
                "FROM PRODUCTION.CISFDEPENDENTS WHERE EMPN = ? AND TRIM(DNAME) = ?"
            );
            ps.setString(1, empn);
            ps.setString(2, name);
            rs = ps.executeQuery();

            if (rs.next()) {
                json.put("relation", rs.getString("RELATION"));
                json.put("age", rs.getString("age"));
                json.put("sex", rs.getString("SEX"));
            }
        } catch (Exception e) {
            json.put("error", e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
        out.print(json.toString());
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>OPD Entry - CISF / OTHERS</title>
    <script>
        function onCategoryChange() {
            const category = document.getElementById("category").value;
            const isOthers = category === "O";

            // Toggle visibility and clear dependent section
            document.getElementById("relationTypeRow").style.display = isOthers ? "none" : "";
            document.getElementById("dependentRow").style.display = "none";
            document.getElementById("dependentName").innerHTML = "<option value=''>-- Select --</option>";

            // Reset form fields
            const fields = ["pname", "ename", "relation", "age", "sex"];
            fields.forEach(id => {
                document.getElementById(id).value = "";
                document.getElementById(id).readOnly = !isOthers;
            });

            // Toggle requirement
            document.getElementById("empn").required = !isOthers;
        }

        function fetchEmployeeDetails() {
            const category = document.getElementById("category").value;
            const empn = document.getElementById("empn").value.trim();
            if (category !== "C" || !empn) return;

            const url = "registration_fom.jsp?action=employee"
                + "&empn=" + encodeURIComponent(empn);
		//alert(url);
            fetch(url)
                .then(res => res.json())
                .then(data => {
                    if (data.error) {
                        alert("Error: " + data.error);
                        return;
                    }
                    document.getElementById("pname").value = data.pname || "";
                    document.getElementById("ename").value = data.ename || "";
                    document.getElementById("relation").value = data.relation || "SELF";
                    /* document.getElementById("age").value = data.age || "";
                    document.getElementById("sex").value = data.sex || "M"; */
                });

            fetchDependents();
        }

        function fetchDependents() {
            const empn = document.getElementById("empn").value.trim();
            const url = "registration_fom.jsp?action=dependents"
                + "&empn=" + encodeURIComponent(empn);

            fetch(url)
                .then(res => res.text())
                .then(html => {
                    document.getElementById("dependentName").innerHTML = "<option value=''>-- Select --</option>" + html;
                });
        }

        function toggleDependents() {
            const type = document.querySelector('input[name="relationType"]:checked').value;
            const isDependent = type === "dependent";

            document.getElementById("dependentRow").style.display = isDependent ? "" : "none";

            if (!isDependent) return;

            // Reset dependent fields
            document.getElementById("pname").value = "";
            document.getElementById("relation").value = "";
            document.getElementById("age").value = "";
        }

        function fetchDependentDetails() {
            const empn = document.getElementById("empn").value.trim();
            const name = document.getElementById("dependentName").value.trim();
            if (!empn || !name) return;

            const url = "registration_fom.jsp?action=dependentDetails"
                + "&empn=" + encodeURIComponent(empn)
                + "&name=" + encodeURIComponent(name);

            fetch(url)
                .then(res => res.json())
                .then(data => {
                    document.getElementById("pname").value = name;
                    document.getElementById("relation").value = data.relation || "";
                    document.getElementById("age").value = data.age || "";
                    document.getElementById("sex").value = data.sex || "";
                });
        }

        function validateForm() {
            const pname = document.getElementById("pname").value.trim();
            const age = document.getElementById("age").value.trim();
            if (!pname) {
                alert("Please enter Patient Name.");
                return false;
            }
            if (!age) {
                alert("Please enter Age.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body bgcolor="#DFFFFF">
<%@include file="/navbar.jsp"  %>

<h3 align="center">OPD Entry for CISF / OTHERS</h3>

<form name="MyForm" method="POST" action="/hosp1/HOSPITAL/OPDO/self2other.jsp" onsubmit="return validateForm()">
    <table align="center" width="40%" cellpadding="5">
        <tr>
            <td>Category:</td>
            <td>
                <select id="category" name="category" onchange="onCategoryChange()">
                    <option value="C">CISF</option>
                    <option value="O">OTHERS</option>
                </select>
            </td>
        </tr>

        <tr>
            <td>Employee Code:</td>
            <td><input type="text" id="empn" name="empn" onblur="fetchEmployeeDetails()"></td>
        </tr>

        <tr id="relationTypeRow">
            <td>Is Patient:</td>
            <td>
                <input type="radio" name="relationType" value="self" checked onclick="toggleDependents()"> Self
                <input type="radio" name="relationType" value="dependent" onclick="toggleDependents()"> Dependent
            </td>
        </tr>

        <tr id="dependentRow" style="display:none;">
            <td>Dependent Name:</td>
            <td>
                <select id="dependentName" name="dependentName" onchange="fetchDependentDetails()">
                    <option value="">-- Select --</option>
                </select>
            </td>
        </tr>

        <tr>
            <td>Patient Name:</td>
            <td><input type="text" name="pname" id="pname" maxlength="25" required></td>
        </tr>

        <tr>
            <td>Employee Name:</td>
            <td><input type="text" name="ename" id="ename" maxlength="25" required></td>
        </tr>

        <tr>
            <td>Relation:</td>
            <td><input type="text" name="relation" id="relation" maxlength="20" required></td>
        </tr>

        <tr>
            <td>Age:</td>
            <td><input type="text" name="age" id="age" maxlength="3" required></td>
        </tr>

        <tr>
            <td>Sex:</td>
            <td>
                <select name="sex" id="sex">
                    <option value="M">M</option>
                    <option value="F">F</option>
                </select>
            </td>
        </tr>

        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="Proceed">
                <input type="reset" value="Reset" onclick="onCategoryChange()">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
