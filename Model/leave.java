/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author A S U S
 */
public class leave {

    protected int leaveID;
    protected int empID;
    protected String leaveType;
    protected Date startDate;
    protected Date endDate;
    protected int totalDay;
    protected String leaveDesc;

    public leave(int leaveID, int empID, String leaveType, Date startDate, Date endDate, int totalDay, String leaveDesc) {
        super();
        this.leaveID = leaveID;
        this.empID = empID;
        this.leaveType = leaveType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalDay = totalDay;
        this.leaveDesc = leaveDesc;
    }

    public leave(int empID, String leaveType, Date startDate, Date endDate, int totalDay, String leaveDesc) {
        super();
        this.empID = empID;
        this.leaveType = leaveType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalDay = totalDay;
        this.leaveDesc = leaveDesc;
    }

    public int getLeaveID() {
        return leaveID;
    }

    public void setLeaveID(int leaveID) {
        this.leaveID = leaveID;
    }

    public int getEmpID() {
        return empID;
    }

    public void setEmpID(int empID) {
        this.empID = empID;
    }

    public String getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getTotalDay() {
        return totalDay;
    }

    public void setTotalDay(int totalDay) {
        this.totalDay = totalDay;
    }

    public String getLeaveDesc() {
        return leaveDesc;
    }

    public void setLeaveDesc(String leaveDesc) {
        this.leaveDesc = leaveDesc;
    }

}
