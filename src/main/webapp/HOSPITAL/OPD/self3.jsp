<%@ page language="java" session="true"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=windows-1252" %>
<%@ page import="com.entity.User" %>

<%@ page import="org.json.JSONObject" %>


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
    User user2 = (User) session.getAttribute("Docobj");
    if (user2 == null) {
        response.sendRedirect("/hosp1/index.jsp");
        return;
    }

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

<%@include file="/allCss.jsp"%>

<html>
<head>
     <title>OPD Slip</title>
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

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />


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
	    if (patientName) patientName.required = isOthers;
	    if (patientRelation) patientRelation.required = isOthers;

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


 
 
      /*   function onCategoryChange() {
        	
        	const category = document.querySelector('input[name="category"]:checked').value;
            const isOthers = category === "Others";
            
            // Clear all fields
            document.getElementById("empn").value = "";
            document.getElementById("ename").value = "";
            document.getElementById("age").value = "";
            document.getElementById("sex").value = "";
            document.getElementById("patientName").value = "";
            document.getElementById("patientRelation").value = "";
            document.getElementById("relation").value = "";

            document.querySelector('input[name="relationType"][value="self"]').checked = true;

            document.getElementById("dependentName").innerHTML = "<option value=''>-- Select --</option>";
            document.getElementById("dependentRow").style.display = "none";
            
            
        
            
         // Toggle required attributes dynamically
            document.getElementById("patientName").required = isOthers;
            document.getElementById("patientRelation").required = isOthers;
            
            // Handle Employee No field
            const empnField = document.getElementById("empn");
            const empnLabel = empnField.parentElement.previousElementSibling;
            if (isOthers) {
                empnField.removeAttribute("required");
                empnField.readOnly = false;
                empnLabel.textContent = "Employee No (Optional):";
            } else {
                empnField.setAttribute("required", "required");
                empnLabel.textContent = "Employee No:";
            }
            
            // Handle patient section
            const patientSection = document.getElementById("patientSection");
            const relationSection = document.getElementById("relationSection");
            const selfDependentSection = document.getElementById("selfDependentSection");
            
            if (isOthers) {
                patientSection.style.display = "";
                relationSection.style.display = "";
                selfDependentSection.style.display = "none";
                document.getElementById("ename").readOnly = false;
            } else {
                patientSection.style.display = "none";
                relationSection.style.display = "none";
                selfDependentSection.style.display = "";
                document.getElementById("ename").readOnly = true;
                
            }
            

        	updateFieldVisibility(); 
        	
            
        } */

        function fetchEmployeeDetails() {
            const empn = document.getElementById("empn").value;
            const category = document.querySelector('input[name="category"]:checked').value;

            if (empn === "" || category === "Others") return;

            const url = "self3.jsp?action=getEmployee"
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

                const url = "self3.jsp?action=getDependents"
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



        /* function toggleDependents() {
        	
        	document.getElementById("relation").value = "";
            document.getElementById("age").value = "";
            document.getElementById("sex").value = "";
            
            
        	const category = document.querySelector('input[name="category"]:checked').value;

            const type = document.querySelector('input[name="relationType"]:checked').value;
            const dependentRow = document.getElementById("dependentRow");

            if (type === "dependent" && category !== "Others") {
                const empn = document.getElementById("empn").value;
                if (!empn) return;
                
                const url = "self3.jsp?action=getDependents"
                    + "&empn=" + encodeURIComponent(empn)
                    + "&category=" + encodeURIComponent(category);
                
                fetch(url)
                    .then(res => res.text())
                    .then(html => {
                        document.getElementById("dependentName").innerHTML = "<option value=''>-- Select --</option>" + html;
                        dependentRow.style.display = "";
                    });
            } else {
                dependentRow.style.display = "none";
            }
            

        	updateFieldVisibility(); 
        	
        } */

        function fetchDependentDetails() {
            const empn = document.getElementById("empn").value;
            const depName = document.getElementById("dependentName").value;
            const category = document.querySelector('input[name="category"]:checked').value;

            
            const url = "self3.jsp?action=getDependentDetails"
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
        	const category = document.querySelector('input[name="category"]:checked').value;
            const ename = document.getElementById("ename").value.trim();
           

            if (category === "Others") {
                const patientName = document.getElementById("patientName").value.trim();
                const patientRelation = document.getElementById("patientRelation").value.trim();
                
                if (!ename ) {
                    alert("Please fill Employee Name");
                    event.preventDefault();
                    return false;
                }
                if (!patientName || !patientRelation) {
                    alert("Please fill Patient Name and Relation.");
                    event.preventDefault();
                    return false;
                }
            }

           

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
                if (patientName) patientName.removeAttribute("required");
                if (patientRelation) patientRelation.removeAttribute("required");
            } else {
                if (dependentRow) dependentRow.style.display = "none";
                if (patientName) patientName.setAttribute("required", "required");
                if (patientRelation) patientRelation.setAttribute("required", "required");
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
            if (dependentRow && (category === "Others" )) {
                dependentRow.style.display = "none";
            }
            
        }


        
    </script>
   
</head>
<body>
 
<div class="container-fluid p-3 bg-light">

	<div class="row">
	
	
		<div align="center" >
  <center>
  <table border="0" width="100%" cellspacing="1" height="53">
    <tr>
      <td width="12%" height="49" valign="middle" align="left">
        <p align="center">
       <a href="/hosp1/home/rep1.jsp"> <img border="0" src="/hosp1/nflimage.png" width="100" height="80" style="margin-left:50px;"></a>
      
      <td width="88%" height="49" style="padding-left: 30vw;">

<p align="center" style="margin-top: -3; margin-bottom: 0;width:450px" ><strong><b><font face="Tahoma" color="#006600" size="4">NATIONAL FERTILIZERS LIMITED, PANIPAT UNIT</font></b></strong></p>
<p align="center" style="margin-top: 5; margin-bottom: 0"><b><font face="Tahoma" size="5" color="#800000">HOSPITAL</font></b></p>
      </td>
      
      
    </tr>
    

  </table>
  </center>
</div>

		
		
		
		
		
		<div class="col-md-3 ml-auto  ">
		 <%
		   
	        User user1 = (User) session.getAttribute("Docobj");
	        if (user1 != null) {
	    %>
	        <span class="text-white btn btn-success ml-2">Welcome, <%= user1.getUsername() %>!</span>
	        <!-- <a data-toggle="modal" data-target="#exampleModalCenter" class="btn btn-danger ml-2 text-white"><i class="fas fa-sign-out-alt"></i> Logout</a> -->
	        
	        <a href="/hosp1/changePassword.jsp" class="btn btn-primary my-2 my-sm-2 ml-2 mr-2"
				type="submit"> <i class="fas "></i> Change Password
			
			</a>
	        <a data-toggle="modal" data-target="#logoutModal" class="btn btn-danger ml-2 text-white"><i class="fas fa-sign-out-alt"></i> Logout</a>
	        
	     
			
	
	    <%
	        } else {
	    %>
				<a href="index.jsp" class="btn btn-success "><i
					class="fas fa-sign-in-alt"></i> Login</a> 
					
			</div>
		<%
		}
		%>

	</div>
</div>
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="logoutModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="text-center">
          <h4>Are you sure you want to logout?</h4>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <!-- Trigger the LogoutServlet on Logout -->
          <a href="/hosp1/logout" class="btn btn-danger ml-4 text-white">Logout!</a>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="container-fluid" style="height: 5px; background-color: #303f9f; margin-bottom:10px; margin-top:30px"></div>




 <%-- <%@include file="../../navbar.jsp" %>  --%>
    

<form method="post" action="/hosp1/jsps/savePrescription3.jsp">





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
      <input type="text" name="ename" id="ename" />
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
      <input type="text" name="age" id="age" style="color:red; font-weight:bold" maxlength="10"/>
    </td>
    <td align="center">Sex:<br>
      <input type="text" name="sex" id="sex" style="color:red; font-weight:bold" maxlength="1" />
    </td>
  </tr>
  <!-- Buttons -->
  <tr>
    <td colspan="7" align="center">
      <input type="reset" value="Reset" />
    </td>
  </tr>
</table>







<div style="display: flex;
    gap: 100px; /* space between divs */
    justify-content: center;
    align-items: flex-start;
    margin:30px">
    
    
  <div style="min-width: 320px;
    background: #f9f9f9;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 1px 6px rgba(0,0,0,0.08);">
    
    <h3>Select or Add Disease</h3>
    <select id="diseaseSelect" name="diseaseSelect" multiple style="width: 300px;"></select>
    <br><br>
    <input type="text" id="newDisease" placeholder="Type and click Add if not listed" />
    <button type="button" onclick="addNewDisease()">Add Disease</button>
    <div id="todoItemsDisease" style="margin-top:10px;"></div>
  </div>

  <div style=" min-width: 320px;
    background: #f9f9f9;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 1px 6px rgba(0,0,0,0.08);">
    <h3>Select or Add Medicine</h3>
    <select id="medicineSelect" multiple style="width: 300px;"></select>
    <br><br>
    <input type="text" id="newMedicine" placeholder="Type and click Add if not listed" />
    <button type="button" onclick="addNewMedicine()">Add Medicine</button>
    <div id="todoItemsMedicine" style="margin-top: 20px;"></div>
  </div>
     </div>
     
<div align="center"> 
    <button  type="button" onclick="saveTempPrescription()">Save Data</button>
    
 </div>
    
    <div align="center" id="medicineDetailsContainer" style="margin:20px; display:none;">
  <h3>Medicine Details</h3>
  <table border="1" cellpadding="5" cellspacing="0" width="50%" id="medicineDetailsTable">
    <thead>
      <tr>
        <th width="40%" >Medicine Name</th>
        <th width="40%">Dose</th>
        <!-- <th>Frequency & Timing</th> -->
        <th width="20%">Number of Days</th>
      </tr>
    </thead>
    <tbody>
      <!-- Rows will be added dynamically here -->
    </tbody>
  </table>
  

    
  		 <div  align="center" style="margin-top:20px;">
 			 <button type="button" onclick="submitFinalPrescription()">Save Prescription</button>
		</div>
    </div>
  </form>

  <!-- <script src="/hosp1/javascript/getOV.js"></script> -->
  <script>
    $(document).ready(function () {
    	
      loadDisease();
      loadMedicine();
      updateFieldVisibility();
    });

    function loadDisease() {
      $.ajax({
        url: '/hosp1/jsps/getDisease.jsp',
        method: 'GET',
        success: function (response) {
          $('#diseaseSelect').html(response).select2({
            placeholder: "Select diseases",
            allowClear: true,
            width: 'resolve'
          }).on('change', updateToDoListDisease);
          updateToDoListDisease();
        },
        error: function () {
          alert("Failed to load diseases.");
        }
      });
    }

    function loadMedicine() {
      $.ajax({
        url: '/hosp1/jsps/getMedicine.jsp',
        method: 'GET',
        success: function (response) {
          $('#medicineSelect').html(response).select2({
            placeholder: "Select medicines",
            allowClear: true,
            width: 'resolve'
          }).on('change', updateToDoListMedicine);
          updateToDoListMedicine();
        },
        error: function () {
          alert("Failed to load medicines.");
        }
      });
    }

   /*  function addNewDisease() {
      let newDisease = $('#newDisease').val().trim();
      if (!newDisease) return alert("Please enter a Disease.");
      $.post('/hosp1/jsps/addDisease.jsp', { diseaseName: newDisease }, function (response) {
        if (response.trim() === "OK") {
          let newOption = new Option(newDisease, newDisease, true, true);
          $('#diseaseSelect').append(newOption).trigger('change');
          $('#newDisease').val('');
        } else {
          alert("Disease already exists or failed to add.");
        }
      });
    } */
    function addNewDisease() {
    	  let newDisease = $('#newDisease').val().trim();
    	  if (!newDisease) return alert("Please enter a Disease.");
    	  $.post('/hosp1/jsps/addDisease.jsp', { diseaseName: newDisease }, function (response) {
    	    response = response.trim();
    	    if (response !== "FAIL1" && response !== "FAIL2" && !isNaN(response)) {
    	      // response is the new disease code/id
    	      let newDiseaseCode = response;
    	      let newOption = new Option(newDisease, newDiseaseCode, true, true);
    	      $('#diseaseSelect').append(newOption).trigger('change');
    	      $('#newDisease').val('');
    	    } else {
    	      alert("Disease already exists or failed to add.");
    	    }
    	  });
    	}

/*      function addNewMedicine() {
      let newMedicine = $('#newMedicine').val().trim();
      if (!newMedicine) return alert("Please enter a Medicine.");
      $.post('/hosp1/jsps/addMedicine.jsp', { medicineName: newMedicine }, function (response) {
        if (response.trim() === "OK") {
          let newOption = new Option(newMedicine, newMedicine, true, true);
          $('#medicineSelect').append(newOption).trigger('change');
          $('#newMedicine').val('');
        } else {
          alert("Medicine already exists or failed to add.");
        }
      });
    }  */
     function addNewMedicine() {
    	  let newMedicine = $('#newMedicine').val().trim();
    	  if (!newMedicine) return alert("Please enter a Medicine.");
    	  $.post('/hosp1/jsps/addMedicine.jsp', { medicineName: newMedicine }, function (response) {
    	    response = response.trim();
    	    if (response !== "FAIL1" && response !== "FAIL2" && !isNaN(response)) {
    	      let newMedicineCode = response;
    	      let newOption = new Option(newMedicine, newMedicineCode, true, true);
    	      $('#medicineSelect').append(newOption).trigger('change');
    	      $('#newMedicine').val('');
    	    } else {
    	      alert("Medicine already exists or failed to add.");
    	    }
    	  });
    	} 

    
    
    function updateToDoListDisease() {
      let listHtml = '';
      $('#diseaseSelect option:selected').each(function () {
        listHtml += '<div class="todo-item">' + $(this).text() + '</div>';
      });
      $('#todoItemsDisease').html(listHtml);
    }
    
    
    

    function updateToDoListMedicine() {
      let listHtml = '';
      $('#medicineSelect option:selected').each(function () {
        listHtml += '<div class="todo-item">' + $(this).text() + '</div>';
      });
      $('#todoItemsMedicine').html(listHtml);
    }
    
    
    
    
    function saveTempPrescription() {
    	  let empn = $('#empn').val().trim();
    	  let age = $('#age').val().trim();
    	  let sex = $('#sex').val().trim();
    	  let relationType = $('input[name="relationType"]:checked').val();
    	  let category = $('input[name="category"]:checked').val();
    	  let diseases = $('#diseaseSelect').val();
    	  let medicines = $('#medicineSelect').val();

    	  if (!empn && category !== "Others") {
    	    alert("Please enter Employee Code before saving.");
    	    return;
    	  }
    	  
    	  if (relationType === "dependent" ) {
    	      let relation = $('#relation').val().trim();
        	  if(!relation){
        		  alert("Please select Dependent Name to before saving.");
           	    return;
        	  }
    	   
    	  }
    	  if(category === "Others"){
    		  empn = empn ? empn : 1; // default to 1 if empty
    		  let ename = $('#ename').val().trim();
    		  let patientName = $('#patientName').val().trim();
    		  let patientRelation = $('#patientRelation').val().trim();
    		  if(!ename){
    			  alert("Please enter Employee Name before saving.");
           	    return;
    		  }
    		  if(!patientName || !patientRelation){
    			  alert("Please enter Patient Name and Relation before saving.");
           	    return;
    		  }
    		  
    	  }
    	  
    	  if(!age){
    		  alert("Please enter Age before saving.");
       	    return;
    	  }
    	  if(!sex){
    		  alert("Please enter Sex before saving.");
       	    return;
    	  }

    	  $.ajax({
    	    url: '/hosp1/jsps/saveTempPrescription3.jsp',
    	    method: 'POST',
    	    data: {
    	      empn: empn,
    	      diseaseSelect: diseases,
    	      medicineSelect: medicines
    	    },
    	    traditional: true, // This is key: sends arrays properly
    	    success: function (response) {
    	      //alert(response.trim());

    	      // ✅ Now generate the medicine detail table
    	      generateMedicineDetailsTable();
    	    },
    	    error: function () {
    	      alert("Failed to save data.");
    	    }
    	  });
    	}
    
    
    function generateMedicineDetailsTable() {
    	
    	  let empn = $('#empn').val().trim()!="" ? $('#empn').val().trim() : 1;
    	  let category = $('input[name="category"]:checked').val();
    	  if (!empn && category !== "Others") {
    	    alert("Please enter Employee Code first.");
    	    return;
    	  }

    	  $.ajax({
    	    url: '/hosp1/jsps/getTempMedicine3.jsp',
    	    method: 'GET',
    	    data: { empn: empn },
    	    success: function(html) {
    	      if (!html.trim()) {
    	        alert("No medicines found in temp prescription.");
    	        $('#medicineDetailsContainer').hide();
    	      } else {
    	        $('#medicineDetailsTable tbody').html(html);
    	        $('#medicineDetailsContainer').show();
    	      }
    	    },
    	    error: function() {
    	      alert("Failed to fetch medicines from temp prescription.");
    	    }
    	  });
    	}


    function submitFinalPrescription() {
    	
    	  let empn = $('#empn').val();
    	  let category = $('input[name="category"]:checked').val();
    	  
    	  if (category !== "Others" && !empn) {
    	    alert("Please enter Employee Code before submitting.");
    	    return;
    	  }
    	 
    	  /*
     	  // Validate that at least one disease is selected	
    	  alert("Submitting prescription for Employee Code: " + empn);
    	  // Gather selected diseases
    	  let diseaseCodes = $('#diseaseSelect').val();
    	  alert("Selected diseases: " + diseaseCodes);
    	  
			if (!diseaseCodes || diseaseCodes.length === 0) {
					alert("Please select at least one disease.");
					return;
				} */

				/*   // Gather additional notes
				  let notes = $('#additionalNotes').val();

				  // Gather medicine data
				  let data = {
				    empn: empn,
				    notes: notes
				  };

				  // Collect data from each row
				  $('#medicineDetailsTable tbody tr').each(function () {
				    let medCode = $(this).find('input[name^="medicineCodes"]').val();
				    data['dosage_' + medCode] = $(this).find('input[name^="dosage_"]').val();
				    data['frequency_' + medCode] = $(this).find('select[name^="frequency_"]').val();
				    data['timing_' + medCode] = $(this).find('select[name^="timing_"]').val();
				    data['days_' + medCode] = $(this).find('input[name^="days_"]').val();
				  }); */

				/* $.ajax({
				  url: '/hosp1/jsps/savePrescription.jsp',
				  method: 'POST',
				  data: data,
				  success: function (response) {
				    alert(response.trim());
				    // Optionally, clear temp data or reload page
				  },
				  error: function () {
				    alert("Failed to save final prescription.");
				  }
				}); */

				document.forms[0].submit();	
			}
    
    
    
    
   
		</script>

	
    

</body>
</html>
