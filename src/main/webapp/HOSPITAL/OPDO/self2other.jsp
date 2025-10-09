<%@ page language="java" session="true"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page contentType="text/html; charset=windows-1252" %>
<%@ page import="com.entity.User" %>
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
</head>

<%
String oempn = request.getParameter("empn");
oempn = (oempn != null) ? oempn.trim() : "";
String orelation = request.getParameter("relation");
String ocategory = request.getParameter("category");


String odt = "";
String osrno ="";


String opname = request.getParameter("pname");
String oage = request.getParameter("age");


String osex = request.getParameter("sex");
String oename = request.getParameter("ename");

String category = request.getParameter("category");




	// Assigning values to session attributes
	

		


		if (osex.equalsIgnoreCase("M")) {
	osex = "M";
		} else if(osex.equalsIgnoreCase("F")) {
	osex = "F";}
		else
			osex = "U";
		
%>


<body>

<%

    // Check if the user is logged in
    User user = (User) session.getAttribute("Docobj");
    if (user == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("/hosp1/index.jsp");
        
        return;
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
       </td>
      
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
	        
	        <a href="changePassword.jsp" class="btn btn-primary my-2 my-sm-2 ml-2 mr-2"
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

<!-- Logout Modal -->

<!-- Button trigger modal 
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
  Launch demo modal
</button>
-->
<!-- Modal -->
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

  <form method="post" action="/hosp1/jsps/opdother/savePrescription.jsp">
    <div align="center">
      <table border="1" cellpadding="0" cellspacing="0" width="47%">
        <tr>
          <td align="center">
            E.Code:
            <input type="text" name="ovcode" id="ovcode" size="9" style="color: red; font-weight: bold" readonly value=<%= oempn%> />
          <!--  <input type="button" value="GET" onclick="getOV();" /> -->
          </td>
        </tr>
      </table>
    </div>

    <div align="center">
      <table border="1" cellpadding="0" cellspacing="0" width="47%">
        <tr>
         <td align="center">Patient Name</td>
          <td align="center">Emp. Name</td>
          <td align="center">Age</td>
          <td align="center">Sex</td>
          <td align="center">Relation</td>
        </tr>
        <tr>
        <td align="center">
            <input type="text" name="opname" id="opname" size="24" readonly style="color:red; font-weight:bold" value=<%= opname%>>
          </td>
        
          <td align="center">
            <input type="text" name="oename" id="oename" size="24" readonly style="color:red; font-weight:bold" value=<%= oename%>>
          </td>
          <td align="center">
            <input type="text" name="oage" id="oage" size="19" readonly style="color:red; font-weight:bold" value=<%= oage%>>
          </td>
          <td align="center">
            <input type="text" name="osex" id="osex" size="22" readonly style="color:red; font-weight:bold" value=<%= osex%>>
          </td>
           <td align="center">
            <input type="text" name="orelation" id="orelation" size="22" readonly style="color:red; font-weight:bold" value=<%= orelation	%>>
          </td>
        </tr>
      </table>
    </div>
    
    <input type="hidden" name="ocategory" value="<%=category %>">
    
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
    	     // alert(response.trim());

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
    	
    	 
    	

				document.forms[0].submit();

			}
		</script>
</body>
</html>
