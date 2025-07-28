function getMatlMem()
 {
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
       {
          alert ("Your browser does not support AJAX!");
          return;
       } 
         
     var label=document.getElementById('matlmem').value;
     var empn=document.getElementById('matlmemcode').value;
     var reason="";
    
     

             if (label=="GET")
                {
                   var url="jsps/matlMemberInfo.jsp";
                   url=url+"?q="+label;
                   url=url+"&sid="+Math.random();
                   xmlHttp.onreadystatechange=stateChangedMatlMem;
                   xmlHttp.open("GET",url,true);
                   xmlHttp.send(null);
                }
             else
                {
                   if(validateReason(reason))
                      {
                         var url="jsps/matlMemberInfo.jsp";
                         url=url+"?q="+label;
                         url=url+"&p="+empn;
                         url=url+"&r="+reason;
                         url=url+"&sid="+Math.random();
                         xmlHttp.onreadystatechange=stateChangedMatlMem;
                         xmlHttp.open("GET",url,true);
                         xmlHttp.send(null);
                      }
                    else
                    return false;
                }
        
 }
function stateChangedMatlMem()
  {
     if(xmlHttp.readyState==4)
        {
           var edata = new Array();

           edata = xmlHttp.responseText.split("#");
           //alert(edata); 
           document.getElementById('matlmemcode').value=edata[0];
           document.getElementById('matlmemname').value=edata[1];
           document.getElementById('matlmemdesg').value=edata[2];
           document.getElementById('matlmemdept').value=edata[3];
           document.getElementById('matlmem').value="SKIP";
           
           //document.bag.ovcode.value=xmlHttp.responseText;
           //document.getElementById('ovcode').value=xmlHttp.responseText;

        }
 }
