<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.* "%>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.DB.DBConnect" %>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
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
<script language="javascript" type="text/javascript" src="/hosp1/javascript/getOV.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
</head>
<body>


<div align="center">
               <center>
               <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse; border-width: 0" bordercolor="#111111" width="47%" height="39">
                 <tr>
                   <td width="5%" style="border-top-color: #111111; border-top-width: 1" align="center" height="37">
                   E.Code<font color="#FF0000" size="4"><b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" name="ovcode" id="ovcode" size="9"  style="color: #FF0000; font-weight: bold">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b></font> <input type="button" value="GET" name="B1" id="ov" onclick="getOV();"></td>
                  
                 </tr>
               </table>
               </center>
      </div>
             <div align="center" >
               <center>
               <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse; border-width: 0" bordercolor="#111111" width="47%">
                 <tr>
                   <td width="10%" style="border-top-color: #111111; border-top-width: 1" align="center">Name</td>
                   <td width="10%" style="border-top-color: #111111; border-top-width: 1" align="center">
                   Age</td>
                   <td width="10%" style="border-top-color: #111111; border-top-width: 1" align="center">
                   Sex</td>
                  
                 </tr>
                 <tr>
                   <td width="10%" style="border-bottom-color: #111111; border-bottom-width: 1" align="center">
                        <input type="text" name="ovname" id="ovname" size="24" disabled="true" style="color: #FF0000; font-weight: bold"></td>
                   <td width="10%" style="border-bottom-color: #111111; border-bottom-width: 1" align="center">
                        <input type="text" name="ovage" id="ovage" size="19" disabled="true" style="color: #FF0000; font-weight: bold"></td>
                   <td width="10%" style="border-bottom-color: #111111; border-bottom-width: 1" align="center">
                        <input type="text" name="ovsex" id="ovsex" size="22" disabled="true" style="color: #FF0000; font-weight: bold"></td>
                  
                 </tr>
               </table>
               </center>
             </div>
             
             
             
             
  <div>
  <h3>Select or Add Disease</h3>
  <p>Hold down the Ctrl (windows) or Command (Mac) button to select multiple options.</p>
  <select id="diseaseSelect" multiple style="width: 300px;"></select>
  <br><br>
  <input type="text" id="newDisease" placeholder="Type and click Add if not listed" />
  <button onclick="addNewDisease()">Add Disease</button>
  <div class="todo-list" id="todoListDisease">
    <strong>Selected Disease:</strong>
    <div id="todoItemsDisease"></div>
  </div>
</div>

<div>
  <h3>Select or Add Medicine</h3>
  
  <select id="medicineSelect" multiple style="width: 300px;"></select>
  <br><br>
  <input type="text" id="newMedicine" placeholder="Type and click Add if not listed" />
  <button onclick="addNewMedicine()">Add Medicine</button>
  
  





<script>
$(document).ready(function () {
  loadDisease();
  loadMedicine();
});

// ---------------- Load Dropdowns ----------------

function loadDisease() {
  $.ajax({
    url: '/hosp1/jsps/getDisease.jsp',
    method: 'GET',
    success: function(response) {
      $('#diseaseSelect').html(response).select2({
        placeholder: "Select diseases",
        allowClear: true,
        width: 'resolve'
      }).on('change', updateToDoListDisease);
    },
    error: function() {
      alert("Failed to load diseases.");
    }
  });
}

function loadMedicine() {
  $.ajax({
    url: '/hosp1/jsps/getMedicine.jsp',
    method: 'GET',
    success: function(response) {
      $('#medicineSelect')
        .html(response)
        .select2({
          placeholder: "Select medicines",
          allowClear: true,
          width: 'resolve'
        })
        .on('change', updateToDoListMedicine);
    },
    error: function() {
      alert("Failed to load medicines.");
    }
  });
}

// ---------------- Add New Options ----------------

function addNewDisease() {
  let newDisease = $('#newDisease').val().trim();
  if (!newDisease) return alert("Please enter a Disease.");
  $.post('/hosp1/jsps/addDisease.jsp', { diseaseName: newDisease }, function(response) {
    if (response.trim() === "OK") {
      let newOption = new Option(newDisease, newDisease, true, true);
      $('#diseaseSelect').append(newOption).trigger('change');
      $('#newDisease').val('');
    } else {
      alert("Disease already exists or failed to add.");
    }
  });
}

function addNewMedicine() {
  let newMedicine = $('#newMedicine').val().trim();
  if (!newMedicine) return alert("Please enter a Medicine.");
  $.post('/hosp1/jsps/addMedicine.jsp', { medicineName: newMedicine }, function(response) {
    if (response.trim() === "OK") {
      let newOption = new Option(newMedicine, newMedicine, true, true);
      $('#medicineSelect').append(newOption).trigger('change');
      $('#newMedicine').val('');
    } else {
      alert("Medicine already exists or failed to add.");
    }
  });
}

// ---------------- Update Displayed Selections ----------------

function updateToDoListDisease() {
  let listHtml = '';
  $('#diseaseSelect option:selected').each(function() {
    listHtml += '<div class="todo-item">' + $(this).text() + '</div>';
  });
  $('#todoItemsDisease').html(listHtml);
}



/* function updateToDoListMedicine() {
		  const selectedData = $('#medicineSelect').select2('data');

		  if (selectedData.length === 0) {
		    $('#medicineDetailsContainer').html('<em>No medicines selected</em>');
		    $('#todoItemsMedicine').html('');
		    console.log("No medicines selected");
		    return;
		  }

		  $('#todoItemsMedicine').html(''); // clear names container

		  let html = '';
		  selectedData.forEach(item => {
		    html += `
		      <div class="medicine-block" style="margin-bottom:20px; border-bottom:1px solid #ccc; padding-bottom:10px;">
		        <strong style="display:block; font-size:16px; margin-bottom:8px;">${item.text}</strong>
		        <input type="hidden" name="medicine_name[]" value="${item.id}">
		        Dosage: <input type="text" name="dosage[]" placeholder="e.g. 500mg" style="width:100px;" required> &nbsp;
		        Frequency: <input type="text" name="frequency[]" placeholder="e.g. 2 times/day" style="width:120px;" required> &nbsp;
		        Duration: <input type="text" name="duration[]" placeholder="e.g. 5 days" style="width:100px;" required>
		      </div>
		    `;
		  });

		  $('#medicineDetailsContainer').html(html);

		  console.log("Updated medicineDetailsContainer:", $('#medicineDetailsContainer').html());
		} */
	

		
		/* 	function updateToDoListMedicine() {
				  const selectedData = $('#medicineSelect').select2('data');

				  if (selectedData.length === 0) {
				    $('#medicineDetailsContainer').html('<em>No medicines selected</em>');
				    $('#todoItemsMedicine').html('');
				    return;
				  }

				  let html = '';
				  selectedData.forEach(item => {
				    html += `
				      <div class="medicine-block" style="margin-bottom:20px; border-bottom:1px solid #ccc; padding-bottom:10px;">
				        <strong style="display:block; font-size:16px; margin-bottom:8px;">${item.text}</strong>
				        <input type="hidden" name="medicine_name[]" value="${item.id}">
				        <div style="margin-bottom:5px;">
				          <label>Dosage:</label>
				          <input type="text" name="dosage[]" placeholder="e.g. 500mg" style="width:100px;" required>
				        </div>
				        <div style="margin-bottom:5px;">
				          <label>Frequency:</label>
				          <input type="text" name="frequency[]" placeholder="e.g. 2 times/day" style="width:120px;" required>
				        </div>
				        <div>
				          <label>Duration:</label>
				          <input type="text" name="duration[]" placeholder="e.g. 5 days" style="width:100px;" required>
				        </div>
				      </div>
				    `;
				  });

				  $('#medicineDetailsContainer').html(html);
				  $('#todoItemsMedicine').html('');
				} */

			
			
			

</script>

</body>
</html>