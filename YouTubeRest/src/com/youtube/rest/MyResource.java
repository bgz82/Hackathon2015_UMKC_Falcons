package com.youtube.rest;

import java.net.UnknownHostException;
import java.util.Map;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.bson.types.ObjectId;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.sql.*;

@Path("/youtube")
public class MyResource {

        @GET
        @Produces("text/plain")
        public String getIt() {
                return "Hi Bhargava!";
        }

        @GET
        @Path("No")
        @Produces("text/plain")
        public String getI() {
                return "Hi Gellaboina!";
        }

     @GET
     @Path("login")
     @Produces("text/plain")
     public String getEventsInfo(@QueryParam(value = "user") String username, @QueryParam(value = "pass") String password)
      {
    	    Connection conn;
    	    Statement stmt = null;
    	    String sql="select email,password from login";
    	    ResultSet rs;
    	    String conURL = "jdbc:mysql://localhost/youtube";
    	    String user = "balu";
    	    String pass = "balu";
    	    
             try {
                      Class.forName("com.mysql.jdbc.Driver");
                      conn = DriverManager.getConnection(conURL, user, pass);
                      stmt = conn.createStatement();
                      rs = stmt.executeQuery(sql);
                      while(rs.next())
                       {
                	      if(rs.getObject(1).toString().equals(username))
                	        {
                		       if(rs.getObject(2).toString().equals(password))
                		         {
                			       return "0"; 
                		          }
                	         }
                	 
                         }
                         return "1";
              }
              catch (Exception e) {
                     e.printStackTrace();
                     return e.toString();
             }
            

      }
     

     @GET
     @Path("forgot")
     @Produces("text/plain")
     public String getPassword(@QueryParam(value = "user") String username)
      {
    	    Connection conn;
    	    Statement stmt = null;
    	    String sql="select email,password from login";
    	    ResultSet rs;
    	    String conURL = "jdbc:mysql://localhost/youtube";
    	    String user = "balu";
    	    String pass = "balu";
    	    
             try {
                      Class.forName("com.mysql.jdbc.Driver");
                      conn = DriverManager.getConnection(conURL, user, pass);
                      stmt = conn.createStatement();
                      rs = stmt.executeQuery(sql);
                      while(rs.next())
                       {
                	      if(rs.getObject(1).toString().equals(username))
                	        {
                		      return rs.getObject(2).toString();
                	         }
                	 
                         }
                         return "1";
              }
              catch (Exception e) {
                     e.printStackTrace();
                     return e.toString();
             }
            
      }
     
     @GET
     @Path("update")
     @Produces("text/plain")
     public String setAnalysisInfo(@QueryParam(value = "email") String email, @QueryParam(value = "search") String search) {
             try {
			Connection conn;
			Statement stmt = null;
			String sql;
			String conURL = "jdbc:mysql://localhost/youtube";
			String user = "balu";
			String pass = "balu";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(conURL, user, pass);
			stmt = conn.createStatement();
			java.util.Date utilDate = new java.util.Date();
			int year = utilDate.getYear() + 1900;
			int month = utilDate.getMonth();
			int day = utilDate.getDate();
			long time = utilDate.getTime();
			sql = "insert into ysearch VALUES ('"+ email + "','" + search + "'," + year + "," + month + "," + day + "," + time +")";
			System.out.println("SQL : " + sql);
			int res = stmt.executeUpdate(sql);
			if(res == 1)
			{
				return "0";
			}
			else
			{
				return "1";
			}
               
              } catch (Exception e) {
            	  
                     e.printStackTrace();
                     return "1";
             }
     }

     @GET
     @Path("search")
     @Produces("text/plain")
     public String getSearch(@QueryParam(value = "email") String email) {
             try {
			Connection conn;
			Statement stmt = null;
			String sql;
			String conURL = "jdbc:mysql://localhost/youtube";
			String user = "balu";
			String pass = "balu";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(conURL, user, pass);
			stmt = conn.createStatement();
			sql = "select distinct(search) from ysearch where username='"+email+"' order by year desc, month desc, day desc, time desc";
			ResultSet rs = stmt.executeQuery(sql);
			String result="";
			while(rs.next())
			{
				result=result + rs.getString(1) + ";";
			}
			return result;
               
              } catch (Exception e) {
            	  
                     e.printStackTrace();
                     return "1";
             }
     }

     @GET
     @Path("count")
     @Produces("text/plain")
     public String getCount(@QueryParam(value = "email") String email) {
             try {
			Connection conn;
			Statement stmt = null;
			String sql;
			String conURL = "jdbc:mysql://localhost/youtube";
			String user = "balu";
			String pass = "balu";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(conURL, user, pass);
			stmt = conn.createStatement();
			sql = "select count from login where email='"+email+"'";
			ResultSet rs = stmt.executeQuery(sql);
			int count=0;
			while(rs.next())
			{
				count = rs.getInt(1);
			}
			count++;
			System.out.println("COUNT: " + count);
			String sql1 = "UPDATE login SET count="+count+" WHERE email='"+email+"'";
			System.out.println("SQL : " + sql1);
			int res = stmt.executeUpdate(sql1);
			if(res == 1)
			{
				return "0";
			}
			else
			{
				return "1";
			}
              } catch (Exception e) {
            	  
                     e.printStackTrace();
                     return "1";
             }
     }



}
