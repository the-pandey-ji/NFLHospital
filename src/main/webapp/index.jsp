

<!-- <a href= "/hosp1/home/main1.htm" > home page</a> -->



<%@ page import="java.sql.Connection" %>
<%@ page import="com.DB.DBConnect" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>OPD Management System</title>
<%@include file="allCss.jsp"%>
<style type="text/css">


body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	 background: url('path') no-repeat center center fixed;
            background-size: cover;
	background-size: cover;
	margin: 0;
	justify-content: center;
	align-items: center;
	color: #333;
} 

.login {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 80vh;
}
 
.container1 {
	background-color: rgba(255, 255, 255, 0.9);
	padding: 10px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
	max-width: 650px;
	width: 100%;
}

.flash {
	animation: flash 0.9s linear infinite alternate;
}

@keyframes flash {
from { color:black;}

to {color: green;}

}
h1, h2 {
	margin: 10px 0;
}

.form-group {
	margin: 15px 0;
	text-align: left;
}

label {
	display: inline-block;
	width: 100px;
	text-align: right;
	margin-right: 10px;
	font-weight: bold;
}

input[type="text"], input[type="password"] {
	width: calc(100% - 120px);
	padding: 10px;
	margin: 5px 0;
	border: 1px solid #ccc;
	border-radius: 4px;
}

input[type="submit"], input[type="reset"] {
	padding: 10px 20px;
	margin: 10px 5px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	background-color: #4CAF50;
	color: white;
	transition: background-color 0.3s ease;
}

input[type="reset"] {
	background-color: #f44336;
}

input[type="submit"]:hover {
	background-color: #45a049;
}

input[type="reset"]:hover {
	background-color: #e53935;
}

.notice {
	font-size: 0.7em;
	color: #555;
	margin-top: 15px;
}

.error-message {
	font-size: 0.8em;
	color: red;
	margin-top: 5px;
}

img {
	margin-bottom: 10px;
}

.table-container {
	display: flex;
	justify-content: center;
	width: 100%;
}

table {
	border-collapse: collapse;
	width: 100%;
}

td {
	padding: 5px;
}

.form-group-buttons {
	display: flex;
	justify-content: right;
	gap: 5px;
	margin-top: 5px;
}
</style>


</head>
<body style="background-color: #f7f7f7;">

<div class="container-fluid"
	style="height: 5px; background-color: #303f9f"></div>
	
	
	

<div class="container-fluid p-3 bg-light" width="100%">

	<div >
		<div class=" text-success">
			<h3>
				<i class="fas fa-book"></i> OPD Management System</h3>
			
			
		</div>
		
		
		

	
	<%-- <%@include file="all_component/navbar.jsp"%> --%>
	
	<div class="login">
	
	<div class="container1">
	<%
          String succMsg = (String) session.getAttribute("succMsg");
          if (succMsg != null) {
      %>
          <h4 class="success text-center text-success" style="font-size:30px; font-weight: bold;"><%= succMsg %></h4>
          <%
              session.removeAttribute("succMsg"); // Clear the message after displaying
          }
      %>

			 <%
            String failedMsg = (String) session.getAttribute("errorMsg");
            if (failedMsg != null) {
        %>
            <div style="color: red;font-size:25px; font-weight: bold;">
                <%= failedMsg %>
            </div>
        <%
            session.removeAttribute("errorMsg");
            }
        %>
      
      	
        <form action="login" method="post">
            <img src="/hosp1/nflimage.png" alt="NFL Logo" height="200" width="230">
            <h1 class="flash">National Fertilizers Limited, Panipat</h1>
            <h2>OPD</h2>
            <div class="table-container">
                <table>
                    <tbody><tr>
                        <td align="right">
                           <label for="exampleInputEmail1">Emp. ID</label>
                        </td>
                        <td align="left">
                            <input
									type="text" class="form-control" required="required" name="empn">                
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <label for="password">Password</label>
                        </td>
                        <td align="left">
                            <input
									type="password" class="form-control" id="exampleInputPassword1"
									required="required" name="password">              
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                                              
                    </td></tr><tr align="justify">
                        <td align="right">
                            <input type="submit" value="Login">
                        </td>
                        <td align="center">
                            <!-- <input type="submit" value="Login"> -->
                            <input type="reset" value="Cancel">          
                        </td>
                    </tr>
                </tbody></table>
            </div>
            <div class="notice">
              <!--  For better view & JavaScript functionality, please open the application in Microsoft Internet Explorer (IE-9 or IE-11). -->
              For better view/JavaScript functionality, please use latest version of Google Chrome/Microsoft Edge.
            </div>
        </form>



</div>
 
    </div>
	
	
	
	

	<%@include file="footer.jsp"%>

</body>
</html>