
var xmlHttp =null;
function getOV()
  {
	xmlHttp = new XMLHttpRequest();
	if (!xmlHttp) {
	    alert("Your browser does not support AJAX!");
	    return;
	}
      
      
     
            
             var empn=document.getElementById('ovcode').value;
             //var reason="";


                    var url="/hosp1/jsps/employeeInfo.jsp";
					url=url+"?q="+empn;
                   url=url+"&sid="+Math.random();
					//url += "&sid=" + Date.now();
                    xmlHttp.onreadystatechange=stateChangedOV;
                    xmlHttp.open("GET",url,true);
                    xmlHttp.send(null);
					
              
            
				
  }

function stateChangedOV()
  {
    if(xmlHttp.readyState==4)
      {
         var edata = new Array();
		
         edata = xmlHttp.responseText.split("#");
		 
  
         //document.getElementById('ovcode').value=edata[0];
         document.getElementById('ovname').value=edata[0];
         document.getElementById('ovage').value=edata[1];
         document.getElementById('ovsex').value=edata[2];

        
         //document.bag.ovcode.value=xmlHttp.responseText;
         //document.getElementById('ovcode').value=xmlHttp.responseText;

      }
  }

