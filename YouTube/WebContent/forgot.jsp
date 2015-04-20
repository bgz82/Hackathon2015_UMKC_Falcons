<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <link rel="stylesheet" href="content/css/style.css">
<title>Recover Password</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript">

   function getData()
    {
      var user;
      var pass;
      var result="1";
      user = document.getElementById("user").value;
      $.ajax({
                 url: "http://localhost:8080/youtuberest/webresources/youtube/forgot?user="+ user,
                 type: 'GET',
                 success: function disp(msg){
                    result = msg; 	 
                    if(result == "1")
                	{
                	   //window.location.replace("sendEmail.jsp");
                	}
                    else
                	{
                    	
                    	document.getElementById("user1").value=user;
                    	document.getElementById("pass1").value=result;
                    	document.getElementById("sub").submit();
                	}
 
                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(errorThrown);             	    
             	}

               });         
     }
   
   </script>


</head>
<body>
 <section class="container">
    <div class="login">
      <h1>Recover password</h1>
      <form method="post">
        <p>Enter Email Address : <input type="text" name="login" value="" id="user" placeholder="Email"></p>
        <p class="submit"><input type="submit" onclick="return getData();" value="Retrieve"></p>
      </form>
    </div>
      </section>
      <%
      String user = request.getParameter("user");
      String pass = request.getParameter("pass");
      if(user != null && pass != null)
      {
    	  %> <section class="container">
    <div class="res">
        <p align="center"><font color="white" size="4">Password has been sent to the User Email Address.</font></p>
    </div>
    <p align="center"><font color="white" size="3"><a href="index.jsp">Click here to Login </a></font></p>
      </section>
      <%
      
      }
      
      %>
      
      
      <form id="sub" method="post" action="sendEmail.jsp">
      <p><input type="hidden" name="user1" value="" id="user1" ></p>
      <p><input type="hidden" name="pass1" value="" id="pass1" ></p>
      </form>
</body>
</html>