/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author A S U S
 */
public class suppliers {
    
    protected int supID;
    protected String supName;
    protected String phoneNo;
    protected String email;
    
    public suppliers( int supID, String supName, String phoneNo, String email) {
        super();
        this.supID = supID;
        this.supName = supName;
        this.phoneNo = phoneNo;
        this.email = email;
    }
    
        public suppliers( String supName, String phoneNo, String email) {
        super();
        this.supName = supName;
        this.phoneNo = phoneNo;
        this.email = email;
    }

    public int getSupID() {
        return supID;
    }

    public void setSupID(int supID) {
        this.supID = supID;
    }

    public String getSupName() {
        return supName;
    }

    public void setSupName(String supName) {
        this.supName = supName;
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
    
    
}
