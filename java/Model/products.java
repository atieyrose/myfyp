/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author A S U S
 */
public class products {
    
    protected int prodID;
    protected String prodName;
    protected String prodDesc;
    protected Double price;
    
    public products (int prodID, String prodName, String prodDesc, Double price) {
        super();
        this.prodID = prodID;
        this.prodName = prodName;
        this.prodDesc = prodDesc;
        this.price = price;
    }

    public products (String prodName, String prodDesc, Double price) {
        super();
        this.prodName = prodName;
        this.prodDesc = prodDesc;
        this.price = price;
    }
    
    public int getProdID() {
        return prodID;
    }

    public void setProdID(int prodID) {
        this.prodID = prodID;
    }

    public String getProdName() {
        return prodName;
    }

    public void setProdName(String prodName) {
        this.prodName = prodName;
    }

    public String getProdDesc() {
        return prodDesc;
    }

    public void setProdDesc(String prodDesc) {
        this.prodDesc = prodDesc;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
    
    
    
}
