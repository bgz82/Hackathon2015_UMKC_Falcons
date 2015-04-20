package com.youtube.adk;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {
     public void mailSending(String smtpHost, int smtp_Port,String from, String to,String subject, String content)throws AddressException, MessagingException {

        java.util.Properties props = new java.util.Properties();
   
        String smtpPort = Integer.toString(smtp_Port);
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", smtpPort);
        props.put("mail.smtp.auth", "true");

        Session session = Session.getDefaultInstance(props, null);
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(from));//set from mailId here.
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));//set to mailId here.
        msg.setRecipient(Message.RecipientType.CC,new InternetAddress(to));//set cc mailId here.
        msg.setSubject(subject);//mail Subject
        msg.setContent(content,"text/plain");//mail content in plain format

        String mailHost= "smtp.gmail.com";//mailHost for your mail provider.For gmail smtp.gmail.com
        String userName = "bhargavaakhi@gmail.com";//userName for an E-mail provider.
        String password = "gvmpushpa";//password for the same.
        Transport tr = session.getTransport("smtp");
        tr.connect(mailHost,userName,password);
        System.out.println("whether connection established***"+tr.isConnected());
        msg.saveChanges();
        tr.sendMessage(msg, msg.getAllRecipients());
        tr.close();
        System.out.println("Message sent OK.");
        }
     
     
     public void sendingDetails() throws Exception
     {
    	 
         mailSending("localhost", 25, "bhargavaakhi@gmail.com", "bhargavaakhi@gmail.com","Password Recovery","Nothing");
          
     }
} 