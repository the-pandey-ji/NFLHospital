<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.* "%>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.DB.DBConnect" %>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>OPD Slip</title>
<style type="text/css" media="print">

   div {
        background-color: #fff;
        padding: 25px;
        max-width: 500px;
        margin: auto;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        
    }


</style>
<script language="javascript" type="text/javascript" src="/hosp1/javascript/getOV.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
</head>
<body>
<% 
	/* String empn = session.getAttribute("nm").toString();
	String name = "";
	String age = "";
	String sex = "";
					
    //String dataSourceName = "hosp";
    // String dbURL = "jdbc:oracle:thin:@10.3.126.84:1521:ORCL";
    
  
    
    Connection con=DBConnect.getConnection(); 
    Connection con1=DBConnect.getConnection1(); 

    try 
        {
  
           String query = "select ename,to_char(sysdate,'yyyy') - to_char(birthdate,'yyyy'), sex FROM employeemaster where empn=?";           
           
           
            Statement stmt=con.createStatement();
  

           PreparedStatement pstmt = con1.prepareStatement(query);
			pstmt.setString(1, empn);
			ResultSet rs = pstmt.executeQuery();


           while(rs.next())
	          {
	             name = rs.getString(1);
	             age = rs.getString(2);
                     sex = rs.getString(3);
                    
	          }
           
           System.out.println("name:"+name);
           System.out.println("agr:"+age);
           System.out.println("sex:"+sex);
           
       
        	
	     // ResultSet rs3 = stmt.executeQuery("insert into opd(SRNO, PATIENTNAME,RELATION, AGE, OPDDATE, SEX, EMPN,TYP,EMPNAME) values ('"+srno+"','"+name+"','SELF','"+age1+"',SYSDATE,'"+sex+"','"+empn+"','"+typ+"','"+name+"')");
	        

	
	

	    }
	    
catch(SQLException e) 
   {
      while((e = e.getNextException()) != null)
      out.println(e.getMessage() + "<BR>");
   }

finally
   {
       if(con != null) 
         {
             try
                 {
                    con.close();
                 }
             catch (Exception ignored) {}
         }
   } */
%>
<div align="center">
               <center>
               <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse; border-width: 0" bordercolor="#111111" width="47%" height="39">
                 <tr>
                   <td width="5%" style="border-top-color: #111111; border-top-width: 1" align="center" height="37">
                   E.Code<font color="#FF0000" size="4"><b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" name="ovcode" id="ovcode" size="9"  style="color: #FF0000; font-weight: bold">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b></font> <input type="button" value="GET" name="B1" id="ov" onclick="getOV();"></td>
                  
                 </tr>
               </table>
               </center>
      </div>
             <div align="center" >
               <center>
               <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse; border-width: 0" bordercolor="#111111" width="47%">
                 <tr>
                   <td width="10%" style="border-top-color: #111111; border-top-width: 1" align="center">Name</td>
                   <td width="10%" style="border-top-color: #111111; border-top-width: 1" align="center">
                   Age</td>
                   <td width="10%" style="border-top-color: #111111; border-top-width: 1" align="center">
                   Sex</td>
                  
                 </tr>
                 <tr>
                   <td width="10%" style="border-bottom-color: #111111; border-bottom-width: 1" align="center">
                        <input type="text" name="ovname" id="ovname" size="24" disabled="true" style="color: #FF0000; font-weight: bold"></td>
                   <td width="10%" style="border-bottom-color: #111111; border-bottom-width: 1" align="center">
                        <input type="text" name="ovage" id="ovage" size="19" disabled="true" style="color: #FF0000; font-weight: bold"></td>
                   <td width="10%" style="border-bottom-color: #111111; border-bottom-width: 1" align="center">
                        <input type="text" name="ovsex" id="ovsex" size="22" disabled="true" style="color: #FF0000; font-weight: bold"></td>
                  
                 </tr>
               </table>
               </center>
             </div>
             
             
             
             
  <div >
  <h3>Select or Add Disease</h3>
  <p>Hold down the Ctrl (windows) or Command (Mac) button to select multiple options.</p>
  <select id="diseaseSelect" multiple style="width: 300px;"></select>
  <br><br>
  <input type="text" id="newDisease" placeholder="Type and click Add if not listed" />
  <button onclick="addNewDisease()">Add Disease</button>
  <div class="todo-list" id="todoListDisease">
    <strong>Selected Disease:</strong>
    <div id="todoItemsDisease"></div>
  </div>
  
</div>

<div>
  <h3>Select or Add Medicine</h3>
  
  <select id="medicineSelect" multiple style="width: 300px;"></select>
  <br><br>
  <input type="text" id="newMedicine" placeholder="Type and click Add if not listed" />
  <button onclick="addNewMedicine()">Add Medicine</button>
  <div class="todo-list" id="todoListMedicine">
    <strong>Selected Medicine:</strong>
    <div id="todoItemsMedicine"></div>
  </div>
 
</div>

 <button onclick="saveToDoList('medicine')">Save Selected Medicines</button>



<script>
$(document).ready(function () {
	  loadDisease();
	  loadMedicine();
	});

	function loadDisease() {
	  $.ajax({
	    url: '/hosp1/jsps/getDisease.jsp',
	    method: 'GET',
	    success: function(response) {
	      $('#diseaseSelect').append(response);
	      $('#diseaseSelect').select2({
	        placeholder: "Select diseases",
	        allowClear: true,
	        width: 'resolve'
	      });
	      $('#diseaseSelect').on('change', updateToDoListDisease);
	    },
	    error: function() {
	      alert("Failed to load diseases.");
	    }
	  });
	}

	function loadMedicine() {
	  $.ajax({
	    url: '/hosp1/jsps/getMedicine.jsp',
	    method: 'GET',
	    success: function(response) {
	      $('#medicineSelect').append(response);
	      $('#medicineSelect').select2({
	        placeholder: "Select medicines",
	        allowClear: true,
	        width: 'resolve'
	      });
	      $('#medicineSelect').on('change', updateToDoListMedicine);
	    },
	    error: function() {
	      alert("Failed to load medicines.");
	    }
	  });
	}

	function addNewDisease() {
	  let newDisease = $('#newDisease').val().trim();
	  if (!newDisease) {
	    alert("Please enter a Disease.");
	    return;
	  }

	  $.ajax({
	    url: '/hosp1/jsps/addDisease.jsp',
	    method: 'POST',
	    data: { diseaseName: newDisease },
	    success: function(response) {
	      if (response.trim() === "OK") {
	        let newOption = new Option(newDisease, newDisease, true, true);
	        $('#diseaseSelect').append(newOption).trigger('change');
	        $('#newDisease').val('');
	        updateToDoListDisease();
	      } else {
	        alert("Disease already exists or failed to add.");
	      }
	    },
	    error: function() {
	      alert("An error occurred while adding the disease.");
	    }
	  });
	}

	function addNewMedicine() {
	  let newMedicine = $('#newMedicine').val().trim();
	  if (!newMedicine) {
	    alert("Please enter a Medicine.");
	    return;
	  }

	  $.ajax({
	    url: '/hosp1/jsps/addMedicine.jsp',
	    method: 'POST',
	    data: { medicineName: newMedicine },
	    success: function(response) {
	      if (response.trim() === "OK") {
	        let newOption = new Option(newMedicine, newMedicine, true, true);
	        $('#medicineSelect').append(newOption).trigger('change');
	        $('#newMedicine').val('');
	        updateToDoListMedicine();
	      } else {
	        alert("Medicine already exists or failed to add.");
	      }
	    },
	    error: function() {
	      alert("An error occurred while adding the medicine.");
	    }
	  });
	}

	function updateToDoListDisease() {
	  let selected = $('#diseaseSelect option:selected');
	  let listHtml = '';
	  selected.each(function() {
	    listHtml += '<div class="todo-item">' + $(this).text() + '</div>';
	  });
	  $('#todoItemsDisease').html(listHtml);
	}

	function updateToDoListMedicine() {
	  let selected = $('#medicineSelect option:selected');
	  let listHtml = '';
	  selected.each(function() {
	    listHtml += '<div class="todo-item">' + $(this).text() + '</div>';
	  });
	  $('#todoItemsMedicine').html(listHtml);
	}

	// Example save function placeholder


	


</script>


</body>
</html>