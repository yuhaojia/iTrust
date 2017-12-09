<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="edu.ncsu.csc.itrust.beans.DiagnosisStatisticsBean"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewDiagnosisStatisticsAction"%>
<%@page import="edu.ncsu.csc.itrust.charts.DiagnosisTrendData" %>

<%

	DiagnosisStatisticsBean avgBean = null;


%>

<!-- Use this tag to specify the location of the dataset for the chart -->
<jsp:useBean id="DSchart" class="edu.ncsu.csc.itrust.charts.DiagnosisTrendData"/>

<%

	// This calls the class from the useBean tag and initializes the Adverse Event list and pres/immu name


/*
	if ( view.equalsIgnoreCase("trends") ) {

		DSchart.initializeDiagnosisStatistics(dsBean8, view);

	} else  {

		return;

	}
	*/

	long[][] DiagnosisBeanInt;
	if (view.equalsIgnoreCase("trends")) {
		DiagnosisBeanInt = new long[8][3];
		for(int i = 0; i<7;i++){
			DiagnosisBeanInt[i][0] = dsBean.get(7-i).getZipStats()-dsBean.get(6-i).getZipStats();
			DiagnosisBeanInt[i][1] = dsBean.get(7-i).getRegionStats()-dsBean.get(6-i).getRegionStats();
			DiagnosisBeanInt[i][2] = count[7-i]-count[6-i];
		}

		DiagnosisBeanInt[7][0] = dsBean.get(0).getZipStats();
		DiagnosisBeanInt[7][1] = dsBean.get(0).getRegionStats();
		DiagnosisBeanInt[7][2] = count[0];


/*
		DSchart.initializeDiagnosisStatistics(dsBean8, view);

		DiagnosisBeanInt[0][0] = dsBean8.getZipStats()-dsBean7.getZipStats();
		DiagnosisBeanInt[0][1] = dsBean8.getRegionStats()-dsBean7.getRegionStats();
		DiagnosisBeanInt[0][2] = count[7]-count[6];

		DSchart.initializeDiagnosisStatistics(dsBean7, view);

		DiagnosisBeanInt[1][0] = dsBean7.getZipStats()-dsBean6.getZipStats();
		DiagnosisBeanInt[1][1] = dsBean7.getRegionStats()-dsBean6.getRegionStats();
		DiagnosisBeanInt[1][2] = count[6]-count[5];

		DSchart.initializeDiagnosisStatistics(dsBean6, view);

		DiagnosisBeanInt[2][0] = dsBean6.getZipStats()-dsBean5.getZipStats();
		DiagnosisBeanInt[2][1] = dsBean6.getRegionStats()-dsBean5.getRegionStats();
		DiagnosisBeanInt[2][2] = count[5]-count[4];

		DSchart.initializeDiagnosisStatistics(dsBean5, view);

		DiagnosisBeanInt[3][0] = dsBean5.getZipStats()-dsBean4.getZipStats();
		DiagnosisBeanInt[3][1] = dsBean5.getRegionStats()-dsBean4.getRegionStats();
		DiagnosisBeanInt[3][2] = count[4]-count[3];

		DSchart.initializeDiagnosisStatistics(dsBean4, view);

		DiagnosisBeanInt[4][0] = dsBean4.getZipStats()-dsBean3.getZipStats();
		DiagnosisBeanInt[4][1] = dsBean4.getRegionStats()-dsBean3.getRegionStats();
		DiagnosisBeanInt[4][2] = count[3]-count[2];

		DSchart.initializeDiagnosisStatistics(dsBean3, view);

		DiagnosisBeanInt[5][0] = dsBean3.getZipStats()-dsBean2.getZipStats();
		DiagnosisBeanInt[5][1] = dsBean3.getRegionStats()-dsBean2.getRegionStats();
		DiagnosisBeanInt[5][2] = count[2]-count[1];

		DSchart.initializeDiagnosisStatistics(dsBean2, view);

		DiagnosisBeanInt[6][0] = dsBean2.getZipStats()-dsBean1.getZipStats();
		DiagnosisBeanInt[6][1] = dsBean2.getRegionStats()-dsBean1.getRegionStats();
		DiagnosisBeanInt[6][2] = count[1]-count[0];

		DSchart.initializeDiagnosisStatistics(dsBean1, view);

		DiagnosisBeanInt[7][0] = dsBean1.getZipStats();
		DiagnosisBeanInt[7][1] = dsBean1.getRegionStats();
		DiagnosisBeanInt[7][2] = count[0];
*/
	} else {

		return;

	}

%>

<html>
<head>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
        google.charts.load('current', {'packages':['bar']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Week', 'ZIP', 'Region', 'All'],
                ['WEEK-8', <%=DiagnosisBeanInt[0][0]%>, <%=DiagnosisBeanInt[0][1]%>, <%=DiagnosisBeanInt[0][2]%>],
                ['WEEK-7', <%=DiagnosisBeanInt[1][0]%>, <%=DiagnosisBeanInt[1][1]%>, <%=DiagnosisBeanInt[1][2]%>],
                ['WEEK-6', <%=DiagnosisBeanInt[2][0]%>, <%=DiagnosisBeanInt[2][1]%>, <%=DiagnosisBeanInt[2][2]%>],
                ['WEEK-5', <%=DiagnosisBeanInt[3][0]%>, <%=DiagnosisBeanInt[3][1]%>, <%=DiagnosisBeanInt[3][2]%>],
                ['WEEK-4', <%=DiagnosisBeanInt[4][0]%>, <%=DiagnosisBeanInt[4][1]%>, <%=DiagnosisBeanInt[4][2]%>],
                ['WEEK-3', <%=DiagnosisBeanInt[5][0]%>, <%=DiagnosisBeanInt[5][1]%>, <%=DiagnosisBeanInt[5][2]%>],
                ['WEEK-2', <%=DiagnosisBeanInt[6][0]%>, <%=DiagnosisBeanInt[6][1]%>, <%=DiagnosisBeanInt[6][2]%>],
                ['WEEK-1', <%=DiagnosisBeanInt[7][0]%>, <%=DiagnosisBeanInt[7][1]%>, <%=DiagnosisBeanInt[7][2]%>]

            ]);

            var options = {
                chart: {
                    title: 'Examine recent trends in diagnoses',
                    subtitle: 'Count in last 8 week',
                },
                bars: 'vertical' // Required for Material Bar Charts.
            };

            var chart = new google.charts.Bar(document.getElementById('barchart_material'));

            chart.draw(data, google.charts.Bar.convertOptions(options));
        }
	</script>
</head>
<body>
<div id="barchart_material" style="width: 900px; height: 500px;"></div>
</body>
</html>
