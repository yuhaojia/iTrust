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
<%@ page import="java.util.*" %>
<%@page import="java.lang.String" %>
<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.axis.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import="org.jfree.chart.plot.*" %>
<%@ page  import="org.jfree.chart.renderer.category.*" %>
<%@ page  import="org.jfree.data.category.*" %>


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
            var dateFormat = "mm/dd/yy",
                from = $( "#startDate" )
                    .datepicker({
                        defaultDate: "+1w",
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

    //All roles used to ouput bar chart
    String [] rollList1 = new String[]{"ER", "HCP", "LT", "Patient", "PHA", "PR", "Staff", "Tester", "UAP", "Admin"};
    List<TransactionBean> list = DAOFactory.getProductionInstance().getTransactionDAO().getAllTransactions();

    //number of transaction logs of each rolls and second rolls
    double[] numRolls = new double[10];
    double[] numSecondaryRolls = new double[10];

    //The name of transactionType and time whose value is not 0
    ArrayList<String> transactionTypeString = new ArrayList<String>();
    ArrayList<String> timeString = new ArrayList<String>();

    //The number value of transactionType and time whose value is not 0
    ArrayList<Double> numTransactionTypes = new ArrayList<Double>();
    ArrayList<Double> numTime = new ArrayList<Double>();

    String [] options = new String[5];

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

    if (request.getParameter("view") == null && request.getParameter("summarize") == null) {

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
        <!--<form method="post" action="transactionLogFilter.jsp?view=true">-->
        <form method="post" action="transactionLogFilter.jsp">
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
                            if (!options[2].equals("All") && type.getCode() == Integer.valueOf(options[2])){
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
    if ((request.getParameter("view") != null)){
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

        options[3] = dateFormat.format(new Date(options[3]));
        options[4] = dateFormat.format(new Date(options[4]+" 23:59:59"));
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

    //Click the summarize button
    else if(request.getParameter("summarize") != null){

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

        //get all TransactionBean num according to roll
        for (int i = 0; i < rollList1.length; i++) {
            options[0] = rollList1[i];
            options[1] = "All";
            options[2] = "All";
            options[3] = prevdate;
            options[3] = dateFormat.format(new Date(options[3]));
            options[4] = currdate;
            options[4] = dateFormat.format(new Date(options[4] + " 23:59:59"));

            List<TransactionBean> tlist = DAOFactory.getProductionInstance().getTransactionDAO().getFilteredTransactions(options);
            numRolls[i] = (double) tlist.size();


        }

        //get all TransactionBean num according to second roll
        for (int i = 0; i < rollList1.length; i++) {
            options[0] = "All";
            options[1] = rollList1[i];
            options[2] = "All";
            options[3] = prevdate;
            options[3] = dateFormat.format(new Date(options[3]));
            options[4] = currdate;
            options[4] = dateFormat.format(new Date(options[4] + " 23:59:59"));
            List<TransactionBean> tlist = DAOFactory.getProductionInstance().getTransactionDAO().getFilteredTransactions(options);
            numSecondaryRolls[i] = (double) tlist.size();



        }

        //get all TransactionBean num according to type
        for (TransactionType type : TransactionType.values()) {

            options[0] = "All";
            options[1] = "All";
            options[2] = ""+type.getCode();
            options[3] = prevdate;
            options[3] = dateFormat.format(new Date(options[3]));
            options[4] = currdate;
            options[4] = dateFormat.format(new Date(options[4] + " 23:59:59"));
            List<TransactionBean> tlist = DAOFactory.getProductionInstance().getTransactionDAO().getFilteredTransactions(options);
            if(tlist.size()!=0) {
                transactionTypeString.add(""+type.getCode());
                Double bb = new Double((double) tlist.size());
                numTransactionTypes.add(bb);


            }

        }

        //String prevdate = dateForm.format(minimum);
        //String currdate = dateForm.format(new Date());

        Date startDate = new Date(prevdate);
        Date dateIteration = new Date(prevdate);
        Date dateIterationEnd = new Date(prevdate);
        Date endDate = new Date(currdate);

        int month1 = startDate.getMonth();
        int year1 = startDate.getYear();

        //int month2 = endDate.getMonth();
        int year2 = endDate.getYear();

        int monthIter = month1;
        int yearIter = year1;

        int monthLimit = 12;

        //get all TransactionBean num according to time
        for(; yearIter <= year2;yearIter++){

            /*if(yearIter == year2)
            {
                monthLimit = month2;
            }*/
            for(monthIter = 0;monthIter < monthLimit;monthIter++){
                Calendar mycal = new GregorianCalendar(yearIter, monthIter, 1);
                int daysInMonth = mycal.getActualMaximum(Calendar.DAY_OF_MONTH);
                options[0] = "All";
                options[1] = "All";
                options[2] = "All";
                options[3] = dateForm.format(new Date(yearIter, monthIter, 1));
                options[3] = dateFormat.format(new Date(options[3]));
                options[4] = dateForm.format(new Date(yearIter, monthIter, daysInMonth));
                options[4] = dateFormat.format(new Date(options[4] + " 23:59:59"));
                List<TransactionBean> tlist = DAOFactory.getProductionInstance().getTransactionDAO().getFilteredTransactions(options);
                if(tlist.size()!=0) {
                    int monthIterA = monthIter+1;
                    int yearIterA = yearIter+1900;
                timeString.add(monthIterA+"/"+yearIterA);
                Double bb = new Double((double) tlist.size());
                numTime.add(bb);

            }
            ;
        }
    }

    //start output the bar chart
    JFreeChart chart1 = null;
    JFreeChart chart2 = null;
    JFreeChart chart3 = null;
    JFreeChart chart4 = null;
    BarRenderer renderer1 = null;
    BarRenderer renderer2 = null;
    BarRenderer renderer3 = null;
    BarRenderer renderer4 = null;
    CategoryPlot plot1 = null;
    CategoryPlot plot2 = null;
    CategoryPlot plot3 = null;
    CategoryPlot plot4 = null;

    //Roll BarChart
    DefaultCategoryDataset dataset1 = new DefaultCategoryDataset();

    for (int i = 0; i < rollList1.length; i++) {
        dataset1.addValue(numRolls[i], "roll", rollList1[i]);
    }

    final CategoryAxis categoryAxis = new CategoryAxis("Roll");
    final ValueAxis valueAxis = new NumberAxis("Num");
    renderer1 = new BarRenderer();
        renderer1.setItemMargin(-2);

    plot1 = new CategoryPlot(dataset1, categoryAxis, valueAxis,
            renderer1);
    plot1.setOrientation(PlotOrientation.VERTICAL);
    chart1 = new JFreeChart("Number of Tranaction Log in each roll", JFreeChart.DEFAULT_TITLE_FONT,
            plot1, true);

    chart1.setBackgroundPaint(new Color(249, 231, 236));

    Paint p1 = new GradientPaint(
            0.0f, 0.0f, new Color(244, 0, 24), 0.0f, 0.0f, new Color
            (244, 0, 24));

    renderer1.setSeriesPaint(1, p1);

    plot1.setRenderer(renderer1);

    String path1 = null;
    try {
        final ChartRenderingInfo info = new ChartRenderingInfo
                (new StandardEntityCollection());
        path1 = getServletConfig().getServletContext().getRealPath("/auth/barChartRoll.png");
        File file1 = new File(path1);
        //new File( servletContext.getRealPath( "/text.XML" ) );
        ChartUtilities.saveChartAsPNG(file1, chart1, 1000, 400, info);
    } catch (Exception e) {
        out.println(e);
    }

    //SecondaryRoll BarChart
    DefaultCategoryDataset dataset2 = new DefaultCategoryDataset();

    for (int i = 0; i < rollList1.length; i++) {
        dataset2.addValue(numSecondaryRolls[i], "roll", rollList1[i]);
    }


    final CategoryAxis categoryAxis1 = new CategoryAxis("SRoll");
    final ValueAxis valueAxis1 = new NumberAxis("Num");
    renderer2 = new BarRenderer();

    plot2 = new CategoryPlot(dataset2, categoryAxis1, valueAxis1,
            renderer2);
        renderer2.setItemMargin(-2);
    plot2.setOrientation(PlotOrientation.VERTICAL);
    chart2 = new JFreeChart("Number of Tranaction Log in each Secondary roll", JFreeChart.DEFAULT_TITLE_FONT,
            plot2, true);

    chart2.setBackgroundPaint(new Color(249, 231, 236));

    /*Paint p2 = new GradientPaint(
            0.0f, 0.0f, new Color(16, 89, 172), 0.0f, 0.0f, new Color
            (201, 201, 244));*/
    Paint p2 = new GradientPaint(
            0.0f, 0.0f, new Color(0, 44, 255), 0.0f, 0.0f, new Color
            (0, 44, 255));

    renderer2.setSeriesPaint(1, p2);

    plot2.setRenderer(renderer2);

    String path2 = null;
    try {
        final ChartRenderingInfo info = new ChartRenderingInfo
                (new StandardEntityCollection());
        path2 = getServletConfig().getServletContext().getRealPath("/auth/barChartSRoll.png");
        File file2 = new File(path2);
        //new File( servletContext.getRealPath( "/text.XML" ) );
        ChartUtilities.saveChartAsPNG(file2, chart2, 1000, 400, info);
    } catch (Exception e) {
        out.println(e);
    }

    //Transaction Type BarChart
    DefaultCategoryDataset dataset3 = new DefaultCategoryDataset();

    for (int i = 0; i < transactionTypeString.size(); i++) {
        dataset3.addValue(numTransactionTypes.get(i).doubleValue(), "Type", transactionTypeString.get(i));
    }

    final CategoryAxis categoryAxis2 = new CategoryAxis("Type");
    final ValueAxis valueAxis2 = new NumberAxis("Num");
    renderer3 = new BarRenderer();

    plot3 = new CategoryPlot(dataset3, categoryAxis2, valueAxis2,
            renderer3);
        renderer2.setItemMargin(-2);
    plot3.setOrientation(PlotOrientation.VERTICAL);
    chart3 = new JFreeChart("Number of Tranaction Log in each type", JFreeChart.DEFAULT_TITLE_FONT,
            plot3, true);

    chart3.setBackgroundPaint(new Color(255, 249, 252));

    /*Paint p2 = new GradientPaint(
            0.0f, 0.0f, new Color(16, 89, 172), 0.0f, 0.0f, new Color
            (201, 201, 244));*/
    Paint p3 = new GradientPaint(
            0.0f, 0.0f, new Color(20, 255, 0), 0.0f, 0.0f, new Color
            (20, 255, 0));

    renderer3.setSeriesPaint(1, p3);

    plot3.setRenderer(renderer3);

    String path3 = null;
    try {
        final ChartRenderingInfo info = new ChartRenderingInfo
                (new StandardEntityCollection());
        path3 = getServletConfig().getServletContext().getRealPath("/auth/barChartTransLogType.png");
        File file3 = new File(path3);
        //new File( servletContext.getRealPath( "/text.XML" ) );
        ChartUtilities.saveChartAsPNG(file3, chart3, 1000, 400, info);
    } catch (Exception e) {
        out.println(e);
    }

    //Time BarChart
    DefaultCategoryDataset dataset4 = new DefaultCategoryDataset();

    for (int i = 0; i < timeString.size(); i++) {
        dataset4.addValue(numTime.get(i).doubleValue(), "Time", timeString.get(i));
    }

    final CategoryAxis categoryAxis3 = new CategoryAxis("Time");
    final ValueAxis valueAxis3 = new NumberAxis("Num");
    renderer4 = new BarRenderer();

    plot4 = new CategoryPlot(dataset4, categoryAxis3, valueAxis3,
            renderer4);
        renderer4.setItemMargin(-2);
    plot4.setOrientation(PlotOrientation.VERTICAL);
    chart4 = new JFreeChart("Number of Tranaction Log in each /Month/Year", JFreeChart.DEFAULT_TITLE_FONT,
            plot4, true);

    chart4.setBackgroundPaint(new Color(255, 249, 252));

    /*Paint p2 = new GradientPaint(
            0.0f, 0.0f, new Color(16, 89, 172), 0.0f, 0.0f, new Color
            (201, 201, 244));*/
    Paint p4 = new GradientPaint(
            0.0f, 0.0f, new Color(20, 255, 0), 0.0f, 0.0f, new Color
            (20, 255, 0));

    renderer4.setSeriesPaint(1, p4);

    plot4.setRenderer(renderer4);

    String path4 = null;
    try {
        final ChartRenderingInfo info = new ChartRenderingInfo
                (new StandardEntityCollection());
        path4 = getServletConfig().getServletContext().getRealPath("/auth/barChartTime.png");
        File file4 = new File(path4);
        //new File( servletContext.getRealPath( "/text.XML" ) );
        ChartUtilities.saveChartAsPNG(file4, chart4, 1000, 400, info);
    } catch (Exception e) {
        out.println(e);
    }

%>
<!-- Barchart border -->
<IMG SRC="barChartRoll.png" WIDTH="1000"
     HEIGHT="400" BORDER="0" USEMAP="#chart">
<IMG SRC="barChartSRoll.png" WIDTH="1000"
     HEIGHT="400" BORDER="0" USEMAP="#chart">
<IMG SRC="barChartTransLogType.png" WIDTH="1000"
     HEIGHT="400" BORDER="0" USEMAP="#chart">
<IMG SRC="barChartTime.png" WIDTH="1000"
     HEIGHT="400" BORDER="0" USEMAP="#chart">
<!-- <table>
-->
<%

    }
%>
<%@include file="/footer.jsp" %>
