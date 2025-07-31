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
<!-- Select2 CSS -->
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

<!-- jQuery (already included) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Select2 JS -->
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
             
             <div align="center">
    <h3>Select or Add Disease</h3>
   <select id="searchDisease" style="width: 300px;">
    <option value="">-- Select or type disease --</option>
</select>
<button onclick="addDisease()">Add if not listed</button>
</div>



<script>
$(document).ready(function () {
    $('#searchDisease').select2({
        placeholder: "Select or type disease",
        allowClear: true,
        tags: true // allows typing new diseases
    });

    loadDiseases();
});

function loadDiseases() {
    $.getJSON("hosp1/jsps/getDiseases.jsp", function (data) {
        const $dropdown = $('#searchDisease');
        $dropdown.empty(); // clear old options
        $dropdown.append('<option></option>'); // for placeholder

        $.each(data, function (index, item) {
            $dropdown.append('<option value="' + item.disease_name + '">' + item.disease_name + '</option>');
        });
    });
}

function addDisease() {
    const disease = $('#searchDisease').val().trim();
    if (!disease) {
        alert("Please select or type a disease name.");
        return;
    }

    $.get("hosp1/jsps/addDisease.jsp?disease_name=" + encodeURIComponent(disease), function (response) {
        if (response.trim() === "success") {
            alert("Disease added successfully.");
            loadDiseases();
            $('#searchDisease').val(null).trigger('change'); // reset dropdown
        } else if (response.trim() === "invalid") {
            alert("Invalid disease name.");
        } else {
            alert("Failed to add disease. It may already exist.");
        }
    });
}



</script>

</body>
</html>