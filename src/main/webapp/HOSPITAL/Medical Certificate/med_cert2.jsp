<%@ page language="java" session="true" %>
<%@ page import="java.sql.*, org.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.User" %>

<%
    User user = (User) session.getAttribute("Docobj");
    if (user == null) {
        response.sendRedirect("/hosp1/index.jsp");
        return;
    }

    String action = request.getParameter("action");

    if ("getEmployee".equals(action)) {
    	
    	
    	//System.out.println("Raw query string: " + request.getQueryString());
    	//System.out.println("getEmployee called");
    	
        String empn = request.getParameter("empn");
        String category = request.getParameter("category");
        
        
       //System.out.println("Parameters: empn=" + empn + ", category=" + category);
        
        
        
        JSONObject json = new JSONObject();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnect.getConnection1();

            if ("NFL".equalsIgnoreCase(category)) {
                ps = con.prepareStatement("SELECT e.ENAME, e.DESIGNATION, d.DEPTT FROM PERSONNEL.EMPLOYEEMASTER e JOIN Personnel.DEPARTMENT d ON e.DEPTCODE = d.DEPTCODE WHERE e.oldnewdata='N' and e.EMPN = ?");
            } else if ("CISF".equalsIgnoreCase(category)) {
            	System.out.println("Fetching CISF employee details for EMPN: " + empn);
                ps = con.prepareStatement("SELECT NAME AS ENAME, DESG AS DESIGNATION FROM PRODUCTION.CISFMAST WHERE EMPN = ?");
                //System.out.println("Prepared statement created: " + ps.toString());
            }

            ps.setString(1, empn);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                json.put("ename", rs.getString("ENAME"));
                //System.out.println("Employee Name: " + rs.getString("ENAME"));
                
                json.put("designation", rs.getString("DESIGNATION"));
               // System.out.println("Designation: " + rs.getString("DESIGNATION"));
                 if ("NFL".equalsIgnoreCase(category)){
                	json.put("dept", rs.getString("DEPTT") != null ? rs.getString("DEPTT") : "");
                	
                 }
                 else{
                	 json.put("dept", "CISF");
                 }
               
            }
            
           // System.out.println("Fetched Employee Details: " + json.toString());
        } catch (Exception e) {
            json.put("error", e.getMessage());
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        out.print(json.toString());
        return;
    }

    if ("getDependents".equals(action)) {
        String empn = request.getParameter("empn");
        String category = request.getParameter("category");
        
        
            //System.out.println("getDependents called with empn=" + empn + ", category=" + category);
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnect.getConnection1();

            if ("NFL".equalsIgnoreCase(category)) {
                ps = con.prepareStatement("SELECT DEPENDENTNAME FROM PERSONNEL.DEPENDENTS WHERE status='A' and EMPN = ?");
            } else if ("CISF".equalsIgnoreCase(category)) {
                ps = con.prepareStatement("SELECT trim(DNAME) FROM PRODUCTION.CISFDEPENDENTS WHERE EMPN = ?");
            }

            ps.setString(1, empn);
            rs = ps.executeQuery();
            while (rs.next()) {
                String name = rs.getString(1);
                out.println("<option value='" + name + "'>" + name + "</option>");
            }
        } catch (Exception e) {
            out.println("<option>Error: " + e.getMessage() + "</option>");
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return;
    }

    if ("getDependentDetails".equals(action)) {
        String empn = request.getParameter("empn");
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        JSONObject json = new JSONObject();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnect.getConnection1();

            if ("NFL".equalsIgnoreCase(category)) {
                ps = con.prepareStatement("SELECT b.RELATIONNAME as relation, FLOOR(MONTHS_BETWEEN(SYSDATE, DOB)/12) AS age FROM PERSONNEL.DEPENDENTS a, PERSONNEL.dependentrelation b WHERE A.RELATION =B.RELATIONCODE AND a.empn= ? AND TRIM(a.dependentname) =?");
            } else if ("CISF".equalsIgnoreCase(category)) {
                ps = con.prepareStatement("SELECT RELATION, FLOOR(MONTHS_BETWEEN(SYSDATE, BIRTHYEAR)/12) AS age FROM PRODUCTION.CISFDEPENDENTS WHERE EMPN = ? AND TRIM(DNAME) = ?");
            }

            ps.setString(1, empn);
            ps.setString(2, name);
            rs = ps.executeQuery();
            
           // System.out.println("rs  "+rs);
            if (rs.next()) {
                json.put("relation", rs.getString("RELATION"));
                json.put("age", rs.getString("age"));
            }
        } catch (Exception e) {
            json.put("error", e.getMessage());
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        out.print(json.toString());
        return;
    }
%>

<html>
<head>
    <title>Medical Fitness Certificate</title>
    <script>
        function onCategoryChange() {
            const category = document.getElementById("category").value;

            document.getElementById("empn").value = "";
            document.getElementById("ename").value = "";
            document.getElementById("desg").value = "";
            document.getElementById("dept").value = "";
            document.getElementById("relation").value = "";
            document.getElementById("age").value = "";
            document.getElementById("dependentName").innerHTML = "<option value=''>-- Select --</option>";
            document.getElementById("dependentRow").style.display = "none";

            const readonly = category !== "Others";
            document.getElementById("ename").readOnly = readonly;
            document.getElementById("desg").readOnly = readonly;
            document.getElementById("dept").readOnly = readonly;
        }

        function fetchEmployeeDetails() {
            const empn = document.getElementById("empn").value;
            const category = document.getElementById("category").value;
            //console.log("fetchEmployeeDetails called");
            //alert(empn + " " + category);
            if (empn === "" || category === "Others") return;

            const url = "med_cert2.jsp?action=getEmployee"
                + "&empn=" + encodeURIComponent(empn)
                + "&category=" + encodeURIComponent(category);
            
            //alert("URL: " + url);

            fetch(url)
                .then(res => res.json())
                .then(data => {
                    if (data.error) {
                        alert("Error: " + data.error);
                        return;
                    }
                    document.getElementById("ename").value = data.ename || "";
                    document.getElementById("desg").value = data.designation || "";
                    document.getElementById("dept").value = data.dept || "";
                })
                .catch(err => alert("Failed to fetch employee details."));
        }

        function toggleDependents() {
            const category = document.getElementById("category").value;
            const type = document.querySelector('input[name="relationType"]:checked').value;
            const dependentRow = document.getElementById("dependentRow");
            


            if (type === "dependent" && category !== "Others") {
                const empn = document.getElementById("empn").value;
                if (!empn) return;
                
                const url = "med_cert2.jsp?action=getDependents"
                    + "&empn=" + encodeURIComponent(empn)
                    + "&category=" + encodeURIComponent(category);
                //fetch(`med_cert2.jsp?action=getDependents&empn=${empn}&category=${category}`)
                fetch(url)
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
            const category = document.getElementById("category").value;
            
            
            /* const encodedDepName = encodeURIComponent(depName);
            const url = "med_cert2.jsp?action=getDependentDetails"
                + "&empn=" + empn
                + "&name=" + encodedDepName
                + "&category=" + category; */
            
            const url = "med_cert2.jsp?action=getDependentDetails"
                + "&empn=" + encodeURIComponent(empn)
                + "&name=" + encodeURIComponent(depName)
                + "&category=" + encodeURIComponent(category);
                
                //alert(url);

      			fetch(url)
                .then(res => res.json())
                .then(data => {
                    document.getElementById("relation").value = data.relation || "";
                    document.getElementById("age").value = data.age || "";
                });
        }

        function validateForm(event) {
            const category = document.getElementById("category").value;
            const ename = document.getElementById("ename").value.trim();
            const desg = document.getElementById("desg").value.trim();
            const dept = document.getElementById("dept").value.trim();
            const from = document.querySelector('input[name="fromdt"]').value;
            const to = document.querySelector('input[name="todt"]').value;
            const fit = document.querySelector('input[name="fitdt"]').value;

            if (category === "Others" && (!ename || !desg || !dept)) {
                alert("Please fill Employee Name, Designation, and Department for 'Others'.");
                event.preventDefault();
                return false;
            }

            const fromDate = new Date(from);
            const toDate = new Date(to);
            const fitDate = new Date(fit);

            if (fromDate > toDate) {
                alert("Leave From date must be before Leave To date.");
                event.preventDefault();
                return false;
            }

            if (toDate > fitDate) {
                alert("Fit For Duty From date must be after Leave To date.");
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
                <br>
                Relation: <input type="text" id="relation" name="relation" readonly><br>
                Age: <input type="text" id="age" name="age" readonly>
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
