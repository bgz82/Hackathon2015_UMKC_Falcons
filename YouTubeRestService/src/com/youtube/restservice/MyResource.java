package com.youtube.restservice;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import java.net.UnknownHostException;
import java.sql.*;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;
import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import com.mongodb.util.JSON;
import com.youtube.restservice.pojo.Video;

import com.youtube.restservice.pojo.Video;

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
                	    	  System.out.println("username is : " + username);
                		       if(rs.getObject(2).toString().equals(password))
                		         {
                		    	   System.out.println("password : " + rs.getObject(2).toString());
                			       return "0"; 
                		          }
                		       else
                		       {
                		    	   return "1";
                		       }
                	         }
                	 
                         }
                         return "2";
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
                	    	  System.out.println("username is : " + username);
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
     
     @POST
     @Path("update")
     @Consumes({ MediaType.APPLICATION_JSON, "text/json" })
     @Produces({ MediaType.APPLICATION_JSON, "text/json" })
     public String setAnalysisInfo(com.youtube.restservice.pojo.Video scene, @QueryParam(value = "email") String email) {
                 try {
                     Mongo mongo = new Mongo("localhost", 27017);
                     DBCollection collection= null;
                     DB db = mongo.getDB("youtube");
                     collection = db.getCollection("youtube");
               
                     	// convert JSON to DBObject directly
                     DBObject dbObject = (DBObject) JSON.parse(new Gson().toJson(scene));

                     collection.insert(dbObject);

                     DBCursor cursorDoc = collection.find();
                     DBCursor c = collection.find();

                     while (cursorDoc.hasNext()) {
                             System.out.println(cursorDoc.next());
                     }
                     System.out.println("Done");
            	 
		      } catch (Exception e) {
            	  
                     e.printStackTrace();
        
		      }
             
             return "balu";
     }

     @GET
     @Path("search")
     @Produces({ MediaType.APPLICATION_JSON, "text/json" })
     public String getSearch(@QueryParam(value = "email") String email) throws JSONException {
    	 MongoClient mongo;
         JSONArray jArray = new JSONArray();
         JsonObject result = new JsonObject();
         try {
         	    DBCollection table=null;
                 mongo = new MongoClient("localhost", 27017);
                 DB db = mongo.getDB("youtube");
                 table = db.getCollection("youtube");
                 DBCursor cursor = table.find();
                 System.out.println("BALU");
                 while (cursor.hasNext()) {
                         JSONObject json = new JSONObject(cursor.next().toMap());
                         System.out.println("EMAIL :  " + json.getString("email"));
                         if(json.getString("email").equals(email))
                         {
                            jArray.put(json);
                         }
                 }
                 table = null;
                 return jArray.toString();
         } catch (UnknownHostException e) {
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

     @GET
     @Path("usercount")
     @Produces("text/plain")
     public String getFreq() {
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
			sql = "select email,count from login";
			ResultSet rs = stmt.executeQuery(sql);
			String users="";
			String counts="";
			while(rs.next())
			{
				users= users + rs.getObject(1).toString() + ";";
				counts = counts + rs.getObject(2).toString() + ";";
			}
			
			System.out.println("COUNT: " + counts);
			System.out.println("username: " + users);
			
			return counts + "*" + users;
			
              } catch (Exception e) {
            	  
                     e.printStackTrace();
                     return "1";
             }
     }



}
