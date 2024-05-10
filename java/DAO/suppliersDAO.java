/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import Model.suppliers;

/**
 *
 * @author A S U S
 */
public class suppliersDAO {

    private final String url = "jdbc:mysql://localhost:3306/fyp";
    private final String user = "root";
    private final String pass = "admin";

    private static final String INSERT_SUPPLIERS_SQL = "INSERT INTO suppliers (supName, phoneNo, email) VALUES (?, ?, ?);";
    private static final String SELECT_SUPPLIERS_BY_ID = "SELECT supID, supName, phoneNo, email FROM suppliers WHERE supID = ?";
    private static final String SELECT_ALL_SUPPLIERS = "SELECT * FROM suppliers";
    private static final String DELETE_SUPPLIERS_SQL = "DELETE FROM suppliers WHERE supID = ?";
    private static final String UPDATE_SUPPLIERS_SQL = "UPDATE suppliers SET supName = ?, phoneNo = ?, email = ?  WHERE supID = ?;";

    public suppliersDAO() {

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

    public void insertsuppliers(suppliers sup) throws SQLException {
        System.out.println(INSERT_SUPPLIERS_SQL);

//get from employee java class
        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(INSERT_SUPPLIERS_SQL)) {

            ps.setString(1, sup.getSupName());
            ps.setString(2, sup.getPhoneNo());
            ps.setString(3, sup.getEmail());

            System.out.println(ps);
            ps.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public suppliers selectsuppliers(int supID) throws SQLException, ParseException {
        suppliers sup = null;

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(SELECT_SUPPLIERS_BY_ID);) {
            ps.setInt(1, supID);
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            //get from database
            while (rs.next()) {

                String supname = rs.getString("supName");
                String phoneno = rs.getString("phoneNo");
                String email = rs.getString("email");

                sup = new suppliers(supID, supname, phoneno, email);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return sup;
    }

    public List<suppliers> selectallsuppliers() throws SQLException, ParseException {

        List<suppliers> sup = new ArrayList<>();

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(SELECT_ALL_SUPPLIERS);) {
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int supID = rs.getInt("supID");
                String supname = rs.getString("supName");
                String phoneno = rs.getString("phoneNo");
                String email = rs.getString("email");

                sup.add(new suppliers(supID, supname, phoneno, email));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return sup;
    }

    public boolean deletesuppliers(int supID) throws SQLException {
        boolean rowDeleted;

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(DELETE_SUPPLIERS_SQL);) {
            ps.setInt(1, supID);

            rowDeleted = ps.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updatesuppliers(suppliers sup) throws SQLException {
        boolean rowUpdated;

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(UPDATE_SUPPLIERS_SQL);) {

            ps.setString(1, sup.getSupName());
            ps.setString(2, sup.getPhoneNo());
            ps.setString(3, sup.getEmail());
            ps.setInt(4, sup.getSupID());

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
