<%--
  Created by IntelliJ IDEA.
  User: kmahesh3
  Date: 11/4/17
  Time: 5:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib uri="/WEB-INF/tags.tld" prefix="itrust"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="edu.ncsu.csc.itrust.beans.PatientBean"%>
<%@page import="edu.ncsu.csc.itrust.beans.PatientVisitBean"%>
<%@ page import="edu.ncsu.csc.itrust.action.*" %>

<%@include file="/global.jsp" %>

<%
    pageTitle = "iTrust - View All Preregistered Patients";
%>

<%@include file="/header.jsp" %>

<%
    ViewPreregisteredPatientsAction action = new ViewPreregisteredPatientsAction(prodDAO, loggedInMID.longValue());
    List<PatientBean> patients = action.getPreregisteredPatients();

    ViewPatientOfficeVisitHistoryAction action2 = new ViewPatientOfficeVisitHistoryAction(prodDAO, loggedInMID.longValue());
    List<PatientVisitBean> patientVisits2 = action2.getPatients();


    loggingAction.logEvent(TransactionType.PATIENT_LIST_VIEW, loggedInMID, 0, "");

%>
<script src="/iTrust/DataTables/media/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script type="text/javascript">
    jQuery.fn.dataTableExt.oSort['lname-asc']  = function(x,y) {
        var a = x.split(" ");
        var b = y.split(" ");
        return ((a[1] < b[1]) ? -1 : ((a[1] > b[1]) ?  1 : 0));
    };

    jQuery.fn.dataTableExt.oSort['lname-desc']  = function(x,y) {
        var a = x.split(" ");
        var b = y.split(" ");
        return ((a[1] < b[1]) ? 1 : ((a[1] > b[1]) ?  -1 : 0));
    };
</script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#patientList").dataTable( {
            "aaColumns": [ [2,'dsc'] ],
            "aoColumns": [ { "sType": "lname" }, null, null],
            "bStateSave": true,
            "sPaginationType": "full_numbers"
        });
    });
</script>
<style type="text/css" title="currentStyle">
    @import "/iTrust/DataTables/media/css/demo_table.css";
</style>

<br />
<h2>Preregistered Patients</h2>
<form action="viewReport.jsp" method="post" name="myform">
    <table class="display fTable" id="patientList" align="center">
        <thead>


        <tr class="">
            <th>Name</th>
            <th>Address</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Insurance Name</th>
            <th>Insurance Address</th>
            <th>Insurance Phone</th>
            <th>Height</th>
            <th>Weight</th>
            <th>Smoker</th>

        </tr>
        </thead>
        <tbody>
        <%
            int index = 0;
            for (PatientBean bean : patients) {
        %>
        <tr>
            <td >
                <a href="editPHR.jsp?patient=<%= StringEscapeUtils.escapeHtml("" + (index)) %>">


                    <%= StringEscapeUtils.escapeHtml("" + (bean.getFullName())) %>


                </a>
            </td>
            <td ><%= StringEscapeUtils.escapeHtml("" + (bean.getIcAddress1() )) %></td>
            <td ><%= StringEscapeUtils.escapeHtml("" + (bean.getEmail() )) %></td>
            <td ><%= StringEscapeUtils.escapeHtml("" + (bean.getPhone() )) %></td>
            <td ><%= StringEscapeUtils.escapeHtml("" + (bean.getIcName() )) %></td>
            <td ><%= StringEscapeUtils.escapeHtml("" + (bean.getIcAddress1() )) %></td>
            <td ><%= StringEscapeUtils.escapeHtml("" + (bean.getIcPhone() )) %></td>
            <td ><%= StringEscapeUtils.escapeHtml("" + (bean.getHeight() )) %></td>
            <td ><%= StringEscapeUtils.escapeHtml("" + (bean.getWeight() )) %></td>
            <td ><%= StringEscapeUtils.escapeHtml("" + (bean.getSmoker() )) %></td>
            
        </tr>
        <%
                index ++;
            }
            session.setAttribute("patients", patients);
        %>
        </tbody>
    </table>
</form>
<br />
<br />

<%@include file="/footer.jsp" %>






