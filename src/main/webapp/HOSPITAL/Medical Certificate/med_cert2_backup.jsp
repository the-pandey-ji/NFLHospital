<%@ page language="java" session="true" %>
<%@ page import="java.sql.*, org.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.User" %>

<%

    // Check if the user is logged in
    User user = (User) session.getAttribute("Docobj");
    if (user == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("/hosp1/index.jsp");
        
        return;
    }
%>


<%
    String action = request.getParameter("action");

    if ("getEmployee".equals(action)) {
        String empn = request.getParameter("empn");
        JSONObject json = new JSONObject();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnect.getConnection1();
           // ps = con.prepareStatement("SELECT ENAME, DESIGNATION, DEPTCODE FROM PERSONNEL.EMPLOYEEMASTER WHERE oldnewdata='N' and EMPN = ?");
            ps = con.prepareStatement("SELECT e.ENAME, e.DESIGNATION, d.DEPTT FROM PERSONNEL.EMPLOYEEMASTER e JOIN Personnel.DEPARTMENT d ON e.DEPTCODE = d.DEPTCODE WHERE e.oldnewdata='N' and e.EMPN = ?");

            ps.setString(1, empn);
            rs = ps.executeQuery();
            if (rs.next()) {
                json.put("ename", rs.getString("ENAME"));
                json.put("designation", rs.getString("DESIGNATION"));
                json.put("dept", rs.getString("DEPTT"));
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

    if ("getDependents".equals(action)) {
        String empn = request.getParameter("empn");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnect.getConnection1();
            ps = con.prepareStatement("SELECT DEPENDENTNAME FROM PERSONNEL.DEPENDENTS WHERE status='A' and EMPN = ?");
            ps.setString(1, empn);
            rs = ps.executeQuery();
            while (rs.next()) {
                out.println("<option value='" + rs.getString("DEPENDENTNAME") + "'>" + rs.getString("DEPENDENTNAME") + "</option>");
            }
        } catch (Exception e) {
            out.println("<option>Error: " + e.getMessage() + "</option>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
        return;
    }

    if ("getDependentDetails".equals(action)) {
        String empn = request.getParameter("empn");
        String name = request.getParameter("name");
        JSONObject json = new JSONObject();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnect.getConnection1();
            //ps = con.prepareStatement("SELECT RELATION, DOB FROM PERSONNEL.DEPENDENTS WHERE EMPN = ? AND DEPENDENTNAME = ?");
            ps = con.prepareStatement("select b.RELATIONNAME, FLOOR(MONTHS_BETWEEN(SYSDATE, DOB)/12) as age FROM PERSONNEL.DEPENDENTS a, PERSONNEL.dependentrelation b  where A.RELATION =B.RELATIONCODE and a.empn= ? and trim(a.dependentname) =? ");

            ps.setString(1, empn);
            ps.setString(2, name);
            rs = ps.executeQuery();
            if (rs.next()) {
                json.put("relation", rs.getString("RELATIONNAME"));
                json.put("age", rs.getString("age"));
                
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

<html>
<head>
    <title>Medical Fitness Certificate</title>
    <script>
        function fetchEmployeeDetails() {
            var empn = document.getElementById("empn").value;
            if (empn === "") return;
            fetch("med_cert2.jsp?action=getEmployee&empn=" + empn)
                .then(res => res.json())
                .then(data => {
                    document.getElementById("ename").value = data.ename || "";
                    document.getElementById("desg").value = data.designation || "";
                    document.getElementById("dept").value = data.dept || "";
                });
        }

        function toggleDependents() {
            const type = document.querySelector('input[name="relationType"]:checked').value;
            const dependentRow = document.getElementById("dependentRow");
            if (type === "dependent") {
                const empn = document.getElementById("empn").value;
                if (!empn) return;
                fetch("med_cert2.jsp?action=getDependents&empn=" + empn)
                    .then(res => res.text())
                    .then(html => {
                    	document.getElementById("dependentName").innerHTML = "<option value=''>-- Select --</option>" + html;
                        dependentRow.style.display = "";
                    });
            } else {
                dependentRow.style.display = "none";
            }
        }

        function fetchDependentDetails() {
            const empn = document.getElementById("empn").value;
            const depName = document.getElementById("dependentName").value;
            fetch("med_cert2.jsp?action=getDependentDetails&empn=" + empn + "&name=" + encodeURIComponent(depName))
                .then(res => res.json())
                .then(data => {
                    document.getElementById("relation").value = data.relation || "";
                    document.getElementById("age").value = data.age || "";
                });
        }
        
        
        
        function validateForm(event) {
            const from = document.querySelector('input[name="fromdt"]').value;
            const to = document.querySelector('input[name="todt"]').value;
            const fit = document.querySelector('input[name="fitdt"]').value;

            if (!from || !to || !fit) return true; // allow submit if fields are empty (server will still validate)

            const fromDate = new Date(from);
            const toDate = new Date(to);
            const fitDate = new Date(fit);

            if (fromDate > toDate) {
                alert("Leave From date must be less than or equal to Leave To date.");
                event.preventDefault();
                return false;
            }

            if (toDate > fitDate) {
                alert("Leave To date must be less than or equal to Fit For Duty From date.");
                event.preventDefault();
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<h2 align="center">Medical Fitness Certificate</h2>
<form method="POST" action="mcert2.jsp" onsubmit="return validateForm(event);">

    <table align="center" border="1" cellpadding="5">
    <tr>
    <td>Category:</td>
    <td>
        <select id="category" name="category" onchange="onCategoryChange()">
            <option value="NFL">NFL</option>
            <option value="CISF">CISF</option>
            <option value="Others">Others</option>
        </select>
    </td>
</tr>
        <tr>
            <td>Employee No:</td>
            <td><input type="text" name="empn" id="empn" onblur="fetchEmployeeDetails(); toggleDependents();" required></td>
        </tr>
        <tr>
            <td>Is Patient:</td>
            <td>
                <input type="radio" name="relationType" value="self" checked onclick=""> Self
                <input type="radio" name="relationType" value="dependent" onclick="toggleDependents()"> Dependent
            </td>
        </tr>
        <tr id="dependentRow" style="display:none;">
            <td>Dependent Name:</td>
            <td>
                <select id="dependentName" name="dependentName" onchange="fetchDependentDetails()">
                    <option value="">-- Select --</option>
                </select>
                <div id="dependentSelect"></div><br>
                Relation: <input type="text" id="relation" name="relation" readonly><br>
                AGE: <input type="text" id="age" name="age" readonly>
            </td>
        </tr>
        <tr>
            <td>Employee Name:</td>
            <td><input type="text" name="ename" id="ename" readonly></td>
        </tr>
        <tr>
            <td>Designation:</td>
            <td><input type="text" name="desg" id="desg" readonly></td>
        </tr>
        <tr>
            <td>Department:</td>
            <td><input type="text" name="dept" id="dept" readonly></td>
        </tr>
        <tr>
            <td>Disease:</td>
            <td><input type="text" name="disease" required></td>
        </tr>
        <tr>
            <td>Leave From:</td>
            <td><input type="date" name="fromdt" required></td>
        </tr>
        <tr>
            <td>Leave To:</td>
            <td><input type="date" name="todt" required></td>
        </tr>
        <tr>
            <td>Fit For Duty From:</td>
            <td><input type="date" name="fitdt" required></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="Generate Certificate">
                <input type="reset" value="Reset">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
