<%@taglib uri="/WEB-INF/tags.tld" prefix="itrust"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="edu.ncsu.csc.itrust.action.ViewDeathTrendsAction"%>
<%@page import="edu.ncsu.csc.itrust.beans.DeathTrendsBean"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>
<%@page import="java.util.List"%>

<%@include file="/global.jsp" %>

<%
    pageTitle = "iTrust - View Cause-Of-Death Trends";
%>

<%@include file="/header.jsp" %>



<%
    // Log event !!!
    loggingAction.logEvent(TransactionType.DEATH_TRENDS_VIEW, loggedInMID.longValue(), 0, "View cause-of-death trends report");

    ViewDeathTrendsAction dtAction = new ViewDeathTrendsAction(prodDAO);
    DeathTrendsBean dtBean = null;

    String headerMessage = "";

    // Validate years here? !!!

    // Get years and gender from form data
    String startYear = request.getParameter("startYear");
    String endYear = request.getParameter("endYear");
    String gender = request.getParameter("gender");

    // Initial page load
    if (startYear == null || endYear == null || gender == null){
        gender = "both";
    }

    // Year range/gender submitted, so get death trends
    else {
        try{
            dtBean = dtAction.getDeathTrends(loggedInMID.longValue(), startYear, endYear, gender);
        } catch(FormValidationException e){
            headerMessage += e.getMessage();
            dtBean = null;
        }
    }

%>
<br />
<form action="viewDeathTrends.jsp" method="post" id="formMain">
    <table class="fTable" align="center" id="diagnosisStatisticsSelectionTable">
        <tr>
            <th colspan="6">Cause-of-Death Trends</th>
        </tr>
        <tr class="subHeader">
            <td>Start Year:</td>
            <td>
                <input name="startYear" id="start" value="<%= StringEscapeUtils.escapeHtml(((startYear)==null?"":(startYear))) %>" size="4">
            </td>
            <td>End Year:</td>
            <td>
                <input name="endYear" id="end" value="<%= StringEscapeUtils.escapeHtml(((endYear)==null?"":(endYear))) %>" size="4">
            </td>
            <td>Patient Gender:</td>
            <td>
                <%if (gender.equals("male")) { %>
                <input type="radio" name="gender" value="male" checked> Male<br>
                <% } else { %>
                <input type="radio" name="gender" value="male"> Male<br>
                <% } %>
                <%if (gender.equals("female")) { %>
                <input type="radio" name="gender" value="female" checked> Female<br>
                <% } else { %>
                <input type="radio" name="gender" value="female"> Female<br>
                <% } %>
                <%if (gender.equals("both")) { %>
                <input type="radio" name="gender" value="both" checked> Both<br>
                <% } else { %>
                <input type="radio" name="gender" value="both"> Both<br>
                <% } %>
            </td>
        </tr>
        <tr>
            <td colspan="6" style="text-align: center;"><input type="submit" id="view_death_trends" value="View Trends"></td>
        </tr>
    </table>
    <%= headerMessage.equals("") ? "" : "<br /><span id=\"validateMessage\" class=\"iTrustMessage\">"+headerMessage+"</span><br /><br />" %>
</form>
<br />

<% if (dtBean != null) {
    List<String> icdCodes = dtBean.getICDCodes();
    List<String> icdNames = dtBean.getICDNames();
    List<Long> numDeaths = dtBean.getNumDeaths();
%>

<table class="fTable" align="center" id="deathTrendsTable">
    <tr>
        <th>Diagnosis code</th>
        <th>Diagnosis name</th>
        <th>Number of deaths</th>
    </tr>

    <% for(int i=0; i < icdCodes.size(); i++) { %>
    <tr style="text-align:center;">
        <td><%= icdCodes.get(i) %></td>
        <td><%= icdNames.get(i) %></td>
        <td><%= numDeaths.get(i) %></td>
    </tr>
    <% } %>

</table>
<br />

<% } %>

<br />
<br />




<%@include file="/footer.jsp" %>
