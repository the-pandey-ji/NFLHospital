function getLabMem()
  {
     xmlHttp=GetXmlHttpObject();
     if (xmlHttp==null)
        {
           alert ("Your browser does not support AJAX!");
           return;
        } 
     var label=document.getElementById('labmem').value;
     var empn=document.getElementById('labmemcode').value;
     var reason="";
     
     

            if (label=="GET")
               {
                  var url="jsps/labMemberInfo.jsp";
                  url=url+"?q="+label;
                  url=url+"&sid="+Math.random();
                  xmlHttp.onreadystatechange=stateChangedLabMeb;
                  xmlHttp.open("GET",url,true);
                  xmlHttp.send(null);
               }
            else
               {
        
                 if(validateReason(reason))
                    {
                       var url="jsps/labMemberInfo.jsp";
                       url=url+"?q="+label;
                       url=url+"&p="+empn;
                       url=url+"&r="+reason;
                       url=url+"&sid="+Math.random();
                       xmlHttp.onreadystatechange=stateChangedLabMeb;
                       xmlHttp.open("GET",url,true);
                       xmlHttp.send(null);
                    }
               }
        
  }
      
function stateChangedLabMeb()
{
if(xmlHttp.readyState==4)
  {
  var edata = new Array();
  edata = xmlHttp.responseText.split("#");
  
    document.getElementById('labmemcode').value=edata[0];
    document.getElementById('labmemname').value=edata[1];
    document.getElementById('labmemdesg').value=edata[2];
    document.getElementById('labmemdept').value=edata[3];
    document.getElementById('labmem').value="SKIP";
    
//document.bag.ovcode.value=xmlHttp.responseText;
//document.getElementById('ovcode').value=xmlHttp.responseText;

  }
}
