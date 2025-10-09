<%@ page language="java" session="true"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=windows-1252" %>

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

<%
String depname = request.getParameter("depnm");
if (depname == null || depname.isEmpty()) {
	response.sendRedirect("/hosp1/jsps/error.jsp?message=Dependent name is missing.");
	return;
}

String empn = session.getAttribute("eno").toString();
String drel = session.getAttribute("drel") != null ? session.getAttribute("drel").toString() : "";
String dage = "";
String dsex = "";

Connection con1=DBConnect.getConnection1(); 
Statement stmt1=con1.createStatement();

ResultSet rs = stmt1.executeQuery("select a.DEPENDENTNAME, trim(b.sex), b.RELATIONNAME, to_char(sysdate,'yyyy') - to_char(dob,'yyyy') FROM dependents a, dependentrelation b  where A.RELATION =B.RELATIONCODE and  trim(a.dependentname) ='"+depname+"' and a.empn="+empn+"");
while(rs.next())
     {
         depname = rs.getString(1);
	drel = rs.getString(3);
	dage = rs.getString(4);
	dsex = rs.getString(2);
	
	
     }
	// Assigning values to session attributes
	session.setAttribute("depname", depname);
	session.setAttribute("drel", drel);
	session.setAttribute("dage", dage);
	session.setAttribute("dsex",dsex);
	session.setMaxInactiveInterval(-1);
	

		


		if (dsex.equalsIgnoreCase("M")) {
	dsex = "MALE";
		} else if(dsex.equalsIgnoreCase("F")) {
	dsex = "FEMALE";}
		else
			dsex = "Unknown";
		
%>


<body>
  <form method="post" action="/hosp1/jsps/savePrescription.jsp">
    <div align="center">
      <table border="1" cellpadding="0" cellspacing="0" width="47%">
        <tr>
          <td align="center">
            E.Code:
            <input type="text" name="ovcode" id="ovcode" size="9" style="color: red; font-weight: bold" value=<%= empn%> />
          <!--  <input type="button" value="GET" onclick="getOV();" /> -->
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
            <input type="text" name="ovname" id="ovname" size="24" readonly style="color:red; font-weight:bold" value=<%= depname%>>
          </td>
          <td align="center">
            <input type="text" name="ovage" id="ovage" size="19" readonly style="color:red; font-weight:bold" value=<%= dage%>>
          </td>
          <td align="center">
            <input type="text" name="ovsex" id="ovsex" size="22" readonly style="color:red; font-weight:bold" value=<%= dsex%>>
          </td>
           <td align="center">
            <input type="text" name="ovrel" id="ovrel" size="22" readonly style="color:red; font-weight:bold" value=<%= drel%>>
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
        <th>Frequency & Timing</th>
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
    $(document).ready(function () {
      loadDisease();
      loadMedicine();
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
    	  let ovcode = $('#ovcode').val().trim();
    	  let diseases = $('#diseaseSelect').val();
    	  let medicines = $('#medicineSelect').val();

    	  if (!ovcode) {
    	    alert("Please enter Employee Code before saving.");
    	    return;
    	  }

    	  $.ajax({
    	    url: '/hosp1/jsps/saveTempPrescription.jsp',
    	    method: 'POST',
    	    data: {
    	      ovcode: ovcode,
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
    	  let empn = $('#ovcode').val().trim();
    	  if (!empn) {
    	    alert("Please enter Employee Code first.");
    	    return;
    	  }

    	  $.ajax({
    	    url: '/hosp1/jsps/getTempMedicine.jsp',
    	    method: 'GET',
    	    data: { ovcode: empn },
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
    	
    	  let empn = $('#ovcode').val();
    	  
    	  if (!empn) {
    	    alert("Employee Code is missing.");
    	    return;
    	  }
    	

				document.forms[0].submit();

			}
		</script>
</body>
</html>
