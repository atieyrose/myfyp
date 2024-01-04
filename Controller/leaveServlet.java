/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.leaveDAO;
import Model.leave;
import jakarta.servlet.RequestDispatcher;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author A S U S
 */
@WebServlet(name = "leaveServlet", urlPatterns = {"/leaveServlet"})
public class leaveServlet extends HttpServlet {

    private leaveDAO leaveDAO;

    @Override
    public void init() {
        leaveDAO = new leaveDAO();
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
                case "leavenew":
                    shownewform(request, response);
                    break;
                case "leaveinsert":
                    insertleave(request, response);
                    break;
                case "leavedelete":
                    deleteleave(request, response);
                    break;
                case "leaveedit":
                    showeditform(request, response);
                    break;
                case "leaveupdate":
                    updateleave(request, response);
                    break;
                case "leavelist":
                    listleave(request, response);
                    break;
                default:
                    response.getWriter().println("Unsupported action: " + action);
                    break;
            }
        } catch (SQLException ex) {
            response.getWriter().println("An error occured during the database operation.");
            throw new ServletException(ex);
        } catch (ParseException ex) {
            Logger.getLogger(leaveServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void shownewform(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("leave.jsp");
        dispatcher.forward(request, response);
    }

    private void insertleave(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        int empID = Integer.parseInt(request.getParameter("empID"));
        String type = request.getParameter("leaveType");
        Date start = sdf.parse(request.getParameter("startDate"));
        Date end = sdf.parse(request.getParameter("endDate"));
        int total = Integer.parseInt(request.getParameter("totalDay"));
        String desc = request.getParameter("leaveDesc");

        leave newleave = new leave(empID, type, start, end, total, desc);
        leaveDAO.insertleave(newleave);
        response.sendRedirect("leaveServlet?action=leavelist");

    }

    private void deleteleave(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int leaveID = Integer.parseInt(request.getParameter("leaveID"));

        leaveDAO.deleteleave(leaveID);
        response.sendRedirect("leaveServlet?action=leavelist");
    }

    private void updateleave(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        int leaveID = Integer.parseInt(request.getParameter("leaveID"));
        int empID = Integer.parseInt(request.getParameter("empID"));
        String type = request.getParameter("leaveType");
        Date start = sdf.parse(request.getParameter("startDate"));
        Date end = sdf.parse(request.getParameter("endDate"));
        int total = Integer.parseInt(request.getParameter("totalDay"));
        String desc = request.getParameter("leaveDesc");

        leave leave = new leave(leaveID, type, start, end, total, desc);
        leaveDAO.updateleave(leave);
        response.sendRedirect("leaveServlet?action=leavelist");
    }

    private void listleave(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException, ParseException {
        List<leave> listleave = leaveDAO.selectallleave();
        request.setAttribute("listleave", listleave);
        RequestDispatcher dispatcher = request.getRequestDispatcher("leaveList.jsp");
        dispatcher.forward(request, response);
    }

    private void showeditform(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException, ParseException {
        int leaveID = Integer.parseInt(request.getParameter("leaveID"));
        leave oldleave = leaveDAO.selectleave(leaveID);
        RequestDispatcher dispatcher = request.getRequestDispatcher("leave.jsp");
        request.setAttribute("leave", oldleave);
        dispatcher.forward(request, response);
    }

}
