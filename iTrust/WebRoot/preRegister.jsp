<%--
  Created by IntelliJ IDEA.
  User: jeehaengyoo
  Date: 11/3/17
  Time: 5:07 PM
  To change this template use File | Settings | File Templates.
--%>

<%@page import="edu.ncsu.csc.itrust.action.AddNewPRAction"%>
<%@page import="edu.ncsu.csc.itrust.enums.TransactionType"%>
<%@ page import="edu.ncsu.csc.itrust.dao.mysql.PatientDAO" %>
<%@ page import="edu.ncsu.csc.itrust.beans.PatientBean" %>

<%@include file="/global.jsp" %>

<%
pageTitle = "iTrust - Preregister";
loggingAction.logEvent(TransactionType.HOME_VIEW, 0, 0, "PR Home");
%>

<%
String email = request.getParameter("j_email");
String pass = request.getParameter("j_password");
String passverif = request.getParameter("j_passwordverif");

if (pass.equals(passverif) && AddNewPRAction.validateEmail(email)){
    AddNewPRAction.setIsNewPR(true);
%>

<%@include file="/header.jsp" %>
<h1>You are successfully pre-registered.</h1>
<%@include file="/footer.jsp" %>
<%
    AddNewPRAction.setEmailValidation(true);
    String lastname = request.getParameter("j_lastname");
    String firstname = request.getParameter("j_firstname");
    String addr1 = request.getParameter("j_address1");
    String addr2 = request.getParameter("j_address2");
    String city = request.getParameter("j_city");
    String state = request.getParameter("j_state");
    String zip = request.getParameter("j_zip");
    String phone = request.getParameter("j_phone");

    String ins_name = request.getParameter("j_insurance_name");
    String ins_addr1 = request.getParameter("j_insurance_address1");
    String ins_addr2 = request.getParameter("j_insurance_address2");
    String ins_city = request.getParameter("j_insurance_city");
    String ins_state = request.getParameter("j_insurance_state");
    String ins_zip = request.getParameter("j_insurance_zip");
    String ins_phone = request.getParameter("j_insurance_phone");

    String height = request.getParameter("j_height");
    String weight = request.getParameter("j_weight");
    String smoking = request.getParameter("smoking");

    PatientBean p = new PatientBean();

    p.setFirstName(firstname);
    p.setLastName(lastname);
    p.setStreetAddress1(addr1);
    p.setStreetAddress2(addr2);
    p.setCity(city);
    p.setState(state);
    p.setZip(zip);
    p.setPhone(phone);

    p.setIcName(ins_name);
    p.setIcAddress1(ins_addr1);
    p.setIcAddress2(ins_addr2);
    p.setIcCity(ins_city);
    p.setIcState(ins_state);
    p.setIcZip(ins_zip);
    p.setIcPhone(ins_phone);


    }
else {
    if (!AddNewPRAction.validateEmail(email)) {
        AddNewPRAction.setEmailValidation(false);
    }
    response.sendRedirect("auth/forwardUser.jsp");
}
%>
