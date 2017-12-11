<%--
  Created by IntelliJ IDEA.
  User: jeehaengyoo
  Date: 11/4/17
  Time: 2:40 PM
  To change this template use File | Settings | File Templates.
--%>
<h1>You are successfully pre-registered.</h1>
<h2>You require HCP approval for full access.</h2>

<%
    AddNewPRAction.setEmailValidation(true);
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

    // Health record stores height, weight, smoking information
    HealthRecord h = new HealthRecord();
    try {
        h.setHeight(Double.valueOf(height));
        h.setWeight(Double.valueOf(weight));
        int smoker = Integer.parseInt(smoking);
        if (smoker == 1) {
            // Smoker, unknown current status
            h.setSmoker(5);
        } else {
            // Unknown if ever smoked
            h.setSmoker(9);
        }
    } catch (Exception e) {
        // Could not parse the user input
    }

    // Populate the patient bean
    if (addr1 != null)
        p.setStreetAddress1(addr1);
    if (addr2 != null)
        p.setStreetAddress2(addr2);
    if (city != null)
        p.setCity(city);
    if (state != null && !state.equals(""))
        p.setState(state);
    if (zip != null)
        p.setZip(zip);
    if (phone != null)
        p.setPhone(phone);
    if (ins_name != null)
        p.setIcName(ins_name);
    if (ins_addr1 != null)
        p.setIcAddress1(ins_addr1);
    if (ins_addr2 != null)
        p.setIcAddress2(ins_addr2);
    if (ins_city != null)
        p.setIcCity(ins_city);
    if (ins_state != null && !ins_state.equals(""))
        p.setIcState(ins_state);
    if (ins_zip != null)
        p.setIcZip(ins_zip);
    if (ins_phone != null)
        p.setIcPhone(ins_phone);

    p.setPreregistered(true);

    try {
        long newMID = new AddPatientAction(prodDAO).addPRPatient(p, h);
        loggingAction.logEvent(TransactionType.PATIENT_CREATE, newMID, newMID, "New preregistered patient");
%>
<h2>New MID: <%=newMID%></h2>
<%
} catch(FormValidationException e){
%>
<div align=center>
    <span class="iTrustError"><%=StringEscapeUtils.escapeHtml(e.getMessage()) %></span>
</div>
<%
    }

%>