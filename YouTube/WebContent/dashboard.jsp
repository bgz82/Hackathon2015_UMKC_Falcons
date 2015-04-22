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
<%@ page
	import="com.google.api.services.youtube.model.VideoListResponse"%>
<%@ page import="com.google.api.services.youtube.model.Video"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 //EN">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>DashBoard</title>
    <!-- Bootstrap Styles-->
    <link href="content/style/ihover.css" rel="stylesheet">
    <link href="content/style/ihover.min.css" rel="stylesheet">
    <link href="content/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="content/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Morris Chart Styles-->
    <link href="content/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="content/assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
</head>

<body>
    <div id="wrapper">
        <nav class="navbar navbar-default top-navbar" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="userhome.jsp">Home</a>
            </div>

<ul class="nav navbar-top-links navbar-right">
      <font size=4><a href="userFrequency.jsp">Login User Stats</a></font> &nbsp;&nbsp;&nbsp;
                <font size=4><a href="logout.jsp"><i class="fa fa-user fa-fw"></i>LogOut</a></font>
                <!-- <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="#"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    /.dropdown-user
                </li>
                 --><!-- /.dropdown -->
            </ul>
        </nav>
        <!--/. NAV TOP  -->
		
				
		
		<%
		VideoListResponse[] resultList = null;
		//String user=request.getParameter("login");
		String[] fcList=null;
		ArrayList<String> chan = new ArrayList<String>();
		ArrayList<String> keylist = new ArrayList<String>();
		ArrayList<Video> cList = new ArrayList<Video>();
		List<Video> vList = new ArrayList<Video>();
		String user = null;
		String search = null;
		String[] resultKey=null;
		String[] date=null;
		String[] Menu=null;
		ArrayList<ArrayList<String>> searches=null ;
		ArrayList<String> searchList=null ;
		
		if (session.getAttribute("login") != null) {
			user = session.getAttribute("login").toString();
			search = request.getParameter("search");

			try {
				String url = "http://localhost:8080/youtuberestservice/webresources/youtube/search?email="
						+ user;
				String newURL = url.replaceAll(" ", "%20");
				String[] kwords;
				URL dest = new URL(newURL);
				URLConnection yc = dest.openConnection();
				BufferedReader in = new BufferedReader(
						new InputStreamReader(yc.getInputStream()));
				String inputLine = "";
				String getData = "";
				int i = 0;
				while ((inputLine = in.readLine()) != null) {
					getData += inputLine;
					i++;
				}
				in.close();
				i = 0;
				if (getData == null || getData.equals("1") || getData.equals("")) {
					%>
									<h3 align="center">No Recent Search Data Available</h3>
									<%
						} else {
								
							JSONArray jsonList;
							try {
								jsonList = new JSONArray(getData);
								date =new String[jsonList.length()];
								searches = new ArrayList<ArrayList<String>>();
								searchList = new ArrayList<String>();
									for (i = 0; i < jsonList.length(); i++) {
										   JSONObject video = jsonList.getJSONObject(i);
				                           date[i] = video.getString("tdate");
				                           String slist1 = video.getString("searchterms");
				                           if(!slist1.equals("[ \"\"]")){
				                        	   //out.println("NAME : " + slist1);
				                           String slist2 = slist1.substring(1, slist1.length()-1);
				                           String slist3 = slist2.replaceAll("\"", "");
				                           String slist[] = slist3.split(",");
				                           for(int j=0; j < slist.length; j++)
				                           {
				                        	   searchList.add(slist[j]);
				                        	   keylist.add(slist[j]);
				                           }
				                           
				                           searches.add(searchList);
				                           searchList = new ArrayList<String>();
				                           }
									   }
									
							} catch (JSONException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							
							
								i=0;
								int j=0;
								List<String> comb = new ArrayList<String>();
								while(i < searches.size())
								{
									String[] temp = searches.get(i).get(0).split(" ");
									j=i+1;
									//out.print("TEMP VALUE : " + searches.get(i).get(0));
									comb.add(i, i + "");
									while(j < searches.size())
									{
										//out.print("TEMP VALUE1 : " + searches.get(j).get(0));
										if(searches.get(j).get(0).contains(temp[1]))
										{
											comb.add(i, comb.get(i)+ ";" +j);
										}
										j++;
										
									}
									//out.println("Values : " + comb.get(i) + "End");
									i++;
								}
                                 
								i=comb.size()-1;
								int[] length = new int[comb.size()];
								//length = {{1}};
								while(i > 0)
								{
									j=i-1;
									while(j >= 0){
									if(comb.get(j).contains(comb.get(i)))
											{
										          length[i]=1;
											}
									j--;
									}
									i--;
								}
								int count =0;
								i=0;
								List<Integer> mark = new ArrayList<Integer>();
								while(i < length.length)
								{
									if(length[i]==0)
									{
										count++;
										mark.add(i);
									}
									i++;
										
								}
								 Menu = new String[count];
								 i=0;
								 while(i < count)
								 {
									String[] tempM = comb.get(mark.get(i)).split(";");
									String[] tempList = tempM[0].split(" ");
									 Menu[i] = tempList[0];
									 //out.println(Menu[i] + ";");
									 i++;
								 }
								
								
								}
							}
							 catch (Exception e) {
								out.println(e);
							}

						} else {
							//out.println("Redirecting..");
					%>
										<jsp:forward page="index.jsp" />
										<%
						}
					%>

		
		
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
				
				<%
				   
				  int check=0;
				//out.println("SIZE : " + fcList.length);
				    while(check < Menu.length)
					{
				    	
				%>
                    <li>
                        <a href="MenuData?search=<%=searches.get(Integer.parseInt(Menu[check])).get(0) %>&data=<%=searches %>"><i class="fa fa-desktop"></i><%=searches.get(Integer.parseInt(Menu[check])).get(0) %></a>
                    </li>
					
					 <%
					 check++;
					 }
					 %>
					
		      </ul>

            </div>
            
        </nav>
        <!-- /. NAV SIDE  -->
        
     
        <div id="page-wrapper">
            <div id="page-inner">
                <div class="row">
                    <div class="col-md-12">
                        <h1 class="page-header">
                            Dashboard 
                        </h1>
                    </div>
                </div>
                <!-- /. ROW  -->
                 <div class="row">
                  
            <%
            // code to retrieve the videos
            if(request.getAttribute("searchTerm") != null && request.getAttribute("searchList") != null){
            	
            	
             String searchWord = request.getAttribute("searchTerm").toString();
             String temp = request.getAttribute("searchList").toString();
             String temp1=temp.replace("[", "").replace("]", "");
             String[] tsearch = temp1.split(",");
             Search sObj = new Search();
             int i=0;
             resultList = new VideoListResponse[tsearch.length];
             while(i < tsearch.length){
				if(sObj != null){
					resultList[i] = sObj.getSearchResult(tsearch[i]);
					if(resultList[i] != null)
					{
						 List<Video> videoList = resultList[i].getItems();
				         Iterator<Video> videoIterator = videoList.iterator();
				         while(videoIterator.hasNext())
				          {
				            	Video item = videoIterator.next();
				            	
				            	%>
				            	
				                 <!-- <div class="col-md-3 col-sm-12 col-xs-12"> -->
                                    <!-- <div class="col-md-2 col-sm-3 text-center"> -->
                       <%-- <div class="ih-item square colored effect19">               
                       <div class="img">  <a href="https://www.youtube.com/watch?v=<%=item.getId() %>"><img src="<%=item.getSnippet().getThumbnails().getHigh().getUrl() %>" >
                       
                       
                       </div>
                       <div class="info">
                       <h3>Heading here</h3>
                        <p>Description goes here</p>
                       </div>
                       </a></div>
                        --%>     <%-- <div class="panel-footer back-footer-green">
                             <%=item.getStatistics().getViewCount() %>   
                              </div>
                             --%>
                        <div class="col-sm-4">
						<div class="ih-item square color effect7 from_top_and_bottom">
							<a href="https://www.youtube.com/watch?v=<%=item.getId() %>">
								<div class="img">
									<img src="<%=item.getSnippet().getThumbnails().getHigh().getUrl() %>" alt="img">
								</div>
								<div class="info">
							<font color="white" size=3">	<h4>Views: <%=item.getStatistics().getViewCount() %></h4>
									<h4>Likes: <%=item.getStatistics().getLikeCount() %></h4>
									<h4><%=item.getSnippet().getTitle() %></h4></font>
								</div>
							</a>
						</div>
                        </div>
						<%
				        	 
					      }
				}
				}
				i++;
             }
             
            }
            %>

								
					</div>
					</div>
                </div>
                <!-- /. ROW  -->
            </div>
            <!-- /. PAGE INNER  -->
        </div>
        <!-- /. PAGE WRAPPER  -->
    </div>
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
    <!-- jQuery Js -->
    <script src="content/assets/js/jquery-1.10.2.js"></script>
    <!-- Bootstrap Js -->
    <script src="content/assets/js/bootstrap.min.js"></script>
    <!-- Metis Menu Js -->
    <script src="content/assets/js/jquery.metisMenu.js"></script>
    <!-- Morris Chart Js -->
    <script src="content/assets/js/morris/raphael-2.1.0.min.js"></script>
    <script src="content/assets/js/morris/morris.js"></script>
    <!-- Custom Js -->
    <script src="content/assets/js/custom-scripts.js"></script>


</body>

</html>