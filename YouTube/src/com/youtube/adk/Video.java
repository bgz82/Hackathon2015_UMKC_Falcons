package com.youtube.adk;

import java.io.Serializable;
import java.sql.Date;


public class Video implements Serializable
{
	private static final long serialVersionUID = -8391958543836725081L;
	private String email;
	private String[] searchterms;
	private String tdate;
	public Video()
	{
	}
	
	public Video(String user, String[] list, String dt)
	{
		this.email = user;
		this.searchterms = list;
		this.tdate = dt;
		
	}
	
	public void setEmail(String user)
	{
		this.email = user;
	}
	public void setSearchterms(String[] list)
	{
		this.searchterms = list;
	}
	public void setTdate(String dt)
	{
		this.tdate = dt;
	} 
	public String getEmail()
	{
		return this.email;
	}
	public String[] getList()
	{
		return this.searchterms;
	}
	public String getTDate()
	{
		return this.tdate;
	}
}
	
	