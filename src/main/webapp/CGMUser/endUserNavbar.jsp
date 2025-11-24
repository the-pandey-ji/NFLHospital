
<%@include file="/allCss.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@ page import="com.entity.User"%>
<%@ page import="com.entity.EndUser"%>

<%
// Check if the user is logged in
EndUser user = (EndUser) session.getAttribute("EndUserObj");
if (user == null) {
	// Redirect to login page if not logged in
	response.sendRedirect("/hosp1/index.jsp");

	return;
}
%>
<div class="sticky-top" style="z-index: 1030;">
<div class="container-fluid p-3 bg-light sticky-top">
    <div class="d-flex align-items-center position-relative" style="min-height: 80px;">

        <!-- LEFT: Logo -->
        <div class="position-absolute start-0">
            <a href="/hosp1/EndUser/endUser.jsp">
                <img src="/hosp1/nflimage.png" width="80" height="70">
            </a>
        </div>

        <!-- CENTER: Text -->
        <div class="mx-auto text-center">
            <div style="font-family: Tahoma; color: #006600; font-size: 22px; font-weight: bold;">
                NATIONAL FERTILIZERS LIMITED, PANIPAT UNIT
            </div>

            <div style="font-family: Tahoma; color: #800000; font-size: 28px; font-weight: bold; margin-top: 5px;">
                EMPLOYEE HEALTH PORTAL
            </div>
        </div>

    </div>
</div>



<nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link"
				href="/hosp1/EndUser/endUser.jsp"><i class="fa fa-home"></i>
					Home </a></li>
			<li class="nav-item active"><a class="nav-link"
				href="/hosp1/EndUser/EndUserOPDdetails.jsp"><i
					class="fa fa-book"></i> OPD History</a></li>
			<li class="nav-item active"><a class="nav-link"
				href="/hosp1/EndUser/EndUserReferDetails.jsp"><i
					class="fa fa-share-square-o"></i> My Referrals</a></li>
			<li class="nav-item active"><a class="nav-link"
				href="/hosp1/EndUser/EndUserMEDCerti.jsp"><i
					class="	fa fa-certificate"></i> Med Certificate</a></li>
					<li class="nav-item active"><a class="nav-link"
				href="/hosp1/EndUser/EndUserMedicalExam.jsp"><i
					class="fa fa-medkit"></i> Med Examination</a></li>
					<li class="nav-item active"><a class="nav-link"
				href="/hosp1/EndUser/EndUserMedicalReport.jsp"><i
					class="fa fa-plus-square"></i> Med Reports</a></li>
		</ul>
	</div>
	<div class="col-md-6 d-flex align-items-center justify-content-end">
		<span class="text-white btn btn-info mr-3"> <i
			class="fa fa-user"></i> Welcome, **<%=user.getUsername()%>**
		</span>
		<!--  <a href="/hosp1/changePassword.jsp" class="btn btn-primary mr-2">
                <i class="fas fa-key"></i> Change Password
            </a> -->
		<a data-toggle="modal" data-target="#logoutModal"
			class="btn btn-danger text-white"> <i class="fas fa-sign-out-alt"></i>
			Logout
		</a>
	</div>
</nav>
</div>
<%-- Logout Modal (Copy the modal HTML from the doctor's dashboard here) --%>
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
	aria-labelledby="logoutModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="text-center">
					<h4>Are you sure you want to logout?</h4>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<a href="/hosp1/logout" class="btn btn-danger ml-4 text-white">Logout!</a>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="container-fluid"
	style="height: 5px; background-color: #0056b3; margin-bottom: 10px; margin-top: 10px"></div>
	
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
	color: #ffffff; /* Color when hovered */
	background-color: #5aaaf9; /* Background color when hovered */
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


