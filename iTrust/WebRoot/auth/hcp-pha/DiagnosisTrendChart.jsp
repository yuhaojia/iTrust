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

	//Get the number of diagnoses by weeks in region, state and all area
	long[][] DiagnosisBeanInt;
	if (view.equalsIgnoreCase("trends")) {
		DiagnosisBeanInt = new long[8][3];
		for(int i = 0; i<7;i++){
			//DiagnosisBeanInt[i][0] = dsBean.get(7-i).getZipStats()-dsBean.get(6-i).getZipStats();

			DiagnosisBeanInt[i][0] = dsBean.get(7-i).getRegionStats()-dsBean.get(6-i).getRegionStats();
			DiagnosisBeanInt[i][1] = countS[7-i]-countS[6-i];
			DiagnosisBeanInt[i][2] = count[7-i]-count[6-i];
		}

		//DiagnosisBeanInt[7][0] = dsBean.get(0).getZipStats()
		DiagnosisBeanInt[7][0] = dsBean.get(0).getRegionStats();
		DiagnosisBeanInt[7][1] = countS[0];
		DiagnosisBeanInt[7][2] = count[0];



	} else {

		return;

	}

%>

<html>
<head>
	<!-- Barchart border -->
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
        google.charts.load('current', {'packages':['bar']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Week', 'Region', 'State', 'All'],
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
