function getOV() {
  var xmlHttp = new XMLHttpRequest();
  if (!xmlHttp) {
    alert("Your browser does not support AJAX!");
    return;
  }

  var empn = document.getElementById('ovcode').value;
  var url = "/hosp1/jsps/employeeInfo.jsp?q=" + encodeURIComponent(empn) + "&sid=" + Date.now();

  xmlHttp.onreadystatechange = function() {
    if (xmlHttp.readyState === 4 && xmlHttp.status === 200) {
      var edata = xmlHttp.responseText.split("#");
      if (edata.length >= 3) {
        document.getElementById('ovname').value = edata[0];
        document.getElementById('ovage').value = edata[1];
        document.getElementById('ovsex').value = edata[2];
      } else {
        alert("Invalid response format.");
      }
    }
  };

  xmlHttp.open("GET", url, true);
  xmlHttp.send(null);
}
