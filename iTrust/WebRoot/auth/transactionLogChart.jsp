
<%@page import="edu.ncsu.csc.itrust.enums.TransactionType"%>
<%@page import="edu.ncsu.csc.itrust.dao.DAOFactory"%>
<%@page import="edu.ncsu.csc.itrust.beans.TransactionBean"%>
<%@page import="java.sql.Timestamp" %>
<%@page import="java.time.Month"%>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.sql.Timestamp" %>

<%@page import="java.lang.String" %>
<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.axis.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import="org.jfree.chart.labels.*" %>
<%@ page  import="org.jfree.chart.plot.*" %>
<%@ page  import="org.jfree.chart.renderer.category.*" %>
<%@ page  import="org.jfree.chart.urls.*" %>
<%@ page  import="org.jfree.data.category.*" %>
<%@ page  import="org.jfree.data.general.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="org.jfree.chart.servlet.ServletUtilities" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List" %>

<%@include file="/global.jsp"%>
<%
    pageTitle = "iTrust - Transaction Log";
%>

<%@include file="/header.jsp"%>

<%


    List<TransactionBean> list = DAOFactory.getProductionInstance().getTransactionDAO().getAllTransactions();

    double[] numRolls = new double[10];
    double[] numSecondaryRolls = new double[10];

    ArrayList<String> transactionTypeString = new ArrayList<String>();
    ArrayList<String> timeString = new ArrayList<String>();
    ArrayList<Double> numTransactionTypes = new ArrayList<Double>();
    //ArrayList<Double> numTransactionTypes = new ArrayList<Double>();
    ArrayList<Double> numTime = new ArrayList<Double>();

    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

    String[] rollList = new String[]{"ER", "HCP", "LT", "Patient", "PHA", "PR", "Staff", "Tester", "UAP", "Admin"};
    //List<TransactionType> TransactionTypeList = Arrays.asList(TransactionType.values());

    String[] options = new String[5];

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

    for (int i = 0; i < rollList.length; i++) {
        options[0] = rollList[i];
        options[1] = "All";
        options[2] = "All";
        options[3] = prevdate;
        options[3] = dateFormat.format(new Date(options[3]));
        options[4] = currdate;
        options[4] = dateFormat.format(new Date(options[4] + " 23:59:59"));

        List<TransactionBean> tlist = DAOFactory.getProductionInstance().getTransactionDAO().getFilteredTransactions(options);
        numRolls[i] = (double) tlist.size();

    }

    for (int i = 0; i < rollList.length; i++) {
        options[0] = "All";
        options[1] = rollList[i];
        options[2] = "All";
        options[3] = prevdate;
        options[3] = dateFormat.format(new Date(options[3]));
        options[4] = currdate;
        options[4] = dateFormat.format(new Date(options[4] + " 23:59:59"));
        List<TransactionBean> tlist = DAOFactory.getProductionInstance().getTransactionDAO().getFilteredTransactions(options);
        numSecondaryRolls[i] = (double) tlist.size();
    }

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

    int month2 = endDate.getMonth();
    int year2 = endDate.getYear();

    int monthIter = month1;
    int yearIter = year1;

    int monthLimit = 12;

    for(; yearIter < year2;yearIter++){
        if(yearIter > year1){
            monthIter = 0;
        }
        if(yearIter == year2)
        {
            monthLimit = month2;
        }
        for(;monthIter < monthLimit;monthIter++){
            Calendar mycal = new GregorianCalendar(yearIter, monthIter, 1);
            int daysInMonth = mycal.getActualMaximum(Calendar.DAY_OF_MONTH);
            options[0] = "All";
            options[1] = "All";
            options[2] = "All";
            options[3] = dateForm.format(new Date(yearIter, monthIter, 1));
            options[3] = dateFormat.format(new Date(options[3]));
            options[4] = dateForm.format(new Date(yearIter, daysInMonth, daysInMonth));
            options[4] = dateFormat.format(new Date(options[4] + " 23:59:59"));
            List<TransactionBean> tlist = DAOFactory.getProductionInstance().getTransactionDAO().getFilteredTransactions(options);
            if(tlist.size()!=0) {
                timeString.add("/"+monthIter+"/"+yearIter);
                Double bb = new Double((double) tlist.size());
                numTime.add(bb);

            }
            ;
        }
    }






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

    for (int i = 0; i < rollList.length; i++) {
        dataset1.addValue(numRolls[i], "roll", rollList[i]);
    }

    final CategoryAxis categoryAxis = new CategoryAxis("Roll");
    final ValueAxis valueAxis = new NumberAxis("Num");
    renderer1 = new BarRenderer();

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
        ChartUtilities.saveChartAsPNG(file1, chart1, 600, 400, info);
    } catch (Exception e) {
        out.println(e);
    }

    //SecondaryRoll BarChart
    DefaultCategoryDataset dataset2 = new DefaultCategoryDataset();

    for (int i = 0; i < rollList.length; i++) {
        dataset2.addValue(numSecondaryRolls[i], "roll", rollList[i]);
    }


    final CategoryAxis categoryAxis1 = new CategoryAxis("SRoll");
    final ValueAxis valueAxis1 = new NumberAxis("Num");
    renderer2 = new BarRenderer();

    plot2 = new CategoryPlot(dataset2, categoryAxis1, valueAxis1,
            renderer2);
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
        ChartUtilities.saveChartAsPNG(file2, chart2, 600, 400, info);
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
        ChartUtilities.saveChartAsPNG(file3, chart3, 600, 400, info);
    } catch (Exception e) {
        out.println(e);
    }

    //Time BarChart
    DefaultCategoryDataset dataset4 = new DefaultCategoryDataset();

    for (int i = 0; i < transactionTypeString.size(); i++) {
        dataset4.addValue(numTime.get(i).doubleValue(), "Type", timeString.get(i));
        %>
        <th><%=timeString.get(i)%></th>
        <th><%=numTime.get(i).doubleValue()%></th>
        <%
    }

    final CategoryAxis categoryAxis3 = new CategoryAxis("Time");
    final ValueAxis valueAxis3 = new NumberAxis("Num");
    renderer4 = new BarRenderer();

    plot4 = new CategoryPlot(dataset4, categoryAxis3, valueAxis3,
            renderer4);
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
        ChartUtilities.saveChartAsPNG(file4, chart4, 600, 400, info);
    } catch (Exception e) {
        out.println(e);
    }


%>
    <!--
    <IMG SRC="barchart.png" WIDTH="600" HEIGHT="400" BORDER="0" USEMAP="#chart">
    -->

<html>
<head>
    <meta http-equiv="Content-Type"
          content="text/html; charset=UTF-8" >
    <!meta  http-equiv="refresh" content="1">
    <title>JSP Page</title>
</head>

<body>
    <IMG SRC="barChartRoll.png" WIDTH="600"
     HEIGHT="400" BORDER="0" USEMAP="#chart">
    <IMG SRC="barChartSRoll.png" WIDTH="600"
         HEIGHT="400" BORDER="0" USEMAP="#chart">
    <IMG SRC="barChartTransLogType.png" WIDTH="600"
         HEIGHT="400" BORDER="0" USEMAP="#chart">
    <IMG SRC="barChartTime.png" WIDTH="600"
         HEIGHT="400" BORDER="0" USEMAP="#chart">

</body>
</html>

<%@include file="/footer.jsp" %>
