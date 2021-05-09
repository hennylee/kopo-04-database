<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
  <head>
    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script type="text/javascript">
  
    $(document).ready(function(){
    	$.ajax({
    		url : "chart",
    		dataType : "JSON",
    		success : function(result) {
    			//alert(result);
    			google.charts.load('current', {packages: ['corechart']});
    			google.charts.setOnLoadCallback(function(){
    				drawChart(result);
    			});
    			   
    			function drawChart(result){
	    			var data = new google.visualization.DataTable();
	                data.addColumn('string', 'custom_region');
	                //data.addColumn('string', 'custom_gender');
	                data.addColumn('number', 'total');
	                //data.addColumn('string', 'age_range');
	               
	                var dataArray = [];
	                
	                $.each(result, function (i, obj) {
	                	dataArray.push([ obj.custom_region, 
	                		obj.total ]);
	                });
	                data.addRows(dataArray);
	                
	                var options = {
	                        title: "지역별 고객 수",
	                        width: 600,
	                        height: 400,
	                        bar: {groupWidth: "95%"},
	                        legend: { position: "none" },
	                };
    			
	                var barchart = new google.visualization.BarChart(document.getElementById('barchart_div'));
	                barchart.draw(data, options);
    			}
    	
    		}
    	})
    
    });
    </script>
  </head>
  <body>
    <div id="barchart_div"></div>
  </body>
</html>