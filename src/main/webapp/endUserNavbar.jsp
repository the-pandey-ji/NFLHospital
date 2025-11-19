
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
        
        <%-- Branding (Similar to Doctor's Navbar) --%>
        <div class="col-md-6">
            <div align="left">
                <center>
                    <table border="0" width="100%" cellspacing="1" height="53">
                        <tr>
                            <td width="12%" height="49" valign="middle" align="left">
                                <a href="/hosp1/userDashboard.jsp"> 
                                    <img border="0" src="/hosp1/nflimage.png" width="80" height="70" style="margin-right:20px;">
                                </a>
                            </td>
                            <td width="88%" height="49" style="padding-left: 2vw;">
                                <p align="left" style="margin-top: -3; margin-bottom: 0;">
                                    <strong><b><font face="Tahoma" color="#006600" size="4">NATIONAL FERTILIZERS LIMITED, PANIPAT UNIT</font></b></strong>
                                </p>
                                <p align="left" style="margin-top: 5; margin-bottom: 0">
                                    <b><font face="Tahoma" size="5" color="#800000">EMPLOYEE HEALTH PORTAL</font></b>
                                </p>
                            </td>
                        </tr>
                    </table>
                </center>
            </div>
        </div>

        <%-- Welcome and Actions --%>
        <div class="col-md-6 d-flex align-items-center justify-content-end">
             <span class="text-dark btn btn-info mr-3">
                <i class="fa fa-user"></i> Welcome, **<%= user.getUsername() %>**
            </span>
             <a href="/hosp1/changePassword.jsp" class="btn btn-primary mr-2">
                <i class="fas fa-key"></i> Change Password
            </a>
            <a data-toggle="modal" data-target="#logoutModal" class="btn btn-danger text-white">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
</div>

<%-- Logout Modal (Copy the modal HTML from the doctor's dashboard here) --%>
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
                    <a href="/hosp1/logout" class="btn btn-danger ml-4 text-white">Logout!</a>
                </div>
            </div>
        </div>
    </div>
</div>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="/hosp1/userDashboard.jsp"><i class="fa fa-home"></i> Home (Dashboard)</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/hosp1/HOSPITAL/OPD/opdReport.jsp?empn=<%= user.getEmpn() %>"><i class="fa fa-book"></i> My OPD History</a>
            </li>
             <li class="nav-item">
                <a class="nav-link" href="/hosp1/HOSPITAL/Reports/referralHistory.jsp?empn=<%= user.getEmpn() %>"><i class="fa fa-share-square-o"></i> My Referrals</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="fa fa-file-contract"></i> Medical Certificate Copies</a>
            </li>
        </ul>
    </div>
</nav>
<div class="container-fluid" style="height: 5px; background-color: #0056b3; margin-bottom:10px; margin-top:10px"></div>
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


