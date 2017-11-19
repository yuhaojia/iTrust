<%--
  Created by IntelliJ IDEA.
  User: jeehaengyoo
  Date: 11/18/17
  Time: 2:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="edu.ncsu.csc.itrust.dao.DAOFactory"%>
<%@page import="java.util.List"%>
<%@page import="edu.ncsu.csc.itrust.beans.TransactionBean"%>
<%@page import="edu.ncsu.csc.itrust.enums.TransactionType"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="java.util.Date"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>

<%@include file="/global.jsp"%>

<%
    pageTitle = "iTrust - Transaction Log";
%>

<%@include file="/header.jsp"%>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>jQuery UI Datepicker - Default functionality</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $( function() {
            var dateFormat = "yyyy/mm/dd",
                from = $( "#startDate" )
                    .datepicker({
                        defaultDate: getDate( this ),
                        changeMonth: true,
                        changeYear: true,
                        numberOfMonths: 1,
                        maxDate: new Date()
                    })
                    .on( "change", function() {
                        to.datepicker( "option", "minDate", getDate( this ) );
                    }),
                to = $( "#endDate" ).datepicker({
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 1,
                    maxDate: new Date()
                })
                    .on( "change", function() {
                        from.datepicker( "option", "maxDate", getDate( this ) );
                    });

            function getDate( element ) {
                var date;
                try {
                    date = $.datepicker.parseDate( dateFormat, element.value );
                } catch( error ) {
                    date = null;
                }

                return date;
            }
        } );
    </script>
</head>

<h1>Transaction Log</h1>

<%
    String [] rollList = new String[]{"All", "ER", "HCP", "LT", "Patient", "PHA", "PR", "Staff", "Tester", "UAP", "Admin"};
    List<TransactionBean> list = DAOFactory.getProductionInstance().getTransactionDAO().getAllTransactions();
    String [] options = new String[5];
    if (request.getParameter("view") == null) {
        Timestamp minimum = null;
        for (TransactionBean i : list) {
            if (minimum == null) {
                minimum = i.getTimeLogged();
            } else {
                if (minimum.after(i.getTimeLogged())) {
                    minimum = i.getTimeLogged();
                }
            }
        }
        DateFormat dateForm = new SimpleDateFormat("MM/dd/yyyy");

        String prevdate = dateForm.format(minimum);
        String currdate = dateForm.format(new Date());

        options[0] = "All";
        options[1] = "All";
        options[2] = "All";
        options[3] = prevdate;
        options[4] = currdate;
    }
    else{
        options[0] = request.getParameter("rolls");
        options[1] = request.getParameter("srolls");
        options[2] = request.getParameter("ttype");
        options[3] = request.getParameter("startDate");
        options[4] = request.getParameter("endDate");
    }
%>

<div>
    <div align="center">
        <span style="font-size: 13pt; font-weight: bold;">Transaction Log Filter</span>
        <form method="post" action="transactionLogFilter.jsp?view=true">
            <table>
                <tr style="text-align: left;">
                    <td>
                        <label>Roll: </label>
                        <select name="rolls">
                            <%
                                for (String r : rollList){
                                    if (r.equals(options[0])){
                            %>
                                <option value="<%=r%>" selected><%=r%></option>
                            <%
                                    }
                                    else{
                            %>
                                <option value="<%=r%>"><%=r%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </td>
                    <td>
                        <label>Secondary Roll: </label>
                        <select name="srolls">
                            <%
                                for (String r : rollList){
                                    if (r.equals(options[1])){
                            %>
                            <option value="<%=r%>" selected><%=r%></option>
                            <%
                            }
                            else{
                            %>
                            <option value="<%=r%>"><%=r%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </td>
                    <td>
                        <label>Transaction Type: </label>
                        <select name="ttype">
                            <option value="All">All</option>
                        <%
                        for(TransactionType type : TransactionType.values()){
                            if (type.name().equals(options[2])){
                            %>
                            <option value="<%=type.getCode()%>" selected><%=type.name()%></option>
                            <%
                            }
                            else{
                        %>
                            <option value="<%=type.getCode()%>"><%=type.name()%></option>
                        <%
                                }
                        }
                        %>
                        </select>
                        <input type="hidden" name="selectedValue" value=<%=options[2]%>/>
                    </td>
                    <td>
                        <label for="startDate">Start Date: </label>
                        <input type="text" name="startDate" id="startDate" value="<%= StringEscapeUtils.escapeHtml("" + (options[3] )) %>" size="12"/>
                    </td>
                    <td>
                        <label for="endDate">End Date: </label>
                        <input type="text" name="endDate" id="endDate" value="<%= StringEscapeUtils.escapeHtml("" + (options[4] )) %>" size="12"/>
                    </td>
                </tr>
            </table>
            <tr>
                <td align="center" colspan="2">
                    <input type="submit" name="view" value="View" />
                    <input type="submit" name="summarize" value="Summarize" />
                </td>
            </tr>
        </form>
    </div>
</div>
<br />



<%
    if (request.getParameter("view") != null){
%>

<table border=1>
    <tr>
        <th>ID></th>
        <th>Time Logged</th>
        <th>Type</th>
        <th>Code</th>
        <th>Description</th>
        <th>Logged in User MID</th>
        <th>Secondary MID</th>
        <th>Extra Info</th>
    </tr>
    <%
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

        options[3] = dateFormat.format(new Date(options[3]));
        options[4] = dateFormat.format(new Date(options[4]+" 23:59:59"));

        List<TransactionBean> tlist = DAOFactory.getProductionInstance().getTransactionDAO().getFilteredTransactions(options);

        for (TransactionBean t : tlist) {
    %>
    <tr>
        <td><%= StringEscapeUtils.escapeHtml("" + (t.getTransactionID())) %></td>
        <td><%= StringEscapeUtils.escapeHtml("" + (t.getTimeLogged())) %></td>
        <td><%= StringEscapeUtils.escapeHtml("" + (t.getTransactionType().name())) %></td>
        <td><%= StringEscapeUtils.escapeHtml("" + (t.getTransactionType().getCode())) %></td>
        <td><%= StringEscapeUtils.escapeHtml("" + (t.getTransactionType().getDescription())) %></td>
        <td><%= StringEscapeUtils.escapeHtml("" + (t.getLoggedInMID())) %></td>
        <td><%= StringEscapeUtils.escapeHtml("" + (t.getSecondaryMID())) %></td>
        <td><%= StringEscapeUtils.escapeHtml("" + (t.getAddedInfo())) %></td>
    </tr>
    <%
        }

    %>
</table>
<%
    }
%>
<%@include file="/footer.jsp" %>
