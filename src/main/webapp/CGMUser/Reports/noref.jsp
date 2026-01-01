<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Date Range</title>
 <script>
        window.onload = function () {
            const today = new Date().toISOString().split('T')[0]; // format: yyyy-mm-dd
            document.querySelector('input[name="fromDate"]').value = today;
            document.querySelector('input[name="toDate"]').value = today;
        };
    </script>
</head>
<body background="../Stationery/Clear%20Day%20Bkgrd.jpg">
<%@ include file="/navbar.jsp" %> 
    <h2 align="center"><u>No of Referred Cases in Date Range</u></h2>

    <form method="POST" action="/hosp1/HOSPITAL/Reports/refered2all.jsp" >
        <p align="center">
            <label><b><font face="Tahoma" size="3" color="#003399">From Date:</font></b></label>
            <input type="date" name="fromDate">
        </p>
        <p align="center">
            <label><b><font face="Tahoma" size="3" color="#003399">To Date:</font></b></label>
            <input type="date" name="toDate">
        </p>

        <!-- Hidden fields to send ddmmyyyy format -->
       <!--  <input type="hidden" name="fromDateFormatted" id="fromDateFormatted">
		<input type="hidden" name="toDateFormatted" id="toDateFormatted">
 -->

        <p align="center">
            <input type="submit" value="Proceed" name="B1" style="font-family: Tahoma; font-size: 10pt; color: #3366CC; font-weight: bold">
        </p>
    </form>
</body>
</html>
