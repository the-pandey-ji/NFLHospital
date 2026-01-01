<%@ page language="java" session="true"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=windows-1252" %>
<%@ page import="com.entity.User" %>
<%@include file="../../allCss.jsp"%>

<%

    // Check if the user is logged in
    User user = (User) session.getAttribute("Docobj");
    if (user == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("/hosp1/index.jsp");
        
        return;
    }
%>

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
</head>

<body>


<%
    int opdId = 0;

// ===== YEAR LOGIC =====
String currentYear = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
String selectedYear = request.getParameter("year");

if (selectedYear == null || selectedYear.trim().isEmpty()) {
    selectedYear = currentYear;
}

String opdTable,prescriptionTable;
if (selectedYear.equals(currentYear)) {
    opdTable = "OPD";
    prescriptionTable = "PRESCRIPTION";
} else {
    opdTable = "OPD" + selectedYear;
    prescriptionTable = "PRESCRIPTION" + selectedYear;
}
// ===== END YEAR LOGIC =====

    try {
        opdId = Integer.parseInt(request.getParameter("opdId"));
        
        
    } catch (NumberFormatException e) {
        out.println("Invalid OPD ID.");
        return;
    }

    // Declare all variables used in the form
    String name = "", age = "", sex = "", empn = "", relation = "", note = "", empname= "";
    List<Map<String, String>> medicines = new ArrayList<Map<String, String>>();
    Set<String> selectedDiseases = new HashSet<String>();
    

    Connection conn = null;
    PreparedStatement ps1 = null, ps2 = null;
    ResultSet rs1 = null, rs2 = null;

    try {
        conn = DBConnect.getConnection();

        // Get basic patient details from OPD table
        String sql1 = "SELECT PATIENTNAME, AGE, SEX, EMPN, EMPNAME, RELATION FROM " + opdTable + " WHERE srno = ?";
        ps1 = conn.prepareStatement(sql1);
        ps1.setInt(1, opdId);
        rs1 = ps1.executeQuery();

        if (rs1.next()) {
            name = rs1.getString("PATIENTNAME");
            age = rs1.getString("AGE");
            sex = rs1.getString("SEX");
            empn = rs1.getString("EMPN");
            relation = rs1.getString("RELATION");
            empname = rs1.getString("EMPNAME");
        }
        session.setAttribute("depname",name);
    	session.setAttribute("drel", relation);
    	session.setAttribute("dage", age);
    	session.setAttribute("dsex",sex);
    	session.setMaxInactiveInterval(-1);

       // Get prescriptions (medicines, diseases, notes)
        String sql2 = "SELECT p.MEDICINECODE, mm.MEDICINENAME, p.DOSAGE, p.TIMING, p.DAYS, p.NOTES, p.DISEASECODE " +
                      "FROM " + prescriptionTable + " p LEFT JOIN MEDICINEMASTER mm ON TO_CHAR(p.MEDICINECODE) = TO_CHAR(mm.MEDICINECODE) " +
                      "WHERE p.OPD_ID = ?";
        ps2 = conn.prepareStatement(sql2);
        ps2.setInt(1, opdId);
        rs2 = ps2.executeQuery();
        
 
		

        while (rs2.next()) {
        	
            Map<String, String> med = new HashMap<String, String>();
            med.put("medicine", rs2.getString("MEDICINENAME"));
            med.put("code", rs2.getString("MEDICINECODE")); // add this!
            med.put("dosage", rs2.getString("DOSAGE"));
            med.put("timing", rs2.getString("TIMING"));
            med.put("days", rs2.getString("DAYS"));
            medicines.add(med);

            // Only assign notes once (they are repeated per row in JOIN)
            if (!note.isEmpty()) {
                note = rs2.getString("NOTES");
            }

            String diseaseCodes = rs2.getString("DISEASECODE");
            if (diseaseCodes != null && !diseaseCodes.trim().isEmpty()) {
                for (String d : diseaseCodes.split(",")) {
                    selectedDiseases.add(d.trim());
                }
            }
        }

    } catch (Exception e) {
    	System.out.println("Error: " + e.getMessage());
    } finally {
        try { if (rs1 != null) rs1.close(); } catch (Exception e) {}
        try { if (rs2 != null) rs2.close(); } catch (Exception e) {}
        try { if (ps1 != null) ps1.close(); } catch (Exception e) {}
        try { if (ps2 != null) ps2.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>


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

<div class="container-fluid" style="height: 5px; background-color: #303f9f; margin-bottom:50px; margin-top:30px"></div>




<%-- <%@include file="/navbar.jsp" %> --%>
  <form method="post" action="/hosp1/jsps/savePrescription.jsp">
    <div align="center">
      <table border="1" cellpadding="0" cellspacing="0" width="47%">
        <tr>
          <td align="center">
            E.Code:
            <input type="text" value="<%=empn %>" style="color: red; font-weight: bold" disabled />
<input type="hidden" name="ovcode" id="ovcode" value="<%=empn %>" />
          </td>
        </tr>
      </table>
    </div>

    <div align="center">
      <table border="1" cellpadding="0" cellspacing="0" width="47%">
        <tr>
          <td align="center">Name</td>
          <td align="center">Age</td>
          <td align="center">Sex</td>
          <td align="center">Relation</td>
        </tr>
        <tr>
          <td align="center">
            <input type="text" name="ovname" id="ovname" value="<%= name %>" size="24" readonly style="color:red; font-weight:bold" disabled/>
          </td>
          <td align="center">
            <input type="text" name="ovage" id="ovage" value ="<%= age %>" size="19" readonly style="color:red; font-weight:bold" disabled/>
          </td>
          <td align="center">
            <input type="text" name="ovsex" id="ovsex" value ="<%= sex %>" size="22" readonly style="color:red; font-weight:bold" disabled/>
          </td>
          <td>
            <input type="text" name="ovrel" id="ovrel" value= <%= relation%> size="22" readonly style="color:red; font-weight:bold"  disabled>
          </td>
        </tr>
      </table>
    </div>

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
        <th>Medicine Name</th>
        <th>Dose</th>
        <th>Number of Days</th>
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

  <script src="/hosp1/javascript/getOV.js"></script>
  <script>



  const preSelectedDiseases = [
	    <%  
	      int i = 0;
	      for (String d : selectedDiseases) {
	          out.print("\"" + d + "\"");
	          if (i < selectedDiseases.size() - 1) out.print(", ");
	          i++;
	      }
	    %>
	  ];
  const preSelectedMedicines = [
	  <%
	    int j = 0;
	    for (Map<String, String> med : medicines) {
	        String mname = med.get("medicine");
	        String code = med.get("code");
	        if (mname == null) mname = "NO_NAME";
	        mname = mname.trim().replace("\"", "\\\"");
	        out.print("\"" + code + "\"");

	        if (j < medicines.size() - 1) out.print(", ");
	        j++;
	    }
	  %>
	];





	  $(document).ready(function () {
	    loadDisease();
	    loadMedicine();
	  });

	  // ÃƒÂ¢Ã¢â€šÂ¬Ã¢â‚¬ï¿½ Disease side (as before) ÃƒÂ¢Ã¢â€šÂ¬Ã¢â‚¬ï¿½
	  function loadDisease() {
	    $.ajax({
	      url: '/hosp1/jsps/getDisease.jsp',
	      method: 'GET',
	      success: function (response) {
	        $('#diseaseSelect').html(response);
	        $('#diseaseSelect').select2({
	          placeholder: "Select diseases",
	          allowClear: true,
	          width: 'resolve'
	        });
	        selectPreselectedDiseases();
	        updateToDoListDisease();
	        $('#diseaseSelect').on('change', updateToDoListDisease);
	      },
	      error: function () {
	        alert("Failed to load diseases.");
	      }
	    });
	  }
	  function selectPreselectedDiseases() {
	    if (preSelectedDiseases && preSelectedDiseases.length > 0) {
	      $('#diseaseSelect').val(preSelectedDiseases).trigger('change');
	    }
	  }
	  function updateToDoListDisease() {
	    let listHtml = '';
	    $('#diseaseSelect option:selected').each(function () {
	      listHtml += '<div class="todo-item">' + $(this).text() + '</div>';
	    });
	    $('#todoItemsDisease').html(listHtml);
	  }

	  // ÃƒÂ¢Ã¢â€šÂ¬Ã¢â‚¬ï¿½ Medicine side (with robust fallback) ÃƒÂ¢Ã¢â€šÂ¬Ã¢â‚¬ï¿½
	  function loadMedicine() {
	    $.ajax({
	      url: '/hosp1/jsps/getMedicine.jsp',
	      method: 'GET',
	      success: function (response) {
	        $('#medicineSelect').html(response);
	        $('#medicineSelect').select2({
	          placeholder: "Select medicines",
	          allowClear: true,
	          width: 'resolve'
	        });

	        console.log("Medicine options after load:", $('#medicineSelect option').map((i, el) => el.value).get());
	        console.log("preSelectedMedicines:", preSelectedMedicines);

	        let missing = preSelectedMedicines.filter(val =>
	          $('#medicineSelect option[value="' + val + '"]').length === 0
	        );
	        console.log("Missing medicine option values:", missing);

	        missing.forEach(function(mVal) {
	          let newOption = new Option(mVal, mVal, true, true);
	          $('#medicineSelect').append(newOption);
	        });

	        selectPreselectedMedicines();
	        updateToDoListMedicine();
	        $('#medicineSelect').on('change', updateToDoListMedicine);
	      },
	      error: function () {
	        alert("Failed to load medicines.");
	      }
	    });
	  }
	  function selectPreselectedMedicines() {
	    if (preSelectedMedicines && preSelectedMedicines.length > 0) {
	      $('#medicineSelect').val(preSelectedMedicines).trigger('change');
	    }
	  }

	  
	  // Add new disease / medicine functions ...
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
	        updateToDoListMedicine();
	      } else {
	        alert("Medicine already exists or failed to add.");
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
     function addNewMedicine1() {
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
    
    

    function updateToDoListMedicine() {
      let listHtml = '';
      $('#medicineSelect option:selected').each(function () {
        listHtml += '<div class="todo-item">' + $(this).text() + '</div>';
      });
      $('#todoItemsMedicine').html(listHtml);
    }
    
    function saveTempPrescription() {
        let ovcode = $('#ovcode').val().trim();
        let diseases = $('#diseaseSelect').val(); // optional
        let medicines = $('#medicineSelect').val(); // array of medicine codes

        if (!ovcode) {
            alert("Please enter Employee Code before saving.");
            return;
        }

        $.ajax({
            url: '/hosp1/jsps/saveTempPrescription.jsp',
            method: 'POST',
            data: {
                ovcode: ovcode,
                medicineSelect: medicines
            },
            traditional: true,
            success: function(response) {
                console.log("Temp data saved.");
                generateMedicineDetailsTable();
            },
            error: function() {
                alert("Failed to save data.");
            }
        });
    }

    
    function generateMedicineDetailsTable() {
        let ovcode = $('#ovcode').val().trim();
        let opdno = "<%= opdId %>"; // Use the OPD ID from your JSP variable

        if (!ovcode || !opdno) return;

        $.ajax({
            url: '/hosp1/jsps/getTempMedicine2.jsp',
            method: 'GET',
            data: { 
                ovcode: ovcode,
                opdno: opdno, // Ã°Å¸â€�Â¹ send OPD number here
                selectedYear: '<%=selectedYear %>'
            },
            success: function (response) {
                $('#medicineDetailsTable tbody').html(response);
                $('#medicineDetailsContainer').show();
            },
            error: function () {
                alert("Failed to load medicine details.");
            }
        });
    }



    function submitFinalPrescription() {
    	
    	  let empn = $('#ovcode').val();
    	  
    	  if (!empn) {
    	    alert("Employee Code is missing.");
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
				    ovcode: empn,
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
