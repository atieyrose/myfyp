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
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import Model.employee;
import DAO.employeeDAO;
import jakarta.servlet.annotation.WebServlet;

/**
 *
 * @author A S U S
 */
@WebServlet(name = "employeeServlet", urlPatterns = {"/employeeServlet"})
public class employeeServlet extends HttpServlet {

    private employeeDAO empDAO;

    @Override
    public void init() {
        empDAO = new employeeDAO();
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
                case "empnew":
                    shownewform(request, response);
                    break;
                case "empinsert":
                    insertemployee(request, response);
                    break;
                case "empdelete":
                    deleteemployee(request, response);
                    break;
                case "empedit":
                    showeditform(request, response);
                    break;
                case "empupdate":
                    updateemployee(request, response);
                    break;
                case "emplist":
                    listemployee(request, response);
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("employee.jsp");
        dispatcher.forward(request, response);
    }

private void insertemployee(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ParseException {
    String fname = request.getParameter("firstName");
    String lname = request.getParameter("lastName");
    String card = request.getParameter("cardID");
    String role = request.getParameter("role");
    String icno = request.getParameter("icNo");
    Date dob = Date.valueOf(request.getParameter("DOB"));
    String phoneno = request.getParameter("phoneNo");
    String email = request.getParameter("email");
    String address = request.getParameter("address");
    String password = request.getParameter("password");

    employee newemployee = new employee(fname, lname, card, role, icno, dob, phoneno, email, address, password);
    empDAO.insertemployee(newemployee);
    response.sendRedirect("employeeServlet?action=emplist");
}


    private void deleteemployee(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int ID = Integer.parseInt(request.getParameter("ID"));

        empDAO.deleteemployee(ID);
        response.sendRedirect("employeeServlet?action=emplist");
    }

    private void updateemployee(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ParseException {

        int ID = Integer.parseInt(request.getParameter("ID"));
        String fname = request.getParameter("firstName");
        String lname = request.getParameter("lastName");
        String card = request.getParameter("cardID");
        String role = request.getParameter("role");
        String icno = request.getParameter("icNo");
        Date dob = Date.valueOf(request.getParameter("DOB"));
        String phoneno = request.getParameter("phoneNo");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        employee emp = new employee(ID, fname, lname, card, role, icno, dob, phoneno, email, address);
        empDAO.updateemployee(emp);
        response.sendRedirect("employeeServlet?action=emplist");
    }

    private void listemployee(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException, ParseException {
        List<employee> listemployee = empDAO.selectallemployee();
        request.setAttribute("listemployee", listemployee);
        RequestDispatcher dispatcher = request.getRequestDispatcher("employeeList.jsp");
        dispatcher.forward(request, response);
    }

    private void showeditform(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException, ParseException {
        int ID = Integer.parseInt(request.getParameter("ID"));
        employee oldemployee = empDAO.selectemployee(ID);
        RequestDispatcher dispatcher = request.getRequestDispatcher("employee.jsp");
        request.setAttribute("employee", oldemployee);
        dispatcher.forward(request, response);
    }

}