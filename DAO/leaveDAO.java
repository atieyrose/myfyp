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
import Model.leave;

/**
 *
 * @author A S U S
 */
public class leaveDAO {

    private final String url = "jdbc:mysql://localhost:3306/fyp";
    private final String user = "root";
    private final String pass = "admin";

    private static final String INSERT_LEAVE_SQL = "INSERT INTO empleave (empID, leaveType, startDate, endDate, totalDay, leaveDesc) VALUES (?, ?, ?, ?, ?, ?);";
    private static final String SELECT_lEAVE_BY_ID = "SELECT leaveID, empID, leaveType, startDate, endDate, totalDay, leaveDesc FROM empleave WHERE leaveID = ?";
    private static final String SELECT_ALL_LEAVE = "SELECT * FROM empleave";
    private static final String DELETE_LEAVE_SQL = "DELETE FROM empleave WHERE leaveID = ?";
    private static final String UPDATE_LEAVE_SQL = "UPDATE empleave SET leaveType = ?, startDate = ?, endDate = ?, totalDay = ?, leaveDesc = ? WHERE leaveID = ?;";

    public leaveDAO() {

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

    public void insertleave(leave leave) throws SQLException {
        System.out.println(INSERT_LEAVE_SQL);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String start = sdf.format(leave.getStartDate());
        String end = sdf.format(leave.getEndDate());

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(INSERT_LEAVE_SQL)) {

            ps.setInt(1, leave.getEmpID());
            ps.setString(2, leave.getLeaveType());
            ps.setString(3, start);
            ps.setString(4, end);
            ps.setInt(5, leave.getTotalDay());
            ps.setString(6, leave.getLeaveDesc());

            System.out.println(ps);
            ps.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public leave selectleave(int leaveID) throws SQLException, ParseException {
        leave leave = null;

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(SELECT_lEAVE_BY_ID);) {
            ps.setInt(1, leaveID);
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            while (rs.next()) {

                int empID = rs.getInt("empID");
                String type = rs.getString("leaveType");
                Date start = sdf.parse(rs.getString("startDate"));
                Date end = sdf.parse(rs.getString("endDate"));
                int total = rs.getInt("totalDay");
                String desc = rs.getString("leaveDesc");

                leave = new leave(leaveID, empID, type, start, end, total, desc);
            }

        } catch (SQLException e) {
            printSQLException(e);
        }
        return leave;

    }

    public List<leave> selectallleave() throws SQLException, ParseException {

        List<leave> leave = new ArrayList<>();

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(SELECT_ALL_LEAVE);) {
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            while (rs.next()) {
                int leaveID = rs.getInt("leaveID");
                int empID = rs.getInt("empID");
                String type = rs.getString("leaveType");
                Date start = sdf.parse(rs.getString("startDate"));
                Date end = sdf.parse(rs.getString("endDate"));
                int total = rs.getInt("totalDay");
                String desc = rs.getString("leaveDesc");
                
                leave.add(new leave(leaveID, empID, type, start, end, total, desc));
            }

        } catch (SQLException e) {
            printSQLException(e);
        }
        return leave;
    }
    
    public boolean deleteleave(int leaveID) throws SQLException {
        boolean rowDeleted;
        
        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(DELETE_LEAVE_SQL);) {
            ps.setInt(1, leaveID);
            
            rowDeleted = ps.executeUpdate() > 0;
        }
        return rowDeleted;
        
    }
    
    public boolean updateleave(leave leave) throws SQLException {
        boolean rowUpdated;
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String start = sdf.format(leave.getStartDate());
        String end = sdf.format(leave.getEndDate());
        
        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(UPDATE_LEAVE_SQL);) {
            
            //ps.setInt(1, leave.getEmpID());
            ps.setString(1, leave.getLeaveType());
            ps.setString(2, start);
            ps.setString(3, end);
            ps.setInt(4, leave.getTotalDay());
            ps.setString(5, leave.getLeaveDesc());
            ps.setInt(6, leave.getLeaveID());
            
            rowUpdated = ps.executeUpdate() > 0;
        }
        return rowUpdated;
        
    }

    private void printSQLException(SQLException ex) {
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
