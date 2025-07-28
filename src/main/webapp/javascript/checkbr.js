var xmlHttp;
var xmlHttpfaculty;
function GetXmlHttpObject()
{
var xmlHttp=null;
try
  {
  // Firefox, Opera 8.0+, Safari
  xmlHttp=new XMLHttpRequest();
  xmlHttpfaculty = new XMLHttpRequest();
  }
catch (e)
  {
  // Internet Explorer
  try
    {
    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    xmlHttpfaculty=new ActiveXObject("Msxml2.XMLHTTP");    
    }
  catch (e)
    {
    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    xmlHttpfaculty=new ActiveXObject("Microsoft.XMLHTTP");
    }
  }
return xmlHttp;
}