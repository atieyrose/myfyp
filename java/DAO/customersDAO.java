/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import Model.customers;

/**
 *
 * @author A S U S
 */
public class customersDAO {

    private final String url = "jdbc:mysql://localhost:3306/fyp";
    private final String user = "root";
    private final String pass = "admin";

    private static final String INSERT_CUSTOMERS_SQL = "INSERT INTO customers (firstName, lastName,phoneNo, email, address) VALUES (?, ?, ?, ?, ?);";
    private static final String SELECT_CUSTOMERS_BY_ID = "SELECT custID, firstName, lastName, phoneNo, email, address FROM customers WHERE custID = ?";
    private static final String SELECT_ALL_CUSTOMERS = "SELECT * FROM customers";
    private static final String DELETE_CUSTOMERS_SQL = "DELETE FROM customers WHERE custID = ?";
    private static final String UPDATE_CUSTOMERS_SQL = "UPDATE customers SET firstName = ?, lastName = ?, phoneNo = ?, email = ?, address = ?  WHERE custID = ?;";

    public customersDAO() {

    }

    protected Connection getConnection() {
        Connection cn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection(url, user, pass);

            if (cn != null) {
                System.out.println("Connected to the database!");

            } else {
                System.out.println("Failed to connect to the database.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return cn;
    }

    public void insertcustomers(customers cust) throws SQLException {
        System.out.println(INSERT_CUSTOMERS_SQL);

//get from employee java class
        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(INSERT_CUSTOMERS_SQL)) {

            ps.setString(1, cust.getFirstName());
            ps.setString(2, cust.getLastName());
            ps.setString(3, cust.getPhoneNo());
            ps.setString(4, cust.getEmail());
            ps.setString(5, cust.getAddress());

            System.out.println(ps);
            ps.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public customers selectcustomers(int custID) throws SQLException, ParseException {
        customers cust = null;

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(SELECT_CUSTOMERS_BY_ID);) {
            ps.setInt(1, custID);
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            //get from database
            while (rs.next()) {

                String fname = rs.getString("firstName");
                String lname = rs.getString("lastName");
                String phoneno = rs.getString("phoneNo");
                String email = rs.getString("email");
                String address = rs.getString("address");

                cust = new customers(custID, fname, lname, phoneno, email, address);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return cust;
    }

    public List<customers> selectallcustomers() throws SQLException, ParseException {

        List<customers> cust = new ArrayList<>();

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(SELECT_ALL_CUSTOMERS);) {
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("custID");
                String fname = rs.getString("firstName");
                String lname = rs.getString("lastName");
                String phoneno = rs.getString("phoneNo");
                String email = rs.getString("email");
                String address = rs.getString("address");

                cust.add(new customers(id, fname, lname, phoneno, email, address));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return cust;
    }

    public boolean deletecustomers(int custID) throws SQLException {
        boolean rowDeleted;

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(DELETE_CUSTOMERS_SQL);) {
            ps.setInt(1, custID);

            rowDeleted = ps.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updatecustomers(customers cust) throws SQLException {
        boolean rowUpdated;

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(UPDATE_CUSTOMERS_SQL);) {

            ps.setString(1, cust.getFirstName());
            ps.setString(2, cust.getLastName());
            ps.setString(3, cust.getPhoneNo());
            ps.setString(4, cust.getEmail());
            ps.setString(5, cust.getAddress());
            ps.setInt(6, cust.getCustID());

            rowUpdated = ps.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    private static void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }

}
