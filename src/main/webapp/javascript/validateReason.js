function validateReason(label)
   {
     var text=label;
     //var pattern = /[a-zA-Z0-9&_\.-]/;
     var pattern = /[0-9&@#$%!*^()+=_\.-]/;
     
     if(text== 'reason')
       {
          text='textOV';
       }
     else if (text== 'prodreason')
       {
          text='prodreason';
       } 
     else if (text=='matlreason' )
       {
          text='matlreason';
       } 
     else if (text=='labreason')
       {
          text='labreason';
       } 
     else
       {
          
       } 
 //alert('text is '+text);
 //alert('label is '+label);
    
  /* 
     var textOV=document.getElementById('reason').value;
     var textProd=document.getElementById('prodreason').value;
     var textMatl=document.getElementById('matlreason').value;
     var textLab=document.getElementById('labreason').value;
    
     
     if(textOV != null)
       {
          text=textOV;
       }
     else if (textProd != null)
       {
          text=textProd;
       } 
     else if (textMatl != null)
       {
          text=textMatl;
       } 
     else if (textLab != null)
       {
          text=textLab;
       } 
     else
       {
          
       } 
  */
     
    //alert('OV value '+textOV+ 'Prod value '+textProd+'Matl value '+textMatl+'Lab value '+textLab);
    

     if(text.match(pattern)) 
       {
          
          alert('invalid reason');
          return false;
       }
     else
       {
          return true;
       }
   }