<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.util.List"%>

<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Properties"%>
<%@ page import="com.youtube.adk.Search"%>
<%@ page import="com.google.api.services.youtube.model.VideoListResponse"%>
<%@ page import="com.google.api.services.youtube.model.Video"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html lang="en">
<head>
<title>Image Database</title>
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
	function getSearch() {
		var text;
		var dataList = document.getElementById('json');
		var input = document.getElementById('search');
		//var apiKey="AIzaSyBaVwTy7gUwhXcbYwcQ1PdlYGGUOhGDBzo";
		text = document.getElementById("search").value;
		if (text == "") {
			var childArray = dataList.children;
			while (childArray.length > 0) {
				dataList.removeChild(childArray[0]);
			}
		}
		$
				.ajax({
					url : "http://suggestqueries.google.com/complete/search?client=youtube&ds=yt&q="
							+ text,
					type : 'GET',
					dataType : 'jsonp',
					success : function disp(data) {
						var i = 0;
						while (i < data[1].length) {
							var option = document.createElement('option');
							option.value = data[1][i][0];
							dataList.appendChild(option);
							//  alert(data[1][i][0]);
							i++;

						}

					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {

					}

				});

	}

	function searchQuery() {
		alert("BALU");
		console.log("invoked searchQuery");
	}
</script>
</head>

<body>

	<%
	     VideoListResponse resultList=null;
		//String user=request.getParameter("login");
		String user=null;
		String search=null;
		if (session.getAttribute("login") != null) {
			
			user = session.getAttribute("login").toString();
			search = request.getParameter("search");
//			out.println("Search: " + search);	
			if (search != null) {
				Search sObj = new Search();
				if(sObj != null){
					//out.println("sObj not null");
					resultList = sObj.getSearchResult(search.toString());
					if(resultList != null)
					{
						//out.println("Search result: "+resultList.toPrettyString());
					}
				}
				//out.println(search.toString());
			}

			//String pass = request.getParameter("password");

		//	}
				
		} else {
			     user=request.getParameter("login");
			   if (user != null) {
				String check = request.getParameter("rem");
				session.setAttribute("login", user);
				session.setAttribute("check", check);
				 try
		            {
		             String url = "http://localhost:8080/youtuberest/webresources/youtube/count?email="+ user;
		             String newURL = url.replaceAll(" ", "%20");
		             URL dest = new URL(newURL);
		             URLConnection yc = dest.openConnection();
		             BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream()));
		             String inputLine="";
		             String getData="";
		             int i=0;
		             while ((inputLine = in.readLine()) != null)
		               {
		                 getData+=inputLine;
		                 i++;
		               }
		             in.close();
		             i=0;
		            }
		            catch(Exception e)
		             {
		               out.println(e);
		              }
				
				
				//out.println("USER : " + user);
				if (check != null) {
					byte[] bytes = user.getBytes();
					String encodedCredentials = com.youtube.adk.Base64
							.encodeBytes(bytes);
					Cookie cookie = new Cookie("ytube", encodedCredentials);
					cookie.setMaxAge(60 * 60 * 24 * 15);
					response.addCookie(cookie);
				}
			
			}
			else
			{
				//out.println("Redirecting..");
			
		%>
	<jsp:forward page="index.jsp" /> 
	<%
		}}
	%>
	<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<p class="navbar-brand">
				<font size=3>Welcome
				<%=session.getAttribute("login").toString()%>,</font>
			</p>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<form class="navbar-form navbar-left" role="search"
				action="userhome.jsp">
				<div class="form-group">
					<font color="white" size=4"><a href="dashboard.jsp">DashBoard  </a>
					<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
				<a href="http://youtube.com"> YouTube</a></font> <b>&nbsp;&nbsp;</b><input type="text" class="form-control"
						list="json" id="search" name="search" onkeydown="getSearch()"
						onkeyup="getSearch()">
					<datalist id="json"></datalist>
				</div>
				<button type="submit" class="btn btn-default">Search</button>
			</form>

			<ul class="nav navbar-nav navbar-right">
				<li><a href="logout.jsp">LogOut</a></li>
			</ul>

		</div>
	</div>
	</nav>
	
	
<div class="container">
  <div class="row">
    <div class="col-md-12">   
      <div class="panel">
          
          
          <%
          if(resultList != null){
        	  %>
     <div class="panel-body" style="background-image: url(content/bg1.jpg); height: auto; width: auto; border: 1px solid black;">
          <!--/stories-->
           	  
	<h3 align="center">
	<font color="#FFFFFF"> Search Results</font></h3>
	<%
        	  //out.println(resultList.toString());
            List<Video> videoList = resultList.getItems();
            Iterator<Video> videoIterator = videoList.iterator();
            while(videoIterator.hasNext())
            {
            	Video item = videoIterator.next();
            	String datep = item.getSnippet().getPublishedAt().toString();
            	String[] values = datep.split("-");
            	java.util.Date ndate = new java.util.Date(); 
                int year = Integer.parseInt(values[0]);
                int month = Integer.parseInt(values[1]);
                int day = Integer.parseInt(values[2].substring(0,2));
                int diff = (ndate.getYear()) + 1900 - year;
				if(diff == 0)
				{
					diff=1;
				}
				long aviews = diff*365;
                long nviews = Long.parseLong(item.getStatistics().getViewCount().toString());
                aviews = (int)nviews/aviews;
            	int length = item.getSnippet().getDescription().length();
            	if(length > 200)
            	{
            		length=200;
            	}
            	%>
            	<div class="row">    
            <br>
            <div class="col-md-2 col-sm-3 text-center">
              <a class="story-title" href="https://www.youtube.com/watch?v=<%=item.getId() %>"><img alt="" src='<%=item.getSnippet().getThumbnails().getHigh().getUrl() %>' style="width:150px;height:150px" ></a>
            </div>
            <div class="col-md-10 col-sm-9">
            
              <h3></h3>
              <div class="row">
                <div class="col-xs-9">
                <font color="white">
                  <table>
                  <tr><td></td></tr>
                  <tr><td><a style="color:#B45F04" href="https://www.youtube.com/watch?v=<%=item.getId() %>"><%=item.getSnippet().getTitle() %></a></td></tr>
                  <tr><td><%=item.getSnippet().getChannelTitle() %></td></tr>
                  <tr><td><%=item.getStatistics().getViewCount() %>, views</td></tr>
                  <tr><td><%=aviews %>, Average Views</td></tr>
                  <tr><td><%=item.getStatistics().getLikeCount() %>, likes</td></tr>
                  <tr><td><%=item.getSnippet().getDescription().substring(0, length) %></td></tr>
                  
                  </table>
                  </font>
                  </div>
                <div class="col-xs-3"></div>
                
              </div>
              <br><br>
            </div>
          </div>
	<% 
            }
            
            
           if(search != null){ 
            try
            {
             String url = "http://localhost:8080/youtuberest/webresources/youtube/update?email="+ user + "&search=" + search;
             String newURL = url.replaceAll(" ", "%20");
             URL dest = new URL(newURL);
             URLConnection yc = dest.openConnection();
             BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream()));
             String inputLine="";
             String getData="";
             int i=0;
             while ((inputLine = in.readLine()) != null)
               {
                 getData+=inputLine;
                 i++;
               }
             in.close();
             i=0;
            }
            catch(Exception e)
             {
               out.println(e);
              }

            
          }
           }
          %>
       </div>
	</div>
	</div>
	</div>
	</div>
	</body>
	</html>
	