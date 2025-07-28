function getProdMem()
  {
     xmlHttp=GetXmlHttpObject();
     if (xmlHttp==null)
        {
           alert ("Your browser does not support AJAX!");
           return;
        } 
     
     var label=document.getElementById('prodmem').value;
     var empn=document.getElementById('prodmemcode').value;
     var reason="";
    
     

           if (label=="GET")
              {
                 var url="jsps/prodMemberInfo.jsp";
                 url=url+"?q="+label;
                 url=url+"&sid="+Math.random();
                 xmlHttp.onreadystatechange=stateChangedProdMem;
                 xmlHttp.open("GET",url,true);
                 xmlHttp.send(null);
              }
           else
              {
                  if(validateReason(reason))
                    {
                        var url="jsps/prodMemberInfo.jsp";
                        url=url+"?q="+label;
                        url=url+"&p="+empn;
                        url=url+"&r="+reason;
                        url=url+"&sid="+Math.random();
                        xmlHttp.onreadystatechange=stateChangedProdMem;
                        xmlHttp.open("GET",url,true);
                        xmlHttp.send(null);
                    }
                 else
                    return false;
              }
       
  }
function stateChangedProdMem()
{
if(xmlHttp.readyState==4)
  {
  var edata = new Array();
  edata = xmlHttp.responseText.split("#");
  
    document.getElementById('prodmemcode').value=edata[0];
    document.getElementById('prodmemname').value=edata[1];
    document.getElementById('prodmemdesg').value=edata[2];
    document.getElementById('prodmemdept').value=edata[3];

    document.getElementById('prodmem').value="SKIP";
    

//document.bag.ovcode.value=xmlHttp.responseText;
//document.getElementById('ovcode').value=xmlHttp.responseText;

  }
}
