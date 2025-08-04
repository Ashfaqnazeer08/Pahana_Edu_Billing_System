/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pahana.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.pahana.dao.UserDAO;
import javax.servlet.*;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        UserDAO dao = new UserDAO();
        boolean valid = dao.validate(username, password);

        if (valid) {
            HttpSession session = req.getSession();
            session.setAttribute("username", username);
            res.sendRedirect("dashboard.jsp");
        } else {
            res.sendRedirect("login.jsp?error=true");
        }
    }
}
