
<%@include file="/allCss.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@ page import="com.entity.User" %>
<%@ page import="com.entity.EndUser" %>	

<%

    // Check if the user is logged in
    EndUser user = (EndUser) session.getAttribute("EndUserObj");
    if (user == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("/hosp1/index.jsp");
        
        return;
    }
%>



<div class="container-fluid p-3 bg-light">

	<div class="row">
	
	
		<div align="center" >
  <center>
  <table border="0" width="100%" cellspacing="1" height="53">
    <tr>
      <td width="12%" height="49" valign="middle" align="left">
        <p align="center">
        <a href="/hosp1/home/rep1.jsp"> <img border="0" src="/hosp1/nflimage.png" width="100" height="80" style="margin-left:50px;"></a>
       </td>
      
      <td width="88%" height="49" style="padding-left: 30vw;">

<p align="center" style="margin-top: -3; margin-bottom: 0;width:450px" ><strong><b><font face="Tahoma" color="#006600" size="4">NATIONAL FERTILIZERS LIMITED, PANIPAT UNIT</font></b></strong></p>
<p align="center" style="margin-top: 5; margin-bottom: 0"><b><font face="Tahoma" size="5" color="#800000">HOSPITAL</font></b></p>
      </td>
      
      
    </tr>
    

  </table>
  </center>
</div>

		
		
		
		
		
		<div class="col-md-3 ml-auto align-right ">
		 <%
		   
	        EndUser user1 = (EndUser) session.getAttribute("EndUserObj");
	        if (user1 != null) {
	    %>
	        <span class="text-white btn btn-success ml-5 ">Welcome, <%= user1.getUsername() %></span>
	        <!-- <a data-toggle="modal" data-target="#exampleModalCenter" class="btn btn-danger ml-2 text-white"><i class="fas fa-sign-out-alt"></i> Logout</a> -->
	        
	        <!-- <a href="/hosp1/changePassword.jsp" class="btn btn-primary my-2 my-sm-2 ml-2 mr-2"
				type="submit"> <i class="fas "></i> Change Password
			
			</a> -->
	       <!--  <a data-toggle="modal" data-target="#logoutModal" class="btn btn-danger ml-2 text-white"><i class="fas fa-sign-out-alt"></i> Logout</a>
	        --> 
	     
			
	
	    <%
	        } else {
	    %>
				<a href="index.jsp" class="btn btn-success "><i
					class="fas fa-sign-in-alt"></i> Login</a> 
					
			</div>
		<%
		}
		%>

	</div>
</div>

<!-- Logout Modal -->

<!-- Button trigger modal 
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
  Launch demo modal
</button>
-->
<!-- Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="logoutModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="text-center">
          <h4>Are you sure you want to logout?</h4>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <!-- Trigger the LogoutServlet on Logout -->
          <a href="/hosp1/logout" class="btn btn-danger ml-4 text-white">Logout!</a>
        </div>
      </div>
    </div>
  </div>
</div>

<nav class="navbar navbar-expand-lg navbar-dark bg-custom navbar-custom">
    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item mr-2 active">
                <a class="nav-link" href="/hosp1/home/rep1.jsp"><i class="fa fa-home" style="font-size:24px"></i> Home</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/hosp1/HOSPITAL/OPD/self3.jsp"><i class="fa fa-stethoscope" style="font-size:20px;"></i>OPD</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/hosp1/HOSPITAL/OPD/opdReport.jsp"><i class="fa fa-book"></i> OPD History</a>
            </li>
            
            <li class="nav-item dropdown">
                <a class="nav-link active dropdown-toggle" href="#" id="navbarDropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-share" style="font-size:20px;color:red"></i> Local Refer </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/hosp1/HOSPITAL/Localref/self/local_refer_revisit.jsp">Local Hospital refer</a>
                    <a class="dropdown-item" href="/hosp1/HOSPITAL/Localref/self/local_revisit.jsp">Local Hospital Revisit</a>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link active dropdown-toggle" href="#" id="navbarDropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-share-square-o" style="font-size:20px;color:red"></i> OutStation Refer </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/hosp1/HOSPITAL/Outref/dep/out_refer_revisit.jsp">Outstation refer</a>
                    <a class="dropdown-item" href="/hosp1/HOSPITAL/Outref/dep/out_revisit.jsp">Outstation Revisit</a>
                </div>
            </li>
            
            <li class="nav-item active">
                <a class="nav-link " href="/hosp1/HOSPITAL/Medical%20Certificate/med_cert.jsp"><i class="fa fa-heartbeat" style="font-size:20px"></i> Med Certificate</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link active dropdown-toggle" href="#" id="navbarDropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-medkit" style="font-size:24px"></i> Med Examination </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/hosp1/HOSPITAL/Medical Examination/medical_examination.htm">Medical Examination Form</a>
                    <a class="dropdown-item" href="/hosp1/HOSPITAL/Medical Examination/reportentry.htm">Medical Examination Report</a>
                    <a class="dropdown-item" href="/hosp1/HOSPITAL/Medical Examination/alert.jsp">Employees Due for MED.EX.</a>
                </div>
            </li> 
            <li class="nav-item dropdown">
                <a class="nav-link active dropdown-toggle" href="#" id="navbarDropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-file-text" style="font-size:20px"></i> Reports </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/hosp1/HOSPITAL/Reports/noopd.jsp">Today's OPD Report</a>
                    <a class="dropdown-item" href="/hosp1/HOSPITAL/Reports/opdhome.jsp">Date wise OPD Report</a>
                    <a class="dropdown-item" href="/hosp1/HOSPITAL/Reports/todayrefered.jsp">Today's Referred Cases</a>
                    <a class="dropdown-item" href="/hosp1/HOSPITAL/Reports/noref.jsp">Date wise Referred Cases</a>
                    <a class="dropdown-item" href="/hosp1/HOSPITAL/Reports/medcert.htm">Medical Certificates</a>
                </div>
            </li>
            
            
        </ul>
        <div class="form-inline my-2 my-lg-0">
            <a href="/hosp1/changePassword.jsp" class="btn btn-primary my-2 my-sm-2 ml-2 mr-2">Change Password</a>
        
            <a data-toggle="modal" data-target="#logoutModal" class="btn btn-danger ml-2 text-white"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
</nav>
<div class="container-fluid" style="height: 5px; background-color: #303f9f; margin-bottom:10px; margin-top:10px"></div>
<!-- Add the CSS for the hover effect -->
<style>
    .bg-custom {
        background-color: rgb(53, 143, 253);
    }

    .navbar .nav-item:hover .nav-link {
        background-color: white;
        color: rgb(99, 99, 250);
        border-radius: 15px;
        padding: 5px 10px;
    }

    .navbar .nav-link {
        color: white;
        font-weight: bold;
    }

    .navbar-custom {
        padding-top: 0 !important;
        padding-bottom: 0 !important;
    }

    /* Dropdown open on hover */
    .nav-item.dropdown .dropdown-menu {
        display: none;
        position: absolute;
        z-index: 1000;
        opacity: 0;
        transition: opacity 0.3s ease-in-out;
    }

    .nav-item.dropdown:hover .dropdown-menu {
        display: block;
        opacity: 1;
    }
    /* Default color for the dropdown item */
	.dropdown-item {
	    color: #5a5a5a; /* Change this to your desired color */
	}
	
	/* Hover color for the dropdown item */
	.dropdown-item:hover {
	    color: #ffffff;  /* Color when hovered */
	    background-color: #5aaaf9;  /* Background color when hovered */
	}
	
	/* Active color for the dropdown item (when selected) */
	.dropdown-item.active {
	    color: #ffffff; /* Color when active */
	    background-color: #0056b3; /* Background color when active */
	}
	
	/* Reduce gap between dropdown toggle and menu */
	.nav-item.dropdown .dropdown-menu {
	    margin-top: 0; /* default is usually ~0.125rem or more */
	}
</style>


