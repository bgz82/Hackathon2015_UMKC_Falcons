<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
   <!-- <script type="text/javascript" src="https://www.google.com/jsapi"></script> --> 
     <script type="text/javascript" src="https://www.google.com/jsapi?autoload={'modules':[{'name':'visualization','version':'1.1','packages':['bar']}]}"></script>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
     <meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap-theme.css"></script>

<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
         
    <script type="text/javascript">
    google.setOnLoadCallback(drawStuff);

    function drawStuff() {
    	
    	var users=null;
    	var counts=null;
    	var list;
    	$
		.ajax({
			url : "http://localhost:8080/youtuberestservice/webresources/youtube/usercount",
			type : 'GET',
			async: false,
			success : function disp(data) {
				list = data.split("*");
				counts = list[0].split(";");
				users = list[1].split(";");
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(errorThrown);
			}
		});
    	
      var data = new google.visualization.DataTable();
      var i=0;
      data.addColumn('string', 'Frequency');
      data.addColumn('number', 'Count');
      data.addRows(users.length-1);
      while(i < users.length-1)
      {
    	data.setCell(i,0,users[i]);
    	data.setCell(i,1,counts[i]);
    	i++;
      }
      var options = {
        title: 'Users Login Frequency',
        width: 400,
        legend: { position: 'none' },
        chart: { title: 'Users Login frequency',
                },
        bars: 'vertical', // Required for Material Bar Charts.
        axes: {
          y: {
            0: { side: 'top', label: 'Login Count'} // Top x-axis.
          }
        },
        bar: { Width: "100%" }
      };

      var chart = new google.charts.Bar(document.getElementById('top_x_div'));
      chart.draw(data, options);
    };
    
    </script>
    
    
    <nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<form class="navbar-form navbar-left" role="search"
				action="userhome.jsp">
				<div class="form-group">
					<font color="white" size=4"><a href="userhome.jsp">HOME  </a>
					<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
				<a href="dashboard.jsp"> DASHBOARD</a></font> <b>&nbsp;&nbsp;</b>
				
				</div>
				
			</form>

			<ul class="nav navbar-nav navbar-right">
				<li><a href="logout.jsp">LogOut</a></li>
			</ul>
		</div>
	</div>
	</nav>
    
  </head>




  <body>
 <br><br><br><br><br><br>
       <div id="top_x_div" style="width: 900px; height: 500px;"></div>

  </body>
</html>