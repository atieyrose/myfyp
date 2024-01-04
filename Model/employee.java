/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author A S U S
 */
public class employee {

    protected int ID;
    protected String firstName;
    protected String lastName;
    protected String role;
    protected String icNo;
    protected Date DOB;
    protected String phoneNo;
    protected String email;
    protected String address;
    protected String password;

    public employee(int ID, String firstName, String lastName, String role, String icNo, Date DOB, String phoneNo, String email, String address) {
        super();
        this.ID = ID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.role = role;
        this.icNo = icNo;
        this.DOB = DOB;
        this.phoneNo = phoneNo;
        this.email = email;
        this.address = address;
    }

    public employee(int ID, String firstName, String lastName, String role, String icNo, Date DOB, String phoneNo, String email, String address, String password) {
        super();
        this.ID = ID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.role = role;
        this.icNo = icNo;
        this.DOB = DOB;
        this.phoneNo = phoneNo;
        this.email = email;
        this.address = address;
        this.password = password;
    }

    public employee(String firstName, String lastName, String role, String icNo, Date DOB, String phoneNo, String email, String address, String password) {
        super();
        this.firstName = firstName;
        this.lastName = lastName;
        this.role = role;
        this.icNo = icNo;
        this.DOB = DOB;
        this.phoneNo = phoneNo;
        this.email = email;
        this.address = address;
        this.password = password;
    }

   public employee(String firstName, String lastName, String role, String icNo, Date DOB, String phoneNo, String email, String address) {
        super();
        this.firstName = firstName;
        this.lastName = lastName;
        this.role = role;
        this.icNo = icNo;
        this.DOB = DOB;
        this.phoneNo = phoneNo;
        this.email = email;
        this.address = address;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getIcNo() {
        return icNo;
    }

    public void setIcNo(String icNo) {
        this.icNo = icNo;
    }

    public Date getDOB() {
        return DOB;
    }

    public void setDOB(Date DOB) {
        this.DOB = DOB;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}
