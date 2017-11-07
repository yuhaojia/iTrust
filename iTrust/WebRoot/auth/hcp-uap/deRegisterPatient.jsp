<%--
  Created by IntelliJ IDEA.
  User: kmahesh3
  Date: 11/6/17
  Time: 4:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib uri="/WEB-INF/tags.tld" prefix="itrust"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>
<%@page import="java.util.List"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewPrescriptionRecordsAction"%>
<%@page import="edu.ncsu.csc.itrust.beans.PrescriptionBean"%>
<%@page import="edu.ncsu.csc.itrust.beans.PatientBean"%>
<%@page import="edu.ncsu.csc.itrust.dao.mysql.PatientDAO"%>
<%@page import="edu.ncsu.csc.itrust.action.EditPHRAction"%>


<%@include file="/global.jsp" %>

<%
    pageTitle = "iTrust - DeRegister Patient";
%>



<%@include file="/header.jsp" %>
<itrust:patientNav thisTitle="Registering"/>
<div align=center>
    <h1>Patient is DeRegistered</h1>
    <%
        String pidString = (String)session.getAttribute("pid");
        PatientDAO patientDAO = new PatientDAO(prodDAO);
        EditPHRAction action = new EditPHRAction(prodDAO,loggedInMID.longValue(), pidString);
        PatientBean patient = action.getPatient();

        patient.setPreregistered(true);
        patientDAO.editPatient(patient,loggedInMID);%>


</div>

<%@include file="/footer.jsp" %>
