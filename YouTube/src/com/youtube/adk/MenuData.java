package com.youtube.adk;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MenuData
 */
@WebServlet("/MenuData")
public class MenuData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MenuData() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String search = request.getParameter("search");
		String data= request.getParameter("data");
		String temp1=data.replace("[", "").replace("]", "");
		String[] slist = temp1.split(",");
		List<String> searchList = new ArrayList<String>();
		int i=0;
		String[] part=null;
		part = search.split(" ");
		while(i < slist.length)
		{
			if(slist[i].contains(part[1]))
			{
				searchList.add(slist[i]);
			}
			i++;
		}
	  request.setAttribute("searchTerm", search);
	  
	  request.setAttribute("searchList", searchList);
	  getServletContext().getRequestDispatcher("/dashboard.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
