/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.sales;
import DAO.salesDAO;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.json.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(name = "salesServlet", urlPatterns = {"/salesServlet"})
public class salesServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type
        response.setContentType("application/json");

        // Get the request body
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String requestBody = sb.toString();

        try {
            // Parse the JSON data
            JSONObject jsonData = new JSONObject(requestBody);
            JSONArray salesArray = jsonData.getJSONArray("sales");

            // Process each sale item
            for (int i = 0; i < salesArray.length(); i++) {
                JSONObject saleItem = salesArray.getJSONObject(i);
                String custID = saleItem.getString("custID");
                String prodID = saleItem.getString("prodID");
                String item = saleItem.getString("item");
                double price = saleItem.getDouble("price");
                int quantity = saleItem.getInt("quantity");
                double amount = saleItem.getDouble("amount");

                // Here you can save the sales data to your database or perform any other necessary operations
                // For demonstration purposes, let's just print the data
                System.out.println("Customer ID: " + custID + ", Product ID: " + prodID + ", Item: " + item + ", Price: " + price + ", Quantity: " + quantity + ", Amount: " + amount);
            }

            // Send a response indicating success
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "success");
            PrintWriter out = response.getWriter();
            out.print(jsonResponse.toString());
        } catch (JSONException e) {
            // Handle JSON parsing errors
            e.printStackTrace();
            // Send a response indicating failure
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "error");
            PrintWriter out = response.getWriter();
            out.print(jsonResponse.toString());
        }
    }
}


