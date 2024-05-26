/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author A S U S
 */
import Model.sales;
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

public class salesDAO {

    private final String url = "jdbc:mysql://localhost:3306/fyp";
    private final String user = "root";
    private final String pass = "admin";

    private static final String INSERT_SALES_SQL = "INSERT INTO sales (custID, prodID, quantity, total) VALUES (?, ?, ?, ?);";
    private static final String SELECT_SALES_BY_ID = "SELECT saleID, custID, prodID, quantity, total FROM sales WHERE saleID = ?";
    private static final String SELECT_ALL_SALES = "SELECT * FROM sales";
    private static final String DELETE_SALES_SQL = "DELETE FROM sales WHERE saleID = ?";
    private static final String UPDATE_SALES_SQL = "UPDATE sales SET custID = ?, prodID = ?, quantity = ?  WHERE saleID = ?;";

    public salesDAO() {

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

    public void insertsales(sales sale) throws SQLException {
        System.out.println(INSERT_SALES_SQL);

//get from products java class
        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(INSERT_SALES_SQL)) {

            ps.setInt(1, sale.getCustID());
            ps.setInt(2, sale.getProdID());
            ps.setInt(3, sale.getQuantity());
            ps.setDouble(4, sale.getTotal());

            System.out.println(ps);
            ps.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public List<sales> selectallsales() throws SQLException, ParseException {

        List<sales> sale = new ArrayList<sales>();

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(SELECT_ALL_SALES);) {
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int saleID = rs.getInt("saleID");
                int custID = rs.getInt("custID");
                int prodID = rs.getInt("prodID");
                int quantity = rs.getInt("quantity");
                double total = rs.getDouble("total");

                sale.add(new sales(saleID, custID, prodID, quantity, total));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return sale;
    }

    private void printSQLException(SQLException e) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
