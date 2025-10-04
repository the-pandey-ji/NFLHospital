<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Date Range</title>
    <script>
        function formatDateToDDMMYYYY(dateStr) {
            const [year, month, day] = dateStr.split("-");
            return `${day}${month}${year}`;
        }

        function prepareAndValidate(form) {
        	alert("check chek");
            const fromDateRaw = form.fromDate.value;
            const toDateRaw = form.toDate.value;

            if (!fromDateRaw || !toDateRaw) {
                alert("Please select both From and To dates.");
                return false;
            }

            if (fromDateRaw > toDateRaw) {
                alert("From Date cannot be after To Date.");
                return false;
            }

            // Convert to ddmmyyyy format and store in hidden inputs
            form.fromDateFormatted.value = formatDateToDDMMYYYY(fromDateRaw);
            form.toDateFormatted.value = formatDateToDDMMYYYY(toDateRaw);
            
            
            alert("FromDateFormatted: " + form.fromDateFormatted.value + "\nToDateFormatted: " + form.toDateFormatted.value);

            console.log("Formatted From Date:", form.fromDateFormatted.value);
            console.log("Formatted To Date:", form.toDateFormatted.value);
            

            return true;
        }
    </script>
</head>
<body background="../Stationery/Clear%20Day%20Bkgrd.jpg">
    <h2 align="center"><u>No of Referred Cases in Date Range</u></h2>

    <form method="POST" action="/hosp1/HOSPITAL/Reports/refered2all.jsp" onsubmit="return prepareAndValidate(this);">
        <p align="center">
            <label><b><font face="Tahoma" size="3" color="#003399">From Date:</font></b></label>
            <input type="date" name="fromDate">
        </p>
        <p align="center">
            <label><b><font face="Tahoma" size="3" color="#003399">To Date:</font></b></label>
            <input type="date" name="toDate">
        </p>

        <!-- Hidden fields to send ddmmyyyy format -->
        <input type="hidden" name="fromDateFormatted" id="fromDateFormatted">
		<input type="hidden" name="toDateFormatted" id="toDateFormatted">


        <p align="center">
            <input type="submit" value="Proceed" name="B1" style="font-family: Tahoma; font-size: 10pt; color: #3366CC; font-weight: bold">
        </p>
    </form>
</body>
</html>
