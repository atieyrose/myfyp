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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import Model.products;

/**
 *
 * @author A S U S
 */
public class productsDAO {

    private final String url = "jdbc:mysql://localhost:3306/fyp";
    private final String user = "root";
    private final String pass = "admin";

    private static final String INSERT_PRODUCTS_SQL = "INSERT INTO products (prodName, prodDesc, price) VALUES (?, ?, ?);";
    private static final String SELECT_PRODUCTS_BY_ID = "SELECT prodID, prodName, prodDesc, price FROM products WHERE prodID = ?";
    private static final String SELECT_ALL_PRODUCTS = "SELECT * FROM products";
    private static final String DELETE_PRODUCTS_SQL = "DELETE FROM products WHERE prodID = ?";
    private static final String UPDATE_PRODUCTS_SQL = "UPDATE products SET prodName = ?, prodDesc = ?, price = ?  WHERE prodID = ?;";

    public productsDAO() {

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

    public void insertproducts(products prod) throws SQLException {
        System.out.println(INSERT_PRODUCTS_SQL);

//get from products java class
        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(INSERT_PRODUCTS_SQL)) {

            ps.setString(1, prod.getProdName());
            ps.setString(2, prod.getProdDesc());
            ps.setDouble(3, prod.getPrice());


            System.out.println(ps);
            ps.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public products selectproducts(int prodID) throws SQLException, ParseException {
        products prod = null;

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(SELECT_PRODUCTS_BY_ID);) {
            ps.setInt(1, prodID);
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            //get from database
            while (rs.next()) {

                String prodName = rs.getString("prodName");
                String prodDesc = rs.getString("prodDesc");
                Double price = rs.getDouble("price");

                prod = new products(prodID, prodName, prodDesc, price);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return prod;
    }

    public List<products> selectallproducts() throws SQLException, ParseException {

        List<products> prod = new ArrayList<>();

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(SELECT_ALL_PRODUCTS);) {
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int prodID = rs.getInt("prodID");
                String prodName = rs.getString("prodName");
                String prodDesc = rs.getString("prodDesc");
                Double price = rs.getDouble("price");
               
                prod.add(new products(prodID, prodName, prodDesc, price));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return prod;
    }

    public boolean deleteproducts(int prodID) throws SQLException {
        boolean rowDeleted;

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(DELETE_PRODUCTS_SQL);) {
            ps.setInt(1, prodID);

            rowDeleted = ps.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateproducts(products prod) throws SQLException {
        boolean rowUpdated;


        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(UPDATE_PRODUCTS_SQL);) {

            ps.setString(1, prod.getProdName());
            ps.setString(2, prod.getProdDesc());
            ps.setDouble(3, prod.getPrice());
            ps.setInt(4, prod.getProdID());

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
