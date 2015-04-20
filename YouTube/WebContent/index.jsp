<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]> <html class="lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]> <html class="lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html lang="en"> <!--<![endif]-->


  
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Login Form</title>  
  <link rel="stylesheet" href="content/css/style.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script type="text/javascript">

   function getData()
    {
      var user;
      var pass;
      var result="1";
      user = document.getElementById("user").value;
      pass =  document.getElementById("pass").value;
        $.ajax({
                 url: "http://localhost:8080/youtuberest/webresources/youtube/login?user="+ user + "&pass=" + pass,
                 type: 'GET',
                 success: function disp(msg){
                    result = msg; 	 
                if(result == "0")
                	{
                	   document.getElementById("sub").submit();
                	}
                    else
                	{
                	 //   alert(result);
                	    window.location.replace("index.jsp");
                	}
 
                 }
               });         
      }
   function loginCookie(users)
   {
	   var user = users;
       var result="1";
       $.ajax({
                url: "http://localhost:8080/youtuberest/webresources/youtube/login?user="+ user + "&pass=" + pass,
                type: 'GET',
                success: function disp(msg){
                   result = msg; 	 
               if(result == "0")
               	{
            	   document.getElementById("user").value=user;
               	}
                   else
               	{
               	    alert(result);
               	    window.location.replace("index.jsp");
               	}

                }
              });         
               }
   </script>
  
</head>

<body>
  <section class="container">
    <div class="login">
      <h1>Login Page</h1>
      <form id="sub" method="post" action="userhome.jsp">
        <p><input type="text" name="login" value="" id="user" placeholder="Email"></p>
        <p><input type="password" name="password" value="" id="pass" placeholder="******"></p>
        <p class="remember_me">
          <label>
            <input type="checkbox" name="rem" id="rem" value="checked">
            Remember me on this computer
          </label>
        </p>
        <p class="submit"><input type="submit" onclick="return getData();" value="Login"></p>
      </form>
    </div>

    <div class="login-help">
      <p>Forgot your password? <a href="forgot.jsp">Click here to reset it</a>.</p>
    </div>
  </section>
<%
try{
	
	//session.setAttribute( "login", "login" );
	String checkCookie = request.getParameter("value");
	if(checkCookie != null && checkCookie.equals("no"))
	{
		//do nothing
	}
	else
	{
      Cookie[] cookies = request.getCookies();
      for (int i = 0; i < cookies.length; i++) {
        Cookie cookie = cookies[i];
        if (cookie.getName().equals("ytube")) {
        if(cookie.getValue()!= "" && cookie.getValue().length() > 0){
            try{
            	    String credentials = cookie.getValue();
            	    if (credentials != null) {
            	        String decodedCredentials = new String(com.youtube.adk.Base64.decode(credentials));
            	        %>  <script> window.loginCookie('<%=decodedCredentials %>'); </script><% 
 
            }
            }	    catch(Exception e){
            e.printStackTrace();
            }
           
        }
        }
      }
    }
    }catch(Exception e){
     e.printStackTrace();
}

%>
  </body>
</html>
