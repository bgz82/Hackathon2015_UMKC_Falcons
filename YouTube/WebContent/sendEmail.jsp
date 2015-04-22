<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.MessagingException" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.AddressException" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="com.sun.mail.util.MailSSLSocketFactory" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="javascript">
function read()
{
//alert("BALU");
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body onload="read()">

<%

String user = request.getParameter("user1");
String pass = request.getParameter("pass1");
if(user != null ||  pass != null)
{
try{
java.util.Properties props = new java.util.Properties();
String smtpPort = Integer.toString(25);
props.put("mail.smtp.host", "localhost");
props.put("mail.smtp.port", "25");
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.user","bhargavaakhi@gmail.com");
props.put("mail.smtp.starttls.enable", "true");

java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
Session tsession = Session.getDefaultInstance(props);
Message msg = new MimeMessage(tsession);
msg.setFrom(new InternetAddress("bhargavaakhi@gmail.com"));//set from mailId here.
msg.setRecipient(Message.RecipientType.TO, new InternetAddress(user));//set to mailId here.
msg.setSubject("YSE : Email for Password Recovery");//mail Subject
msg.setContent("Your Password for YSE Account is " + pass + " .Please use the link http://localhost:8080/YouTube/index.jsp to login.","text/plain");//mail content in plain format

String mailHost= "smtp.gmail.com";//mailHost for your mail provider.For gmail smtp.gmail.com
String userName = "bhargavaakhi@gmail.com";//userName for an E-mail provider.
String password = "gvmpushpa";//password for the same.
Transport tr = tsession.getTransport("smtps");
tr.connect(mailHost,userName,password);
System.out.println("whether connection established  : "+tr.isConnected());
msg.saveChanges();

tr.sendMessage(msg, msg.getAllRecipients());
tr.close();
System.out.println("Message sent OK.");
}
catch(Exception e){
	out.println(e);
}
}
else
{
	user = "invalid";
	pass="invalid";
}
/*request.setAttribute("user", user);
request.setAttribute("pass", pass);*/
%>
<jsp:forward page="forgot.jsp"> 
<jsp:param name="user" value="${user}" />
<jsp:param name="pass" value="${pass}" /> 
</jsp:forward> 

</body>
</html>