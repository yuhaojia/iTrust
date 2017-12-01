<%--
  Created by IntelliJ IDEA.
  User: jeehaengyoo
  Date: 11/3/17
  Time: 5:07 PM
  To change this template use File | Settings | File Templates.
--%>

<%@page import="edu.ncsu.csc.itrust.enums.TransactionType"%>
<%@ page import="edu.ncsu.csc.itrust.dao.mysql.PatientDAO" %>
<%@ page import="edu.ncsu.csc.itrust.beans.PatientBean" %>
<%@ page import="edu.ncsu.csc.itrust.action.AddPatientAction" %>
<%@ page import="edu.ncsu.csc.itrust.exception.FormValidationException" %>
<%@ page import="edu.ncsu.csc.itrust.BeanBuilder" %>
<%@ page import="edu.ncsu.csc.itrust.beans.HealthRecord" %>
<%@ page import="edu.ncsu.csc.itrust.beans.EmailAddressBean" %>
<%@ page import="edu.ncsu.csc.itrust.dao.mysql.EmailAddressDAO" %>

<%@include file="/global.jsp" %>

<%
pageTitle = "iTrust - Preregister";
loggingAction.logEvent(TransactionType.HOME_VIEW, 0, 0, "PR Home");
%>

<%
String email = request.getParameter("j_email");
String pass = request.getParameter("j_pass");
String passverif = request.getParameter("j_passwordverif");
String lastname = request.getParameter("j_lastname");
String firstname = request.getParameter("j_firstname");

Boolean loginFlag = true;


// Patient bean stores all information that is not in health record
PatientBean p = new BeanBuilder<PatientBean>().build(request.getParameterMap(), new PatientBean());
p.setFirstName(firstname);
p.setLastName(lastname);
p.setPassword(pass);
p.setEmail(email);

if (lastname.isEmpty() || firstname.isEmpty() || pass.isEmpty() || passverif.isEmpty() || email.isEmpty()){
    loginFlag = false;
    AddNewPRAction.setReqFields(false);
}
else {
    AddNewPRAction.setReqFields(true);
}
if (!pass.equals(passverif) && !pass.isEmpty()){
    loginFlag = false;
    AddNewPRAction.setPwMatch(false);
}
else {
    AddNewPRAction.setPwMatch(true);
    }
if(!AddNewPRAction.validateEmail(email) || !new AddPatientAction(prodDAO).checkPatientEmailIsUnique(p)) {
    loginFlag = false;
    AddNewPRAction.setEmailValidation(false);
}
else{
    AddNewPRAction.setEmailValidation(true);
}

if (loginFlag){
    AddNewPRAction.setIsNewPR(true);
%>

<%@include file="/header.jsp" %>
<%@include file="/auth/pr/home.jsp"%>
<%@include file="/footer.jsp" %>
<%
    AddNewPRAction.setIsNewPR(false);
}
    else {
        response.sendRedirect("auth/forwardUser.jsp");
    }


%>
