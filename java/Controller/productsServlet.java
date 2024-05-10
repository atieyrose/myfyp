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
import Model.products;
import DAO.productsDAO;
import jakarta.servlet.annotation.WebServlet;

/**
 *
 * @author A S U S
 */
@WebServlet(name = "productsServlet", urlPatterns = {"/productsServlet"})
public class productsServlet extends HttpServlet {
    
    private productsDAO prodDAO;
    
    @Override
    public void init() {
        prodDAO = new productsDAO();
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
                case "prodnew":
                    shownewform(request, response);
                    break;
                case "prodinsert":
                    insertproducts(request, response);
                    break;
                case "proddelete":
                    deleteproducts(request, response);
                    break;
                case "prodedit":
                    showeditform(request, response);
                    break;
                case "produpdate":
                    updateproducts(request, response);
                    break;
                case "prodlist":
                    listproducts(request, response);
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("products.jsp");
        dispatcher.forward(request, response);
    }

    private void insertproducts(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ParseException {

        String prodName = request.getParameter("prodName");
        String prodDesc = request.getParameter("prodDesc");
        Double price = Double.parseDouble(request.getParameter("price"));

        products newproducts = new products(prodName, prodDesc, price);
        prodDAO.insertproducts(newproducts);
        response.sendRedirect("productsServlet?action=prodlist");

    }

    private void deleteproducts(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int prodID = Integer.parseInt(request.getParameter("prodID"));

        prodDAO.deleteproducts(prodID);
        response.sendRedirect("productsServlet?action=prodlist");
    }

    private void updateproducts(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ParseException {

        int prodID = Integer.parseInt(request.getParameter("prodID"));
        String prodName = request.getParameter("prodName");
        String prodDesc = request.getParameter("prodDesc");
        Double price = Double.parseDouble(request.getParameter("price"));

        products prod = new products(prodID, prodName, prodDesc, price);
        prodDAO.updateproducts(prod);
        response.sendRedirect("productsServlet?action=prodlist");
    }

    private void listproducts(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException, ParseException {
        List<products> listproducts = prodDAO.selectallproducts();
        request.setAttribute("listproducts", listproducts);
        RequestDispatcher dispatcher = request.getRequestDispatcher("productsList.jsp");
        dispatcher.forward(request, response);
    }

    private void showeditform(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException, ParseException {
        int prodID = Integer.parseInt(request.getParameter("prodID"));
        products oldproducts = prodDAO.selectproducts(prodID);
        RequestDispatcher dispatcher = request.getRequestDispatcher("products.jsp");
        request.setAttribute("products", oldproducts);
        dispatcher.forward(request, response);
    }

    

}
