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
import Model.suppliers;
import DAO.suppliersDAO;
import jakarta.servlet.annotation.WebServlet;

/**
 *
 * @author A S U S
 */
@WebServlet(name = "suppliersServlet", urlPatterns = {"/suppliersServlet"})
public class suppliersServlet extends HttpServlet {

    private suppliersDAO supDAO;

    @Override
    public void init() {
        supDAO = new suppliersDAO();
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
                case "supnew":
                    shownewform(request, response);
                    break;
                case "supinsert":
                    insertsuppliers(request, response);
                    break;
                case "supdelete":
                    deletesuppliers(request, response);
                    break;
                case "supedit":
                    showeditform(request, response);
                    break;
                case "supupdate":
                    updatesuppliers(request, response);
                    break;
                case "suplist":
                    listsuppliers(request, response);
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("suppliers.jsp");
        dispatcher.forward(request, response);
    }

    private void insertsuppliers(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ParseException {

        String supname = request.getParameter("supName");
        String phoneno = request.getParameter("phoneNo");
        String email = request.getParameter("email");

        suppliers newsuppliers = new suppliers(supname, phoneno, email);
        supDAO.insertsuppliers(newsuppliers);
        response.sendRedirect("suppliersServlet?action=suplist");

    }

    private void deletesuppliers(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int supID = Integer.parseInt(request.getParameter("supID"));

        supDAO.deletesuppliers(supID);
        response.sendRedirect("suppliersServlet?action=suplist");
    }

    private void updatesuppliers(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ParseException {

        int supID = Integer.parseInt(request.getParameter("supID"));
        String supname = request.getParameter("supName");
        String phoneno = request.getParameter("phoneNo");
        String email = request.getParameter("email");

        suppliers sup = new suppliers(supID, supname, phoneno, email);
        supDAO.updatesuppliers(sup);
        response.sendRedirect("suppliersServlet?action=suplist");
    }

    private void listsuppliers(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException, ParseException {
        List<suppliers> listsuppliers = supDAO.selectallsuppliers();
        request.setAttribute("listsuppliers", listsuppliers);
        RequestDispatcher dispatcher = request.getRequestDispatcher("suppliersList.jsp");
        dispatcher.forward(request, response);
    }

    private void showeditform(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException, ParseException {
        int supID = Integer.parseInt(request.getParameter("supID"));
        suppliers oldsuppliers = supDAO.selectsuppliers(supID);
        RequestDispatcher dispatcher = request.getRequestDispatcher("suppliers.jsp");
        request.setAttribute("suppliers", oldsuppliers);
        dispatcher.forward(request, response);
    }
}
