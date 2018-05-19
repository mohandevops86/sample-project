<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%	
	//String loginAutocomplete = (String) application.getAttribute("loginAutocompleteUrl");
	String impersonateAutocomplete = (String) application.getAttribute("impersonateAutocompleteUrl");
	String it_help_desk_email = (String) application.getAttribute("it_help_desk_email");
	String loggedInAbn = (String) session.getAttribute("abn8");
%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>TRAC/TIME TRAC REPORT</title>
<link rel="stylesheet" type="text/css" href="css/styles.css" />
<link rel="stylesheet" href="css/jquery-ui.css">
<link rel="stylesheet" href="css/jquery-ui.min.css">
 <script src="js/jquery-1.11.1.min.js"></script>  
<script src="js/jquery-ui.min.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/placeholders.jquery.min.js"></script>
<script src="js/moment.min.js"></script>
<script src="js/filesaver.js"></script>
<script src="js/sorttable.js" type="text/javascript" charset="utf-8"></script>

<script>
var subordinateName = true;


	$(function() {

		$( "#from" ).datepicker();
		$( "#to" ).datepicker();/*
		var dateFormat = "mm/dd/yy", from = $("#from").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			numberOfMonths : 1
		}).on("change", function() {
			to.datepicker("option", "minDate", getDate(this));
		}), to = $("#to").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			numberOfMonths : 1
		}).on("change", function() {
			from.datepicker("option", "maxDate", getDate(this));
		});

		function getDate(element) {
			var date;
			try {
				date = $.datepicker.parseDate(dateFormat, element.value);
			} catch (error) {
				date = null;
			}

			return date;
		}*/
	});

	function fnExcelReport(id, name){
		
		 var tab_text = '<html xmlns:x="urn:schemas-microsoft-com:office:excel">';
		  tab_text = tab_text + '<head><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>';
		  tab_text = tab_text + '<x:Name>Sheet1</x:Name>';
		  tab_text = tab_text + '<x:WorksheetOptions><x:Panes></x:Panes></x:WorksheetOptions></x:ExcelWorksheet>';
		  tab_text = tab_text + '</x:ExcelWorksheets></x:ExcelWorkbook></xml></head><body>';
		  tab_text = tab_text + "<table border='2px'><tr bgcolor='#87AFC6'>";
		  var exportTable = $('#' + id).clone();
		  exportTable.find('input').each(function (index, elem) { $(elem).remove(); });
		  tab_text = tab_text + exportTable.html();
		  tab_text = tab_text + '</table></body></html>';
		  var fileName = name + '.xls';

		  //Save the file
		  var blob = new Blob([tab_text], { type: "application/vnd.ms-excel;charset=utf-8" })
		  window.saveAs(blob, fileName);
			}


	
	/* function fnExcelReport() {
		var tab_text = "<table border='2px'><tr bgcolor='#87AFC6'>";
		var textRange;
		var j = 0;
		tab = document.getElementById('myTable'); // id of table

		for (j = 0; j < tab.rows.length; j++) {
			tab_text = tab_text + tab.rows[j].innerHTML + "</tr>";
			//tab_text=tab_text+"</tr>";
		}

		tab_text = tab_text + "</table>";
		var ua = window.navigator.userAgent;
		var msie = ua.indexOf("MSIE ");

		if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer
		{
			txtArea1.document.open("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "replace");
			txtArea1.document.write(tab_text);
			txtArea1.document.close();
			txtArea1.focus();
			sa = txtArea1.document.execCommand("SaveAs", true,
					"DSITracReport.xlsx");
		} else
			//other browser not tested on IE 11
			sa = window.open('data:application/vnd.ms-excel,'
					+ encodeURIComponent(tab_text));

		return (sa);
	}
 */
	function fnClearAutotypeText(){
		 document.getElementById("autotype").value = "";
		 
	}

	function fnCheckImpUserValue(){

		var startDateStr = document.getElementById("from").value;
		var endDateStr = document.getElementById("to").value;
		document.getElementById("autotypeNotEmpty").innerHTML = "";
		document.getElementById("noSuchSubordinates").innerHTML = "";
		document.getElementById("atleast3Letters").innerHTML = "";
		if(document.getElementById("impUser").checked){
				var autotypestr = document.getElementById("autotype").value;
				if(autotypestr.length > 0){
					autotypestr = autotypestr.trim();
					if(autotypestr.length < 3){
						document.getElementById("atleast3Letters").innerHTML = "<b>Please type atleast 3 letters of the last name.</b>";
						document.getElementById("autotype").focus();
						return false;
					}
				}
				if(autotypestr === "Type atleast 3 letters of the last name.."){
					document.getElementById("autotype").value = "";
					document.getElementById("autotypeNotEmpty").innerHTML = "<b>Please enter the user to impersonate, or select 'My Report'.</b>";
					document.getElementById("displayDataFor").innerHTML = "";
					document.getElementById("autotype").focus();
					return false;
				}
				if(autotypestr == ""){
					document.getElementById("autotypeNotEmpty").innerHTML = "<b>Please enter the user to impersonate, or select 'My Report'.</b>";
					document.getElementById("displayDataFor").innerHTML = "";
					document.getElementById("autotype").focus();
					return false;
				}
				if(subordinateName == false){
					document.getElementById("noSuchSubordinates").innerHTML = "<b>No assigned employees by that name. Please try some other name.</b>";
					document.getElementById("autotype").focus();
			       	return false;
				}
				
		}
		if(document.getElementById("from").value == ""){
			document.getElementById("fromToDatesReq").innerHTML = "<b>Start Date field is mandatory. Please enter 'Start Date'.</b>";
			document.getElementById("from").focus();
			return false;
		}
		if(document.getElementById("to").value == ""){
			document.getElementById("fromToDatesReq").innerHTML = "<b>End Date field is mandatory. Please enter 'End Date'.</b>";
			document.getElementById("to").focus();
			return false;
		}
		 // mm/dd/yyyy length is 10
	
		if((startDateStr.length < 10) || (startDateStr.length > 10)){
			document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter 'Start Date' in mm/dd/yyyy format only.</b>";
			
			return false;
		}
		if((endDateStr.length < 10 ) ||((endDateStr.length > 10))){
			document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter 'End Date' in mm/dd/yyyy format only.</b>";
			
			return false;
		} 
		if(moment(startDateStr).isAfter(endDateStr)){
			document.getElementById("fromToDatesReq").innerHTML = "<b>'Start Date' should be before 'End Date'. Please enter valid Start and End Dates.</b>";
			return false;
		}
		var numberPattern = '[0123456789]';
		var pat = "^[0-9\/]*$";
	    if(startDateStr.match(pat) == null){
	    	document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter only numbers for Start Date in format mm/dd/yyyy.</b>";
	    	document.getElementById("from").focus();
	    	return false;
		} 
	    if(endDateStr.match(pat) == null){
	    	document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter only numbers for End Date in format mm/dd/yyyy.</b>";
	    	document.getElementById("to").focus();
	    	return false;
		}
		if(startDateStr.match(numberPattern) != null){
			var sDate = startDateStr.split("/");
			var month = sDate[0]; 
			var day = sDate[1]; //var dayPattern = '[1-31]';
			var year = sDate[2];// var yearPattern = '[0-9]';
			var leap = leapYear(year);
			//alert(month+","+day+","+year);

			if((month.match(numberPattern) == null) || (day.match(numberPattern) == null) || (year.match(numberPattern) == null)){
				document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter only numbers for Start Date.</b>";
				document.getElementById("from").focus();
				return false;
			}
			if(day > 0 && day < 10 && day.length == 1){
					day = '0' + day;
			}
			if(month < 10 && month.length == 1){
				month = '0' + month;
			}
			if(year.length == 2){
				year = '20' + year;
			}
			document.getElementById("from").value = month + "/" + day + "/" + year;
			startDateStr = month + "/" + day + "/" + year;
			
			if(month.length!=2 || month > 12 || month < 01){
			 		document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid month('mm') between 01-12 for 'Start Date'.</b>";
			 		document.getElementById("from").focus();
			 		return false;
			}
				//document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid day('dd') for 'Start Date'.</b>";
		 		//return false;
			
			//if(year.length == 2){
		//	year = '20' + year;
		 		//document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid year('yyyy') for 'Start Date'.</b>";
		 		// return false;
		//	}
			//if(year.length!=4 && year < 1900){
				
		 		//document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid year('yyyy') for 'Start Date'.</b>";
		 		// return false;
			//}
			
			if(month == 02 && leap  && (day > 29 || day < 01)){
				document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid day('dd') between 01-29 in Feb month for 'Start Date'.</b>";
				document.getElementById("from").focus();
				return false;
			}
			if(month == 02 && !(leap) && (day > 28 || day < 01)){
				document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid day('dd') between 01-28 in Feb month for 'Start Date'.</b>";
				document.getElementById("from").focus();
				return false;
			}
			if((month == 01 || month == 03 || month == 05 || month == 07 || month == 08 || month == 10 || month == 12) && (day > 31 || day < 01)){
				document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid day('dd') between 01-31 for 'Start Date'.</b>";
				document.getElementById("from").focus();
				return false;
			}
			if((month == 04 || month == 06 || month == 09 || month == 11) && (day > 30 || day < 01)){
				document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid day('dd') between 01-30 for 'Start Date'.</b>";
				return false;
			}
		}

		if(endDateStr.match(numberPattern) != null){
			var sDate = endDateStr.split("/");
			var month= sDate[0]; 
			var day = sDate[1]; //var dayPattern = '[1-31]';
			var year = sDate[2];// var yearPattern = '[0-9]';
			var leap = leapYear(year);
			//alert(month+","+day+","+year);

			if((month.match(numberPattern) == null) || (day.match(numberPattern) == null) || (year.match(numberPattern) == null)){
				document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter only numbers for End Date.</b>";
				document.getElementById("to").focus();
				return false;
			}
			if(day > 0 && day < 10 && day.length == 1){
				day = '0' + day;
			}
			if(month < 10 && month.length == 1){
				month = '0' + month;
			}
			if(year.length == 2){
				year = '20' + year;
			}
			document.getElementById("to").value = month + "/" + day + "/" + year;
			endDateStr = month + "/" + day + "/" + year;
		
			if(month.length!=2 || month > 12 || month < 01){
			 	document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid month('mm') between 01-12 for 'End Date'.</b>";
			 	document.getElementById("to").focus();
			 	return false;
			}
			if(day.length!=2){
		 		document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid day('dd') for 'End Date'.</b>";
		 		document.getElementById("to").focus();
		 		return false;
			}
			if(year.length!=4 || year < 1900){
		 		document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid year('yyyy') for 'End Date'.</b>";
		 		document.getElementById("to").focus();
		 		return false;
			}
			if(month == 02 && leap  && (day > 29  || day < 01)){
				document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid day('dd') between 01-29 in Feb month for 'End Date'.</b>";
				document.getElementById("to").focus();
				return false;
			}
			if(month == 02 && !(leap) && (day > 28 || day < 01)){
				document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid day('dd') between 01-28 in Feb month for 'End Date'.</b>";
				document.getElementById("to").focus();
				return false;
			}
			if((month == 01 || month == 03 || month == 05 || month == 07 || month == 08 || month == 10 || month == 12) && (day > 31 || day < 01)){
				document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid day('dd') between 01-31 for 'End Date'.</b>";
				document.getElementById("to").focus();
				return false;
			}
			if((month == 04 || month == 06 || month == 09 || month == 11) && (day > 30 || day < 01)){
				document.getElementById("fromToDatesReq").innerHTML = "<b>Please enter a valid day('dd') between 01-30 for 'End Date'.</b>";
				document.getElementById("to").focus();
				return false;
			}
		}
		
      }
	
	 function leapYear( year)
     {
	   	  return  ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
     }
   
	function fnComputeTotal() {
		var totalHrsMins = "${totalHHMM}";
		var totalRDH = "${totalRDHHHMM}";
		var startDate = "${from}";
		var endDate = "${to}";
		var abn = "${abn}";
		var name = "${displayName}";
		var impersonate = "${impersonate}";
		var autotype = "${autotype}";
		
		
		/****To comment later******/
		var totalhundredMinHrs = "${totalHrsDecimals}";
		//		document.getElementById("durationHours").innerHTML = "<B>" + totalHrs
		//			+ "</B>";
		 
		document.getElementById("durationHoursMinutes").innerHTML = "<B>"
				+ totalHrsMins + "</B>";
		document.getElementById("totalRequestedDurationHours").innerHTML = "<B>"
				+ totalRDH + "</B>";
		if(startDate == "")	{
			var dayOfWeek = moment().day();
			if(dayOfWeek == 0)
				dayOfWeek = 7;	
			document.getElementById("from").value = moment().subtract(dayOfWeek, 'days').format("MM/DD/YYYY");
		}
		else
			document.getElementById("from").value = startDate;
		if(endDate == "")
			document.getElementById("to").value = moment().format("MM/DD/YYYY");
		else
			document.getElementById("to").value = endDate;
		if(impersonate=="0"){
			document.getElementById("impUser").checked = true;
			document.getElementById("autotype").value =  autotype;
		}
		if(impersonate=="1"){
			document.getElementById("none").checked = true;
		}
		//document.getElementById("abn").value = abn;
		/****To comment later******/
		document.getElementById("displayDataFor").innerHTML = "Showing Data for: <B>" + name + "</B>";
		console.log("logged in user id - <%=loggedInAbn%>");
		$.ajax({
			url : "<%=impersonateAutocomplete%>",
			type : "GET",
			data : { user : "", userid: "<%=loggedInAbn%>", contextAppName: "TimeTracReporting"},
			dataType : "jsonp",
			success : function(data) {
						//console.log(data);
						//console.log(data.totalRecords);
						 if(data.totalRecords > 0) {
				        	 $(".impersonateForHROnly").show();
					     } else {
					      	 $(".impersonateForHROnly").hide();
						 }
			       },   
				error: function(jqXHR, textStatus, errorThrown){
		        alert("ERROR!!! \n \n System Error code: " + jqXHR.status + "\n \n Please contact your Server administrator. <%=it_help_desk_email%> ");                        
		    }
		});
		
	}

	$(document).ready(						
					function() {
						    window.history.forward(1); 
							$(function() {
								$("#autotype").autocomplete(	{
													source : function(request,response) {
													if (request.term.length < 3) {
												        //don't do anything
												        return;
												      }
												      

														$.ajax({
															url : "<%=impersonateAutocomplete%>",
															type : "GET",
															data : { user : request.term, userid: "<%=loggedInAbn%>", contextAppName: "TimeTracReporting" },
															dataType : "jsonp",
															success : function(data) {
																		//console.log(data);
																         response(data.jdeUserLoginDDDTOList);
																         if(data.jdeUserLoginDDDTOList.length == 0){
																        	 subordinateName = false;
																	         return false;
																         }
																         if(data.jdeUserLoginDDDTOList.length > 0){
																        	 document.getElementById("noSuchSubordinates").innerHTML = "";
																        	 document.getElementById("autotypeNotEmpty").innerHTML = "";
																        	 document.getElementById("atleast3Letters").innerHTML = "";
																        	 subordinateName = true;
																         }
																         
															            },   
															error: function(jqXHR, textStatus, errorThrown){
											                    alert("ERROR!!! \n \n System Error code: " + jqXHR.status + "\n \n Please contact your Server administrator. <%=it_help_desk_email%> ");                        
											                }
														});
													},
									autoFocus : true,
									scroll : true
								});
							});
					});


	
</script>
<style>
table.sortable tbody tr:nth-child(2n) td {
	background: #e6e6e6;
	font-family: Tahoma;
	font-size: 14px;
}

table.sortable tbody tr:nth-child(2n+1) td {
	background: white;
	font-family: Tahoma;
	font-size: 14px;
}

</style>

</head>
<body onLoad="fnComputeTotal()">

	<div class="header">
		<div class="login-logo">
			<img src="images/logo2.png" alt="Stewart &amp; Stevenson" />
		</div>
		<div class="login-logo-center-text">Stewart &amp; Stevenson</div>
		<div class="user-info">
			<div class="username">
				<div class="logout">
					<a href="logout.action">Logout</a>
				</div>
				<br>
			</div>
		</div>
		<div class="display-user-info">
			<div class="displayname">
				<div class="dataFor">
					<p id="displayDataFor"> </p>
				</div>
				<br>
			</div>
		</div>
	</div>
	<center>
		<div class="sub-header">
			<div style="color: #48694d; font-size: 18px">
				<b>TRAC/TIME TRAC REPORT</b>
			</div>
		</div>
		<br> <br>
		<form id="inputForm" method="POST" action="report.action">
			<!-- ****To comment later******  -->
			 <!-- <label for="abn"><b>ABN:</b></label> <input type="text" id="abn"
				name="abn"> <br> <br>  -->
			<!-- ****To comment later******  -->
		<div class = "impersonateForHROnly" align="left">
		<div class="center">
		<b>
			Select 'My Report' to see your report.<br/>
			Select 'Impersonate', enter the name of the Employee to see his/her report.<br/>
		</b></div>
	<!-- 	<p class="instruction-report" align="left"><b>
			 <ul>
				<li>Select 'My Report' to see your report. </li>
			 	<li>Select 'Retrieve Company Report' to see the whole company's report. </li>
			 	<li>Select 'Impersonate', enter the name of the Employee to see his/her report. </li>
			 </ul>
			 </b></p> -->
				<input type="radio" name="impersonate" id="none" value="1" checked onclick="if(this.checked){fnClearAutotypeText()}"/>
				<label class="labelClass" for="none"><b>My Report</b></label>
				<br/>
				<input type="radio" name="impersonate" id="company" value="2" onclick="if(this.checked){fnClearAutotypeText()}"/>
				<label class="labelClass" for="company"><b>Retrieve Company Report</b></label>
				<br/>
				<br/>
				<div class="center">
				<b>Select 'Impersonate', enter the name of the Employee to see his/her report.<br/>
				</b></div>
				<input type="radio" name="impersonate" id="impUser" value="0" />
				<label class="labelClass" for="impersonateLabel"><b>Impersonate</b></label>
				<br/>
				<input type="text" style="width:250px;padding:5px;" id = "autotype" name ="autotype" placeholder="Type atleast 3 letters of the last name.."/>
				
		 	<p class="autotypeNotEmpty" id="autotypeNotEmpty"></p>
		 	<p class="autotypeNotEmpty" id="noSuchSubordinates"></p>
		 	<p class="autotypeNotEmpty" id="atleast3Letters"></p>
		 
		 </div>
			<!-- 	<p class="instruction-report" style="width:1000px;" align="center"><b>Select from Calendar or type the Start and End dates(in mm/dd/yyyy format) for which you would like to see the Trac/TimeTrac Reports.</b></p> -->
			<!-- <p class="instruction-report" align="left"> -->
			<div class="center"><b>Select from Calendar or type the Start and End dates(in mm/dd/yyyy format) for which you would like to see the Trac/TimeTrac Reports.</b></p>
			<p class="instruction-report-info" align="center"><b>DSI Time worked information will only populate for hourly employees. <br/>Due to system limitations,you will only be able to pull DSI time worked data for the last 120 days.</b></p>
			</div>
			<label class="labelClass" for="from"><b>Start Date:</b></label> <input
				type="text" id="from" name="from"  /> &nbsp;&nbsp; <label class="labelClass" for="to"><b>End
					Date:</b></label> <input type="text" id="to" name="to" /> &nbsp;&nbsp; <input class="btnClass" 
				type="submit" value="Get Report" id="btnGetReport" onClick=" return fnCheckImpUserValue();"/> &nbsp;&nbsp;
		<p class="autotypeNotEmpty" id="fromToDatesReq"></p>
		</form>
		
	<div class="center"><b>
	<b>INSTRUCTIONS: </b>
	<ul>
	<li>Click on the column header below (Type, Start Date - Day of Week, etc.) to sort that particular column.</li>
	<li>Click on "Export to Excel" button to export the report to excel and sort and filter the information.</li>
	<li>Click on the printer icon(next to the Export to Excel button) to print the report.</li>
	</ul>
	<p class="instruction-report-info" align="left">Hours Requested may be different from the Hours Duration if the hourly employees' time has been automatically "trimmed" in the system. Click here to see more details on trimming.</p>
	</b></div>
	<p class="instruction-report" style="width:1000px;">
	<iframe id="txtArea1" style="display: none"></iframe>&nbsp;&nbsp; 
	&nbsp;&nbsp;<a href="javascript:window.print();"><img class="imgClass" 
				src='images/images.jpg' width='15' height='15' style="border-color: #FFFFFF;float:right;" /></a>&nbsp;&nbsp;
	<button  class="btnClass" id="btnExport" onclick="javascript:fnExcelReport('myTable', 'DSI Trac Report');" style="float:right">Export to
				Excel</button> 
	</p>
	
	
	<table id="myTable" class="sortable" bgcolor="black" width="1100px">
			<thead>
				<tr
					style="background-color: #5e8cba; color: white; text-align: center;font-family:Tahoma;font-size: 12px;"
					height="40px">

					<th width="170px"><B>Name</B></th>
					<th width="150px"><B>Type</B></th>
					<th width="170px"><B>Start Date - Day of Week</B></th>
					<th width="100px"><B>Start Time</B></th>
					<th width="100px"><B>End Time</B></th>
					<!--<th width="100px"><B>Duration in 100min Hours</B></th> -->
					<th width="100px"><B>Hours Requested in HH:MM</B></th>
					<th width="100px"><B>Duration in HH:MM</B></th>
					<th width="100px"><B>Originator</B></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${mergedList}" var="merged">
					<tr
						style="background-color: white; color: black; text-align: center; font-size: 14px;font-family:Tahoma;font-size: 12px;"
						height="18px">

						<td><c:out value="${merged.name}" /></td>
						<td><c:out value="${merged.type}" /></td>
						<td align="left">&nbsp;&nbsp;<c:out
								value="${merged.startDate}" /></td>
						<td><c:out value="${merged.startTimeHHMM}" /></td>
						<td><c:out value="${merged.endTimeHHMM}" /></td>
						<!-- <td><c:out value="${merged.hundredMinuteHours}" /></td>  -->
						<td><c:out value="${merged.requestedDurationHours}" /></td>
						<td><c:out value="${merged.hoursMinutes}" /></td>
						<td><c:out value="${merged.transactionOriginator}" /></td>
						
					</tr>
				</c:forEach>
			<tfoot>
				<tr style="background-color: white; color: black; font-size: 14px;font-family:Tahoma;font-size: 12px;">
					<td colspan="5" align="right"><b>Total:</b> 
					<td id="totalRequestedDurationHours" align="center"></td>   
					<td id="durationHoursMinutes" align="center"></td>
					<td></td>
				</tr>
			</tfoot>
			</tbody>
		</table>
		<br> <br> <br> <br> <br> <br>
	</center>
</body>
</html>