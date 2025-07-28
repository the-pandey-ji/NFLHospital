function getCom(com)
{
xmlHttp=GetXmlHttpObject();
var comno=com.value;
if (xmlHttp==null)
  {
  alert ("Your browser does not support AJAX!");
  return;
  } 
//alert("committee no is "+comno);
var url="jsps/getDataByComNo.jsp";
url=url+"?q="+comno;
url=url+"&sid="+Math.random();
xmlHttp.onreadystatechange=stateChangedCom;
xmlHttp.open("GET",url,true);
xmlHttp.send(null);
}
function stateChangedCom()
{
if(xmlHttp.readyState==4)
  {
  var cdata = new Array();
  cdata = xmlHttp.responseText.split("#");
  
    document.getElementById('dt').innerHTML=cdata[0];
    document.getElementById('ovcode').innerHTML=cdata[1];
    document.getElementById('ovnam').innerHTML=cdata[2];
    document.getElementById('ovdesig').innerHTML=cdata[3];
    document.getElementById('ovdept').innerHTML=cdata[4];
    document.getElementById('pmcode').innerHTML=cdata[5];
    document.getElementById('pmnam').innerHTML=cdata[6];
    document.getElementById('pmdesig').innerHTML=cdata[7];
    document.getElementById('pmdept').innerHTML=cdata[8];
    document.getElementById('mmcode').innerHTML=cdata[9];
    document.getElementById('mmnam').innerHTML=cdata[10];
    document.getElementById('mmdesig').innerHTML=cdata[11];
    document.getElementById('mmdept').innerHTML=cdata[12];
    document.getElementById('lmcode').innerHTML=cdata[13];
    document.getElementById('lmnam').innerHTML=cdata[14];
    document.getElementById('lmdesig').innerHTML=cdata[15];
    document.getElementById('lmdept').innerHTML=cdata[16];
  }
}
