
<html>
<head>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
        google.charts.load('current', {'packages':['bar']});
        google.charts.setOnLoadCallback(drawChart);

<%

	long[][] DiagnosisBeanInt;
	if (view.equalsIgnoreCase("trends")) {

	DiagnosisBeanInt = new long[8][3];

	DiagnosisBeanInt[0][0] = dsBean8.getZipStats()-dsBean7.getZipStats();
	DiagnosisBeanInt[0][1] = dsBean8.getRegionStats()-dsBean7.getRegionStats();
	DiagnosisBeanInt[0][2] = 1;

	DiagnosisBeanInt[1][0] = dsBean7.getZipStats()-dsBean6.getZipStats();
	DiagnosisBeanInt[1][1] = dsBean7.getRegionStats()-dsBean6.getRegionStats();
	DiagnosisBeanInt[1][2] = 1;

	DiagnosisBeanInt[2][0] = dsBean6.getZipStats()-dsBean5.getZipStats();
	DiagnosisBeanInt[2][1] = dsBean6.getRegionStats()-dsBean5.getRegionStats();
	DiagnosisBeanInt[2][2] = 1;

	DiagnosisBeanInt[3][0] = dsBean5.getZipStats()-dsBean4.getZipStats();
	DiagnosisBeanInt[3][1] = dsBean5.getRegionStats()-dsBean4.getRegionStats();
	DiagnosisBeanInt[3][2] = 1;

	DiagnosisBeanInt[4][0] = dsBean4.getZipStats()-dsBean3.getZipStats();
	DiagnosisBeanInt[4][1] = dsBean4.getRegionStats()-dsBean3.getRegionStats();
	DiagnosisBeanInt[4][2] = 1;

	DiagnosisBeanInt[5][0] = dsBean3.getZipStats()-dsBean2.getZipStats();
	DiagnosisBeanInt[5][1] = dsBean3.getRegionStats()-dsBean2.getRegionStats();
	DiagnosisBeanInt[5][2] = 1;

	DiagnosisBeanInt[6][0] = dsBean2.getZipStats()-dsBean1.getZipStats();
	DiagnosisBeanInt[6][1] = dsBean2.getRegionStats()-dsBean1.getRegionStats();
	DiagnosisBeanInt[6][2] = 1;

	DiagnosisBeanInt[7][0] = dsBean1.getZipStats();
	DiagnosisBeanInt[7][1] = dsBean1.getRegionStats();
	DiagnosisBeanInt[7][2] = 1;

	} else {

	return;

	}


%>

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Week', 'Zip', 'Region', 'All'],
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
                    title: 'The trends in diagnoses',
                    subtitle: 'Count of diagnose in past 8 month',
                },
                bars: 'horizontal' // Required for Material Bar Charts.
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
</html>