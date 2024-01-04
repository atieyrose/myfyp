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
import Model.employee;

/**
 *
 * @author A S U S
 */
public class employeeDAO {

    private final String url = "jdbc:mysql://localhost:3306/fyp";
    private final String user = "root";
    private final String pass = "admin";

    private static final String INSERT_EMPLOYEE_SQL = "INSERT INTO employee (firstName, lastName, role, icNo, DOB, phoneNo, email, address, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";
    private static final String SELECT_EMPLOYEE_BY_ID = "SELECT ID, firstName, lastName, role, icNo, DOB, phoneNo, email, address FROM employee WHERE ID = ?";
    private static final String SELECT_ALL_EMPLOYEE = "SELECT * FROM employee";
    private static final String DELETE_EMPLOYEE_SQL = "DELETE FROM employee WHERE ID = ?";
    private static final String UPDATE_EMPLOYEE_SQL = "UPDATE employee SET firstName = ?, lastName = ?, role = ?, icNo = ?, DOB = ?, phoneNo = ?, email = ?, address = ?  WHERE ID = ?;";

    
    public employeeDAO() {

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

    public void insertemployee(employee emp) throws SQLException {
        System.out.println(INSERT_EMPLOYEE_SQL);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDOB = sdf.format(emp.getDOB());

//get from employee java class
        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(INSERT_EMPLOYEE_SQL)) {

            ps.setString(1, emp.getFirstName());
            ps.setString(2, emp.getLastName());
            ps.setString(3, emp.getRole());
            ps.setString(4, emp.getIcNo());
            ps.setString(5, formattedDOB);
            ps.setString(6, emp.getPhoneNo());
            ps.setString(7, emp.getEmail());
            ps.setString(8, emp.getAddress());
            ps.setString(9, emp.getPassword());

            System.out.println(ps);
            ps.executeUpdate();
            
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public employee selectemployee(int ID) throws SQLException, ParseException {
        employee emp = null;

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(SELECT_EMPLOYEE_BY_ID);) {
            ps.setInt(1, ID);
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            // Assuming "yyyy-MM-dd" is the format of your date string
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            //get from database
            while (rs.next()) {

                String fname = rs.getString("firstName");
                String lname = rs.getString("lastName");
                String role = rs.getString("role");
                String icno = rs.getString("icNo");
                Date dob = sdf.parse(rs.getString("DOB"));
                String phoneno = rs.getString("phoneNo");
                String email = rs.getString("email");
                String address = rs.getString("address");

                emp = new employee(ID, fname, lname, role, icno, dob, phoneno, email, address);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return emp;
    }

    public List<employee> selectallemployee() throws SQLException, ParseException {

        List<employee> emp = new ArrayList<>();

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(SELECT_ALL_EMPLOYEE);) {
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            // Assuming "yyyy-MM-dd" is the format of your date string
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            while (rs.next()) {
                int id = rs.getInt("ID");
                String fname = rs.getString("firstName");
                String lname = rs.getString("lastName");
                String role = rs.getString("role");
                String icno = rs.getString("icNo");
                Date dob = sdf.parse(rs.getString("DOB"));
                String phoneno = rs.getString("phoneNo");
                String email = rs.getString("email");
                String address = rs.getString("address");

                emp.add(new employee(id, fname, lname, role, icno, dob, phoneno, email, address));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return emp;
    }

    public boolean deleteemployee(int ID) throws SQLException {
        boolean rowDeleted;

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(DELETE_EMPLOYEE_SQL);) {
            ps.setInt(1, ID);

            rowDeleted = ps.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateemployee(employee emp) throws SQLException {
        boolean rowUpdated;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDOB = sdf.format(emp.getDOB());

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(UPDATE_EMPLOYEE_SQL);) {

            ps.setString(1, emp.getFirstName());
            ps.setString(2, emp.getLastName());
            ps.setString(3, emp.getRole());
            ps.setString(4, emp.getIcNo());
            ps.setString(5, formattedDOB);
            ps.setString(6, emp.getPhoneNo());
            ps.setString(7, emp.getEmail());
            ps.setString(8, emp.getAddress());
            ps.setInt(9, emp.getID());

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
