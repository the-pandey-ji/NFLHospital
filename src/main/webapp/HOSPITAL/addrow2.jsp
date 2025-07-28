<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.* "%>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>New Page 1</title>
</head>

<body>
<script>
var tbody; function addAddressRow() { tbody = 
document.getElementById("myadTable").getElementsByTagName("tbody")[0]; var row = 
document.createElement("TR"); var cell1 = document.createElement("TD"); 
cell1.innerHTML = document.getElementById("td1").innerHTML ; var cell2 = 
document.createElement("TD"); cell2.innerHTML = 
document.getElementById("td2").innerHTML ; var cell3 = 
document.createElement("TD"); cell3.innerHTML = 
document.getElementById("td3").innerHTML ; var cell4 = 
document.createElement("TD"); cell4.innerHTML = 
document.getElementById("td4").innerHTML ; var cell5 = 
document.createElement("TD"); cell5.innerHTML = 
document.getElementById("td5").innerHTML ; var cell6 = 
document.createElement("TD"); cell6.innerHTML = 
document.getElementById("td6").innerHTML ; var cell7 = 
document.createElement("TD"); cell7.innerHTML = 
document.getElementById("td7").innerHTML ; var cell9 = 
document.createElement("TD"); var len = document.all.myadTable.rows.length-2; 
cell9.innerHTML = " "; cell9.align = "center"; row.appendChild(cell1); 
row.appendChild(cell2); row.appendChild(cell9); row.appendChild(cell3); 
row.appendChild(cell4); row.appendChild(cell5); row.appendChild(cell6); 
row.appendChild(cell7); tbody.appendChild(row); } var optIndexValue = ""; 
function getValue(optIndex) { createRequest(); optIndexValue = optIndex; var 
State = 
document.forms[0].States.options[document.forms[0].States.selectedIndex].value; 
http.open("GET", 
"/system/getOptions.jsp?optIndex="+optIndex+"&amp;States="+State, true); 
http.onreadystatechange = handleHttpResponse; http.send(null); } function 
createRequest(){ try { http = new XMLHttpRequest(); } catch(e) { try { http = 
new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { http = new 
ActiveXObject("Microsoft.XMLHTTP"); } catch (E) { http = false; } } } } function 
handleHttpResponse() { if (http.readyState == 4) { if(optIndexValue=="OPT0"){ 
document.getElementById("td6").innerHTML=http.responseText; } } } function 
resetStates(){ document.getElementById("td6") .innerHTML = "Select"; } 
</script>
</body>

</html>
