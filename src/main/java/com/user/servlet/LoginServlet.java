package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.EndUser;
import com.entity.User;
import com.DAO.UserDAOImpl;
import com.DB.DBConnect;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            long empn = Long.parseLong(request.getParameter("empn"));
            String password = request.getParameter("password");

            // Basic validation
            if (empn <= 0 || password == null || password.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Invalid Employee Number or Password.");
                response.sendRedirect("index.jsp");
                return;
            }

            // 1️⃣ Try default user login
            UserDAOImpl userDAO = new UserDAOImpl(DBConnect.getConnection());
            User us = userDAO.userLogin(empn, password);
            
            
            
			if (us != null && "V".equalsIgnoreCase(us.getRole())) {
				
				session.setAttribute("Docobj", us);
				 response.sendRedirect("/hosp1/EndUser/CGMUser.jsp");
				return;
            	
            }

            if (us != null) {
                session.setAttribute("Docobj", us);
                response.sendRedirect("/hosp1/home/rep1.jsp");
                return;
            }

            // 2️⃣ Try EndUser login in another DB
            userDAO = new UserDAOImpl(DBConnect.getConnection1());
            boolean isEndUser = userDAO.enduserLogin(empn, password);
			/* System.out.println("EndUser Login Attempt: " + isEndUser); */

            if (isEndUser) {
				/* System.out.println("EndUser Login Successful for empn: " + empn); */
                EndUser eus = userDAO.endUserDetail(empn);
                session.setAttribute("EndUserObj", eus);
                response.sendRedirect("/hosp1/EndUser/endUser.jsp");
                return;
            }

            // 3️⃣ If both fail → show error
            session.setAttribute("errorMsg", "Invalid Employee Number or Password.");
            response.sendRedirect("index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An error occurred while processing your request.");
            response.sendRedirect("index.jsp");
        }
    }
}
