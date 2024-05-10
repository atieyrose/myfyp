/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import Model.customers;
import DAO.customersDAO;
import jakarta.servlet.annotation.WebServlet;

/**
 *
 * @author A S U S
 */
@WebServlet(name = "customersServlet", urlPatterns = {"/customersServlet"})
public class customersServlet extends HttpServlet {

    private customersDAO custDAO;

    @Override
    public void init() {
        custDAO = new customersDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
    
        @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "custnew":
                    shownewform(request, response);
                    break;
                case "custinsert":
                    insertcustomers(request, response);
                    break;
                case "custdelete":
                    deletecustomers(request, response);
                    break;
                case "custedit":
                    showeditform(request, response);
                    break;
                case "custupdate":
                    updatecustomers(request, response);
                    break;
                case "custlist":
                    listcustomers(request, response);
                    break;
                default:
                     response.getWriter().println("Unsupported action: " + action);
                    break;
            }
        } catch (SQLException ex) {
            response.getWriter().println("An error occured during the database operation.");
            throw new ServletException(ex);
        } catch (ParseException ex) {
            Logger.getLogger(employeeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void shownewform(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("customers.jsp");
        dispatcher.forward(request, response);
    }
    
    private void insertcustomers(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ParseException {

        String fname = request.getParameter("firstName");
        String lname = request.getParameter("lastName");
        String phoneno = request.getParameter("phoneNo");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        customers newcustomers = new customers(fname, lname, phoneno, email, address);
        custDAO.insertcustomers(newcustomers);
        response.sendRedirect("customersServlet?action=custlist");

    }
    
    private void deletecustomers(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int custID = Integer.parseInt(request.getParameter("custID"));

        custDAO.deletecustomers(custID);
        response.sendRedirect("customersServlet?action=custlist");
    }
    
    private void updatecustomers(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ParseException {

        int custID = Integer.parseInt(request.getParameter("custID"));
        String fname = request.getParameter("firstName");
        String lname = request.getParameter("lastName");
        String phoneno = request.getParameter("phoneNo");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        customers cust = new customers(custID, fname, lname, phoneno, email, address);
        custDAO.updatecustomers(cust);
        response.sendRedirect("customersServlet?action=custlist");
    }
    
    private void listcustomers(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException, ParseException {
        List<customers> listcustomers = custDAO.selectallcustomers();
        request.setAttribute("listcustomers", listcustomers);
        RequestDispatcher dispatcher = request.getRequestDispatcher("customersList.jsp");
        dispatcher.forward(request, response);
    }

    private void showeditform(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException, ParseException {
        int custID = Integer.parseInt(request.getParameter("custID"));
        customers oldcustomers = custDAO.selectcustomers(custID);
        RequestDispatcher dispatcher = request.getRequestDispatcher("customers.jsp");
        request.setAttribute("customers", oldcustomers);
        dispatcher.forward(request, response);
    }
}
