<%@ page language="java" session="true"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.User" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="../../allCss.jsp"%>

<%
    // Check session user
    User user = (User) session.getAttribute("Docobj");
    if (user == null) {
        response.sendRedirect("/hosp1/index.jsp");
        return;
    }
%>

<html>
<head>
    <title>OPD Entry - NFL / CISF / OTHERS</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

    <style>
        body { background-color: #f5faff; font-family: Arial; }
        .container { margin: 20px auto; width: 80%; background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .toggle-group { text-align: center; margin-bottom: 20px; }
        .toggle-group input { margin: 0 10px; }
        table { border-collapse: collapse; width: 60%; margin: auto; }
        td { padding: 8px; }
        th { background: #dfefff; }
        .hidden { display: none; }
    </style>

</head>
<body>
<div class="container-fluid p-3 bg-light">
    <div class="row">
        <div align="center">
            <center>
                <table border="0" width="100%" cellspacing="1" height="53">
                    <tr>
                        <td width="12%" align="center">
                            <a href="/hosp1/home/rep1.jsp">
                                <img src="/hosp1/nflimage.png" width="100" height="80">
                            </a>
                        </td>
                        <td width="88%" style="text-align:center;">
                            <p><b><font face="Tahoma" color="#006600" size="4">NATIONAL FERTILIZERS LIMITED, PANIPAT UNIT</font></b></p>
                            <p><b><font face="Tahoma" size="5" color="#800000">HOSPITAL</font></b></p>
                        </td>
                    </tr>
                </table>
            </center>
        </div>

        <div class="col-md-3 ml-auto">
            <%
                if (user != null) {
            %>
                <span class="btn btn-success ml-2">Welcome, <%= user.getUsername() %>!</span>
                <a href="/hosp1/changePassword.jsp" class="btn btn-primary ml-2">Change Password</a>
                <a data-toggle="modal" data-target="#logoutModal" class="btn btn-danger ml-2 text-white">Logout</a>
            <%
                }
            %>
        </div>
    </div>
</div>

<!-- Logout Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-dialog-centered"><div class="modal-content">
    <div class="modal-body text-center">
      <h4>Are you sure you want to logout?</h4>
      <a href="/hosp1/logout" class="btn btn-danger">Logout!</a>
    </div>
  </div></div>
</div>

<div class="container">
    <h3 align="center">OPD Entry - NFL / CISF / OTHERS</h3>

    <!-- Category Toggle -->
    <div class="toggle-group">
        <label><input type="radio" name="category" value="N" checked onclick="onCategoryChange()"> NFL</label>
        <label><input type="radio" name="category" value="C" onclick="onCategoryChange()"> CISF</label>
        <label><input type="radio" name="category" value="O" onclick="onCategoryChange()"> OTHERS</label>
    </div>

    <form id="opdForm" method="POST" action="/hosp1/jsps/savePrescription.jsp">
        <table border="1">
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

            <tr id="dependentRow" class="hidden">
                <td>Dependent Name:</td>
                <td>
                    <select id="dependentName" name="dependentName" onchange="fetchDependentDetails()">
                        <option value="">-- Select --</option>
                    </select>
                </td>
            </tr>

            <tr><td>Patient Name:</td><td><input type="text" id="pname" name="pname" required></td></tr>
            <tr><td>Employee Name:</td><td><input type="text" id="ename" name="ename" required></td></tr>
            <tr><td>Relation:</td><td><input type="text" id="relation" name="relation" required></td></tr>
            <tr><td>Age:</td><td><input type="text" id="age" name="age" required></td></tr>
            <tr>
                <td>Sex:</td>
                <td>
                    <select id="sex" name="sex">
                        <option value="M">M</option>
                        <option value="F">F</option>
                    </select>
                </td>
            </tr>
        </table>
    </form>

    <hr style="margin: 30px 0;">

    <!-- Prescription Section -->
    <div align="center">
        <table border="1" width="70%">
            <tr>
                <th>Disease(s)</th>
                <th>Medicine(s)</th>
            </tr>
            <tr>
                <td align="center">
                    <select id="diseaseSelect" multiple style="width:90%"></select><br>
                    <input type="text" id="newDisease" placeholder="Add new disease">
                    <button onclick="addNewDisease()">Add</button>
                    <div id="todoItemsDisease" style="margin-top:10px;"></div>
                </td>
                <td align="center">
                    <select id="medicineSelect" multiple style="width:90%"></select><br>
                    <input type="text" id="newMedicine" placeholder="Add new medicine">
                    <button onclick="addNewMedicine()">Add</button>
                    <div id="todoItemsMedicine" style="margin-top:10px;"></div>
                </td>
            </tr>
        </table>

        <br>
        <button onclick="saveTempPrescription()">Save Data</button>
    </div>

    <div align="center" id="medicineDetailsContainer" style="margin-top:30px; display:none;">
        <h3>Medicine Details</h3>
        <table border="1" width="60%" id="medicineDetailsTable">
            <thead>
                <tr><th>Medicine</th><th>Dose</th><th>Days</th></tr>
            </thead>
            <tbody></tbody>
        </table>
        <br>
        <button onclick="submitFinalPrescription()">Save Prescription</button>
    </div>
</div>

<script>
$(document).ready(function() {
    loadDisease();
    loadMedicine();
});

function onCategoryChange() {
    let category = document.querySelector('input[name="category"]:checked').value;
    let isOthers = (category === "O");
    document.getElementById("relationTypeRow").style.display = isOthers ? "none" : "";
    document.getElementById("empn").disabled = isOthers;
    if (isOthers) {
        ['pname','ename','relation','age','sex'].forEach(id => {
            document.getElementById(id).value = '';
            document.getElementById(id).readOnly = false;
        });
    }
}

function fetchEmployeeDetails() {
    let empn = $("#empn").val().trim();
    if (!empn) return;
    let cat = $('input[name="category"]:checked').val();

    let url = (cat === "C") ? "registration_fom.jsp?action=employee&empn=" + empn
              : "/hosp1/jsps/getNFLDetails.jsp?empn=" + empn;

    fetch(url)
        .then(r => r.json())
        .then(data => {
            $("#pname").val(data.pname || "");
            $("#ename").val(data.ename || "");
            $("#relation").val(data.relation || "SELF");
            $("#age").val(data.age || "");
            $("#sex").val(data.sex || "M");
        });
    fetchDependents();
}

function fetchDependents() {
    let empn = $("#empn").val().trim();
    let cat = $('input[name="category"]:checked').val();
    let url = (cat === "C")
        ? "registration_fom.jsp?action=dependents&empn=" + empn
        : "/hosp1/jsps/getNFLDependents.jsp?empn=" + empn;
    fetch(url).then(r => r.text()).then(html => $("#dependentName").html("<option>-- Select --</option>"+html));
}

function toggleDependents() {
    let isDependent = $('input[name="relationType"]:checked').val() === "dependent";
    $("#dependentRow").toggle(isDependent);
}

function fetchDependentDetails() {
    let empn = $("#empn").val().trim();
    let name = $("#dependentName").val().trim();
    if (!name) return;
    let cat = $('input[name="category"]:checked').val();
    let url = (cat === "C")
        ? "registration_fom.jsp?action=dependentDetails&empn="+empn+"&name="+encodeURIComponent(name)
        : "/hosp1/jsps/getNFLDependentDetails.jsp?empn="+empn+"&name="+encodeURIComponent(name);
    fetch(url).then(r => r.json()).then(d => {
        $("#pname").val(name);
        $("#relation").val(d.relation || "");
        $("#age").val(d.age || "");
        $("#sex").val(d.sex || "");
    });
}

// --- Disease / Medicine Functions ---
function loadDisease() {
    $.get('/hosp1/jsps/getDisease.jsp', res => {
        $('#diseaseSelect').html(res).select2({placeholder:"Select diseases"}).on('change', updateDiseaseList);
    });
}
function loadMedicine() {
    $.get('/hosp1/jsps/getMedicine.jsp', res => {
        $('#medicineSelect').html(res).select2({placeholder:"Select medicines"}).on('change', updateMedicineList);
    });
}
function addNewDisease() {
    let d = $('#newDisease').val().trim(); if (!d) return alert("Enter disease");
    $.post('/hosp1/jsps/addDisease.jsp',{diseaseName:d},res=>{
        res=res.trim(); if(!isNaN(res)){ $('#diseaseSelect').append(new Option(d,res,true,true)).trigger('change'); $('#newDisease').val('');}
    });
}
function addNewMedicine() {
    let m = $('#newMedicine').val().trim(); if (!m) return alert("Enter medicine");
    $.post('/hosp1/jsps/addMedicine.jsp',{medicineName:m},res=>{
        res=res.trim(); if(!isNaN(res)){ $('#medicineSelect').append(new Option(m,res,true,true)).trigger('change'); $('#newMedicine').val('');}
    });
}
function updateDiseaseList() {
    let html=''; $('#diseaseSelect option:selected').each(function(){ html+='<div>'+$(this).text()+'</div>'; });
    $('#todoItemsDisease').html(html);
}
function updateMedicineList() {
    let html=''; $('#medicineSelect option:selected').each(function(){ html+='<div>'+$(this).text()+'</div>'; });
    $('#todoItemsMedicine').html(html);
}

// --- Save Prescription Temp / Final ---
function saveTempPrescription() {
    let empn = $("#empn").val().trim();
    if (!empn && $('input[name="category"]:checked').val()!=="O") return alert("Enter Employee Code first");
    $.post('/hosp1/jsps/saveTempPrescription.jsp',{
        ovcode: empn,
        diseaseSelect: $('#diseaseSelect').val(),
        medicineSelect: $('#medicineSelect').val()
    }, ()=> generateMedicineDetailsTable(empn));
}

function generateMedicineDetailsTable(empn){
    $.get('/hosp1/jsps/getTempMedicine.jsp',{ovcode:empn},html=>{
        if(html.trim()){ $('#medicineDetailsTable tbody').html(html); $('#medicineDetailsContainer').show();}
    });
}

function submitFinalPrescription(){
    document.getElementById("opdForm").submit();
}
</script>
</body>
</html>
