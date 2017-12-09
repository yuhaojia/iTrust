        <%@taglib uri="/WEB-INF/tags.tld" prefix="itrust"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="edu.ncsu.csc.itrust.action.ViewDiagnosisStatisticsAction"%>
<%@page import="edu.ncsu.csc.itrust.beans.DiagnosisBean"%>
<%@page import="edu.ncsu.csc.itrust.beans.DiagnosisStatisticsBean"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>
<%@ page import="edu.ncsu.csc.itrust.DateUtil" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	//log the page view
	loggingAction.logEvent(TransactionType.DIAGNOSIS_TRENDS_VIEW, loggedInMID.longValue(), 0, "");

	ViewDiagnosisStatisticsAction diagnoses = new ViewDiagnosisStatisticsAction(prodDAO);
	ArrayList<DiagnosisStatisticsBean> dsBean = new ArrayList<DiagnosisStatisticsBean>();
	/*DiagnosisStatisticsBean dsBean8 = null;
	DiagnosisStatisticsBean dsBean7 = null;
	DiagnosisStatisticsBean dsBean6 = null;
	DiagnosisStatisticsBean dsBean5 = null;
	DiagnosisStatisticsBean dsBean4 = null;
	DiagnosisStatisticsBean dsBean3 = null;
	DiagnosisStatisticsBean dsBean2 = null;
	DiagnosisStatisticsBean dsBean1 = null;
	*/
	long [] count = new long [8];
	long [] countS = new long [8];


	//get form data
	String endDate = request.getParameter("endDate");

	String zipCode = request.getParameter("zipCode");
	if (zipCode == null)
		zipCode = "";

	String icdCode = request.getParameter("icdCode");


		//try to get the statistics. If there's an error, print it. If null is returned, it's the first page load
		try {

			for (int i = 0; i < 8; i++){
			dsBean.add(diagnoses.getDiagnosisStatisticsNWeeksBefore(i+1, endDate, icdCode, zipCode));
			count[i] = (long) diagnoses.getAllDiagnosisCount(i+1, endDate, icdCode);
			countS[i] = (long) diagnoses.getDiagnosisStatisticsState(i+1, endDate, icdCode,zipCode);
		}

		} catch (FormValidationException e) {
			e.printHTML(pageContext.getOut());
		}

	if (endDate == null)
		endDate = "";
	if (icdCode == null)
		icdCode = "";

%>
<br />
<form action="viewDiagnosisStatistics.jsp" method="post" id="formMain">
<input type="hidden" name="viewSelect" value="trends" />
<table class="fTable" align="center" id="diagnosisStatisticsSelectionTable">
	<tr>
		<th colspan="4">Diagnosis Statistics</th>
	</tr>
	<tr class="subHeader">
		<td>Diagnosis:</td>
		<td>
			<select name="icdCode" style="font-size:10" >
			<option value="">-- None Selected --</option>
			<%for (DiagnosisBean diag : diagnoses.getDiagnosisCodes()) { %>
				<%if (diag.getICDCode().equals(icdCode)) { %>
				<option selected="selected" value="<%=diag.getICDCode()%>">
					<%=StringEscapeUtils.escapeHtml("" + (diag.getICDCode()))%>
					- <%=StringEscapeUtils.escapeHtml("" + (diag.getDescription()))%></option>
				<% } else { %>
					<option value="<%=diag.getICDCode()%>"><%=StringEscapeUtils.escapeHtml("" + (diag.getICDCode()))%>
					- <%=StringEscapeUtils.escapeHtml("" + (diag.getDescription()))%></option>
				<% } %>
				<%}%>
			</select>
		</td>
		<td>Zip Code:</td>
		<td ><input name="zipCode" value="<%=StringEscapeUtils.escapeHtml(zipCode)%>" /></td>
	</tr>
	<tr class="subHeader">
		<td>End Date:</td>
		<td>
			<input name="endDate" value="<%=StringEscapeUtils.escapeHtml("" + (endDate))%>" size="10">
			<input type=button value="Select Date" onclick="displayDatePicker('endDate');">
		</td>
	</tr>
	<tr>
		<td colspan="4" style="text-align: center;"><input type="submit" id="select_diagnosis" value="View Statistics"></td>
	</tr>
</table>	

</form>

<br />

<% if (dsBean.get(7) != null) { %>



<table class="fTable" align="center" id="diagnosisStatisticsTable">
<tr>
	<th>Diagnosis code</th>
	<th>Complete Zip</th>
	<th>Cases in Zip</th>
	<th>Cases in Region</th>
	<th>Start Date</th>
	<th>End Date</th>
</tr>
<tr style="text-align:center;">
	<td><%=icdCode%></td>
	<td><%=zipCode%></td>
	<td><%=dsBean.get(7).getZipStats()%></td>
	<td><%=dsBean.get(7).getRegionStats()%></td>
	<td><%=endDate%></td>
</tr>

</table>

<br />
<p style="display:block; margin-left:auto; margin-right:auto; width:600px;">
<%@include file="DiagnosisTrendChart.jsp" %>
</p>
		<%} %>


<br />
<br />
