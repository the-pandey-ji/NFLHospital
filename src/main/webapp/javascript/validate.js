
function Validate()
              {
                  if(bagsampling.ovcode.value=="")
                    {
                      alert("Please enter the Overviewer"); 
                      event.returnValue=false;
                    }  
                   else if(bagsampling.prodmemcode.value=="")
                    {
                      alert("Please enter the Member of Production"); 
                      event.returnValue=false;
                    } 
                    else if(bagsampling.matlmemcode.value=="")
                    {
                      alert("Please enter the Member of Material"); 
                      event.returnValue=false;
                    } 
                    else if(bagsampling.labmemcode.value=="")
                    {
                      alert("Please enter the Member of Lab"); 
                      event.returnValue=false;
                    } 
                                      
                    else
                    {
                      event.returnValue=true;
                    }
               }
   
