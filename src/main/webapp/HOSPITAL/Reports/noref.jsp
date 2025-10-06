<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Date Range</title>

</head>
<body background="../Stationery/Clear%20Day%20Bkgrd.jpg">
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
