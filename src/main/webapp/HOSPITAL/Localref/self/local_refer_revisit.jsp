<%@ page language="java" session="true"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=windows-1252" %>
<%@ page import="com.entity.User" %>

<%@ page import="org.json.JSONObject" %>


<%
    User user2 = (User) session.getAttribute("Docobj");
    if (user2 == null) {
        response.sendRedirect("/hosp1/index.jsp");
        return;
    }

    
    String refdt = "";
    String action = request.getParameter("action");


		if ("getEmployee".equals(action)) {
		    String empn = request.getParameter("empn");
		    String category = request.getParameter("category");
		
		    response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		
		    JSONObject json = new JSONObject();
		    Connection con = null;
		    PreparedStatement ps = null;
		    ResultSet rs = null;
		
		    try {
		        con = DBConnect.getConnection1();
		
		        if ("NFL".equalsIgnoreCase(category)) {
		            ps = con.prepareStatement(
		                "SELECT e.ENAME, e.DESIGNATION, d.DEPTT, e.SEX, " +
		                "FLOOR(MONTHS_BETWEEN(SYSDATE, e.BIRTHDATE)/12) AS AGE " +
		                "FROM PERSONNEL.EMPLOYEEMASTER e " +
		                "JOIN PERSONNEL.DEPARTMENT d ON e.DEPTCODE = d.DEPTCODE " +
		                "WHERE e.oldnewdata='N' AND e.EMPN = ?"
		            );
		        } else if ("CISF".equalsIgnoreCase(category)) {
		            ps = con.prepareStatement(
		                "SELECT NAME AS ENAME, DESG AS DESIGNATION, 'CISF' AS DEPTT " +
		                "FROM PRODUCTION.CISFMAST WHERE EMPN = ?"
		            );
		       
		        }
		
		        ps.setString(1, empn);
		        rs = ps.executeQuery();
		
		        if (rs.next()) {
		            json.put("ename", rs.getString("ENAME"));
		            json.put("designation", rs.getString("DESIGNATION"));
                       
		          /*   json.put("dept", rs.getString("DEPTT")); */
		             if ("NFL".equalsIgnoreCase(category)) {
		                json.put("sex", rs.getString("SEX"));
		                json.put("age", rs.getString("AGE"));
		            }
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


    if ("getDependents".equals(action)) {
        String empn = request.getParameter("empn");
        String category = request.getParameter("category");
        
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

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnect.getConnection1();

            if ("NFL".equalsIgnoreCase(category)) {
                ps = con.prepareStatement(
                    "SELECT b.RELATIONNAME AS RELATION, FLOOR(MONTHS_BETWEEN(SYSDATE, DOB)/12) AS AGE, SEX " +
                    "FROM PERSONNEL.DEPENDENTS a, PERSONNEL.DEPENDENTRELATION b " +
                    "WHERE A.RELATION = B.RELATIONCODE AND a.empn = ? AND TRIM(a.dependentname) = ?"
                );
            } else if ("CISF".equalsIgnoreCase(category)) {
               /*  ps = con.prepareStatement(
                    "SELECT RELATION, FLOOR(MONTHS_BETWEEN(SYSDATE, BIRTHYEAR)/12) AS AGE, SEX " +
                    "FROM PRODUCTION.CISFDEPENDENTS WHERE EMPN = ? AND TRIM(DNAME) = ?"
                ); */
                
            	 ps = con.prepareStatement(
            		        "SELECT RELATION, FLOOR(MONTHS_BETWEEN(SYSDATE, BIRTHYEAR)/12) AS AGE, SEX " +
            		        "FROM PRODUCTION.CISFDEPENDENTS " +
            		        "WHERE EMPN = ? " +
            		        "AND TRIM(REPLACE(REPLACE(DNAME, CHR(10), ''), CHR(13), '')) = ?"
            		    );
            }

            ps.setString(1, empn);
            if (name != null) {
                name = name.replaceAll("[\\r\\n]+", " ").trim();
            }
            ps.setString(2, name);
            rs = ps.executeQuery();

            if (rs.next()) {
                json.put("relation", rs.getString("RELATION"));
                json.put("age", rs.getString("AGE"));
                json.put("sex", rs.getString("SEX"));
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
     <title>Refer Slip</title>
  <style type="text/css" media="print">
    div {
      background-color: #fff;
      padding: 25px;
      max-width: 500px;
      margin: auto;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    
  </style>
<!-- 
   
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" /> -->


 <script>
 
 function onCategoryChange() {
	    const categoryRadio = document.querySelector('input[name="category"]:checked');
	    if (!categoryRadio) return; // Safety guard

	    const category = categoryRadio.value;
	    const isOthers = category === "Others";

	    // ✅ Reset all text fields
	    document.querySelectorAll('input[type="text"]').forEach(input => input.value = "");

	    // ✅ Reset dependent dropdown
	    const dependentSelect = document.getElementById("dependentName");
	    if (dependentSelect) dependentSelect.innerHTML = "<option value=''>-- Select --</option>";

	    // ✅ Hide dependent row immediately
	    const dependentRow = document.getElementById("dependentRow");
	    if (dependentRow) dependentRow.style.display = "none";

	    // ✅ Reset "Is Patient" to Self
	    const selfRadio = document.querySelector('input[name="relationType"][value="self"]');
	    if (selfRadio) selfRadio.checked = true;

	    // ✅ Adjust name and relation fields
	    const ename = document.getElementById("ename");
	    const patientName = document.getElementById("patientName");
	    const patientRelation = document.getElementById("patientRelation");
	    if (ename) ename.readOnly = !isOthers;
	  /*   if (patientName) patientName.required = isOthers;
	    if (patientRelation) patientRelation.required = isOthers;
 */
	    // ✅ Handle Employee No field
	    const empnField = document.getElementById("empn");
	    if (empnField) {
	        const empnLabel = empnField.parentElement?.previousElementSibling;
	        if (isOthers) {
	            empnField.removeAttribute("required");
	            empnField.readOnly = false;
	            if (empnLabel) empnLabel.textContent = "Employee No (Optional):";
	        } else {
	            empnField.setAttribute("required", "required");
	            if (empnLabel) empnLabel.textContent = "Employee No:";
	        }
	    }

	    // ✅ Re-apply field visibility rules
	    updateFieldVisibility();

	    // ✅ Ensure dependent row stays hidden for Others
	    if (isOthers && dependentRow) dependentRow.style.display = "none";

	    // ✅ Move focus to Employee No field
	    if (empnField) setTimeout(() => empnField.focus(), 50);
	}


 
 
 

        function fetchEmployeeDetails() {
            const empn = document.getElementById("empn").value;
            const category = document.querySelector('input[name="category"]:checked').value;

            if (empn === "" || category === "Others") return;

            const url = "local_refer_revisit.jsp?action=getEmployee"
                + "&empn=" + encodeURIComponent(empn)
                + "&category=" + encodeURIComponent(category);
            
         
            fetch(url)
            .then(res => {
                if (!res.ok) throw new Error("HTTP error " + res.status);
                return res.text();
            })
            .then(txt => {
                console.log("Response text:", txt); // For debugging
                return JSON.parse(txt);
            })
            .then(data => {
			    if (data.error) {
			        alert("Error: " + data.error);
			        return;
			    }
			    document.getElementById("ename").value = data.ename || "";
			    document.getElementById("relation").value = "SELF";
			    document.getElementById("age").value = data.age || "";
			    document.getElementById("sex").value = data.sex || "";
            })
            .catch(err => {
                console.error("Fetch error:", err);
                alert("Failed to fetch employee details.");
            });
        }
        
        
        function toggleDependents() {
            const category = document.querySelector('input[name="category"]:checked').value;
            const relationType = document.querySelector('input[name="relationType"]:checked').value;
            const dependentRow = document.getElementById("dependentRow");

            // ✅ Always clear dependent-related fields
            document.getElementById("dependentName").innerHTML = "<option value=''>-- Select --</option>";
            document.getElementById("relation").value = "";
            document.getElementById("age").value = "";
            document.getElementById("sex").value = "";

            // ✅ If "Dependent" is selected and not Others
            if (relationType === "dependent" && category !== "Others") {
                const empn = document.getElementById("empn").value.trim();
                if (!empn) {
                    dependentRow.style.display = "none";
                    return;
                }

                const url = "local_refer_revisit.jsp?action=getDependents"
                    + "&empn=" + encodeURIComponent(empn)
                    + "&category=" + encodeURIComponent(category);
                fetch(url)
                    .then(res => res.text())
                    .then(html => {
                        document.getElementById("dependentName").innerHTML = "<option value=''>-- Select --</option>" + html;
                        dependentRow.style.display = ""; // show dropdown
                    })
                    .catch(() => {
                        dependentRow.style.display = "none";
                    });
            } else {
                // ✅ Hide dependents row when switching to self or Others
                dependentRow.style.display = "none";
            }

            updateFieldVisibility(); // always refresh visibility logic
        }



      

        function fetchDependentDetails() {
            const empn = document.getElementById("empn").value;
            const depName = document.getElementById("dependentName").value;
            const category = document.querySelector('input[name="category"]:checked').value;

            
            const url = "local_refer_revisit.jsp?action=getDependentDetails"
                + "&empn=" + encodeURIComponent(empn)
                + "&name=" + encodeURIComponent(depName)
                + "&category=" + encodeURIComponent(category);
                
            fetch(url)
                .then(res => res.json())
                .then(data => {
                    document.getElementById("relation").value = data.relation || "";
                    document.getElementById("age").value = data.age || "";
                    document.getElementById("sex").value = data.sex || "";
                });

        }

        function validateForm(event) {
     /*        const category = document.getElementById("category").value;
            const ename = document.getElementById("ename").value.trim();
            const desg = document.getElementById("desg").value.trim();
            const dept = document.getElementById("dept").value.trim();
            const from = document.querySelector('input[name="fromdt"]').value;
            const to = document.querySelector('input[name="todt"]').value;
            const fit = document.querySelector('input[name="fitdt"]').value;

            if (category === "Others") {
                const patientName = document.getElementById("patientName").value.trim();
                const patientRelation = document.getElementById("patientRelation").value.trim();
                
                if (!ename || !desg || !dept) {
                    alert("Please fill Employee Name, Designation, and Department.");
                    event.preventDefault();
                    return false;
                }
                if (!patientName || !patientRelation) {
                    alert("Please fill Patient Name and Relation.");
                    event.preventDefault();
                    return false;
                }
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
            } */

            return true;
        }
        


        function updateFieldVisibility() {
            const categoryRadio = document.querySelector('input[name="category"]:checked');
            const relationTypeRadio = document.querySelector('input[name="relationType"]:checked');
            if (!categoryRadio) return; // no category selected yet

            const category = categoryRadio.value;
            const relationType = relationTypeRadio ? relationTypeRadio.value : null;

            const dependentRow = document.getElementById("dependentRow");
            const patientName = document.getElementById("patientName");
            const patientRelation = document.getElementById("patientRelation");
            
            const isPatientRow = document.getElementById("isPatientRow");

            // Hide "Is Patient" row for Others
            if (isPatientRow) {
                isPatientRow.style.display = (category === "Others") ? "none" : "";
            }

            // --- Handle dependent vs self visibility ---
            if (relationType === "dependent") {
                if (dependentRow) dependentRow.style.display = "";
               /*  if (patientName) patientName.removeAttribute("required");
                if (patientRelation) patientRelation.removeAttribute("required"); */
            } else {
                if (dependentRow) dependentRow.style.display = "none";
                /* if (patientName) patientName.setAttribute("required", "required");
                if (patientRelation) patientRelation.setAttribute("required", "required"); */
            }

            // --- Handle category-specific logic ---
            const tableRow = document.querySelector('form table tr:nth-child(4)');
            if (tableRow) {
                const cells = tableRow.children;
                for (let i = 0; i < cells.length; i++) cells[i].style.display = "";

                if (category === "NFL" || category === "CISF") {
                    if (cells[1]) cells[1].style.display = "none"; // patientName
                    if (cells[2]) cells[2].style.display = "none"; // patientRelation

                    if (relationType === "self" && cells[3]) cells[3].style.display = "none"; // dependentName
                    if (relationType === "self") fetchEmployeeDetails();
                } 
                else if (category === "Others") {
                    if (cells[3]) cells[3].style.display = "none"; // dependentName
                    if (cells[4]) cells[4].style.display = "none"; // relation
                }
            }

            // --- Always hide dependentRow in "Others" or "Self" ---
            if (dependentRow && (category === "Others" || relationType === "self")) {
                dependentRow.style.display = "none";
            }
        }


        
    </script>
   
</head>
<body>
 

<%@ include file="/navbar.jsp" %>
    <h2 style="text-align:center;">LOCAL HOSPITAL REFER</h2>

<form method="post" action="/hosp1/HOSPITAL/Localref/self/local_refer_revisit_print.jsp" onsubmit="return validateForm(event);">





<table border="1" cellpadding="5" cellspacing="0" width="80%" align="center">
  <!-- First row: Category Selection -->
  <tr>
    <td colspan="7" align="center">
      <label><input type="radio" name="category" value="NFL" checked onclick="onCategoryChange()"> NFL</label>
      <label><input type="radio" name="category" value="CISF" onclick="onCategoryChange()"> CISF</label>
      <label><input type="radio" name="category" value="Others" onclick="onCategoryChange()"> OTHERS</label>
    </td>
  </tr>
  <!-- Second row: Employee No -->
  <tr>
    <td colspan="7" align="center">
      Employee No: <input type="text" name="empn" id="empn" onblur="fetchEmployeeDetails(); toggleDependents();" 
      onkeydown="if(event.keyCode===13){fetchEmployeeDetails(); toggleDependents(); return false;}"/>
    </td>
  </tr>
  <!-- Third row: Patient Type -->
  <tr id="isPatientRow">
    <td colspan="7" align="center">
      Is Patient:
      <label><input type="radio" name="relationType" value="self" checked onclick="toggleDependents()"> Self</label>
      <label><input type="radio" name="relationType" value="dependent" onclick="toggleDependents()"> Dependent</label>
    </td>
  </tr>
  <!-- Fourth row: All other fields horizontally -->
  <tr>
    <td align="center">Employee Name:<br>
      <input type="text" name="ename" id="ename" required />
    </td>
    <td align="center">Patient Name:<br>
      <input type="text" name="patientName" id="patientName" />
    </td>
    <td align="center">Relation:<br>
      <input type="text" name="patientRelation" id="patientRelation" />
    </td>
    <td id="dependentRow" align="center">Dependent Name:<br>
      <select id="dependentName" name="dependentName" onchange="fetchDependentDetails()">	
        <option value="">-- Select --</option>
      </select>
    </td>
    <td align="center">Relation:<br>
      <input type="text" id="relation" name="relation" readonly style="color:red; font-weight:bold" />
    </td>
    <td align="center">Age:<br>
      <input type="text" name="age" id="age" style="color:red; font-weight:bold" required maxlength="10"/>
    </td>
    <td align="center">Sex:<br>
      <input type="text" name="sex" id="sex" style="color:red; font-weight:bold" required maxlength="1" />
    </td>
  </tr>

            
            

            
       <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Disease</b></font></td>
      <td width="50%"><input type="text" name="disease" size="20" required <%-- value="<%=disease%>" --%>></td>
    </tr> 
            
            
            <!-- Add other fields as needed -->
            <tr>
      <td width="50%"><font face="Tahoma" size="2"><b>Referred to&nbsp; </b></font></td>
      <td width="50%"><font face="Tahoma" size="2" color="#0000FF">
      <b><select size="1" name="referto" required>
       <option value="">--Select--</option>
 <%       
     Connection conn1  = null;    
       try 
         {

    	  conn1 = DBConnect.getConnection();
           Statement stmt1=conn1.createStatement();
	            
             ResultSet rshosp = stmt1.executeQuery("select hcode, hname from LOCALHOSPITAL order by hcode");
               while(rshosp.next())
                 {
  %>
                     <option value="<%=rshosp.getString(1)%>"><%=rshosp.getString(2)%></option>
  <%
                 }
  %>  
  </select>
     </b></font></td>
    </tr>
 
  <%
                    
     }
   catch(SQLException e) 
     {
       while((e = e.getNextException()) != null)
       out.println(e.getMessage() + "<BR>");
     }
  
   finally
      {
          if(conn1 != null) 
            {
               try
                  {
                      conn1.close();
                  }
               catch (Exception ignored) {}
            }
      }
 %>  
   </select>
   </td>
    </tr>
    
  <!-- Buttons -->
<!--   <tr>
    <td colspan="7" align="center">
      <input type="reset" value="Reset" />
    </td>
  </tr> -->
  
	
  <tr>
            <td colspan="7" align="center">
                <input type="submit" value="Submit Details">
                <input type="reset" value="Reset">
            </td>
        </tr>
</table>





<!-- 
  		 <div  align="center" style="margin-top:20px;">
 			 <button type="submit">Save Prescription</button>
 			 <input type="submit" value="Submit">
		</div> -->

  </form>

  <!-- <script src="/hosp1/javascript/getOV.js"></script> -->
  <script>
    $(document).ready(function () {
    	
    
      updateFieldVisibility();
    });
</script>
</body>
</html>
